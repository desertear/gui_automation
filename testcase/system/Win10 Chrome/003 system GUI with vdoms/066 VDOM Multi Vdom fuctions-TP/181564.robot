*** Settings ***
Documentation    To verify a zone could be created and deleted under a virtual domain in GUI.
Resource    ../../../system_resource.robot

*** Variables ***
${zone_name}    181564
${zone_int}    ${SYSTEM_TEST_INTF_3}
*** Test Cases ***
181564
    [Tags]    v6.0    chrome   181564   High     win10,64bit    browsers    runable   rest
    [setup]    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    login FortiGate    
    Go To Vdom     ${SYSTEM_TEST_VDOM_NAME_tp}
    sleep   1
    Go to network
    Go to network_Interfaces
    ### create a zone
    select frame        ${NETWORK_FRAME}
    wait and click      ${NETWORK_INTERFACES_CREATE NEW_BUTTON}
    wait and click      ${NETWORK_INTERFACES_CREATE NEW_MENU_BAR_ZONE}
    wait until element is visible   ${NETWORK_INTERFACES_CREATE NEW_ZONE_NAME}
    sleep  1
    wait and click      ${NETWORK_INTERFACES_CREATE NEW_ZONE_NAME_INPUT}
    clear element text  ${NETWORK_INTERFACES_CREATE NEW_ZONE_NAME_INPUT}
    input text          ${NETWORK_INTERFACES_CREATE NEW_ZONE_NAME_INPUT}     ${zone_name}
    wait and click      ${NETWORK_INTERFACES_CREATE NEW_ZONE_INTERFACE}
    SELECT MENU BAR FROM SELECTION PANE        ${zone_int}
    wait and click      ${SUBMIT_OK_BUTTON}
    sleep   2
    network delete interface    ${zone_name}    table_type=Zone   
    sleep   2 
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    Close All Browsers
    write test result to file    ${CURDIR}
