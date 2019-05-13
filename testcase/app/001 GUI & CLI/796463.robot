*** Settings ***
Documentation    Verify can add UUID for MS.RPC.UUID in GUI (check if parameter can be added)
Resource    ../app_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${app_sensor_name}    testgui
${app_filter_name}    xpath://button[contains(text(),"Name")]
${app_filter_name_input}    xpath://span[@class='facet-options-container']//input[@type='text']
${app_filter_name_facebook_appname}    facebook_appname
${app_filter_name_input_verify}    xpath://button[contains(text(),"Facebook_AppName")]
${app_filter_name_facebook_appname_include}    xpath://span[contains(text(),"Facebook_AppName")]
${edit_parameter_input}    xpath://*[@id="navbar-view-section"]/div/div[2]/div/div[2]/div[1]/f-slide-container/div/div/div/div/input
${edit_parameter_input_value}    birds
${edit_parameter_ok}    xpath://button[contains(text(),"Save Parameters")]
${edit_parameter_add_verify}    xpath://span[@class="blue"]

*** Test Cases ***
796463
    [Documentation]    
    [Tags]    6.2.0    application    chrome    796463    high    win10    norun

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to Security Profile
    Go to Application Control
    click button    ${APP_SENSOR_NEW_BUTTON}
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_SIGNATURES_BUTTON}
    input text    ${EDIT_APP_SENSOR_NAME}    ${app_sensor_name}
    click element    ${EDIT_APP_SENSOR_ADD_SIGNATURES_BUTTON}

    #filter "Facebook_appName" by searching name

    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_SIGNATURES_ADD_FILTER}
    click element    ${EDIT_APP_SENSOR_ADD_SIGNATURES_ADD_FILTER}
    Wait Until Element Is Visible    ${app_filter_name}
    click element    ${app_filter_name}
    Wait Until Element Is Visible    ${app_filter_name_input}
    input text    ${app_filter_name_input}    ${app_filter_name_facebook_appname}
    click button    ${app_filter_name_input_verify}
    Wait Until Element Is Visible    ${app_filter_name_facebook_appname_include}
    SeleniumLibrary.Mouse Down    ${app_filter_name_facebook_appname_include}
    SeleniumLibrary.Mouse Up    ${app_filter_name_facebook_appname_include}
    click element    ${app_filter_name_facebook_appname_include}
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_SIGNATURES_USE}
    click button    ${EDIT_APP_SENSOR_ADD_SIGNATURES_USE}

    #add parameters in app overrides

    Wait Until Element Is Visible    xpath://span[@class='message-content not-disabled']
    click element    xpath://span[@class='message-content not-disabled']
    click element    ${EDIT_APP_SENSOR_DELETE_SIGNATURES_EDIT_PARAMETER}
    Wait Until Element Is Visible    ${edit_parameter_input}
    input text    ${edit_parameter_input}    ${edit_parameter_input_value}
    Wait Until Element Is Visible    ${edit_parameter_ok}
    click element    ${edit_parameter_ok}
    Wait Until Element Is Visible    ${edit_parameter_add_verify}

    #save new app profile and verify parameter exists

    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_OK}
    click element    ${EDIT_APP_SENSOR_OK}
    sleep    10
    Wait Until Element Is Visible    ${edit_parameter_add_verify}

    Delete New App Sensor in List

    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    write test result to file    ${CURDIR}