*** Settings ***
Documentation    Verify application control list can be enabled/disabled in firewall policy in GUI
Resource    ../app_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${app_sensor_name}    testgui
    
*** Test Cases ***
206119
    [Documentation]    
    [Tags]    6.2.0    application    chrome    206119    high    win10    norun

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}

    Create New App List   ${app_sensor_name}
    Apply App Profile in Firewall Policy     ${app_sensor_name}
    Wait Until Element Is Visible    xpath://span[contains(text(),"${app_sensor_name}")]
    Delete App Profile in Firewall Policy     ${app_sensor_name}
    Wait Until Element Is Not Visible    xpath://span[contains(text(),"${app_sensor_name}")]
    Delete New App Sensor in List

    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    write test result to file    ${CURDIR}