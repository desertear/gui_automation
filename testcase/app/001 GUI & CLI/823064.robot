*** Settings ***
Documentation    Verify Application Sensor displays SSL deep inspection requirement
Resource    ../app_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${app_profile_deep_inspection_required_notification}    xpath://div[@class="message-content"]//div
*** Test Cases ***
823064
    [Documentation]    
    [Tags]    6.2.0    application    chrome    823064    critical    win10    norun

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to Security Profile
    Go to Application Control
    click button    ${APP_SENSOR_NEW_BUTTON}
    Wait Until Element Is Visible    ${app_profile_deep_inspection_required_notification}

    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    write test result to file    ${CURDIR}