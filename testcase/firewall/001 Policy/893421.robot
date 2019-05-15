*** Settings ***
Documentation    Create ipv4 vwp policy, verify proxy-based policy can be created/deleted using default utm profile
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${vwp_name}   893421_vwp
${policy_name}   893421
@{incoming}    ${FW_TEST_INTF_1}
@{outgoing}    ${FW_TEST_INTF_2}
@{source_addresses}    ADDRESS:${FW_TEST_ADDR_1}   
@{destination_addresses}   ADDRESS:${FW_TEST_ADDR_2}
@{security_profile_list}   AntiVirus:g-default    Web Filter:g-default    DNS Filter:default    Application Control:g-default    IPS:g-default   SSL Inspection:no-inspection
@{security_profile_check_list}   AntiVirus   Web Filter    DNS Filter    Application Control    IPS   SSL Inspection
${policy_name_new}   893421_edit
@{source_addresses_new}    ADDRESS:${FW_TEST_ADDR_2} 
@{destination_addresses_new}   ADDRESS:${FW_TEST_ADDR_1}
@{column_list}    Source    Destination
@{config_list}    config    ${FW_TEST_ADDR_2}    ${FW_TEST_ADDR_1}
*** Test Cases ***
893421
    [Documentation]    
    [Tags]    chrome    893421    High   firewall_new
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown
    Login FortiGate  
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects  
    Go to Policy_IPV4_VWP_Policy
    #Step 1: create ipv4 vwp policy
    Log    ==================== Step 1: create ipv4 vwp policy ==================== 
    create vwp policy  ${vwp_name}  ${policy_name}   ${source_addresses}  ${destination_addresses} 
    ...    always    ALL    ACCEPT     direction=bi   inspection_mode=Proxy-based   security_profile=${security_profile_list}
    

    #Step 2: check if policy has been created and then edit it
    Log    ==================== Step 2: check if policy has been created and then edit it ==================== 
    ${status}=    if ip policy exists    ${policy_name}
    Should be equal    "${status}"    "True"
    ${config}=    Get Policy Security Profile Config by Policy NAME    ${security_profile_check_list}    ${policy_name}
    Lists Should Be Equal    ${config}    ${security_profile_list}
    edit vwp policy    ${vwp_name}    ${policy_name}    ${policy_name_new}     ${source_addresses_new}    ${destination_addresses_new}
    ...    always    ALL    ACCEPT    direction=left    inspection_mode=Proxy-based    security_profile=${security_profile_list}
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