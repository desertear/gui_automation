*** Settings ***
Documentation    Verify add/edit category filter works on chrome
Resource    ../app_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${app_sensor_name}    testgui

*** Test Cases ***
794721
    [Documentation]    
    [Tags]    6.2.0    application    chrome    794721    high    win10    norun

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to Security Profile
    Go to Application Control
    click button    ${APP_SENSOR_NEW_BUTTON}
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_SIGNATURES_BUTTON}
    input text    ${EDIT_APP_SENSOR_NAME}    ${app_sensor_name}
    
    #add category override
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_CATEGORY_GENERAL_INTEREST}
    click element    ${EDIT_APP_SENSOR_CATEGORY_GENERAL_INTEREST}
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_CATEGORY_GENERAL_INTEREST_BLOCK}
    sleep    3
    click element    ${EDIT_APP_SENSOR_CATEGORY_GENERAL_INTEREST_BLOCK}
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_OK}
    click element    ${EDIT_APP_SENSOR_OK}
    sleep    10
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_CATEGORY_GENERAL_INTEREST}[@class="fa-denied"]
    Delete New App Sensor in List

    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    write test result to file    ${CURDIR}