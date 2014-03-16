NAME
    japi - A Humble Jira API Tool

SYNOPSIS
    Synopsis: japi [--debug] [--help] [--version] [--passfile]
    [--jira_apiversion <STRING>] [--jira_query <STRING>] [--jira_uribase
    <STRING>] [--jira_user <STRING>]

  Options:
    --debug
        Prints out extra debugging infos during execution.

    --help
        Prints out the help.

    --version
        Prints out the version.

    --passfile <STRING>
        Specifies the path to an optional file which includes the Jira API
        password but Base64 encoded. The default value is "~/.japipass".

        If the file is not present, Japi will prompt for the password.

    --jira_apiversion <STRING>
        Specifies the Jira API version to use. The default value is
        "rest/api/2".

    --jira_query <STRING>
        Specifies the Jira search string (e.q. a JQL string). The default
        value is "search?jql=project=MT and status not in
        (Resolved,Closed)'".

    --jira_uribase <STRING>
        Specifies the Jira URI base. The default value is
        "https://your-jira.example.com". This has to be changed.

    --jira_user <STRING>
        Specifies the Jira user. The default value is your current
        Linux/UNIX user.

CONFIG
    Almost all options have to be passed the Japi tool via command line. One
    exception is the password file containing your Jira password Base64
    encoded.

    It can be created like this:

      bash -c 'read -s PASSWORD; tr -d "\n" <<< "$PASSWORD" | base64' | tee ~/.japipass

AUTHOR
    Paul C. Buetow - <paul@buetow.org>

