*** Settings ***
Documentation    Verify that valid RADIUS user can  login sslvpn web portal
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
${radius_user}    ${FGT_RADIUS_USERNAME}
${radius_password}    ${FGT_RADIUS_PASSWORD}
*** Test Cases ***
593145
    [Tags]    v6.0    firefox    chrome    edge    safari    593145    medium    win10,64bit
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login SSLVPN Portal    username=${radius_user}    password=${radius_password}
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}