*** Settings ***
Documentation    Create IPV6 Policy: Verify basic DENY policy can be created/deleted with srcintf,dstintf, srcaddr,dstaddr schedule and service
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${policy_name}   893411
@{incoming}    ${FW_TEST_INTF_1}
@{outgoing}    ${FW_TEST_INTF_2}
@{source_addresses}    ADDRESS:${FW_TEST_ADDR6_1}
@{destination_addresses}   NONE:${FW_TEST_ADDR6_2}
*** Test Cases ***
893411
    [Documentation]    
    [Tags]    chrome    893411    High
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
    ...    always    ALL    DENY    enable   multi_intf=${multi_intf}   ip_version=6

    #Step 2: check if policy has been created and then delete it
    Log    ==================== Step 2: check if policy has been created and then delete it ==================== 
    ${status}=    if ip policy exists    ${policy_name}
    Should be equal    "${status}"    "True"
    run keyword if    "${status}"=="True"     delete ip policy    ${policy_name}
    sleep   2
*** Keywords ***
case Teardown 
    Logout FortiGate
    close all browsers