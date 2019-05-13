*** Settings ***
Documentation    Verify policy lookup not support under TP mode
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***

*** Test Cases ***
808387
    [Documentation]    
    [Tags]    chrome    808387    medium
    [Teardown]    case Teardown
        
    Login FortiGate
    
#Step 1: Check Policy Lookup is available on NAT vdom
    Log    ==================== Step 1: Check Policy Lookup is available on NAT vdom ====================
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects  
    Go to IPv4 policy 
    Element Should Be Visible    ${POLICY_V4V6_POLICY_LOOKUP_BUTTON}
    Go to IPv6 policy 
    Element Should Be Visible    ${POLICY_V4V6_POLICY_LOOKUP_BUTTON}

#Step 2: Check Policy Lookup is not available on TP vdom
    Log    ==================== Step 2: Check Policy Lookup is not available on TP vdom ====================
    Go to VDOM    ${FW_TEST_VDOM_NAME_TP}    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects  
    Go to IPv4 policy 
    Element Should Not Be Visible    ${POLICY_V4V6_POLICY_LOOKUP_BUTTON}
    Go to IPv6 policy 
    Element Should Not Be Visible    ${POLICY_V4V6_POLICY_LOOKUP_BUTTON}    
 
    Logout FortiGate

*** Keywords ***

case Teardown
    write test result to file    ${CURDIR}