*** Settings ***
Documentation    Verify two users connect to sslvpn web portal, could HTTP to different HTTP server
...   1. user1 login sslvpn web portal
...   2. connect to http pc5 and keep open the web
...   3. user2 login sslvpn web portal
...   4. conect to same http pc5
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
${http_url1}    https://${SSLVPN_HTTP_IP}
${matching_text1}    ${SSLVPN_HTTP_PAGE_KEYWORD}
${fac}    https://${FAC_IP}/login
${fac_username}    fosqa
${fac_password}    123456

##Please only put case level variables here, while global variables should be set in env.robot
*** Test Cases ***
874895
    [Tags]    v6.0    chrome    firefox    874895    high    win10,64bit
    # login sslvpn portal with user, quick connect to web url
    ${old_browser}=    Login SSLVPN Portal    username=${username}    password=${password}
    #quick connection to http/https
    click button    ${PORTAL_QUICK_CONNECTION_BUTTON}
    click element    ${QUICK_HTTP_HTTPS_LABEL}
    input text    ${QUICK_HTTP_URL_TEXT}    ${http_url1}

    #record opened windows
    ${exclude}=    Get window handles
    #click quick connection button
    click button    ${QUICK_LAUNCH_BUTTON}
    #open url and keep it
    ${older_window}=    Select window    ${exclude}
    ${if_locator}=    If Text Is Locator    ${matching_text1}
    Run keyword if   "${if_locator}"=="True"    wait Until page contains element    ${matching_text1}
    ...    ELSE    wait Until page contains    ${matching_text1}

    # login sslvpn portal with user2, quick connect to different web url
    Login SSLVPN Portal    username=${username2}    password=${password2}
    click button    ${PORTAL_QUICK_CONNECTION_BUTTON}
    click element    ${QUICK_HTTP_HTTPS_LABEL}
    input text    ${QUICK_HTTP_URL_TEXT}    ${fac}
    ${exclude}=    Get window handles
    click button    ${QUICK_LAUNCH_BUTTON}
    ${older_window}=    Select window    ${exclude}
    ${if_warning}=    run keyword and return status    wait Until element is visible    ${FAC_WARNING_CONTENT}
    run keyword if    "${if_warning}"=="${True}"    click element    ${FAC_WARNING_ACCEPT}
    input text    ${FAC_LOGIN_USERNAME}    ${fac_username}
    input text    ${FAC_LOGIN_PASSWORD}    ${fac_password}
    click button    ${FAC_LOGIN_LOGIN}
    wait Until element is visible    ${FAC_HEAD}
    close window
    #switch back to SSLVPN GUI window
    Select window    MAIN
    wait Until page contains element    ${PORTAL_QUICK_CONNECTION_BUTTON}
    # log out sslvpn porttal
    run keyword and ignore error    Logout SSLVPN Portal
    # switch back to first login
    run keyword and ignore error    switch browser    ${old_browser}
    close window
    run keyword and ignore error    switch back to ssl vpn portal    ${older_window}

    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***

