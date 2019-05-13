*** Settings ***
Documentation    Verify the app tooltips has summary category/risk/popularity/technology details.
Resource    ../app_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***


*** Test Cases ***
856928
    [Documentation]    
    [Tags]    6.2.0    application    chrome    856928    high    win10    norun

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to Security Profile
    Go to Application Control
    Wait Until Element Is Visible     ${VIEW_APPLICATION_LIST}
    click element    ${VIEW_APPLICATION_LIST}
    Wait Until Element Is Visible     ${EDIT_APP_SENSOR_ADD_SIGNATURES_1}
    Mouse Over   ${EDIT_APP_SENSOR_ADD_SIGNATURES_1}
    Wait Until Element Is Visible     xpath://div[@class="base-tooltip"]
    Wait Until Element Is Visible     xpath://tbody//tr[1]//td[2]//span[1][@data-name="Video/Audio"]
    Wait Until Element Is Visible     xpath://tbody//tr[1]//td[3][@class="technology"]
    Wait Until Element Is Visible     xpath://tbody//tr[1]//td[5][@class="risk"]
    Wait Until Element Is Visible     xpath://tbody//tr[1]//td[4]//div[1][@class="popularity-level level-4"]


    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    write test result to file    ${CURDIR}