*** Settings ***
Documentation    The web mode second connection can be proceed and other connection will be disconnected when click "login anyway" if limit-user-logins enable
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***

*** Test Cases ***
816601
    [Tags]    v6.0    firefox    chrome    816601    high    win10,64bit
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    ##login with chrome browser
    Login SSLVPN Portal    browser=chrome
    ##login with firefox browser
    ${browser_index}=    Open Browser    ${SSLVPN_URL}    browser=firefox    alias=None
    ...    remote_url=${SSLVPN_REMOTE_URL}    desired_capabilities=${SSLVPN_DESIRED_CAPABILITIES}    ff_profile_dir=${SSLVPN_FF_PROFILE_DIR}
    input text    ${LOGIN_SSLVPN_USERNAME_TEXT}    ${SSLVPN_GUI_USERNAME}
    input password    ${LOGIN_SSLVPN_PASSWORD_TEXT}    ${SSLVPN_GUI_PASSWORD}
    click button    ${LOGIN_SSLVPN_LOGIN_BUTTON}
    wait until page contains element    ${LOGIN_SSLVPN_ALREADY_LOGGED_IN}
    close browser
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}