NAME=japi
all: version documentation build

# THIS IS NEEDED BY THE DEBIAN TOOLS

# Builds the project. Since this is only a fake project, it just copies a script.
build:
	cp -p ./src/$(NAME) bin/$(NAME)
	sed -i "s/VERSION_DEVEL/$$(cat .version)/" bin/$(NAME)
	
# 'install' installes a fake-root, which will be used to build the Debian package
# $DESTDIR is actually set by the Debian tools.
install:
	test ! -d $(DESTDIR)/usr/bin && mkdir -p $(DESTDIR)/usr/bin || exit 0
	test ! -d $(DESTDIR)/usr/share/$(NAME) && mkdir -p $(DESTDIR)/usr/share/$(NAME) || exit 0
	cp ./bin/* $(DESTDIR)/usr/bin

deinstall:
	test ! -z "$(DESTDIR)" && test -f $(DESTDIR)/usr/bin/$(NAME) && rm $(DESTDIR)/usr/bin/$(NAME) || exit 0
	test ! -z "$(DESTDIR)/usr/share/$(NAME)" && -d $(DESTDIR)/usr/share/$(NAME) && rm -r $(DESTDIR)/usr/share/$(NAME) || exit 0

clean:
	rm bin/*

# ADDITIONAL RULES:

# Parses the version out of the Debian changelog
version:
	cut -d' ' -f2 debian/changelog | head -n 1 | sed 's/(//;s/)//' > .version

# Builds the documentation into a manpage
documentation:
	pod2man --release="$(NAME) $$(cat .version)" \
		--center="User Commands" ./docs/$(NAME).pod > ./docs/$(NAME).1
	# Also write README.txt for Github.
	pod2text ./docs/$(NAME).pod >./docs/$(NAME).txt
	# For github page
	cp ./docs/$(NAME).pod README.pod

# Build a debian package (don't sign it, modify the arguments if you want to sign it)
deb: all
	dpkg-buildpackage

dput:
	dput -u wheezy-buetowdotorg ../$(NAME)_$$(cat ./.version)_amd64.changes
	dput -u jessie-buetowdotorg ../$(NAME)_$$(cat ./.version)_amd64.changes

dch: 
	dch -i

release: dch deb 
	bash -c "git tag $$(cat .version)"
	git push --tags
	git commit -a -m 'New release'
	git push origin master

clean-top:
	rm ../$(NAME)_*.tar.gz
	rm ../$(NAME)_*.dsc
	rm ../$(NAME)_*.changes
	rm ../$(NAME)_*.deb

