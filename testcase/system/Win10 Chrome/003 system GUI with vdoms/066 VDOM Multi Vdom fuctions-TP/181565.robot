*** Settings ***
Documentation    To verify a zone could not include interfaces from different VDOMs in GUI.
Resource    ../../../system_resource.robot

*** Variables ***
${zone_name}    181565
${zone_int}    ${SYSTEM_TEST_INTF_3}
${test_int}    ${SYSTEM_TEST_INTF_4}
*** Test Cases ***
181565
    [Tags]    v6.0    chrome   181565   High     win10,64bit    browsers    runable   rest
    [setup]    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    login FortiGate    
    Go To Vdom        ${SYSTEM_TEST_VDOM_NAME_tp}
    Go to network
    Go to network_Interfaces
    ### create a zone
    select frame      ${NETWORK_FRAME}
    wait and click    ${NETWORK_INTERFACES_CREATE NEW_BUTTON}
    wait and click    ${NETWORK_INTERFACES_CREATE NEW_MENU_BAR_ZONE}
    wait until element is visible   ${NETWORK_INTERFACES_CREATE NEW_ZONE_NAME}
    sleep  1
    wait and click      ${NETWORK_INTERFACES_CREATE NEW_ZONE_NAME_INPUT}
    clear element text  ${NETWORK_INTERFACES_CREATE NEW_ZONE_NAME_INPUT}
    input text          ${NETWORK_INTERFACES_CREATE NEW_ZONE_NAME_INPUT}     ${zone_name}
    wait and click      ${NETWORK_INTERFACES_CREATE NEW_ZONE_INTERFACE}
    SELECT MENU BAR FROM SELECTION PANE      ${zone_int}
    wait and click      ${NETWORK_INTERFACES_CREATE NEW_ZONE_INTERFACE}
    ${status}=    run keyword and return status     SELECT MENU BAR FROM SELECTION PANE      ${test_int}
    should be equal    "${status}"    "False"
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    Close All Browsers
    write test result to file    ${CURDIR}
