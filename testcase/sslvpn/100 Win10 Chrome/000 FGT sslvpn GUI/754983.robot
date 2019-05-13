*** Settings ***
Documentation    Verify global admin setting page can show port conflict warning in GUI if sslvpn port conflict with system https access at least one vdom.
Resource    ../../sslvpn_resource.robot

*** Variables ***

*** Test Cases ***
754983
    [Documentation]    The result of this is based on SSLVPN setup,
    ...    because checkpoints have been verifeid on SSLVPN setp already.
    [Tags]    v6.0    chrome    firefox    edge    754983    high    win10,64bit
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login FortiGate    http://${FGT_IP_ADDRESS}
    Go to system_Settings
    Wait Until Element Is Visible     ${PORT_CONFLIC_WAENING}
    Logout FortiGate
    Close All Browsers
    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    [Arguments]
    Logout FortiGate
    Close All Browsers
    run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}