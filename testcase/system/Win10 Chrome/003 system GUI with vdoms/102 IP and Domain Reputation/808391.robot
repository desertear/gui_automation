*** Settings ***
Documentation   Verify search function works and display is good on following browsers
Resource    ../../../system_resource.robot

*** Variables ***
${ip_domain_list}    8.8.8.8
*** Test Cases ***
808391
    [Documentation]    
    [Tags]    v6.0    chrome   808391    High     win10,64bit   runable
    login FortiGate
    go to vdom   ${SYSTEM_TEST_VDOM_NAME_1}
    Go to system
    go to system_feature visibility
    Enable_FGT_Feature_Additional   Reputation
    sleep   2
    Go to system_reputation
    wait and click    ${SYSTEM_REPUTATION_IP_DOMAIN_INPUT} 
    clear element text   ${SYSTEM_REPUTATION_IP_DOMAIN_INPUT} 
    input text    ${SYSTEM_REPUTATION_IP_DOMAIN_INPUT}     ${ip_domain_list}
    sleep   1
    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_REPUTATION_URL_LIST}    Google-Web
    Wait Until Element Is Visible     ${new_locator}
    [Teardown]    Case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    write test result to file    ${CURDIR}
