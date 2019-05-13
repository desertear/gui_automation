*** Settings ***
Documentation    Verify sslvpn associated system interface can show port conflict warning in GUI if sslvpn port-precedence is disabled or enable
Resource    ../../sslvpn_resource.robot

*** Variables ***

*** Test Cases ***
754981
    [Documentation]    The result of this is based on SSLVPN setup,
    ...    because checkpoints have been verifeid on SSLVPN setp already.
    [Tags]    v6.0    chrome    firefox    edge    754981    high    win10,64bit
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login FortiGate    http://${FGT_IP_ADDRESS}
    Go to network
    go to network_Interfaces
    network edit interface    ${FGT_VLAN20_INTERFACE}    table_type=Software Switch
    Wait Until Element Is Visible     ${PORT_CONFLIC_WAENING}
    Logout FortiGate
    Close All Browsers
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}port_precedence_disable_cli.txt
    Login FortiGate    http://${FGT_IP_ADDRESS}
    Go to network
    go to network_Interfaces
    network edit interface    ${FGT_VLAN20_INTERFACE}    table_type=Software Switch
    Wait Until Element Is Visible     ${PORT_CONFLIC_WAENING}

    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    [Arguments]
    Logout FortiGate
    Close All Browsers
    run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}