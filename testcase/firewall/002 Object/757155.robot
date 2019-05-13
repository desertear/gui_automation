*** Settings ***
Documentation    Verify "show in list (visibility)" work for firewall address on policy and address group editor
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
@{ipv4_address_list}    ${FW_TEST_ADDR_1}    ${FW_TEST_ADDR_2}    ${FW_TEST_ADDR_3}    ${FW_TEST_ADDR_4}
...    ${FW_TEST_ADDR_GROUP_1}    ${FW_TEST_ADDR_GROUP_2}

@{ipv6_address_list}    ${FW_TEST_ADDR6_1}    ${FW_TEST_ADDR6_2}    ${FW_TEST_ADDR6_3}    ${FW_TEST_ADDR6_4}
...    ${FW_TEST_ADDR6_GROUP_1}    ${FW_TEST_ADDR6_GROUP_2}

*** Test Cases ***
757155
    [Documentation]    Address that has visibiltiy disabled are still listed in Address group member list
    [Tags]    chrome    757155    high
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects

# Step 1: test address is shown on policy editor
    Log    ==================== Step 1: test address is shown on policy editor ====================
    Go to IPv4 policy
    Click Create New Button on Policy List
    Verify Address Visibility in Policy Editor    Source Address    ${ipv4_address_list}    YES    
    Verify Address Visibility in Policy Editor    Destination Address    ${ipv4_address_list}    YES 
    Click Cancel Button on Policy Editor   

    Go to IPv6 policy
    Click Create New Button on Policy List
    Verify Address Visibility in Policy Editor    Source Address    ${ipv6_address_list}    YES    
    Verify Address Visibility in Policy Editor    Destination Address    ${ipv6_address_list}    YES 
    Click Cancel Button on Policy Editor   

# Step 2: test address is shown on address group editor
    Log    ==================== Step 2: test address is shown on address group editor ====================
    Go to Addresses 
    Click Create New on Addresses List    Address Group
    Verify Address Visibility in Address Group Editor    v4    ${ipv4_address_list}    YES
    Click Cancel Button on Address Editor

    Click Create New on Addresses List    Address Group
    Select Verfion on Address Group Editor    v6
    Verify Address Visibility in Address Group Editor    v6    ${ipv6_address_list}    YES
    Click Cancel Button on Address Editor


# Step 3: test address is not shown on policy editor
    Log    ==================== Step 3: test address is not shown on policy editor ====================
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_cli_1.txt
    Go to IPv4 policy
    Click Create New Button on Policy List
    Verify Address Visibility in Policy Editor    Source Address    ${ipv4_address_list}    NO    
    Verify Address Visibility in Policy Editor    Destination Address    ${ipv4_address_list}    NO 
    Click Cancel Button on Policy Editor   

    Go to IPv6 policy
    Click Create New Button on Policy List
    Verify Address Visibility in Policy Editor    Source Address    ${ipv6_address_list}    NO    
    Verify Address Visibility in Policy Editor    Destination Address    ${ipv6_address_list}    NO 
    Click Cancel Button on Policy Editor

# Step 4: test address is still shown on address group editor
    Log    ==================== Step 4: test address is not shown on address group editor ====================
    Go to Addresses 
    Click Create New on Addresses List    Address Group
    Verify Address Visibility in Address Group Editor    v4    ${ipv4_address_list}    YES
    Click Cancel Button on Address Editor

    Click Create New on Addresses List    Address Group
    Select Verfion on Address Group Editor    v6
    Verify Address Visibility in Address Group Editor    v6    ${ipv6_address_list}    YES
    Click Cancel Button on Address Editor   


# Step 5: test address is visible on policy editor
    Log    ==================== Step 5: test address is visible on policy editor ====================
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_cli_2.txt
    Go to IPv4 policy
    Click Create New Button on Policy List
    Verify Address Visibility in Policy Editor    Source Address    ${ipv4_address_list}    YES
    Verify Address Visibility in Policy Editor    Destination Address    ${ipv4_address_list}    YES
    Click Cancel Button on Policy Editor   

    Go to IPv6 policy
    Click Create New Button on Policy List
    Verify Address Visibility in Policy Editor    Source Address    ${ipv6_address_list}    YES  
    Verify Address Visibility in Policy Editor    Destination Address    ${ipv6_address_list}    YES
    Click Cancel Button on Policy Editor

# Step 6: test address is shown on address group editor
    Log    ==================== Step 6: test address is shown on address group editor ====================
    Go to Addresses 
    Click Create New on Addresses List    Address Group
    Verify Address Visibility in Address Group Editor    v4    ${ipv4_address_list}    YES
    Click Cancel Button on Address Editor

    Click Create New on Addresses List    Address Group
    Select Verfion on Address Group Editor    v6
    Verify Address Visibility in Address Group Editor    v6    ${ipv6_address_list}    YES
    Click Cancel Button on Address Editor         

    Logout FortiGate

*** Keywords ***
Verify Address Visibility in Address Group Editor
    [Arguments]    ${version}    ${test_list}    ${visible}=YES
    [Documentation]    ${version} could be "v4" and "v6"
    Run Keyword If	"${version}"=="v4"    Click Element    ${POLICY_ADDRESSES_IPV4_MEMBER_DIV}		
    ...    ELSE IF  "${version}"=="v6"    Click Element    ${POLICY_ADDRESSES_IPV6_MEMBER_DIV}
    Check Element Visibility in Selection Pane    ${test_list}    ${visible}    ${POLICY_V4V6_ADDRESS_NONE_IN_SELECT_ENTRY} 

case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
