*** Settings ***
Documentation    Verify Object Usage reference works for address, service, and schedule pages
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
@{address_ref_result}    ${FW_TEST_ADDRESS_W_FQDN_GROUP2}    ${FW_TEST_ADDR_GROUP_1}    ${FW_TEST_V4_POLICY_ID_1}
@{address_group_ref_result}    ${FW_TEST_ADDR_GROUP_2}    ${FW_TEST_V4_POLICY_ID_1}

@{address6_ref_result}    ${FW_TEST_ADDR6_GROUP_1}    ${FW_TEST_V6_POLICY_ID_1}
@{address6_group_ref_result}    ${FW_TEST_ADDR6_GROUP_2}    ${FW_TEST_V6_POLICY_ID_1}
@{address6_template_ref_result}    ${FW_TEST_ADDR6_2}

@{service_ref_result}    ${FW_TEST_V6_POLICY_ID_1}    ${FW_TEST_V4_POLICY_ID_1}    ${FW_TEST_SERVICE_GROUP_1}
@{service_group_ref_result}    ${FW_TEST_V6_POLICY_ID_1}    ${FW_TEST_V4_POLICY_ID_1}    ${FW_TEST_SERVICE_GROUP_2}

@{schedule_ref_result}    ${FW_TEST_SCHEDULE_GROUP_1}
@{schedule_group_ref_result}    ${FW_TEST_V6_POLICY_ID_1}    ${FW_TEST_V4_POLICY_ID_1}

*** Test Cases ***
702397
    [Documentation]
    [Tags]    chrome    702397    high
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects

# Step 1: reference works on address page
    Log    ==================== Step 1: reference works on address page ====================
    Go to Addresses
    Open Section Label on Address List    Address
    Click Policy Object REF and Verify Display    ${FW_TEST_ADDR_1}    Usage of Address:    ${address_ref_result}    Address
    
    Open Section Label on Address List    Address Group
    Click Policy Object REF and Verify Display    ${FW_TEST_ADDR_GROUP_1}    Usage of Address Group:    ${address_group_ref_result}    Address

    Open Section Label on Address List    IPv6 Address
    Click Policy Object REF and Verify Display    ${FW_TEST_ADDR6_1}    Usage of IPv6 Address:    ${address6_ref_result}    Address

    Open Section Label on Address List    IPv6 Address Group
    Click Policy Object REF and Verify Display    ${FW_TEST_ADDR6_GROUP_1}    Usage of IPv6 Address Group:    ${address6_group_ref_result}    Address

    Open Section Label on Address List    IPv6 Address Template
    Click Policy Object REF and Verify Display    ${FW_TEST_ADDR6_TEMPLATE_2}    Usage of IPv6 Address Template:    ${address6_template_ref_result}    Address

# Step 2: reference works on service page
    Log    ==================== Step 2: reference works on service page ====================
    Go to Services
    Open Section Label on Service List    Uncategorized
    Click Policy Object REF and Verify Display    ${FW_TEST_SERVICE_1}    Usage of Service:    ${service_ref_result}    Service

    Open Section Label on Service List    Firewall Group
    Click Policy Object REF and Verify Display    ${FW_TEST_SERVICE_GROUP_1}    Usage of Service Group:    ${service_group_ref_result}    Service


# Step 3: reference works on schedule page
    Log    ==================== Step 3: reference works on schedule page ====================
    Go to Schedules
    Select Frame    ${POLICY_OBJECT_FRAME}
    Click Policy Object REF and Verify Display    ${FW_TEST_SCHEDULE_1}    Usage of Recurring Schedule:    ${schedule_ref_result}    Schedule
    Select Frame    ${POLICY_OBJECT_FRAME}
    Click Policy Object REF and Verify Display    ${FW_TEST_SCHEDULE_GROUP_1}    Usage of Schedule Group:    ${schedule_group_ref_result}    Schedule
    Unselect Frame

    Logout FortiGate

*** Keywords ***

case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
