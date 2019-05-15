*** Settings ***
Documentation    Create IPv4 Policy: Verify policy can be created/edited when using ip pools with preserve source port disabled
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${policy_name}   893328
@{incoming}    ${FW_TEST_INTF_1}
@{outgoing}    ${FW_TEST_INTF_2}
@{source_addresses}    ADDRESS:${FW_TEST_ADDR_1}
@{destination_addresses}   ADDRESS:${FW_TEST_ADDR_2}
@{ippool_list}    ${FW_TEST_IP_POOLS_1}    ${FW_TEST_IP_POOLS_2}
*** Test Cases ***
893328
    [Documentation]    
    [Tags]    chrome    893328    High
    [Teardown]    case Teardown
    Login FortiGate  
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects  
    Go to IPv4 policy 
    #Step 1: check multi-interface setting in gui and create ipv4 policy
    Log    ==================== Step 1: check multi-interface setting in gui and create ipv4 deny policy ==================== 
    ${multi_intf}=    get policy multi_intf status from cli    ${FW_TEST_VDOM_NAME_1}
    create ip policy    ${policy_name}    ${incoming}    ${outgoing}    ${source_addresses}    ${destination_addresses}
    ...    always    ALL    ACCEPT    enable   ippool_config_mode=Dynamic   ippool_name=${ippool_list}    preserve_source_port=disable    multi_intf=${multi_intf}
    
    #Step 2:  delete policy
    Log    ==================== Step 2: delete policy ==================== 
    delete ip policy    ${policy_name}
    sleep   2

*** Keywords ***
case Teardown 
    Logout FortiGate
    close all browsers