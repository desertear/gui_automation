*** Settings ***
Documentation    Verify new application entry can be configured/deleted in GUI
Resource    ../app_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${app_sensor_name}    testgui

*** Test Cases ***
206115
    [Documentation]    
    [Tags]    6.2.0    application    chrome    206115    high    win10    norun

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Create New App Sensor   ${app_sensor_name}
    Delete New App Sensor in List

    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    write test result to file    ${CURDIR}