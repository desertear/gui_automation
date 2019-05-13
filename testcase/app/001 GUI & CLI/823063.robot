*** Settings ***
Documentation    Verify Application Sensor displays and cloud signatures can be added in app override correctly
Resource    ../app_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${app_sensor_name}    testgui
${app_filter_name}    xpath://button[contains(text(),"Name")]
${app_filter_name_input}    xpath://span[@class='facet-options-container']//input[@type='text']
${app_filter_name_facebook}    facebook
${app_filter_name_input_verify}    xpath://button[contains(text(),"Facebook")]
${app_filter_name_facebook_include}    xpath://span[contains(text(),"Facebook_AppName")]
${app_filter_name_facebook_login_include}    xpath://span[contains(text(),"Facebook_Login")]
${app_filter_cloud}    xpath://span[@class='ng-binding ng-scope'][contains(text(),"Cloud")]

*** Test Cases ***
823063
    [Documentation]    
    [Tags]    6.2.0    application    chrome    823063    critical    win10    norun

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to Security Profile
    Go to Application Control
    click button    ${APP_SENSOR_NEW_BUTTON}
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_SIGNATURES_BUTTON}
    input text    ${EDIT_APP_SENSOR_NAME}    ${app_sensor_name}
    click element    ${EDIT_APP_SENSOR_ADD_SIGNATURES_BUTTON}

    #filter "Facebook" by searching name and then click Cloud

    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_SIGNATURES_ADD_FILTER}
    click element    ${EDIT_APP_SENSOR_ADD_SIGNATURES_ADD_FILTER}
    Wait Until Element Is Visible    ${app_filter_name}
    click element    ${app_filter_name}
    Wait Until Element Is Visible    ${app_filter_name_input}
    input text    ${app_filter_name_input}    ${app_filter_name_facebook}
    click button    ${app_filter_name_input_verify}
    Wait Until Element Is Visible    ${app_filter_name_facebook_include}
    Wait Until Element Is Visible    ${app_filter_name_facebook_login_include}
    SeleniumLibrary.Mouse Down    ${app_filter_name_facebook_include}
    SeleniumLibrary.Mouse Up    ${app_filter_name_facebook_include}
    click element    ${app_filter_cloud}
    Wait Until Element Is Not Visible    ${app_filter_name_facebook_include}
    Wait Until Element Is Visible    ${app_filter_name_facebook_login_include}
    click element    ${app_filter_name_facebook_login_include}
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_SIGNATURES_USE}
    click button    ${EDIT_APP_SENSOR_ADD_SIGNATURES_USE}

    #save new app profile and verify cloud signature exists

    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_OK}
    click element    ${EDIT_APP_SENSOR_OK}
    sleep    10
    Wait Until Element Is Visible    ${app_filter_name_facebook_login_include}

    Delete New App Sensor in List

    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    write test result to file    ${CURDIR}