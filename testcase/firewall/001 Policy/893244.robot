*** Settings ***
Documentation    Create IPv4 Policy: Verify policy can be created/edited when using ip pools with preserve source port enabled
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${policy_name}   893244
@{incoming}    ${FW_TEST_INTF_1}
@{outgoing}    ${FW_TEST_INTF_2}
@{source_addresses}    ADDRESS:${FW_TEST_ADDR_1}
@{destination_addresses}   ADDRESS:${FW_TEST_ADDR_2}
@{ippool_list}    ${FW_TEST_IP_POOLS_1}    ${FW_TEST_IP_POOLS_2}
${policy_name_new}   893244_edit
@{incoming_new}    ${FW_TEST_INTF_2}
@{outgoing_new}    ${FW_TEST_INTF_1}
@{column_list}    From   To
*** Test Cases ***
893244
    [Documentation]    
    [Tags]    chrome    893244    High
    [Teardown]    case Teardown
    Login FortiGate  
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects  
    Go to IPv4 policy 
    #Step 1: check multi-interface setting in gui and create ipv4 policy
    Log    ==================== Step 1: check multi-interface setting in gui and create ipv4 policy ==================== 
    ${multi_intf}=    get policy multi_intf status from cli    ${FW_TEST_VDOM_NAME_1}
    create ip policy    ${policy_name}    ${incoming}    ${outgoing}    ${source_addresses}    ${destination_addresses}
    ...    always    ALL    ACCEPT    enable   ippool_config_mode=Dynamic   ippool_name=${ippool_list}    preserve_source_port=enable    multi_intf=${multi_intf}
    
    #Step 2: check if policy has been created and then edit it
    Log    ==================== Step 2: check if policy has been created and then edit it ==================== 
    ${status}=    if ip policy exists    ${policy_name}
    Should be equal    "${status}"    "True"
    edit ip policy   ${policy_name}    ${policy_name_new}    ${incoming_new}    ${outgoing_new}    ${source_addresses}    ${destination_addresses}
    ...    always    ALL    ACCEPT    enable   ippool_config_mode=Dynamic   ippool_name=${ippool_list}    preserve_source_port=enable    multi_intf=${multi_intf}
    sleep   2

    #Step 3: check if policy has been edited correctly
    Log    ==================== Step 3: check if policy has been edited correctly ==================== 
    ${config}=    Get Policy Config by Column Name and Policy NAME    ${column_list}     ${policy_name_new} 
    ${edit_list}=    Combine lists    ${incoming_new}    ${outgoing_new} 
    Insert Into List   ${edit_list}    0    config
    Lists Should Be Equal    ${config}    ${edit_list}
    sleep   2

    #Step 4:  delete policy
    Log    ==================== Step 4: delete policy ==================== 
    delete ip policy    ${policy_name_new}
    sleep   2

*** Keywords ***
case Teardown 
    Logout FortiGate
    close all browsers