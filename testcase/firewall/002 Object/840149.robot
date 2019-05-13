*** Settings ***
Documentation    Verify from policy page of NGFW mode, rightclick on nat column would go to central snat list page (M305575)
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
@{fgt_cmd_test_en_cnat}     config vdom    edit ${FW_TEST_VDOM_NAME_1}   config system settings    set ngfw-mode profile-based    set central-nat enable    end    end
@{fgt_cmd_test_dis_cnat}     config vdom    edit ${FW_TEST_VDOM_NAME_1}   config system settings    set central-nat disable    end    end
*** Test Cases ***
840149
    [Documentation]
    [Tags]    chrome    840149    high
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown
    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
# Step 1: test in NGFW policybased mode, central nat should on the NAT menu
    Log    ==================== Step 1: test in NGFW policybased mode, central nat should on the page ====================
    Go to policy and objects
    Go to IPv4 policy
    View By Sequence
    Right Click Policy Column By ID on Policy List    ${FW_TEST_V4_POLICY_ID_1}   NAT
    Mouse Over Button in Context Menu    NAT
    Click Button in Context Submenu    NAT    Edit in Central SNAT
    Wait Until Element Is Visible   ${MENU_POLICY_CENTRAL_SNAT}
    Wait Until Element Is Visible   ${POLICY_V4V6_EDIT_BUTTON}
    Unselect Frame    
# Step 2: test in NGFW profilebased mode, and enable central nat, central nat should on the NAT menu
    Log    ==================== Step 2: test in NGFW profilebased mode, and enable central nat, central nat should on the NAT menu ====================
    Execute CLI commands on FortiGate Via Direct Telnet    ${fgt_cmd_test_en_cnat}
    Reload Page
    Go to policy and objects
    Go to IPv4 policy
    View By Sequence
    Right Click Policy Column By ID on Policy List    ${FW_TEST_V4_POLICY_ID_1}   NAT
    Mouse Over Button in Context Menu    NAT
    Click Button in Context Submenu    NAT    Edit in Central SNAT
    Wait Until Element Is Visible   ${MENU_POLICY_CENTRAL_SNAT}
    Wait Until Element Is Visible   ${POLICY_V4V6_EDIT_BUTTON}
    Unselect Frame    
# Step 3: test in NGFW profilebased mode, and disable central nat, central nat should not on the NAT menu
    Log    ==================== Step 3: test in NGFW profilebased mode, and disable central nat, central nat should not on the NAT menu ====================
    Execute CLI commands on FortiGate Via Direct Telnet    ${fgt_cmd_test_dis_cnat}
    Reload Page
    Go to policy and objects
    Go to IPv4 policy
    View By Sequence
    Right Click Policy Column By ID on Policy List    ${FW_TEST_V4_POLICY_ID_1}   NAT
    Mouse Over Button in Context Menu    NAT
    Wait and click     ${VAR_POLICY_V4V6_CONTEXT_MENU_POLICY_NAT_ENABLE}
    Unselect Frame  
    Go to IPv4 policy
    Logout FortiGate

*** Keywords ***

case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
