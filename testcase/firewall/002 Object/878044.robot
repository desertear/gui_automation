*** Settings ***
Documentation    Verify Object Usage reference works for vip, ip pool, and wildcard FQDN address pages (separated from testcase 702397)
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
@{wildcard_fqdn_ref_result}    custom-deep-inspection    deep-inspection    ${FW_TEST_W_FQDN_GROUP_1}

@{vip46_ref_result}    ${FW_TEST_POLICY46_ID_1}

@{ippool_ref_result}    ${FW_TEST_V4_POLICY_ID_1}
@{ippool6_ref_result}    ${FW_TEST_V6_POLICY_ID_1}

*** Test Cases ***
878044
    [Documentation]
    [Tags]    chrome    878044    high
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects

# Step 1: reference works on wildcard FQDN page
    Log    ==================== Step 1: reference works on wildcard FQDN page ====================
    Go to Wildcard FQDN Address    
    Open Section Label on Wildcard FQDN Address List    Wildcard FQDN
    Click Policy Object REF and Verify Display    ${FW_TEST_W_FQDN_FORTINET}    Usage of Wildcard FQDN:    ${wildcard_fqdn_ref_result}    Wildcard_FQDN
    

# Step 2: reference works on vip page
    Log    ==================== Step 2: reference works on vip46 page ====================
    Go to Virtual IP    
    Open Section Label on VIP List    NAT46 Virtual IP
    Click Policy Object REF and Verify Display    ${FW_TEST_VIP46_1}    Usage of NAT46 Virtual IP:    ${vip46_ref_result}    VIP

# Step 3: reference works on IP pool page
    Log    ==================== Step 3: reference works on IP pool page ====================
    Go to IP Pool    
    Select Frame    ${POLICY_OBJECT_FRAME}
    Click Policy Object REF and Verify Display    ${FW_TEST_IP_POOLS_2}    Usage of Firewall IP Pool:    ${ippool_ref_result}    IP_Pool
    Select Frame    ${POLICY_OBJECT_FRAME}
    Click Policy Object REF and Verify Display    ${FW_TEST_IP_POOLS6_2}    Usage of Firewall IPv6 IP Pool:    ${ippool6_ref_result}    IP_Pool

    Logout FortiGate

*** Keywords ***

case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
