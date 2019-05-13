*** Settings ***
Documentation    Verify number of signatures filtered is displayed in categories and filter overrides.
Resource    ../app_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${general_interest_filter_number}    xpath://span[contains(text(),"238")]
${general_interest_view}    xpath://span[contains(text(),"View Signatures (231)")]
${return_button}    xpath://button[contains(text(),"Return")]
${filter_browser_based_number}    xpath://span[contains(text(),"942")]
${filter_cancel_button}    //button[contains(text(),"Cancel")]

*** Test Cases ***
823065
    [Documentation]    
    [Tags]    6.2.0    application    chrome    823065    critical    win10    norun

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to Security Profile
    Go to Application Control

    #check category filter number
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_CATEGORY_GENERAL_INTEREST}
    click element    ${EDIT_APP_SENSOR_CATEGORY_GENERAL_INTEREST}
    Wait Until Element Is Visible    ${general_interest_view}
    sleep    3
    click element    ${general_interest_view}
    sleep    3
    Wait Until Element Is Visible    ${general_interest_filter_number}
    Wait Until Element Is Visible    ${return_button}
    click element    ${return_button}

    #check filter override number
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_FILTER_BUTTON}
    click element    ${EDIT_APP_SENSOR_ADD_FILTER_BUTTON}
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_FILTER_ADD_FILTER}
    click element    ${EDIT_APP_SENSOR_ADD_FILTER_ADD_FILTER}
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_FILTER_ADD_FILTER_TECHNOLOGY}
    click button    ${EDIT_APP_SENSOR_ADD_FILTER_ADD_FILTER_TECHNOLOGY}
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_FILTER_ADD_FILTER_TECHNOLOGY_BROWSER_BASED}
    click element    ${EDIT_APP_SENSOR_ADD_FILTER_ADD_FILTER_TECHNOLOGY_BROWSER_BASED}
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_FILTER_ADD_FILTER_USE}
    SeleniumLibrary.Mouse Down    ${EDIT_APP_SENSOR_ADD_FILTER_ADD_FILTER_USE}
    SeleniumLibrary.Mouse Up    ${EDIT_APP_SENSOR_ADD_FILTER_ADD_FILTER_USE}
    Wait Until Element Is Visible    ${filter_browser_based_number}
    click element    ${filter_cancel_button}

    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    write test result to file    ${CURDIR}