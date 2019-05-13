*** Settings ***
Documentation    Verify virtual-wire-pair interface members are not listed in policy lookup
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${virtual_wirepair_intf}    v*w=p a-i.r
${first_item_in_src_intf_list}    xpath://div[contains(@class,"selection-dropdown")]//div[span][1]  

*** Test Cases ***
808388
    [Documentation]    
    [Tags]    chrome    808388    medium
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown
        
    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects  

#Step 1: Verify source interface in policy lookup dialog does not show virtual wire pair member
    Log    ==================== Step 1: Verify source interface in policy lookup dialog does not show virtual wire pair member ====================
    Go to IPv4 policy 
    Click Policy Lookup Button on Policy List
    Interface Visibility in Source Interface    ${FW_TEST_INTF_3}    No
    Interface Visibility in Source Interface    ${FW_TEST_INTF_4}    No
    Click Cancel Button on Policy Lookup

    Go to IPv6 policy
    Click Policy Lookup Button on Policy List
    Interface Visibility in Source Interface    ${FW_TEST_INTF_3}    No
    Interface Visibility in Source Interface    ${FW_TEST_INTF_4}    No
    Click Cancel Button on Policy Lookup

#Step 2: Verify source interface in policy lookup dialog shows interface that is removed from virtual wire pair
    Log    ==================== Step 2: Verify source interface in policy lookup dialog shows interface that is removed from virtual wire pair ====================
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_cli.txt

    Go to IPv4 policy 
    Click Policy Lookup Button on Policy List
    Interface Visibility in Source Interface    ${FW_TEST_INTF_3}    YES
    Interface Visibility in Source Interface    ${FW_TEST_INTF_4}    YES
    Click Cancel Button on Policy Lookup

    Go to IPv6 policy 
    Click Policy Lookup Button on Policy List
    Interface Visibility in Source Interface    ${FW_TEST_INTF_3}    YES
    Interface Visibility in Source Interface    ${FW_TEST_INTF_4}    YES
    Click Cancel Button on Policy Lookup 
 
    Logout FortiGate

*** Keywords ***
Interface Visibility in Source Interface
    [Arguments]   ${src_intf}    ${display}
    Click Element    ${POLICY_V4V6_POLICY_LOOKUP_SRC_INTF}
    ${selection_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_V4V6_POLICY_LOOKUP_SRC_INTF_SELECTION}    ${src_intf}
    Run Keyword If    "${display}" == "YES"    Element Should Be Visible    ${selection_locator}
    ...    ELSE IF    "${display}" == "No"    Element Should Not Be Visible    ${selection_locator}
    #click first item just to close the selection list
    Click Element    ${first_item_in_src_intf_list}

case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}