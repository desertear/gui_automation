*** Settings ***
Documentation    Verify gutter area can display on policy4/policy6/policy46/policy64/multicast policy creation/editing page (M469014)
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***

*** Test Cases ***
858399
    [Documentation]    
    [Tags]    chrome    858399    critical
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown
        
    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects    

#Step 1: Verfiy Gutter Area is displayed on ipv4 policy 
    Log    ==================== Step 1: Verfiy Gutter Area is displayed on ipv4 policy ====================
    Go to IPv4 policy   
    View By Sequence
    Gutter Should Be Visible When Edit Policy    ${FW_TEST_V4_POLICY_ID_1}
    Gutter Should Be Visible When Create New Policy

#Step 2: Verfiy Gutter Area is displayed on ipv6 policy 
    Log    ==================== Step 2: Verfiy Gutter Area is displayed on ipv6 policy ====================
    Go to IPv6 policy   
    View By Sequence
    Gutter Should Be Visible When Edit Policy    ${FW_TEST_V6_POLICY_ID_1}
    Gutter Should Be Visible When Create New Policy

#Step 3: Verfiy Gutter Area is displayed on policy64
    Log    ==================== Step 3: Verfiy Gutter Area is displayed on policy64 ====================
    Go to NAT64 policy   
    View By Sequence
    Gutter Should Be Visible When Edit Policy    ${FW_TEST_POLICY64_ID_1}
    Gutter Should Be Visible When Create New Policy

#Step 4: Verfiy Gutter Area is displayed on policy46
    Log    ==================== Step 3: Verfiy Gutter Area is displayed on policy46 ====================
    Go to NAT46 policy   
    View By Sequence
    Gutter Should Be Visible When Edit Policy    ${FW_TEST_POLICY46_ID_1}
    Gutter Should Be Visible When Create New Policy

#Step 5: Verfiy Gutter Area is displayed on multicast policy
    Log    ==================== Step 3: Verfiy Gutter Area is displayed on multicast policy ====================    
    Go to Multicast policy   
    View By Sequence
    Gutter Should Be Visible When Edit Policy    ${FW_TEST_MULTICAST_POLICY_ID_1}
    Gutter Should Be Visible When Create New Policy

    Logout FortiGate

*** Keywords ***
Gutter Should be Visible When Create New Policy
    Click Create New Button on Policy List
    Element Should Be Visible    ${POLICY_GUTTER_AREA}
    Click Cancel Button on Policy Editor

Gutter Should be Visible When Edit Policy
    [Arguments]   ${policy_id}
    Edit Policy By ID on Policy list    ${policy_id}
    Element Should Be Visible    ${POLICY_GUTTER_AREA}
    Click Cancel Button on Policy Editor


case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}