*** Settings ***
Documentation    Verify policy create and edit page support intelligent detection of duplicate firewall policies (M396160)
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
@{addresses}    ADDRESS:all
@{addresses6}    ADDRESS:all
@{service}    ${FW_TEST_SERVICE_ALL}    
${dup_policy_warning_div}    xpath://div[contains(@class,"warning-message")]
${dup_policy_warning_msg}    xpath://div[contains(@class,"warning-message")]/label/span
${dup_policy_warning_item1}    xpath://div[contains(@class,"warning-message")]/label/ul/li[1]
${dup_policy_warning_item2}    xpath://div[contains(@class,"warning-message")]/label/ul/li[2]
${dup_policy_warning_item3}    xpath://div[contains(@class,"warning-message")]/label/ul/li[3]

*** Test Cases ***
832185
    [Documentation]
    [Tags]    chrome    832185    High
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects

# Step 1: duplicate policy information is displayed when create a new policy
    Log    ==================== Step 1: duplicate policy information is displayed when create a new policy ====================
    Go to IPv4 policy
    View By Sequence
    Click Create New Button on Policy List
    Select from List on Policy Editor    Incoming Interface    ${FW_TEST_INTF_1}
    sleep    1s
    Select from List on Policy Editor    Outgoing Interface    ${FW_TEST_INTF_2}
    sleep    1s
    Select Address on Policy Editor    Source    ${addresses}
    sleep    1s
    Select Address on Policy Editor    Destination    ${addresses}
    Select from List on Policy Editor    Schedule     ${FW_TEST_SCHEDULE_ALWAYS}
    Select Service on Policy Editor    ${service}

    Wait Until Element Is Visible    ${dup_policy_warning_div}
    Wait Until Element Contains    ${dup_policy_warning_msg}    This policy may be a duplicate of these existing policies
    Wait Until Element Contains    ${dup_policy_warning_item1}    test_${FW_TEST_V4_POLICY_ID_1} (${FW_TEST_V4_POLICY_ID_1})        
    Wait Until Element Contains    ${dup_policy_warning_item2}    test_${FW_TEST_V4_POLICY_ID_2} (${FW_TEST_V4_POLICY_ID_2})
    Wait Until Element Contains    ${dup_policy_warning_item3}    test_${FW_TEST_V4_POLICY_ID_4} (${FW_TEST_V4_POLICY_ID_4})

    Click Cancel Button on Policy Editor

    Go to IPv6 policy
    View By Sequence
    Click Create New Button on Policy List
    sleep    1s
    Select from List on Policy Editor    Incoming Interface    ${FW_TEST_INTF_1}
    sleep    1s
    Select from List on Policy Editor    Outgoing Interface    ${FW_TEST_INTF_2}
    sleep    1s
    Select Address on Policy Editor    Source    ${addresses6}
    sleep    1s
    Select Address on Policy Editor    Destination Address    ${addresses6}
    Select from List on Policy Editor    Schedule     ${FW_TEST_SCHEDULE_ALWAYS}
    Select Service on Policy Editor    ${service}

    Wait Until Element Is Visible    ${dup_policy_warning_div}
    Wait Until Element Contains    ${dup_policy_warning_msg}    This policy may be a duplicate of these existing policies
    Wait Until Element Contains    ${dup_policy_warning_item1}    test_${FW_TEST_V6_POLICY_ID_1} (${FW_TEST_V6_POLICY_ID_1})        
    Wait Until Element Contains    ${dup_policy_warning_item2}    test_${FW_TEST_V6_POLICY_ID_2} (${FW_TEST_V6_POLICY_ID_2})
    Wait Until Element Contains    ${dup_policy_warning_item3}    test_${FW_TEST_V6_POLICY_ID_4} (${FW_TEST_V6_POLICY_ID_4})

    Click Cancel Button on Policy Editor

# Step 2: duplicate policy information when policy has same srcintf, dstintf, srcaddr, dstaddr, service, and schedule
    Log    ==================== Step 2: duplicate policy information when policy has same srcintf, dstintf, srcaddr, dstaddr, service, and schedule ====================

    Go to IPv4 policy
    View By Sequence
    Edit Policy By ID on Policy list    ${FW_TEST_V4_POLICY_ID_1}
    Wait Until Element Is Visible    ${dup_policy_warning_div}
    Wait Until Element Contains    ${dup_policy_warning_msg}    This policy may be a duplicate of these existing policies
    Wait Until Element Contains    ${dup_policy_warning_item1}    test_${FW_TEST_V4_POLICY_ID_2} (${FW_TEST_V4_POLICY_ID_2})        
    Wait Until Element Contains    ${dup_policy_warning_item2}    test_${FW_TEST_V4_POLICY_ID_4} (${FW_TEST_V4_POLICY_ID_4})
    Click Cancel Button on Policy Editor

    Go to IPv6 policy
    View By Sequence
    Edit Policy By ID on Policy list    ${FW_TEST_V6_POLICY_ID_1}
    Wait Until Element Is Visible    ${dup_policy_warning_div}
    Wait Until Element Contains    ${dup_policy_warning_msg}    This policy may be a duplicate of these existing policies
    Wait Until Element Contains    ${dup_policy_warning_item1}    test_${FW_TEST_V6_POLICY_ID_2} (${FW_TEST_V6_POLICY_ID_2})        
    Wait Until Element Contains    ${dup_policy_warning_item2}    test_${FW_TEST_V6_POLICY_ID_4} (${FW_TEST_V6_POLICY_ID_4})   
    Click Cancel Button on Policy Editor

# Step 3: duplicate policy information is not displayed when policy is not the same
    Log    ==================== Step 3: Should allow two policies from different VDOM using same name ====================
    Go to IPv4 policy
    View By Sequence
    Edit Policy By ID on Policy list    ${FW_TEST_V4_POLICY_ID_3}
    Wait Until Element Is Not Visible    ${dup_policy_warning_div}   
    Click Cancel Button on Policy Editor

    Go to IPv6 policy
    View By Sequence
    Edit Policy By ID on Policy list    ${FW_TEST_V6_POLICY_ID_3}
    Wait Until Element Is Not Visible    ${dup_policy_warning_div}   
    Click Cancel Button on Policy Editor

    Logout FortiGate

*** Keywords ***
case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
