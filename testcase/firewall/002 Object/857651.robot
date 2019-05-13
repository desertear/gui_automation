*** Settings ***
Documentation    Verify zone interface can use as srcintf/dstintf for ipv4/ipv6/nat46/nat64/multicast/DoS/shaping policy in GUI (M461378)
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${policy_id}    ${FW_TEST_V4_POLICY_ID_1}
${ipv6_policy_id}    ${FW_TEST_V6_POLICY_ID_1}
${zone_intf}    857651_vlan
${zone_name}    857651_zone
${acl_id}    7651
${dos_id}    7652
${ipv6_acl_id}    7653
${ipv6_dos_id}    7654
${shape_id}    857651
${multicast_id}    ${FW_TEST_MULTICAST_POLICY_ID_1}
${nat46_id}    ${FW_TEST_POLICY46_ID_1}
${nat64_id}    ${FW_TEST_POLICY64_ID_1}
${vip_46}      ${FW_TEST_VIP46_1}
@{list_should_not_display}    ${zone_intf}
@{list_should_display}    ${zone_name}   ${FW_TEST_INTF_1}
*** Test Cases ***
857651
    [Documentation]
    [Tags]    chrome    857651    High
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown
    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects
# Step 1: test IPV4 policy interface
    Log    ==================== Step 1: test IPV4 policy interface source ====================
    Go to IPv4 policy
    View By Sequence
    Edit Policy By ID on Policy list    ${policy_id}
    Verify Interface Visibility in Policy Editor  incoming  ${list_should_not_display}  NO
    Verify Interface Visibility in Policy Editor  incoming  ${list_should_display}    YES
    Verify Interface Visibility in Policy Editor  outgoing  ${list_should_not_display}   NO
    Verify Interface Visibility in Policy Editor  outgoing  ${list_should_display}    YES
    Click Cancel Button on Policy Editor
# Step 2: test IPV6 policy interface
    Log    ==================== Step 2: test IPV6 policy interface source ====================
    Go to IPv6 policy
    View By Sequence
    Edit Policy By ID on Policy list    ${ipv6_policy_id}
    Verify Interface Visibility in Policy Editor  incoming  ${list_should_not_display}  NO
    Verify Interface Visibility in Policy Editor  incoming  ${list_should_display}    YES
    Verify Interface Visibility in Policy Editor  outgoing  ${list_should_not_display}   NO
    Verify Interface Visibility in Policy Editor  outgoing  ${list_should_display}    YES
    Click Cancel Button on Policy Editor
# Step 3: test NAT46 POLICY interface
    Log    ==================== Step 3: test NAT46 POLICY interface ====================
    Go to NAT46 policy
    View By Sequence
    Edit Policy By ID on Policy list    ${nat46_id}
    Verify Interface Visibility in Policy Editor  incoming  ${list_should_not_display}  NO    policy_type=NAT46
    Verify Interface Visibility in Policy Editor  incoming  ${list_should_display}  YES    policy_type=NAT46
    Verify Interface Visibility in Policy Editor  outgoing  ${list_should_not_display}   NO    policy_type=NAT46
    Verify Interface Visibility in Policy Editor  outgoing  ${list_should_display}    YES    policy_type=NAT46
    Click Cancel Button on Policy Editor
# Step 4: test NAT64 POLICY interface
    Log    ==================== Step 4: test NAT64 POLICY interface ====================
    Go to NAT64 policy
    View By Sequence
    Edit Policy By ID on Policy list   ${nat64_id}
    Verify Interface Visibility in Policy Editor  incoming  ${list_should_not_display}  NO    policy_type=NAT64
    Verify Interface Visibility in Policy Editor  incoming  ${list_should_display}  YES    policy_type=NAT64
    Verify Interface Visibility in Policy Editor  outgoing  ${list_should_not_display}   NO    policy_type=NAT64
    Verify Interface Visibility in Policy Editor  outgoing  ${list_should_display}    YES    policy_type=NAT64
    Click Cancel Button on Policy Editor
# Step 5: test MULTICAST POLICY interface
    Log    ==================== Step 5: test MULTICAST POLICY ====================
    Go to Multicast policy
    View By Sequence
    Edit Policy By ID on Policy list   ${multicast_id}
    Verify Interface Visibility in Policy Editor  incoming  ${list_should_not_display}  NO    policy_type=MULTICAST
    #Verify Interface Visibility in Policy Editor  incoming  ${list_should_display}  YES    policy_type=MULTICAST
    Verify Interface Visibility in Policy Editor  outgoing  ${list_should_not_display}   NO    policy_type=MULTICAST
    Verify Interface Visibility in Policy Editor  outgoing  ${list_should_display}    YES    policy_type=MULTICAST
    Click Cancel Button on Policy Editor
# Step 6: test DoS policy interface
    Log    ==================== Step 6: test DOS Policy ====================
    Go to Ipv4 DoS Policy
    Edit Other Policy By ID on Policy list    ${dos_id}   policy_type=DoS
    Verify Interface Visibility in Policy Editor  incoming  ${list_should_not_display}  NO    policy_type=DoS
    Verify Interface Visibility in Policy Editor  incoming  ${list_should_display}  YES    policy_type=DoS
    Click Button    ${GENERAL_EDITOR_CANCEL_BUTTON}
    Go to Ipv6 DoS Policy
    Edit Other Policy By ID on Policy list    ${ipv6_dos_id}   policy_type=DoS
    Verify Interface Visibility in Policy Editor  incoming  ${list_should_not_display}  NO    policy_type=DoS
    Verify Interface Visibility in Policy Editor  incoming  ${list_should_display}  YES    policy_type=DoS
    Click Button    ${GENERAL_EDITOR_CANCEL_BUTTON}
# Step 7: test SHAPING interface
    Log    ==================== Step 7: test SHAPING interface ====================
    Go to Shaping policy
    Open Shaping Policy Section
    Edit Shaping Policy By ID    ${shape_id}   
    Verify Interface Visibility in Policy Editor  outgoing  ${list_should_not_display}   NO    policy_type=SHAPING
    Verify Interface Visibility in Policy Editor  outgoing  ${list_should_display}    YES    policy_type=SHAPING
    Click Button    ${GENERAL_EDITOR_CANCEL_BUTTON}
    Logout FortiGate

*** Keywords ***

case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
