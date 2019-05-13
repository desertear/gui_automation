*** Settings ***
Documentation    Verify policy name is mandatory and unique per vdom when configuring from the GUI (M269948)
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***

*** Test Cases ***
808805
    [Documentation]    
    [Tags]    chrome    808805    critical
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown
        
    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects    

#Step 1: gui-advanced-policy is disabled, should not show ID in policy editor
    Log    ==================== Step 1: gui-advanced-policy is disabled, should not show ID in policy editor ====================
    #test ipv4 policy
    Go to IPv4 policy    
    View By Sequence    
    Click Create New Button on Policy List
    Element Should Not Be Visible    ${POLICY_V4V6_ID}
    Element Should Not Be Visible    ${POLICY_V4V6_ID_INPUT}    
    Click Cancel Button on Policy Editor

    View By Sequence
    Edit Policy By ID on Policy list    ${FW_TEST_V4_POLICY_ID_1}
    Element Should Not Be Visible    ${POLICY_V4V6_ID}
    Element Should Not Be Visible    ${POLICY_V4V6_ID_TEXT}    
    Click Cancel Button on Policy Editor

    #test ipv6 policy
    Go to IPv6 policy    
    View By Sequence    
    Click Create New Button on Policy List
    Element Should Not Be Visible    ${POLICY_V4V6_ID}
    Element Should Not Be Visible    ${POLICY_V4V6_ID_INPUT}    
    Click Cancel Button on Policy Editor

    View By Sequence
    Edit Policy By ID on Policy list    ${FW_TEST_V6_POLICY_ID_1}
    Element Should Not Be Visible    ${POLICY_V4V6_ID}
    Element Should Not Be Visible    ${POLICY_V4V6_ID_TEXT}    
    Click Cancel Button on Policy Editor     

#Step 2: gui-advanced-policy is enable, should show ID in policy editor
    Log    ====================Step 2: gui-advanced-policy is enable, should show ID in policy editor ====================
    #Enable gui-advanced-policy on cli
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_cli.txt
    Reload Page
    Wait Until Element Is Visible    ${MENU_POLICY_IPV4_POLICY}
    Go to policy and objects
    Go to IPv4 policy    
    View By Sequence    
    Click Create New Button on Policy List
    Element Should Be Visible    ${POLICY_V4V6_ID}
    Element Should Be Visible    ${POLICY_V4V6_ID_INPUT}    
    Click Cancel Button on Policy Editor

    View By Sequence
    Edit Policy By ID on Policy list    ${FW_TEST_V4_POLICY_ID_1}
    Element Should Be Visible    ${POLICY_V4V6_ID}
    Element Should Contain    ${POLICY_V4V6_ID_TEXT}    ${FW_TEST_V4_POLICY_ID_1}
    Click Cancel Button on Policy Editor 

    #test ipv6 policy
    Go to IPv6 policy    
    View By Sequence    
    Click Create New Button on Policy List
    Element Should Be Visible    ${POLICY_V4V6_ID}
    Element Should Be Visible    ${POLICY_V4V6_ID_INPUT}    
    Click Cancel Button on Policy Editor

    View By Sequence
    Edit Policy By ID on Policy list    ${FW_TEST_V6_POLICY_ID_1}
    Element Should Be Visible    ${POLICY_V4V6_ID}
    Element Should Contain    ${POLICY_V4V6_ID_TEXT}    ${FW_TEST_V6_POLICY_ID_1}  
    Click Cancel Button on Policy Editor     

    Logout FortiGate

*** Keywords ***
case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}