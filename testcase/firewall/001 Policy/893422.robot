*** Settings ***
Documentation    Create IPV6 VWP Policy: Verify basic DENY policy can be created/deleted with only one direction, srcaddr, dstaddr schedule and service
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${vwp_name}   893422_vwp
${policy_name}   893422
@{source_addresses}    ADDRESS:${FW_TEST_ADDR6_1}
@{destination_addresses}   NONE:${FW_TEST_ADDR6_2}
*** Test Cases ***
893422
    [Documentation]    
    [Tags]    chrome    893422    Medium
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown
    Login FortiGate  
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects  
    Go to Policy_IPV6_VWP_Policy
    #Step 1: create ipv6 vwp policy
    Log    ==================== Step 1: create ipv6 vwp policy ==================== 
    create vwp policy  ${vwp_name}  ${policy_name}  ${source_addresses}  ${destination_addresses} 
    ...    always    ALL    DENY     direction=right    ip_version=6

    #Step 2: check if policy has been created and then edit it
    Log    ==================== Step 2: check if policy has been created and then edit it ==================== 
    ${status}=    if ip policy exists    ${policy_name}
    Should be equal    "${status}"    "True"
    edit vwp policy    ${vwp_name}    ${policy_name}    ${policy_name}     ${source_addresses}    ${destination_addresses}
    ...    always    ALL    DENY    direction=left    ip_version=6
    sleep   2

    #Step 3: check if policy has been edited and then delete it
    Log    ==================== Step 3: check if policy has been edited and then delete it ==================== 
    ${status}=    if ip policy exists    ${policy_name}
    Should be equal    "${status}"    "True"
    run keyword if    "${status}"=="True"     delete ip policy    ${policy_name}
    sleep   2
*** Keywords ***
case Teardown 
    Logout FortiGate
    close all browsers
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt