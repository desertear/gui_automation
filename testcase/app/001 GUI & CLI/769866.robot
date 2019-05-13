*** Settings ***
Documentation    APP in list_page or edit page can link to FortiGuard server and get right detail information
Resource    ../app_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***


*** Test Cases ***
769866
    [Documentation]    
    [Tags]    6.2.0    application    chrome    769866    high    win10    norun

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to Security Profile
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