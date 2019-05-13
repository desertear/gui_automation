*** Settings ***
Documentation    Verify wildcardfqdn object and group should filter out from omniselect list of ipv4/ipv4_acl/ipv4_DoS/shaping-policy.(M305725/389530)
...              Failcase! bug#0542379
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${policy_id}    ${FW_TEST_V4_POLICY_ID_1}
${add_grp_1}    ${FW_TEST_ADDR_GROUP_1}
${add_grp_2}    ${FW_TEST_ADDR_GROUP_2}
${add_grp_3}    ${FW_TEST_ADDR_GROUP_3}
${acl_id}    8567
${shape_id}    8567413
${dos_id}    6741
@{list_should_not_display}    ${add_grp_1}    ${add_grp_2}
@{list_should_display}    ${add_grp_3}
*** Test Cases ***
856741
    [Documentation]
    [Tags]    chrome    856741    High
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown
    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects
    Log    ==================== Step 1: test IPV4 policy address source ====================
# Step 1: test IPV4 policy address
    Go to IPv4 policy
    View By Sequence
    Edit Policy By ID on Policy list    ${policy_id}
    Verify Address Visibility in Policy Editor    Source Address   ${list_should_not_display}    NO
    Verify Address Visibility in Policy Editor    Source Address   ${list_should_display}    YES
    Verify Address Visibility in Policy Editor    Destination Address    ${list_should_not_display}    NO
    Verify Address Visibility in Policy Editor    Destination Address    ${list_should_display}    YES
    Click Cancel Button on Policy Editor
# Step 2: test IPV4 ACL address
    Log    ==================== Step 2: test IPV4 ACL ====================
    Go to Ipv4 ACL
    Edit Other Policy By ID on Policy list    ${acl_id}   policy_type=ACL
    Verify Address Visibility in Policy Editor    Source Address   ${list_should_not_display}    NO   policy_type=ACL
    Verify Address Visibility in Policy Editor    Source Address   ${list_should_display}    YES    policy_type=ACL
    #Verify Address Visibility in Policy Editor    Destination Address    ${list_should_not_display}    NO    policy_type=ACL
    Verify Address Visibility in Policy Editor    Destination Address    ${list_should_display}    YES    policy_type=ACL
    Click Cancel Button on Policy Editor
# Step 3: test IPV4 DoS address
    Log    ==================== Step 3: test IPV4 DOS ====================
    Go to Ipv4 DoS Policy
    Edit Other Policy By ID on Policy list    ${dos_id}   policy_type=DoS
    Verify Address Visibility in Policy Editor    Source Address   ${list_should_not_display}    NO   policy_type=DoS
    Verify Address Visibility in Policy Editor    Source Address   ${list_should_display}    YES    policy_type=DoS
    Verify Address Visibility in Policy Editor    Destination Address    ${list_should_not_display}    NO    policy_type=DoS
    Verify Address Visibility in Policy Editor    Destination Address    ${list_should_display}    YES    policy_type=DoS
    Click Button    ${GENERAL_EDITOR_CANCEL_BUTTON}
# Step 4: test IPV4 DoS address
    Log    ==================== Step 4: test IPV4 SHAPING ====================
    Go to Shaping policy
    Open Shaping Policy Section
    Edit Shaping Policy By ID    ${shape_id}   
    Verify Address Visibility in Policy Editor    Source Address   ${list_should_not_display}    NO   policy_type=SHAPING
    Verify Address Visibility in Policy Editor    Source Address   ${list_should_display}    YES    policy_type=SHAPING
    Verify Address Visibility in Policy Editor    Destination Address    ${list_should_not_display}    NO    policy_type=SHAPING
    Verify Address Visibility in Policy Editor    Destination Address    ${list_should_display}    YES    policy_type=SHAPING
    Click Button    ${GENERAL_EDITOR_CANCEL_BUTTON}
    Logout FortiGate

*** Keywords ***

case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
