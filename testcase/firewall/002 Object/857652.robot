*** Settings ***
Documentation    Verify SD-WAN can use as srcintf/dstintf for ipv4/ipv6/shaping policy and members for nat64/nat46/multicast/DoS/Acl in GUI (M472579)
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${policy_id}    ${FW_TEST_V4_POLICY_ID_1}
${ipv6_policy_id}    ${FW_TEST_V6_POLICY_ID_1}
${sdwan_intf}    857652_vlan
${acl_id}    7651
${dos_id}    7652
${ipv6_acl_id}    7653
${ipv6_dos_id}    7654
${shape_id}    857652
${multicast_id}    ${FW_TEST_MULTICAST_POLICY_ID_1}
${nat46_id}    ${FW_TEST_POLICY46_ID_1}
${nat64_id}    ${FW_TEST_POLICY64_ID_1}
${vip_46}      ${FW_TEST_VIP46_1}
@{list_should_not_display_sdwan}    ${sdwan_intf}
@{list_should_display_sdwan}    SD-WAN   ${FW_TEST_INTF_1}
@{list_should_not_display_member}    SD-WAN  
@{list_should_display_member}    ${sdwan_intf}    ${FW_TEST_INTF_1}
*** Test Cases ***
857652
    [Documentation]
    [Tags]    chrome    857652    Medium
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown
    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects
# Step 1: test IPV4/IPV6 policy interface
    Log    ==================== Step 1: test IPV4/ipv6 policy interface source ====================
    Go to IPv4 policy
    View By Sequence
    Edit Policy By ID on Policy list    ${policy_id}
    Verify Interface Visibility in Policy Editor  incoming  ${list_should_not_display_sdwan}  NO
    Verify Interface Visibility in Policy Editor  incoming  ${list_should_display_sdwan}    YES
    Verify Interface Visibility in Policy Editor  outgoing  ${list_should_not_display_sdwan}   NO
    Verify Interface Visibility in Policy Editor  outgoing  ${list_should_display_sdwan}    YES
    Click Cancel Button on Policy Editor
    Go to IPv6 policy
    View By Sequence
    Edit Policy By ID on Policy list    ${ipv6_policy_id}
    Verify Interface Visibility in Policy Editor  incoming  ${list_should_not_display_sdwan}  NO
    Verify Interface Visibility in Policy Editor  incoming  ${list_should_display_sdwan}    YES
    Verify Interface Visibility in Policy Editor  outgoing  ${list_should_not_display_sdwan}   NO
    Verify Interface Visibility in Policy Editor  outgoing  ${list_should_display_sdwan}    YES
    Click Cancel Button on Policy Editor
# Step 2: test SHAPING interface
    Log    ==================== Step 2: test SHAPING ====================
    Go to Shaping policy
    Open Shaping Policy Section
    Edit Shaping Policy By ID    ${shape_id}   
    Verify Interface Visibility in Policy Editor  outgoing  ${list_should_not_display_sdwan}   NO    policy_type=SHAPING
    Verify Interface Visibility in Policy Editor  outgoing  ${list_should_display_sdwan}    YES    policy_type=SHAPING
    Click Button    ${GENERAL_EDITOR_CANCEL_BUTTON}
# Step 3: test NAT46 POLICY interface
    Log    ==================== Step 3: test NAT46 POLICY interface ====================
    Go to NAT46 policy
    View By Sequence
    Edit Policy By ID on Policy list    ${nat46_id}
    Verify Interface Visibility in Policy Editor  incoming  ${list_should_not_display_member}  NO    policy_type=NAT46
    Verify Interface Visibility in Policy Editor  incoming  ${list_should_display_member}  YES    policy_type=NAT46
    Verify Interface Visibility in Policy Editor  outgoing  ${list_should_not_display_member}   NO    policy_type=NAT46
    Verify Interface Visibility in Policy Editor  outgoing  ${list_should_display_member}    YES    policy_type=NAT46
    Click Button    ${GENERAL_EDITOR_CANCEL_BUTTON}
# Step 4: test NAT64 POLICY interface
    Log    ==================== Step 4: test NAT64 POLICY interface ====================
    Go to NAT64 policy
    View By Sequence
    Edit Policy By ID on Policy list    ${nat64_id}
    Verify Interface Visibility in Policy Editor  incoming  ${list_should_not_display_member}  NO    policy_type=NAT64
    Verify Interface Visibility in Policy Editor  incoming  ${list_should_display_member}  YES    policy_type=NAT64
    Verify Interface Visibility in Policy Editor  outgoing  ${list_should_not_display_member}   NO    policy_type=NAT64
    Verify Interface Visibility in Policy Editor  outgoing  ${list_should_display_member}    YES    policy_type=NAT64
    Click Button    ${GENERAL_EDITOR_CANCEL_BUTTON}
# Step 5: test MULTICAST POLICY interface
    Log    ==================== Step 5: test MULTICAST POLICY ====================
    Go to Multicast policy
    View By Sequence
    Edit Policy By ID on Policy list   ${multicast_id}
    Verify Interface Visibility in Policy Editor  incoming  ${list_should_not_display_member}  NO    policy_type=MULTICAST
    Verify Interface Visibility in Policy Editor  incoming  ${list_should_display_member}  YES    policy_type=MULTICAST
    Verify Interface Visibility in Policy Editor  outgoing  ${list_should_not_display_member}   NO    policy_type=MULTICAST
    Verify Interface Visibility in Policy Editor  outgoing  ${list_should_display_member}    YES    policy_type=MULTICAST
    Click Cancel Button on Policy Editor
# Step 6: test  DoS interface
    Log    ==================== Step 6: test DOS ====================
    Go to Ipv4 DoS Policy
    Edit Other Policy By ID on Policy list    ${dos_id}   policy_type=DoS
    Verify Interface Visibility in Policy Editor  incoming  ${list_should_not_display_member}  NO    policy_type=DoS
    Verify Interface Visibility in Policy Editor  incoming  ${list_should_display_member}  YES    policy_type=DoS
    Click Button    ${GENERAL_EDITOR_CANCEL_BUTTON}
    Go to Ipv6 DoS Policy
    Edit Other Policy By ID on Policy list    ${ipv6_dos_id}   policy_type=DoS
    Verify Interface Visibility in Policy Editor  incoming  ${list_should_not_display_member}  NO    policy_type=DoS
    Verify Interface Visibility in Policy Editor  incoming  ${list_should_display_member}  YES    policy_type=DoS
    Click Button    ${GENERAL_EDITOR_CANCEL_BUTTON}
# Step 7: test ACL interface
    Log    ==================== Step 7: test ACL ====================
    Go to Ipv4 ACL
    Edit Other Policy By ID on Policy list    ${acl_id}   policy_type=ACL
    Verify Interface Visibility in Policy Editor  incoming  ${list_should_not_display_member}  NO    policy_type=ACL
    Verify Interface Visibility in Policy Editor  incoming  ${list_should_display_member}  YES    policy_type=ACL
    Click Button    ${GENERAL_EDITOR_CANCEL_BUTTON}
    Go to Ipv6 ACL
    Edit Other Policy By ID on Policy list    ${ipv6_acl_id}   policy_type=ACL
    Verify Interface Visibility in Policy Editor  incoming  ${list_should_not_display_member}  NO    policy_type=ACL
    Verify Interface Visibility in Policy Editor  incoming  ${list_should_display_member}  YES    policy_type=ACL
    Click Button    ${GENERAL_EDITOR_CANCEL_BUTTON}
    Logout FortiGate

*** Keywords ***

case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
