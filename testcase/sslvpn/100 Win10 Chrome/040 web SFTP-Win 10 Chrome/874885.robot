*** Settings ***
Documentation    Verify two users connect to sslvpn web portal, could SFTP to same SFTP server simultaneously
...    Action:
...    1. user1 login sslvpn web portal
...    2. connect to https pc5 and keep open the web
...    3. user2 login sslvpn web portal
...    4. conect to same https pc5
...    5. logout
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
${username}    ${SSLVPN_GUI_USERNAME}
${password}    ${SSLVPN_GUI_PASSWORD}
${username2}    ${SSLVPN_GUI_USERNAME2}
${password2}    ${SSLVPN_GUI_PASSWORD2}
${sftp_host}    ${SSLVPN_SFTP_HOST}
${sftp_username}    ${SSLVPN_SFTP_USERNAME}
${sftp_password}    ${SSLVPN_SFTP_PASSWORD}
${matching_text}    ${SSLVPN_SFTP_TEST_FILE}
##Please only put case level variables here, while global variables should be set in env.robot
*** Test Cases ***
874885
    [Tags]    v6.0    chrome    firefox    874885    high    win10,64bit
    # login sslvpn portal with user, quick connect to web url
    ${old_browser}=    Login SSLVPN Portal    username=${username}    password=${password}
    # connection to sftp
    connect to sftp    ${sftp_host}    username=${sftp_username}    password=${sftp_password}

    # login sslvpn portal with user2, quick connect to same web url
    Login SSLVPN Portal    username=${username2}    password=${password2}
    connect to sftp    ${sftp_host}    username=${sftp_username}    password=${sftp_password}
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

