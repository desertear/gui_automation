*** Settings ***
Documentation    Verify policy column filter is not executable, XSS vulnerability code should be shown as text (Mantis 182859)
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***

*** Test Cases ***
774961
    [Documentation]    
    [Tags]    chrome    774961    low
    [Teardown]    case Teardown
    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    ##################Check IPV4 Policy#################
    Go to policy and objects
    Go to IPv4 policy
    View By Sequence
    ####Set filter for Name####
    ${filter_dict2}=    Create Dictionary     filter_type=string    operator=Does Not Contain    value=<script>alert('test4')</script>    set_method=text
    Set Policy Column Filter    Name    4    &{filter_dict2}
    Alert Should Not Be Present
    Remove Policy Column Filters    Name
    ##################Check IPV6 Policy#################
    Go to policy and objects
    Go to IPv6 policy
    View By Sequence
    ####Set filter for Name####
    ${filter_dict2}=    Create Dictionary     filter_type=string    operator=Contains    value=<script>alert('test6')</script>    set_method=text
    Set Policy Column Filter    Name    6    &{filter_dict2}
    Alert Should Not Be Present
    Remove Policy Column Filters    Name
    Logout FortiGate
 
*** Keywords ***
case Teardown
    write test result to file    ${CURDIR}