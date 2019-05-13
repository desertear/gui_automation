*** Settings ***
Documentation    To verify interfaces can be bound and unbound to a zone
Resource    ../../../system_resource.robot

*** Variables ***
${zone_name}    181537
${test_interface}     ${SYSTEM_TEST_INTF_3}

*** Test Cases ***
181537
    [Tags]    v6.0    chrome   181537   Critical     win10,64bit    browsers    runable   rest
    login FortiGate    
    Go To Vdom     ${SYSTEM_TEST_VDOM_NAME_1}
    Go to network
    Go to network_Interfaces
    ### create a zone
    select frame      ${NETWORK_FRAME}
    wait and click    ${NETWORK_INTERFACES_CREATE NEW_BUTTON}
    wait and click    ${NETWORK_INTERFACES_CREATE NEW_MENU_BAR_ZONE}
    wait until element is visible   ${NETWORK_INTERFACES_CREATE NEW_ZONE_NAME}
    sleep  1
    wait and click    ${NETWORK_INTERFACES_CREATE NEW_ZONE_NAME_INPUT}
    clear element text    ${NETWORK_INTERFACES_CREATE NEW_ZONE_NAME_INPUT}
    input text        ${NETWORK_INTERFACES_CREATE NEW_ZONE_NAME_INPUT}     ${zone_name}
    wait and click    ${NETWORK_INTERFACES_CREATE NEW_ZONE_INTERFACE}
    SELECT MENU BAR FROM SELECTION PANE        ${test_interface}
    wait and click    ${SUBMIT_OK_BUTTON}

    network edit interface    ${zone_name}    table_type=Zone
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_INTERFACES_CREATE NEW_ZONE_INTERFACE_UNSELECT}   ${test_interface}
    wait and click     ${new_locator}
    wait and click     ${SUBMIT_OK_BUTTON}    
    ${status}=    run keyword and return status     network select interface    ${zone_name}   ${test_interface}   table_type=Zone
    should be equal   "${status}"    "False"
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    Close All Browsers
    write test result to file    ${CURDIR}
