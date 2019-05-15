*** Settings ***
Documentation    Create IPv4 VWP Policy: Verify accept and deny policy can be created/edited using Address, User and Internet Service mixed as Source
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${policy_name}   893414
@{incoming}    ${FW_TEST_INTF_1}    ${FW_TEST_INTF_2}
@{outgoing}    ${FW_TEST_INTF_2}    ${FW_TEST_INTF_1}
@{source_addresses}    ADDRESS:${FW_TEST_ADDR_1}    USER:${FW_TEST_LOCAL_USER_1}   INTERNET SERVICE:Amazon-AWS
@{destination_addresses}   ADDRESS:${FW_TEST_ADDR_2}
${policy_name_new}   893414_edit
@{source_addresses_new}    ADDRESS:${FW_TEST_ADDR_2}    USER:${FW_TEST_LOCAL_USER_2}   INTERNET SERVICE:Google-Google.Cloud
@{destination_addresses_new}   ADDRESS:${FW_TEST_ADDR_1}
@{column_list}    Source   Destination
@{config_list}    config    ${FW_TEST_ADDR_2}${FW_TEST_LOCAL_USER_2}INTERNET SERVICE:Google-Google.Cloud    ${FW_TEST_ADDR_1}
*** Test Cases ***
893414
    [Documentation]    
    [Tags]    chrome    893414    High
    [setup] 
    [Teardown]    case Teardown
    Login FortiGate  
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects  
    Go to Policy_IPV4_VWP_Policy
    #Step 1: check multi-interface setting in gui and create ipv4 vwp policy
    Log    ==================== Step 1: check multi-interface setting in gui and create ipv4 vwp policy ==================== 
    create vwp policy  ${vwp_name}  ${policy_name}  ${source_addresses}  ${destination_addresses} 
    ...    always    ALL    ACCEPT     direction=bi
    sleep   2
    
    #Step 2: check if policy has been created and then edit it
    Log    ==================== Step 2: check if policy has been created and then edit it ==================== 
    create vwp policy  ${vwp_name}  ${policy_name}  ${source_addresses_new}  ${destination_addresses_new} 
    ...    always    ALL    DENY     direction=bi
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