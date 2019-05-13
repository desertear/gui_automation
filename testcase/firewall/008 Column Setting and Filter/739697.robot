*** Settings ***
Documentation    Verify GUI default display can be customized(155712) per vdom
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
@{column_root}    ID    From    Source Address    Destination Address    Schedule    Service    Action    Log    NAT
@{column_test1}    Status    Bytes    Packets    Active Sessions    Last Used    First Used    Hit Count    Security Profiles    AV
@{column_test2}    Email Filter    Web Filter    Application Control    IPS    DLP    ICAP    VoIP    Protocol Options
@{column_tp}    SSL Inspection    VPN Tunnel    Comments    Source    Users    Groups

*** Test Cases ***
739697
    [Documentation]    This case has bug 442195 and 367616, the scripts is designed AS-IS to pass it.
    [Tags]    chrome    739697    high    has_bug
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown
    Login FortiGate
    
    #Step 1: Test display on vdom root
    Log    ==================== Step 1: Test display on vdom root ====================
    Go to VDOM    ${FW_TEST_VDOM_NAME_root}
    # test ipv4 policy
    Go to policy and objects
    Go to IPv4 policy
    View By Sequence
    ${status}=    Check If Columns are Displayed in Policy Table    ${column_root}    4
    Should be True    ${status}
    # test ipv6 policy
    Go to policy and objects
    Go to IPv6 policy
    View By Sequence
    ${status}=    Check If Columns are Displayed in Policy Table    ${column_root}    6
    Should be True    ${status}
    #Step 2: Test display on test vdom 1
    Log    ==================== Step 2: Test display on test vdom 1 ====================
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}    ${FW_TEST_VDOM_NAME_root}
    # test ipv4 policy
    Go to policy and objects
    Go to IPv4 policy
    View By Sequence
    ${status}=    Check If Columns are Displayed in Policy Table    ${column_test1}    4
    Should be True    ${status}
    # test ipv6 policy
    Go to policy and objects
    Go to IPv6 policy
    View By Sequence
    ${status}=    Check If Columns are Displayed in Policy Table    ${column_test1}    6
    Should be True    ${status}

    #Step 3: Test display on test vdom 2
    Log    ==================== Step 3: Test display on test vdom 2 ====================
    Go to VDOM    ${FW_TEST_VDOM_NAME_2}    ${FW_TEST_VDOM_NAME_1}
    # test ipv4 policy
    Go to policy and objects
    Go to IPv4 policy
    View By Sequence
    ${status}=    Check If Columns are Displayed in Policy Table    ${column_test2}    4
    Should be True    ${status}

    # test ipv6 policy
    Go to policy and objects
    Go to IPv6 policy
    View By Sequence
    ${status}=    Check If Columns are Displayed in Policy Table    ${column_test2}    6
    Should be True    ${status}
 
    #Step 4: Test display on test vdom tp
    Log    ==================== Step 4: Test display on test vdom tp ==================== 
    Go to VDOM    ${FW_TEST_VDOM_NAME_TP}    ${FW_TEST_VDOM_NAME_2}
    # test ipv4 policy
    Go to policy and objects
    Go to IPv4 policy
    View By Sequence
    ${status}=    Check If Columns are Displayed in Policy Table    ${column_tp}    4
    Should be True    ${status}

    # test ipv6 policy
    Go to policy and objects
    Go to IPv6 policy
    View By Sequence
    ${status}=    Check If Columns are Displayed in Policy Table    ${column_tp}    6
    Should be True    ${status}
    
    Logout FortiGate
 
*** Keywords ***
case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}