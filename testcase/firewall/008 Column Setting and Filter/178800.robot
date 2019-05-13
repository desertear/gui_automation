*** Settings ***
Documentation    Verify filter is working on global view when any interface involved
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
@{columns}    ID    To    From    Source   

*** Test Cases ***
178800
    [Documentation]    
    [Tags]    chrome    178800    high
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown
    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}

    #Step 1: Test ipv4 policy
    Log    ==================== Step 1: Test ipv4 policy ====================
    Go to policy and objects
    Go to IPv4 policy
    View By Sequence
    # only show column that is used for filter
    Select Policy Table Columns    ${columns}    4
    ${status}=    Check If Columns are Displayed in Policy Table    ${columns}
    Should be True    ${status} 

    ####Set filter for ID####
    ${filter_dict1}=    Create Dictionary     filter_type=number    operator=\=    value=${FW_TEST_V4_POLICY_ID_2}    set_method=text
    Set Policy Column Filter    ID    4    &{filter_dict1}
    Check Policy Exists or Not by ID    ${FW_TEST_V4_POLICY_ID_1}    NO
    Check Policy Exists or Not by ID    ${FW_TEST_V4_POLICY_ID_2}
    Check Policy Exists or Not by ID    ${FW_TEST_V4_POLICY_ID_3}    NO
    Check Policy Exists or Not by ID    ${FW_TEST_V4_POLICY_ID_4}    NO
    Check Policy Exists or Not by ID    ${FW_TEST_V4_POLICY_ID_5}    NO
    Remove Policy Column Filters    ID
    ####Set filter for To####
    ${filter_dict2}=    Create Dictionary     filter_type=string    operator=Does Not Contain    value=any    set_method=text
    Set Policy Column Filter    To    4    &{filter_dict2}
    Check Policy Exists or Not by ID    ${FW_TEST_V4_POLICY_ID_1}    NO
    Check Policy Exists or Not by ID    ${FW_TEST_V4_POLICY_ID_2}
    Check Policy Exists or Not by ID    ${FW_TEST_V4_POLICY_ID_3}   
    Check Policy Exists or Not by ID    ${FW_TEST_V4_POLICY_ID_4}
    Check Policy Exists or Not by ID    ${FW_TEST_V4_POLICY_ID_5}
    Remove Policy Column Filters    To
    ####Set filter for From####
    ${filter_dict3}=    Create Dictionary     filter_type=string    operator=Contains    value=any    set_method=list
    Set Policy Column Filter    From    4    &{filter_dict3}
    Check Policy Exists or Not by ID    ${FW_TEST_V4_POLICY_ID_1}    NO
    Check Policy Exists or Not by ID    ${FW_TEST_V4_POLICY_ID_2}
    Check Policy Exists or Not by ID    ${FW_TEST_V4_POLICY_ID_3}    NO
    Check Policy Exists or Not by ID    ${FW_TEST_V4_POLICY_ID_4}    NO
    Check Policy Exists or Not by ID    ${FW_TEST_V4_POLICY_ID_5}    NO
    Remove Policy Column Filters    From
    ####Set filter for From####
    ${filter_dict4}=    Create Dictionary     filter_type=string    operator=Regex    value=an.*    set_method=text
    Set Policy Column Filter    From    4    &{filter_dict4}
    Check Policy Exists or Not by ID    ${FW_TEST_V4_POLICY_ID_1}    NO
    Check Policy Exists or Not by ID    ${FW_TEST_V4_POLICY_ID_2}
    Check Policy Exists or Not by ID    ${FW_TEST_V4_POLICY_ID_3}    NO
    Check Policy Exists or Not by ID    ${FW_TEST_V4_POLICY_ID_4}    NO
    Check Policy Exists or Not by ID    ${FW_TEST_V4_POLICY_ID_5}    NO
    Remove Policy Column Filters    From

    #Step 2: Test ipv6 policy
    Log    ==================== Step 2: Test ipv6 policy ====================
    Go to policy and objects
    Go to IPv6 policy
    View By Sequence
    # only show column that is used for filter
    Select Policy Table Columns    ${columns}    6
    ${status}=    Check If Columns are Displayed in Policy Table    ${columns}
    Should be True    ${status} 

    ####Set filter for ID####
    ${filter_dict1}=    Create Dictionary     filter_type=number    operator=\=    value=${FW_TEST_V6_POLICY_ID_2}    set_method=text
    Set Policy Column Filter    ID    6    &{filter_dict1}
    Check Policy Exists or Not by ID    ${FW_TEST_V6_POLICY_ID_1}    NO
    Check Policy Exists or Not by ID    ${FW_TEST_V6_POLICY_ID_2}
    Check Policy Exists or Not by ID    ${FW_TEST_V6_POLICY_ID_3}    NO
    Check Policy Exists or Not by ID    ${FW_TEST_V6_POLICY_ID_4}    NO
    Check Policy Exists or Not by ID    ${FW_TEST_V6_POLICY_ID_5}    NO
    Remove Policy Column Filters    ID
    ####Set filter for To####
    ${filter_dict2}=    Create Dictionary     filter_type=string    operator=Does Not Contain    value=any    set_method=text
    Set Policy Column Filter    To    6    &{filter_dict2}
    Check Policy Exists or Not by ID    ${FW_TEST_V6_POLICY_ID_1}    NO
    Check Policy Exists or Not by ID    ${FW_TEST_V6_POLICY_ID_2}
    Check Policy Exists or Not by ID    ${FW_TEST_V6_POLICY_ID_3}
    Check Policy Exists or Not by ID    ${FW_TEST_V6_POLICY_ID_4}
    Check Policy Exists or Not by ID    ${FW_TEST_V6_POLICY_ID_5}
    Remove Policy Column Filters    To
    ####Set filter for From####
    ${filter_dict3}=    Create Dictionary     filter_type=string    operator=Contains    value=any    set_method=list
    Set Policy Column Filter    From    6    &{filter_dict3}
    Check Policy Exists or Not by ID    ${FW_TEST_V6_POLICY_ID_1}    NO
    Check Policy Exists or Not by ID    ${FW_TEST_V6_POLICY_ID_2}
    Check Policy Exists or Not by ID    ${FW_TEST_V6_POLICY_ID_3}    NO
    Check Policy Exists or Not by ID    ${FW_TEST_V6_POLICY_ID_4}    NO
    Check Policy Exists or Not by ID    ${FW_TEST_V6_POLICY_ID_5}    NO
    Remove Policy Column Filters    From
    ####Set filter for From####
    ${filter_dict4}=    Create Dictionary     filter_type=string    operator=Regex    value=a.y    set_method=text
    Set Policy Column Filter    From    6    &{filter_dict4}
    Check Policy Exists or Not by ID    ${FW_TEST_V6_POLICY_ID_1}    NO
    Check Policy Exists or Not by ID    ${FW_TEST_V6_POLICY_ID_2}
    Check Policy Exists or Not by ID    ${FW_TEST_V6_POLICY_ID_3}    NO
    Check Policy Exists or Not by ID    ${FW_TEST_V6_POLICY_ID_4}    NO
    Check Policy Exists or Not by ID    ${FW_TEST_V6_POLICY_ID_5}    NO
    Remove Policy Column Filters    From
    Logout FortiGate
 
*** Keywords ***
case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}