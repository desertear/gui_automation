*** Settings ***
Documentation    Verify column filter can be persisted even after page refresh or going&back from any other page (M473808)
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***

*** Test Cases ***
870545
    [Documentation]    
    [Tags]    chrome    870545    high
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown
    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    ##################Check IPV4 Policy#################
    Go to policy and objects
    Go to IPv4 policy
    View By Sequence
    ####Set filter for ID####
    ${filter_dict1}=    Create Dictionary     filter_type=number    operator=\=    value=${FW_TEST_V4_POLICY_ID_2}    set_method=text
    Set Policy Column Filter    ID    4    &{filter_dict1}
    Check Policy Exists or Not by ID    ${FW_TEST_V4_POLICY_ID_1}    NO
    Check Policy Exists or Not by ID    ${FW_TEST_V4_POLICY_ID_2}
    Check Policy Exists or Not by ID    ${FW_TEST_V4_POLICY_ID_3}    NO
    Check Policy Exists or Not by ID    ${FW_TEST_V4_POLICY_ID_4}    NO
    Check Policy Exists or Not by ID    ${FW_TEST_V4_POLICY_ID_5}    NO
    ####Refresh page####
    Reload Page
    ####Check Policy again####
    Check Policy Exists or Not by ID    ${FW_TEST_V4_POLICY_ID_1}    NO
    Check Policy Exists or Not by ID    ${FW_TEST_V4_POLICY_ID_2}
    Check Policy Exists or Not by ID    ${FW_TEST_V4_POLICY_ID_3}    NO
    Check Policy Exists or Not by ID    ${FW_TEST_V4_POLICY_ID_4}    NO
    Check Policy Exists or Not by ID    ${FW_TEST_V4_POLICY_ID_5}    NO
    ####recover filter####
    Remove Policy Column Filters    ID
    ####Set filter for Name####
    ${filter_dict2}=    Create Dictionary     filter_type=string    operator=Does Not Contain    value=870545_1    set_method=text
    Set Policy Column Filter    Name    4    &{filter_dict2}
    Check Policy Exists or Not by ID    ${FW_TEST_V4_POLICY_ID_1}    NO
    Check Policy Exists or Not by ID    ${FW_TEST_V4_POLICY_ID_2}
    Check Policy Exists or Not by ID    ${FW_TEST_V4_POLICY_ID_3}   
    Check Policy Exists or Not by ID    ${FW_TEST_V4_POLICY_ID_4}
    Check Policy Exists or Not by ID    ${FW_TEST_V4_POLICY_ID_5}
    ####Go Other Page and come back again####  
    Go to Addresses
    Go to IPv4 policy
    View By Sequence
    ####Check Policy again####
    Check Policy Exists or Not by ID    ${FW_TEST_V4_POLICY_ID_1}    NO
    Check Policy Exists or Not by ID    ${FW_TEST_V4_POLICY_ID_2}
    Check Policy Exists or Not by ID    ${FW_TEST_V4_POLICY_ID_3}   
    Check Policy Exists or Not by ID    ${FW_TEST_V4_POLICY_ID_4}
    Check Policy Exists or Not by ID    ${FW_TEST_V4_POLICY_ID_5}
    ####recover filter####
    Remove Policy Column Filters    Name
    ##################Check IPV6 Policy#################
    Go to policy and objects
    Go to IPv6 policy
    View By Sequence
   ####Set filter for ID####
    ${filter_dict1}=    Create Dictionary     filter_type=number    operator=\=    value=${FW_TEST_V6_POLICY_ID_2}    set_method=text
    Set Policy Column Filter    ID    6    &{filter_dict1}
    Check Policy Exists or Not by ID    ${FW_TEST_V6_POLICY_ID_1}    NO
    Check Policy Exists or Not by ID    ${FW_TEST_V6_POLICY_ID_2}
    Check Policy Exists or Not by ID    ${FW_TEST_V6_POLICY_ID_3}    NO
    Check Policy Exists or Not by ID    ${FW_TEST_V6_POLICY_ID_4}    NO
    Check Policy Exists or Not by ID    ${FW_TEST_V6_POLICY_ID_5}    NO
    ####Refresh page####
    Reload Page
    ####Check Policy again####
    Check Policy Exists or Not by ID    ${FW_TEST_V6_POLICY_ID_1}    NO
    Check Policy Exists or Not by ID    ${FW_TEST_V6_POLICY_ID_2}
    Check Policy Exists or Not by ID    ${FW_TEST_V6_POLICY_ID_3}    NO
    Check Policy Exists or Not by ID    ${FW_TEST_V6_POLICY_ID_4}    NO
    Check Policy Exists or Not by ID    ${FW_TEST_V6_POLICY_ID_5}    NO
    Remove Policy Column Filters    ID
    ####Set filter for Name####
    ${filter_dict2}=    Create Dictionary     filter_type=string    operator=Does Not Contain    value=870545_6_1    set_method=text
    Set Policy Column Filter    Name    6    &{filter_dict2}
    Check Policy Exists or Not by ID    ${FW_TEST_V6_POLICY_ID_1}    NO
    Check Policy Exists or Not by ID    ${FW_TEST_V6_POLICY_ID_2}
    Check Policy Exists or Not by ID    ${FW_TEST_V6_POLICY_ID_3}
    Check Policy Exists or Not by ID    ${FW_TEST_V6_POLICY_ID_4}
    Check Policy Exists or Not by ID    ${FW_TEST_V6_POLICY_ID_5}
    ####Go Other Page and come back again####  
    Go to Addresses
    Go to IPv6 policy
    View By Sequence
    ####Check Policy again####
    Check Policy Exists or Not by ID    ${FW_TEST_V6_POLICY_ID_1}    NO
    Check Policy Exists or Not by ID    ${FW_TEST_V6_POLICY_ID_2}
    Check Policy Exists or Not by ID    ${FW_TEST_V6_POLICY_ID_3}
    Check Policy Exists or Not by ID    ${FW_TEST_V6_POLICY_ID_4}
    Check Policy Exists or Not by ID    ${FW_TEST_V6_POLICY_ID_5}      
    Remove Policy Column Filters    Name
    Logout FortiGate
 
*** Keywords ***
case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}