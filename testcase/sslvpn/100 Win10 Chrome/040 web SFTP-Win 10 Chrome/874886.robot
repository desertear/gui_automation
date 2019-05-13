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
${sftp_host-1}    ${SSLVPN_SFTP_HOST}
${sftp_username}    ${SSLVPN_SFTP_USERNAME}
${sftp_password}    ${SSLVPN_SFTP_PASSWORD}
${matching_text}    ${SSLVPN_SFTP_TEST_FILE}

${sftp_host2}    ${SSLVPN_LINUX_SERVER2}
${sftp_username2}    ${SSLVPN_SFTP_USERNAME}
${sftp_password2}    ${SSLVPN_SFTP_PASSWORD}
${matching_text2}    ${SSLVPN_SFTP_TEST_FILE}

##Please only put case level variables here, while global variables should be set in env.robot
*** Test Cases ***
874886
    [Tags]    v6.0    chrome    firefox    874886    high    win10,64bit    norun
    # login sslvpn portal with user, quick connect to web url
    ${old_browser}=    Login SSLVPN Portal    username=${username}    password=${password}
    # connection to sftp
    connect to sftp    ${sftp_host}    username=${sftp_username}    password=${sftp_password}

    # login sslvpn portal with user2, quick connect to same web url
    Login SSLVPN Portal    username=${username2}    password=${password2}
    connect to sftp    ${sftp_host2}    username=${sftp_username2}    password=${sftp_password2}
    run keyword and ignore error   close window
    run keyword and ignore error    Select window    MAIN
    run keyword and ignore error    Logout SSLVPN Portal
    # switch back to first login
    run keyword and ignore error    switch browser    ${old_browser}
    run keyword and ignore error    close window
    run keyword and ignore error    Select window    MAIN
    run keyword and ignore error    Logout SSLVPN Portal
    #close all windows
    close all browsers


    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***

