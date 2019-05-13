*** Settings ***
Documentation    Verify filter by app_name/category/technology/pop/risk in app list page work in GUI
Resource    ../app_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${app_sensor_name}    testgui
${app_filter_remove_filter}    xpath://button[@title="Remove Filter"]
${app_filter_name}    xpath://button[contains(text(),"Name")]
${app_filter_technology}    xpath://button[contains(text(),"Technology")]
${app_filter_pop}    xpath://button[contains(text(),"Popularity")]
${app_filter_risk}    xpath://button[contains(text(),"Risk")]
${app_filter_category}    xpath://button[contains(text(),"Category")]

${app_filter_category_email}    xpath://button[contains(text(),"Email")]
${app_filter_category_email_include}     xpath://span[contains(text(),"Gmail")]
${app_filter_name_input}    xpath://span[@class='facet-options-container']//input[@type='text']
${app_filter_name_httpaudio}    http.audio
${app_filter_name_input_verify}    xpath://button[contains(text(),'HTTP.Audio')]
${app_filter_name_httpaudio_include}    xpath://span[contains(text(),"HTTP.Audio")]
${app_filter_technology_browser_based}    xpath://button[contains(text(),"Browser-Based")]
${app_filter_technology_browser_based_include}    xpath://span[contains(text(),"360.Yunpan")]
${app_filter_pop_five}    xpath://button[contains(text(),"5")]
${app_filter_pop_five_include}   xpath://span[contains(text(),"Amazon.AWS")]
${app_filter_risk_high}    xpath://button[contains(text(),"High")]
${app_filter_risk_high_include}    xpath://span[contains(text(),"Baidu.Music")]

*** Test Cases ***
769863
    [Documentation]    
    [Tags]    6.2.0    application    chrome    769863    high    win10    norun

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to Security Profile
    Go to Application Control
    click button    ${APP_SENSOR_NEW_BUTTON}
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_SIGNATURES_BUTTON}
    input text    ${EDIT_APP_SENSOR_NAME}    ${app_sensor_name}
    click element    ${EDIT_APP_SENSOR_ADD_SIGNATURES_BUTTON}

    #check the app filters-------name/http.audio

    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_SIGNATURES_ADD_FILTER}
    click element    ${EDIT_APP_SENSOR_ADD_SIGNATURES_ADD_FILTER}
    Wait Until Element Is Visible    ${app_filter_name}
    click element    ${app_filter_name}
    Wait Until Element Is Visible    ${app_filter_name_input}
    input text    ${app_filter_name_input}    ${app_filter_name_httpaudio}
    click button    ${app_filter_name_input_verify}
    Wait Until Element Is Visible    ${app_filter_name_httpaudio_include}
    click button    ${app_filter_remove_filter}

    #check the app filters-------category/email

    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_SIGNATURES_ADD_FILTER}
    click element    ${EDIT_APP_SENSOR_ADD_SIGNATURES_ADD_FILTER}
    Wait Until Element Is Visible    ${app_filter_category}
    click element    ${app_filter_category}
    Wait Until Element Is Visible    ${app_filter_category_email}
    click element    ${app_filter_category_email}
    Wait Until Element Is Visible    ${app_filter_category_email_include}
    click button    ${app_filter_remove_filter}

    #check the app filters-------technology/browser-based
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_SIGNATURES_ADD_FILTER}
    click element    ${EDIT_APP_SENSOR_ADD_SIGNATURES_ADD_FILTER}
    Wait Until Element Is Visible    ${app_filter_technology}
    click element    ${app_filter_technology}
    Wait Until Element Is Visible    ${app_filter_technology_browser_based}
    click element    ${app_filter_technology_browser_based}
    Wait Until Element Is Visible    ${app_filter_technology_browser_based_include}
    click button    ${app_filter_remove_filter}

    #check the app filters-------popularity/5 star
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_SIGNATURES_ADD_FILTER}
    click element    ${EDIT_APP_SENSOR_ADD_SIGNATURES_ADD_FILTER}
    Wait Until Element Is Visible    ${app_filter_pop}
    click element    ${app_filter_pop}
    Wait Until Element Is Visible    ${app_filter_pop_five}
    click element    ${app_filter_pop_five}
    Wait Until Element Is Visible    ${app_filter_pop_five_include}
    click button    ${app_filter_remove_filter}

    #check the app filters-------risk/high
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_SIGNATURES_ADD_FILTER}
    click element    ${EDIT_APP_SENSOR_ADD_SIGNATURES_ADD_FILTER}
    Wait Until Element Is Visible    ${app_filter_risk}
    click element    ${app_filter_risk}
    Wait Until Element Is Visible    ${app_filter_risk_high}
    click element    ${app_filter_risk_high}
    Wait Until Element Is Visible    ${app_filter_risk_high_include}
    click button    ${app_filter_remove_filter}

    Go to Application Control

    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    write test result to file    ${CURDIR}