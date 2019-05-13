*** Settings ***
Documentation    Add specific signature override by searching box works well in GUI
Resource    ../app_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${app_sensor_name}    testgui

*** Test Cases ***
769859
    [Documentation]    
    [Tags]    6.2.0    application    chrome    769859    high    win10    norun

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Create New App Sensor   ${app_sensor_name}
    Delete New App Sensor in List

    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    write test result to file    ${CURDIR}