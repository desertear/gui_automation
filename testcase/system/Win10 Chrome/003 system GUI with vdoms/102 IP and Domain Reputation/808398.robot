*** Settings ***
Documentation   Verify function works when vdom is enabled or disabled and search is per vdom
Resource    ../../../system_resource.robot

*** Variables ***

*** Test Cases ***
808398
    [Documentation]    
    [Tags]    v6.0    chrome   808398    High     win10,64bit   runable
    login FortiGate
    go to vdom     ${SYSTEM_TEST_VDOM_NAME_1}
    Go to system
    go to system_feature visibility
    Enable_FGT_Feature_Additional   Reputation
    Enable_FGT_feature_noRC  Intrusion Prevention
    sleep   2
    go to system_feature visibility
    go to global
    go to system
    Go to system_fortiguard
    sleep    2
    wait and click    ${SYSTEM_FORTIGUARD_LICENSE_INFO_BOTNET_DOMAIN_VIEW_BUTTON}
    sleep    2
    select frame      ${SYSTEM_FORTIGUARD_LICENSE_INFO_SLID_FRAME}
    Wait Until Element Is Visible    ${SYSTEM_FORTIGUARD_LICENSE_INFO_BOTNET_DOMAIN_DEFINIT_1}
    ${botnet_domain_name}=    get text    ${SYSTEM_FORTIGUARD_LICENSE_INFO_BOTNET_DOMAIN_DEFINIT_1}
    unselect frame
    wait and click    ${SYSTEM_FORTIGUARD_LICENSE_INFO_SLID_FRAME_CLOSE_BUTTON}
    Go to system_fortiguard
    sleep    2
    go to vdom    ${SYSTEM_TEST_VDOM_NAME_1}
    Go to system
    Go to system_reputation
    wait and click       ${SYSTEM_REPUTATION_IP_DOMAIN_INPUT} 
    clear element text   ${SYSTEM_REPUTATION_IP_DOMAIN_INPUT} 
    input text    ${SYSTEM_REPUTATION_IP_DOMAIN_INPUT}     ${botnet_domain_name}
    sleep   1
    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_REPUTATION_URL_BOTNET}    ${botnet_domain_name}
    Wait Until Element Is Visible     ${new_locator}
    [Teardown]    Case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    write test result to file    ${CURDIR}
