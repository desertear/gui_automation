*** Settings ***
Documentation    Create IPV6 Policy: Verify basic ACCEPT policy can be created/deleted with srcintf,dstintf, srcaddr,dstaddr schedule and service
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${policy_name}   893404
@{incoming}    ${FW_TEST_INTF_1}
@{outgoing}    ${FW_TEST_INTF_2}
@{source_addresses}    ADDRESS:${FW_TEST_ADDR6_1}
@{destination_addresses}   NONE:${FW_TEST_ADDR6_2}
@{source_addresses_new}    ADDRESS:${FW_TEST_ADDR6_2}
@{destination_addresses_new}   NONE:${FW_TEST_ADDR6_1}
@{column_list}    Source    Destination Address
*** Test Cases ***
893404
    [Documentation]    
    [Tags]    chrome    893404    High
    [setup] 
    [Teardown]    case Teardown
    Login FortiGate  
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects  
    Go to IPv6 policy 
    #Step 1: check multi-interface setting in gui and create ipv6 policy
    Log    ==================== Step 1: check multi-interface setting in gui and create ipv6 policy ==================== 
    ${multi_intf}=    get policy multi_intf status from cli    ${FW_TEST_VDOM_NAME_1}
    create ip policy    ${policy_name}    ${incoming}    ${outgoing}    ${source_addresses}    ${destination_addresses}
    ...    always    ALL    ACCEPT    True   multi_intf=${multi_intf}   ip_version=6

    #Step 2: check if policy has been created and then edit it
    Log    ==================== Step 2: check if policy has been created and then edit it ==================== 
    ${status}=    if ip policy exists    ${policy_name}
    Should be equal    "${status}"    "True"
    edit ip policy   ${policy_name}    ${policy_name}    ${incoming}    ${outgoing}    ${source_addresses_new}    ${destination_addresses_new}
    ...    always    ALL    ACCEPT    True   multi_intf=${multi_intf}    ip_version=6
    sleep   2
    
    #Step 3: check if policy has been edited correctly
    Log    ==================== Step 3: check if policy has been edited correctly ==================== 
    ${config}=    Get Policy Config by Column Name and Policy NAME    ${column_list}     ${policy_name} 
    ${edit_list}=    Combine lists    ${source_addresses_new}    ${destination_addresses_new}
    ${edit_list}=    get value list from action list    ${edit_list}
    Insert Into List   ${edit_list}    0    config
    Lists Should Be Equal    ${config}    ${edit_list}
    sleep   2
    
    #Step 4: delete policy
    Log    ==================== Step 4: delete policy ==================== 
    ${status}=    if ip policy exists    ${policy_name}
    Should be equal    "${status}"    "True"
    run keyword if    "${status}"=="True"     delete ip policy    ${policy_name}
    sleep   2
*** Keywords ***
case Teardown 
    Logout FortiGate
    close all browsers