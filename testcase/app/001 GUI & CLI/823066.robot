*** Settings ***
Documentation    Verify Application overrides displays singature in parent-children structure. Cloud signature detection is functional without intentionally configuring their parent signatures
Resource    ../app_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${app_sensor_name}    testgui
${app_filter_name_input}    facebook_login
${app_filter_name_input_verify}    xpath://button[contains(text(),"Facebook_Login")]
${app_filter_name_display}    xpath://span[contains(text(),"Facebook_Login")]
${dependencies_verify}    xpath://div[@class="indent"]
*** Test Cases ***
823066
    [Documentation]    
    [Tags]    6.2.0    application    chrome    823066    critical    win10    norun

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Create New App Profile with Specific Signature    ${app_sensor_name}    ${app_filter_name_input}    ${app_filter_name_input_verify}    ${app_filter_name_display}
    Wait Until Element Is Visible    ${dependencies_verify}
    Delete New App Sensor in List

    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    write test result to file    ${CURDIR}