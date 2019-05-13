*** Settings ***
Documentation    Verify enforce minimum word for local user GUI
Resource    ../fipscc_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${username}    test730946
${password}    12345678
&{data_dic}    username=${username}    password=${password}
*** Test Cases ***
730946
    [Documentation]    
    [Tags]    chrome    730946    high
    [Teardown]    case Teardown
    Login FortiGate
    Go to VDOM  ${FIPSCC_TEST_VDOM_NAME_1}
    Go to User and Device
    Go to User Definition
    #use all digits as password
    Wait Until Element Is Visible    ${USER_FRAME}
    select frame    ${USER_FRAME}
    click button    ${USER_DEFINITION_ENTRY_CREATE_NEW}
    unselect frame
    Wait Until Element Is Visible    ${USER_WIZARD_H1}
    click element    ${USER_TYPE_LOCAL}
    click button    ${USER_NEXT_BUTTON}
    input text    ${USER_LOCAL_USERNAME}    ${username}
    #input shorter password
    input password    ${USER_LOCAL_PASSWORD}    1234567
    Wait until element is visible    ${USER_LOCAL_CONFIRM_PASSWORD_EMPTY_WARNING_LABEL}
    input password    ${USER_LOCAL_CONFIRM_PASSWORD}    1234567
    Wait until element is Not visible    ${USER_LOCAL_CONFIRM_PASSWORD_EMPTY_WARNING_LABEL}
    Wait until element is visible    ${USER_LOCAL_PASSWORD_WARNING_LABEL}
    #input correct password
    input password    ${USER_LOCAL_PASSWORD}    12345678
    Wait until element is visible    ${USER_LOCAL_CONFIRM_PASSWORD_MISMATCH_WARNING_LABEL}
    input password    ${USER_LOCAL_CONFIRM_PASSWORD}    12345678
    Wait until element is Not visible    ${USER_LOCAL_CONFIRM_PASSWORD_MISMATCH_WARNING_LABEL}
    Wait until element is Not visible    ${USER_LOCAL_PASSWORD_WARNING_LABEL}
    #use correct password    
    Create new user    Local User    &{data_dic}
    Delete user    ${username}
    Logout FortiGate
    
*** Keywords ***
case Teardown
    write test result to file    ${CURDIR}