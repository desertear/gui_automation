*** Settings ***
Documentation    Verify sort/filter/search function works on Wildcard FQDN Addresses page (M434904)
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${table_entries_less_than}    100
*** Test Cases ***
861591
    [Documentation]
    [Tags]    chrome    861591    Medium
    [Teardown]    case Teardown
    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects
# Step 1: test default wild fqdn address is shown on wildcard fqdn page
    Log    ==================== Step 1: test default wild fqdn address is shown on wildcard fqdn page ====================
    Go to Wildcard FQDN Address
    Open Section Label on Address List    Wildcard FQDN
    ${wildfqdn_list_in_wildcard_fqdn}=    get wildcard fqdn list from cli
    ${sorted_wildfqdn_list}=    custom_sort    ${wildfqdn_list_in_wildcard_fqdn}
    click policy sort button   Name  
    ${name_list}=    get all entries of a colum in table   Wildcard FQDN   Name    ${table_entries_less_than}    ${D_WILDCARD_FQDN_NAME_TO_COLUMN_ID}
    Lists Should Be Equal    ${sorted_wildfqdn_list}    ${name_list}
    Logout FortiGate

*** Keywords ***

case Teardown
    Close all browsers
    write test result to file    ${CURDIR}

