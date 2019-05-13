*** Settings ***
Documentation    Verify that valid TACACS user can login sslvpn web portal
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
${tac_user}    ${FGT_TACACS_USERNAME}
${tac_password}    ${FGT_TACACS_PASSWORD}
*** Test Cases ***
593148
    [Tags]    v6.0    firefox    chrome    edge    safari    593148    medium    win10,64bit
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login SSLVPN Portal    username=${tac_user}    password=${tac_password}
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}