*** Settings ***
Documentation    View Application list page display well
Resource    ../app_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***


*** Test Cases ***
769861
    [Documentation]    
    [Tags]    6.2.0    application    chrome    769861    high    win10    norun

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to Security Profile
    Go to Application Control
    Wait Until Element Is Visible     ${VIEW_APPLICATION_LIST}
    click element    ${VIEW_APPLICATION_LIST}
    Wait Until Element Is Visible     ${EDIT_APP_SENSOR_ADD_SIGNATURES_1}
    Wait Until Element Is Visible     ${VIEW_APPLICATION_LIST_ADD_FILTER_BUTTON}
    Wait Until Element Is Visible     xpath://span[@class='app-icon app_icon app35963 small']

   
    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    write test result to file    ${CURDIR}