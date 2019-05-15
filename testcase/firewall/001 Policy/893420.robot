*** Settings ***
Documentation    Create ipv4 vwp Policy: Verify basic ACCEPT policy can be created/deleted with bi-direction, srcaddr, dstaddr schedule and service
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${vwp_name}   893420_vwp
${policy_name}   893420
@{source_addresses}    ADDRESS:${FW_TEST_ADDR_1}
@{destination_addresses}   ADDRESS:${FW_TEST_ADDR_2}
${policy_name_new}   893420_new
@{source_addresses_new}    ADDRESS:${FW_TEST_ADDR_1}   ADDRESS:${FW_TEST_ADDR_3}
@{destination_addresses_new}   ADDRESS:${FW_TEST_ADDR_2}
@{column_list}    Source    Destination
@{configed_list}   config    ${FW_TEST_ADDR_1}${FW_TEST_ADDR_3}    ${FW_TEST_ADDR_2}
*** Test Cases ***
893420
    [Documentation]    
    [Tags]    chrome    893420    High
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown
    Login FortiGate  
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects  
    Go to Policy_IPV4_VWP_Policy
    #Step 1: create ipv4 vwp policy
    Log    ==================== Step 1: create ipv4 vwp policy ==================== 
    create vwp policy  ${vwp_name}  ${policy_name}   ${source_addresses}  ${destination_addresses} 
    ...    always    ALL    ACCEPT     direction=bi

    #Step 2: check if policy has been created and then edit it
    Log    ==================== Step 2: check if policy has been created and then edit it ==================== 
    ${status}=    if ip policy exists    ${policy_name}
    Should be equal    "${status}"    "True"
    edit vwp policy    ${vwp_name}    ${policy_name}    ${policy_name_new}     ${source_addresses_new}    ${destination_addresses_new}
    ...    always    ALL    ACCEPT    direction=left
    sleep   2

    #Step 3: check if policy has been edited correctly
    Log    ==================== Step 3: check if policy has been edited correctly ==================== 
    ${config}=    Get Policy Config by Column Name and Policy NAME    ${column_list}     ${policy_name_new} 
    Lists Should Be Equal    ${config}    ${configed_list} 
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