*** Settings ***
Documentation    create ipv4 vwp Policy: Verify basic DENY policy can be created/deleted with only one direction, srcaddr, dstaddr schedule and service
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${vwp_name}   893413_vwp
${policy_name}   893413
@{source_addresses}    ADDRESS:${FW_TEST_ADDR_1}
@{destination_addresses}   ADDRESS:${FW_TEST_ADDR_2}
${policy_name_new}   893413_edit
*** Test Cases ***
893413
    [Documentation]    
    [Tags]    chrome    893413    High
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown
    Login FortiGate  
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects  
    Go to Policy_IPV4_VWP_Policy
    #Step 1: create ipv4 vwp policy
    Log    ==================== Step 1: create ipv4 vwp policy ==================== 
    create vwp policy  ${vwp_name}  ${policy_name}  ${source_addresses}  ${destination_addresses} 
    ...    always    ALL    DENY     direction=right

    #Step 2: check if policy has been created and then edit it
    Log    ==================== Step 2: check if policy has been created and then edit it ==================== 
    ${status}=    if ip policy exists    ${policy_name}
    Should be equal    "${status}"    "True"
    edit vwp policy    ${vwp_name}    ${policy_name}    ${policy_name_new}     ${source_addresses}    ${destination_addresses}
    ...    always    ALL    DENY    direction=left
    sleep   2

    #Step 3: check if policy has been edited and then delete it
    Log    ==================== Step 3: check if policy has been edited and then delete it ==================== 
    ${status}=    if ip policy exists    ${policy_name_new}
    Should be equal    "${status}"    "True"
    run keyword if    "${status}"=="True"     delete ip policy    ${policy_name_new}
    sleep   2
*** Keywords ***
case Teardown 
    Logout FortiGate
    close all browsers
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt