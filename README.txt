NAME
    japi - A Humble Jira API Tool

    This is a small and simple command line tool to be used manually or via
    cron to fetch the newest unresolved and unclosed tickets from a Jira
    project.

    It might be usefull to write the results every hour to a local file and
    do a "cat ~/.issues" every time you open a new shell.

    CAUTION: You may also need to install the "JIRA::REST" module from CPAN
    manually. It's not included in standard Debian GNU/Linux Wheezy yet.

SYNOPSIS
    Synopsis: japi [--debug] [--help] [--version] [--nocolor] [--passfile]
    [--unassigned] [--jira_apiversion STRING] [--jira_query STRING]
    [--jira_uribase STRING] [--jira_user STRING]

  Options:
    --debug
        Prints out extra debugging infos during execution.

    --help
        Prints out the help.

    --version
        Prints out the version.

    --nocolor
        By default the output uses colored text output. This switch disables
        it.

    --passfile STRING
        Specifies the path to an optional file which includes the Jira API
        password but Base64 encoded. The default value is "~/.japipass".

        If the file is not present, Japi will prompt for the password.

    --unassigned
        By default the output lists assigned and unassigned issues. Use this
        switch to only list unassigned issues.

    --jira_apiversion STRING
        Specifies the Jira API version to use. The default value is
        "rest/api/2".

    --jira_query STRING
        Specifies the Jira search string (e.q. a JQL string). The default
        value is "search?jql=project=MT and status not in
        (Resolved,Closed)".

    --jira_uribase STRING
        Specifies the Jira URI base. The default value is
        "https://your-jira.example.com". This has to be changed.

    --jira_user STRING
        Specifies the Jira user. The default value is your current
        Linux/UNIX user.

CONFIG
    Almost all options have to be passed the Japi tool via command line. One
    exception is the password file containing your Jira password Base64
    encoded.

    It can be created like this:

      bash -c 'read -s PASSWORD; tr -d "\n" <<< "$PASSWORD" | base64' | tee ~/.japipass
      chmod 0600 ~/.japipass

AUTHOR
    Paul C. Buetow - <paul@buetow.org>

