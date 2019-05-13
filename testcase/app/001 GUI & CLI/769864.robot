*** Settings ***
Documentation    Different web browser display new GUI page well: IE/Firefox/Chrome
Resource    ../app_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***


*** Test Cases ***
769864
    [Documentation]    
    [Tags]    6.2.0    application    firefox    769864    high    win10    norun

    Login FortiGate    browser=firefox
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to Security Profile
    Go to Application Control
    Wait Until Element Is Visible     ${EDIT_APP_SENSOR_ADD_SIGNATURES_BUTTON}
    Wait Until Element Is Visible     ${EDIT_APP_SENSOR_DELETE_SIGNATURES_BUTTON}
    Wait Until Element Is Visible     ${APP_SENSOR_NEW_BUTTON}
    Wait Until Element Is Visible     ${APP_SENSOR_LIST_BUTTON}

    Go to policy and objects
    Go to IPv4 policy
    sleep    5
    Wait Until Element Is Visible    ${VIEW_LIST_PLUS_DETAIL_BUTTON}
    click button    ${VIEW_LIST_PLUS_DETAIL_BUTTON}
    Wait Until Element Is Visible     ${IPv4_POLICY_LIST_ENTRY}
    click element    ${IPv4_POLICY_LIST_ENTRY} 
    Wait Until Element Is Visible    ${IPv4_POLICY_EDIT}
    click element    ${IPv4_POLICY_EDIT}
    Wait Until Element Is Visible    ${IPv4_POLICY_EDIT_NAME}
    click element    ${IPv4_POLICY_EDIT_NAME}
    Press Down Key
    Wait Until Element Is Visible    ${IPv4_POLICY_APP_PROFILE_ENABLE}
    click element    ${IPv4_POLICY_APP_PROFILE_ENABLE}
    Wait Until Element Is Visible     ${IPv4_POLICY_APP_PROFILE_ADD}
    Wait Until Element Is Visible     xpath://*[@id="ng-base"]/form/div[2]/div[1]/div[2]/dialog-content/f-utm-profiles/section/div[4]/f-field/div/field-value/div/button/f-icon




    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    write test result to file    ${CURDIR}