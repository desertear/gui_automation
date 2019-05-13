*** Settings ***
Documentation    Verify wildcard-fqdn address and address group filter-out from ipv4 policy (M245218 M261771)
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
@{wildcard_fqdn_list}    ${FW_TEST_W_FQDN_FORTINET}    ${FW_TEST_W_FQDN_ITUNE}    
@{wildcard_fqdn_group_list}    ${FW_TEST_W_FQDN_GROUP_1}

@{address_wildcard_fqdn_list}    ${FW_TEST_ADDRESS_W_FQDN_DROPBOX}    ${FW_TEST_ADDRESS_W_FQDN_GOOGLE}
@{address_wildcard_fqdn_group_list}    ${FW_TEST_ADDRESS_W_FQDN_GROUP1}    ${FW_TEST_ADDRESS_W_FQDN_GROUP2}


*** Test Cases ***
794683
    [Documentation]    
    [Tags]    chrome    794683    high
    [Teardown]    case Teardown

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects

# Step 1: wildcard-fqdn address and address group are not shown on policy editor
    Log    ==================== Step 1: wildcard-fqdn address is not shown on policy editor ====================
    Go to IPv4 policy
    Click Create New Button on Policy List
    Verify Address Visibility in Policy Editor    Source Address    ${wildcard_fqdn_list}    NO   
    sleep    1s
    Verify Address Visibility in Policy Editor    Source Address    ${wildcard_fqdn_group_list}    NO   
    sleep    1s
    Verify Address Visibility in Policy Editor    Destination Address    ${wildcard_fqdn_list}    NO
    sleep    1s
    Verify Address Visibility in Policy Editor    Destination Address    ${wildcard_fqdn_group_list}    NO  
    Click Cancel Button on Policy Editor   

# Step 2: wildcard-fqdn tye address and address group contains wildcard-fqdn type address are not shown on policy editor
    Log    ==================== Step 2: wildcard-fqdn tye address and address group contains wildcard-fqdn type address are not shown on policy editor ====================
    Click Create New Button on Policy List
    Verify Address Visibility in Policy Editor    Source Address    ${address_wildcard_fqdn_list}    NO   
    sleep    1s
    Verify Address Visibility in Policy Editor    Source Address    ${address_wildcard_fqdn_group_list}    NO   
    sleep    1s
    Verify Address Visibility in Policy Editor    Destination Address    ${address_wildcard_fqdn_list}    NO
    sleep    1s
    Verify Address Visibility in Policy Editor    Destination Address    ${address_wildcard_fqdn_group_list}    NO  
    Click Cancel Button on Policy Editor   

    Logout FortiGate

*** Keywords ***

case Teardown
    write test result to file    ${CURDIR}
