*** Settings ***
Documentation    Verify policy lookup work for ipv4 and ipv6 policy from GUI
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${protocol_tcp}    tcp
${protocol_icmp_ping_request}    ICMP ping request
${protocol_icmp6_ping_request}    ICMPv6 ping request
${protocol_ip}    ip
${protocol_udp}    udp

${ip_in_addr_range}    10.1.100.6
${ip_not_in_addr_range}    10.1.100.11
${ip_1}    172.16.200.100
${ip_2}    8.8.8.8

${ip6_in_addr_range}    2000:10:1:100:1::6
${ip6_not_in_addr_range}    2000:10:1:100:2::6
${ip6_1}    2000:172:16:200::100


*** Test Cases ***
796172
    [Documentation]    
    [Tags]    chrome    796172    high
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown
        
    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects    

#Step 1: Check Policy Lookup on Interface Pair View
    Log    ==================== Step 1: Check Policy Lookup on Interface Pair View ====================
    Go to IPv4 policy    
    View By Interface Pair View
    Verify Matched Policy in Policy Lookup    ${FW_TEST_INTF_2}    ${protocol_tcp}    NA    ${ip_in_addr_range}    12345    ${ip_1}    21    ${FW_TEST_V4_POLICY_ID_1}
    
    Verify Matched Policy in Policy Lookup    ${FW_TEST_INTF_2}    ${protocol_icmp_ping_request}    NA    ${ip_in_addr_range}    NA    ${ip_1}    NA    ${FW_TEST_V4_POLICY_ID_3}

    Verify Matched Policy in Policy Lookup    ${FW_TEST_INTF_1}    ${protocol_ip}    17    ${ip_2}    NA    ${ip_in_addr_range}    NA    ${FW_TEST_V4_POLICY_ID_4}
    
    #test warning message when no matched policy
    Verify Matched Policy in Policy Lookup    ${FW_TEST_INTF_1}    ${protocol_udp}    NA    ${ip_2}    12345    ${ip_not_in_addr_range}    12345    NO

    Go to IPv6 policy    
    View By Interface Pair View
    Verify Matched Policy in Policy Lookup    ${FW_TEST_INTF_2}    ${protocol_tcp}    NA    ${ip6_in_addr_range}    12345    ${ip6_1}    21    ${FW_TEST_V6_POLICY_ID_1}
    
    Verify Matched Policy in Policy Lookup    ${FW_TEST_INTF_2}    ${protocol_icmp6_ping_request}    NA    ${ip6_in_addr_range}    NA    ${ip6_1}    NA    ${FW_TEST_V6_POLICY_ID_3}

    Verify Matched Policy in Policy Lookup    ${FW_TEST_INTF_1}    ${protocol_ip}    17    ${ip6_1}    NA    ${ip6_in_addr_range}    NA    ${FW_TEST_V6_POLICY_ID_4}
    
    #test warning message when no matched policy
    Verify Matched Policy in Policy Lookup    ${FW_TEST_INTF_1}    ${protocol_udp}    NA    ${ip6_1}    12345    ${ip6_not_in_addr_range}    12345    NO

#Step 2: Check Policy Lookup on Sequence View
    Log    ==================== Step 2: Check Policy Lookup on Sequence View ====================
    Go to IPv4 policy    
    View By Sequence
    Verify Matched Policy in Policy Lookup    ${FW_TEST_INTF_2}    ${protocol_tcp}    NA    ${ip_in_addr_range}    12345    ${ip_1}    21    ${FW_TEST_V4_POLICY_ID_1}
    
    Verify Matched Policy in Policy Lookup    ${FW_TEST_INTF_2}    ${protocol_icmp_ping_request}    NA    ${ip_in_addr_range}    NA    ${ip_1}    NA    ${FW_TEST_V4_POLICY_ID_3}

    Verify Matched Policy in Policy Lookup    ${FW_TEST_INTF_1}    ${protocol_ip}    17    ${ip_2}    NA    ${ip_in_addr_range}    NA    ${FW_TEST_V4_POLICY_ID_4}
    
    #test warning message when no matched policy
    Verify Matched Policy in Policy Lookup    ${FW_TEST_INTF_1}    ${protocol_udp}    NA    ${ip_2}    12345    ${ip_not_in_addr_range}    12345    NO    

    Go to IPv6 policy    
    View By Sequence
    Verify Matched Policy in Policy Lookup    ${FW_TEST_INTF_2}    ${protocol_tcp}    NA    ${ip6_in_addr_range}    12345    ${ip6_1}    21    ${FW_TEST_V6_POLICY_ID_1}
    
    Verify Matched Policy in Policy Lookup    ${FW_TEST_INTF_2}    ${protocol_icmp6_ping_request}    NA    ${ip6_in_addr_range}    NA    ${ip6_1}    NA    ${FW_TEST_V6_POLICY_ID_3}

    Verify Matched Policy in Policy Lookup    ${FW_TEST_INTF_1}    ${protocol_ip}    17    ${ip6_1}    NA    ${ip6_in_addr_range}    NA    ${FW_TEST_V6_POLICY_ID_4}
    
    #test warning message when no matched policy
    Verify Matched Policy in Policy Lookup    ${FW_TEST_INTF_1}    ${protocol_udp}    NA    ${ip6_1}    12345    ${ip6_not_in_addr_range}    12345    NO
    Logout FortiGate

*** Keywords ***

case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}