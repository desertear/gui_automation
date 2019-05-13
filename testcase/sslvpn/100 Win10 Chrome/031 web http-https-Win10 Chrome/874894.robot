*** Settings ***
Documentation    Verify two users connect to sslvpn web portal, could HTTPS to same HTTPS server simultaneously
...   Action:
...   1. user1 login sslvpn web portal
...   2. connect to https pc5 and keep open the web
...   3. user2 login sslvpn web portal
...   4. conect to same https pc5
...   5. logout
...   Expect:
...   succeed to open the web.
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
${username}    ${SSLVPN_GUI_USERNAME}
${password}    ${SSLVPN_GUI_PASSWORD}
${username2}    ${SSLVPN_GUI_USERNAME2}
${password2}    ${SSLVPN_GUI_PASSWORD2}
${https_url}    https://${SSLVPN_HTTP_IP}
${matching_text}    ${SSLVPN_HTTP_PAGE_KEYWORD}

##Please only put case level variables here, while global variables should be set in env.robot
*** Test Cases ***
874894
    [Tags]    v6.0    chrome    firefox    874894    high    win10,64bit
    # login sslvpn portal with user, quick connect to web url
    ${old_browser}=    Login SSLVPN Portal    username=${username}    password=${password}
    #quick connection to http/https
    click button    ${PORTAL_QUICK_CONNECTION_BUTTON}
    click element    ${QUICK_HTTP_HTTPS_LABEL}
    input text    ${QUICK_HTTP_URL_TEXT}    ${https_url}

    #record opened windows
    ${exclude}=    Get window handles
    #click quick connection button
    click button    ${QUICK_LAUNCH_BUTTON}
    #open url and keep it
    ${older_window}=    Select window    ${exclude}
    ${if_locator}=    If Text Is Locator    ${matching_text}
    Run keyword if   "${if_locator}"=="True"    wait Until page contains element    ${matching_text}
    ...    ELSE    wait Until page contains    ${matching_text}

    # login sslvpn portal with user2, quick connect to same web url
    ${browser_index}=    Login SSLVPN Portal    username=${username2}    password=${password2}
    quick connection of http or https    ${https_url}    ${matching_text}
    # log out sslvpn porttal
    run keyword and ignore error    Logout SSLVPN Portal
    # switch back to first login
    run keyword and ignore error    switch browser    ${browser_index-1}
    run keyword and ignore error    switch back to ssl vpn portal    ${older_window}
    run keyword and ignore error    Logout SSLVPN Portal
    #close all windows
    close all browsers
    #clear sslvpn connection from cli
    #Execute CLI commands on FortiGate Via Direct Telnet    ${cmds}

    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***

