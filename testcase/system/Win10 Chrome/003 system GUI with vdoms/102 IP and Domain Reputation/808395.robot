*** Settings ***
Documentation   Database: Verify searching entry from Trusted host works
Resource    ../../../system_resource.robot

*** Variables ***
@{Internet_Service_name}     8.8.8.8    1.9.91.17     34.232.212.106
${Internet_Service_host_1}    Google-Web    
${Internet_Service_host_2}    Facebook-Web    
${Internet_Service_host_3}    Amazon-Web    
${Reputation_class}     Internet Service
*** Test Cases ***
808395
    [Documentation]    
    [Tags]    v6.0    chrome   808395    High     win10,64bit   runable
    login FortiGate
    go to vdom     ${SYSTEM_TEST_VDOM_NAME_1}
    Go to system
    go to system_feature visibility
    Enable_FGT_Feature_Additional   Reputation
    Enable_FGT_feature_noRC  Intrusion Prevention
    sleep   2
    go to system_feature visibility
    sleep    2
    Go to system
    Go to system_reputation
    ${i}=    Set Variable   0
    :FOR     ${element}    IN     @{Internet_service_name} 
        \    ${i}=     evaluate   ${i}+1
        \    wait and click       ${SYSTEM_REPUTATION_IP_DOMAIN_INPUT} 
        \    clear element text   ${SYSTEM_REPUTATION_IP_DOMAIN_INPUT} 
        \    input text    ${SYSTEM_REPUTATION_IP_DOMAIN_INPUT}     ${element} 
        \    sleep   1
        \    @{placeholders_list}=    CREATE LIST    ${Internet_Service_host_${i}}   ${Reputation_class}
        \    ${new_locator}=   REPLACE PLACEHOLDERS IN LOCATOR WITH VALUE    ${SYSTEM_REPUTATION_URL}    ${placeholders_list}
        \    Wait Until Element Is Visible     ${new_locator}
    [Teardown]    Case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    write test result to file    ${CURDIR}
