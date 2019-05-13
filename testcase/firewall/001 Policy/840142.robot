*** Settings ***
Documentation    Verify on policy page, Enabled/Disabled or ippool name can be displayed on nat column (M305575)
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
@{column_list}    NAT

*** Test Cases ***
840142
    [Documentation]
    [Tags]    chrome    840142    High
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects

# Step 1: ipv4 policy NAT column display NAT Enabled/Disabled and ip pool name
    Log    ==================== Step 1: ipv4 policy NAT column display NAT Enabled/Disabled and ip pool name ====================
    Go to IPv4 policy
    View By Sequence
    ${NAT_display}=    Get Policy Config by Column Name and Policy ID    ${column_list}    ${FW_TEST_V4_POLICY_ID_1}
    Should Be Equal    ${NAT_display[1]}    Enabled
    ${NAT_display}=    Get Policy Config by Column Name and Policy ID    ${column_list}    ${FW_TEST_V4_POLICY_ID_2}
    ${expect}=    Catenate    SEPARATOR=    ${FW_TEST_IP_POOLS_3}    ${FW_TEST_IP_POOLS_2}
    Should Be Equal    ${NAT_display[1]}    ${expect}    
    ${NAT_display}=    Get Policy Config by Column Name and Policy ID    ${column_list}    ${FW_TEST_V4_POLICY_ID_3}
    Should Be Equal    ${NAT_display[1]}    Disabled

# Step 2: ipv6 policy NAT column display NAT Enabled/Disabled and ip pool name
    Log    ==================== Step 2: ipv6 policy NAT column display NAT Enabled/Disabled and ip pool name ====================    

    Go to IPv6 policy
    View By Sequence
    ${NAT_display}=    Get Policy Config by Column Name and Policy ID    ${column_list}    ${FW_TEST_V6_POLICY_ID_1}
    Should Be Equal    ${NAT_display[1]}    Enabled
    ${NAT_display}=    Get Policy Config by Column Name and Policy ID    ${column_list}    ${FW_TEST_V6_POLICY_ID_2}
    ${expect}=    Catenate    SEPARATOR=    ${FW_TEST_IP_POOLS6_1}    ${FW_TEST_IP_POOLS6_2}
    Should Be Equal    ${NAT_display[1]}    ${expect}
    ${NAT_display}=    Get Policy Config by Column Name and Policy ID    ${column_list}    ${FW_TEST_V6_POLICY_ID_3}
    Should Be Equal    ${NAT_display[1]}    Disabled

    Logout FortiGate

*** Keywords ***


case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
