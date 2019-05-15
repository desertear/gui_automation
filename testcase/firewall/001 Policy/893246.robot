*** Settings ***
Documentation    Create IPv4 Policy: Verify policy can be created/edited using non default protocol options
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${policy_name}   893246
@{incoming}    ${FW_TEST_INTF_1}
@{outgoing}    ${FW_TEST_INTF_2}
@{source_addresses}    ADDRESS:${FW_TEST_ADDR_1}
@{destination_addresses}   ADDRESS:${FW_TEST_ADDR_2}
${protocol_option}    893246
${policy_name_new}   893246_edit
@{source_addresses_new}    ADDRESS:${FW_TEST_ADDR_2}
@{destination_addresses_new}   ADDRESS:${FW_TEST_ADDR_1}
@{column_list}    Source    Destination
@{config_list}    config    ${FW_TEST_ADDR_2}   ${FW_TEST_ADDR_1}
*** Test Cases ***
893246
    [Documentation]    
    [Tags]    chrome    893246    Medium   firewall_new
    [setup]   Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown
    Login FortiGate  
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects  
    Go to IPv4 policy 
    #Step 1: check multi-interface setting in gui and create ipv4 policy
    Log    ==================== Step 1: check multi-interface setting in gui and create ipv4 policy ==================== 
    ${multi_intf}=    get policy multi_intf status from cli    ${FW_TEST_VDOM_NAME_1}
    create ip policy    ${policy_name}    ${incoming}    ${outgoing}    ${source_addresses}    ${destination_addresses}
    ...    always    ALL    ACCEPT    enable    protocol_option=${protocol_option}        multi_intf=${multi_intf}
    
    #Step 2: check if policy has been created and then edit it
    Log    ==================== Step 2: check if policy has been created and then edit it ==================== 
    ${status}=    if ip policy exists    ${policy_name}
    Should be equal    "${status}"    "True"
    edit ip policy   ${policy_name}    ${policy_name_new}    ${incoming}    ${outgoing}    ${source_addresses_new}    ${destination_addresses_new}
    ...    always    ALL    ACCEPT    enable    protocol_option=${protocol_option}        multi_intf=${multi_intf}
    sleep   2

    #Step 3: check if policy has been edited correctly
    Log    ==================== Step 3: check if policy has been edited correctly ==================== 
    ${config}=    Get Policy Config by Column Name and Policy NAME    ${column_list}     ${policy_name_new} 
    Lists Should Be Equal    ${config}    ${config_list}
    sleep   2

    #Step 4:  delete policy
    Log    ==================== Step 4: delete policy ==================== 
    delete ip policy    ${policy_name_new}
    sleep   2

*** Keywords ***
case Teardown 
    Logout FortiGate
    close all browsers
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt