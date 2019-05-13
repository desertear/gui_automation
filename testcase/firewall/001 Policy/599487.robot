*** Settings ***
Documentation    Create ipv4 policy, verify basic ACCEPT policy can be created/deleted with srcintf,dstintf, srcaddr,dstaddr schedule and service
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${policy_name}   599487
@{incoming}    ${FW_TEST_INTF_1}
@{outgoing}    ${FW_TEST_INTF_2}
@{source_addresses}    ADDRESS:${FW_TEST_ADDR_1}
@{destination_addresses}   ADDRESS:${FW_TEST_ADDR_2}
# @{security}    AntiVirus:g-wifi-default  Web Filter:g-default  DNS Filter:disable
# @{ippool_list}    ${FW_TEST_IP_POOLS_1}    ${FW_TEST_IP_POOLS_2}
${policy_name_new}   599487_edit
@{incoming_new}    ${FW_TEST_INTF_2}
@{outgoing_new}    ${FW_TEST_INTF_1}
@{column_list}    From   To
*** Test Cases ***
599487
    [Documentation]    
    [Tags]    chrome    599487    Critical
    [setup] 
    [Teardown]    case Teardown
    Login FortiGate  
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects  
    Go to IPv4 policy 
    #Step 1: check multi-interface setting in gui and create ipv4 deny policy
    Log    ==================== Step 1: check multi-interface setting in gui and create ipv4 deny policy ==================== 
    ${multi_intf}=    get policy multi_intf status from cli    ${FW_TEST_VDOM_NAME_1}
    create ip policy    ${policy_name}    ${incoming}    ${outgoing}    ${source_addresses}    ${destination_addresses}
    ...    always    ALL    ACCEPT    True   multi_intf=${multi_intf}
    
    #Step 2: check if policy has been created and then edit it
    Log    ==================== Step 2: check if policy has been created and then edit it ==================== 
    ${status}=    if ip policy exists    ${policy_name}
    Should be equal    "${status}"    "True"
    edit ip policy   ${policy_name}    ${policy_name_new}    ${incoming_new}    ${outgoing_new}    ${source_addresses}    ${destination_addresses}
    ...    always    ALL    ACCEPT    True   multi_intf=${multi_intf}
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

    # #Step 2: Edit policy and set options enable/disable
    # Log    ==================== Step 2: Edit policy and set security profile ==================== 
    # Edit Policy By NAME on Policy list   ${policy_name_accept}
    # set security profiles to policy4   ${security}
    # View By Sequence
    # ${security_list}=    get name list from action list    ${security}
    # ${config}=    Get Policy Security Profile Config by Policy NAME    ${security_list}    ${policy_name_accept}
    # Lists Should Be Equal   ${config}   ${security}

    # #Step 3: Edit policy and set nat enable, set ip pool dynamic
    # Log    ==================== Edit policy and set nat enable, set ip pool dynamic ==================== 
    # Edit Policy By NAME on Policy list   ${policy_name_accept}
    # set item enable disable in policy edit page    NAT  enable
    # set ip pool in policy edit page       preserve_source_port=enable    ippool_mode=Dynamic    ippool_name=${ippool_list}     
    # test if ippool exist in nat column    ${policy_name_accept}    ${ippool_list}
    # sleep  2
    
*** Keywords ***
case Teardown 
    Logout FortiGate
    close all browsers