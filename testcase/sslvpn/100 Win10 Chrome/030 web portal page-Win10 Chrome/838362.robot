*** Settings ***
Documentation    Verify that valid local user can login sslvpn web portal
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
${local_user}    ${SSLVPN_GUI_USERNAME}
${local_password}    ${SSLVPN_GUI_PASSWORD}
*** Test Cases ***
838362
    [Tags]    v6.0    firefox    chrome    edge    safari    838362    medium    win10,64bit
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login SSLVPN Portal    username=${local_user}    password=${local_password}
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}