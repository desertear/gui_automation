*** Settings ***
Documentation    Create Ipv4 policy, verify Ipsec policy option is only avaliable when Policy-based IPsec VPN is enabled
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***

*** Test Cases ***
893241
    [Documentation]    
    [Tags]    chrome    893241    Medium   firewall_new
    [setup] 
    [Teardown]    case Teardown
    Login FortiGate  
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    go to system 
    go to system_feature visibility
    Disable_FGT_Feature_Additional    Policy-based IPsec VPN
    sleep   1
    Go to policy and objects  
    Go to IPv4 policy 
    #Step 1: check if "IPsec" is not shown in Action on policy edit page
    Log    ==================== Step 1: check if "IPsec" is not shown in Action on policy edit page ==================== 
    click button    ${GENERAL_LIST_CREATE_NEW_BUTTON}
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${POLICY_V4V6_ACTION}   IPsec
    ${status}=    run keyword and return status    Wait Until Element Is Visible    ${new_locator}
    should be equal     "${status}"    "False"

    #Step 2: enable policy-based ipsec on GUI, "IPsec" should be shown in Action on policy edit page
    Log    ==================== Step 2: enable policy-based ipsec on GUI, "IPsec" should be shown in Action on policy edit page ==================== 
    go to system 
    go to system_feature visibility
    Enable_FGT_Feature_Additional     Policy-based IPsec VPN
    Go to policy and objects  
    Go to IPv4 policy 
    click button    ${GENERAL_LIST_CREATE_NEW_BUTTON}
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${POLICY_V4V6_ACTION}   IPsec
    ${status}=    run keyword and return status    Wait Until Element Is Visible    ${new_locator}
    should be equal     "${status}"    "True"
*** Keywords ***
case Teardown 
    Logout FortiGate
    close all browsers