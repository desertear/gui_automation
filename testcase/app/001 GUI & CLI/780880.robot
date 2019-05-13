*** Settings ***
Documentation    Verify add tooltips for known categories in app profile and view app list
Resource    ../app_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***


*** Test Cases ***
780880
    [Documentation]    
    [Tags]    6.2.0    application    chrome    780880    critical    win10    norun

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to Security Profile
    Go to Application Control

    #check app profile
    click button    ${APP_SENSOR_NEW_BUTTON}
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_SIGNATURES_BUTTON}
    click element    ${EDIT_APP_SENSOR_ADD_SIGNATURES_BUTTON}
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_SIGNATURES_1}
    click element    ${EDIT_APP_SENSOR_ADD_SIGNATURES_1}
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_SIGNATURES_USE}
    click button    ${EDIT_APP_SENSOR_ADD_SIGNATURES_USE}
    sleep    5
    Wait Until Element Is Visible    xpath://span[@class="tooltip-hint"]
    Mouse Over   xpath://span[@class="tooltip-hint"]
    Wait Until Element Is Visible     xpath://div[@class="base-tooltip"]    
    
    #check view app list
    Go to Application Control
    Wait Until Element Is Visible     ${VIEW_APPLICATION_LIST}
    click element    ${VIEW_APPLICATION_LIST}
    Wait Until Element Is Visible     ${EDIT_APP_SENSOR_ADD_SIGNATURES_1}
    Mouse Over   ${EDIT_APP_SENSOR_ADD_SIGNATURES_1}
    Wait Until Element Is Visible     xpath://div[@class="base-tooltip"]


    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    write test result to file    ${CURDIR}