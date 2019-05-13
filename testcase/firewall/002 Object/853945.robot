*** Settings ***
Documentation    Verify 'all' object cannot be set in policy with other objects at the same time. (M463835)
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${ipv4_policy_id}   ${FW_TEST_V4_POLICY_ID_1}
${ipv6_policy_id}   ${FW_TEST_V6_POLICY_ID_1}
@{add_list_all}      ADDRESS:${FW_TEST_ADDR_ALL}   
@{add_list_other}    ADDRESS:${FW_TEST_ADDR_1}   ADDRESS:${FW_TEST_ADDR_GROUP_1}    
@{ipv6_add_list_other}    ADDRESS:${FW_TEST_ADDR6_1}   ADDRESS:${FW_TEST_ADDR6_GROUP_1}
@{service_list_all}    ${FW_TEST_SERVICE_ALL}
@{service_list_other}   ${FW_TEST_SERVICE_1}   ${FW_TEST_SERVICE_GROUP_1}
*** Test Cases ***
853945
    [Documentation]
    [Tags]    chrome    853945    Medium
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown
    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects
# Step 1: test IPV4 address source
    Go to IPv4 policy
    View By Sequence
    Log    ==================== Step 1: test IPV4 address source ====================
    Edit Policy By ID on Policy list    ${ipv4_policy_id}
    Select Address on Policy Editor    Source   ${add_list_other}
    check if address exist or not on Policy Editor    Source    ${add_list_all}    NOT EXIST
    check if address exist or not on Policy Editor    Source    ${add_list_other}     EXIST
    Select Address on Policy Editor    Source   ${add_list_all}
    check if address exist or not on Policy Editor    Source    ${add_list_all}    EXIST
    check if address exist or not on Policy Editor    Source    ${add_list_other}    NOT EXIST
# Step 2: test IPV4 address Destination 
    Log    ==================== Step 2: test IPV4 address source ====================
    Select Address on Policy Editor    Destination Address   ${add_list_other}
    check if address exist or not on Policy Editor    Destination   ${add_list_all}    NOT EXIST
    check if address exist or not on Policy Editor    Destination   ${add_list_other}     EXIST
    Select Address on Policy Editor    Destination Address   ${add_list_all}
    check if address exist or not on Policy Editor    Destination    ${add_list_all}    EXIST
    check if address exist or not on Policy Editor    Destination    ${add_list_other}    NOT EXIST

# Step 3: test IPV4 service selection
    Log    ==================== Step 3: test IPV4 service selection ====================
    Select Service on Policy Editor    ${service_list_other}   
    check service exist or not on Policy Editor    ${service_list_all}   NOT EXIST
    check service exist or not on Policy Editor    ${service_list_other}   EXIST
    Select Service on Policy Editor    ${service_list_all}   
    check service exist or not on Policy Editor    ${service_list_all}   EXIST
    check service exist or not on Policy Editor    ${service_list_other}   NOT EXIST
    Click Cancel Button on Policy Editor

# Step 4: test IPV6 address source
    Go to IPv6 policy
    View By Sequence
    Edit Policy By ID on Policy list    ${ipv6_policy_id}
    Log    ==================== Step 4: test IPV6 address source ====================
    Select Address on Policy Editor    Source   ${ipv6_add_list_other}
    check if address exist or not on Policy Editor    Source    ${add_list_all}    NOT EXIST
    check if address exist or not on Policy Editor    Source    ${ipv6_add_list_other}     EXIST
    Select Address on Policy Editor    Source   ${add_list_all}
    check if address exist or not on Policy Editor    Source    ${add_list_all}    EXIST
    check if address exist or not on Policy Editor    Source    ${ipv6_add_list_other}    NOT EXIST
# Step 5: test ipv6 address Destination 
    Log    ==================== Step 5: test ipv6 address source ====================
    Select Address on Policy Editor    Destination Address   ${ipv6_add_list_other}
    check if address exist or not on Policy Editor    Destination    ${add_list_all}    NOT EXIST
    check if address exist or not on Policy Editor    Destination   ${ipv6_add_list_other}     EXIST
    Select Address on Policy Editor    Destination Address   ${add_list_all}
    check if address exist or not on Policy Editor    Destination    ${add_list_all}    EXIST
    check if address exist or not on Policy Editor    Destination    ${ipv6_add_list_other}    NOT EXIST

# Step 6: test ipv6 service selection
    Log    ==================== Step 6: test ipv6 service selection ====================
    Select Service on Policy Editor    ${service_list_other}   
    check service exist or not on Policy Editor    ${service_list_all}   NOT EXIST
    check service exist or not on Policy Editor    ${service_list_other}   EXIST
    Select Service on Policy Editor    ${service_list_all}   
    check service exist or not on Policy Editor    ${service_list_all}   EXIST
    check service exist or not on Policy Editor    ${service_list_other}   NOT EXIST
    Click Cancel Button on Policy Editor

    Logout FortiGate

*** Keywords ***

case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
