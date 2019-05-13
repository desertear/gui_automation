*** Settings ***
Documentation    filter category for it 
Resource    ../webfilter_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${webfilter_profile_name}    webfilter
${category_name}    Games
${action}    Warning
${time}    2:30:10    
    
*** Test Cases ***
711871
    [Documentation]    
    [Tags]    6.2.0    webfilter    chrome    716659    high    win10    runable

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}

    #Create New DLP File-Type Sensor   ${dlp_sensor_name}
    # Apply App Profile in Firewall Policy     ${app_sensor_name}
    # Wait Until Element Is Visible    xpath://span[contains(text(),"${app_sensor_name}")]
    # Delete App Profile in Firewall Policy     ${app_sensor_name}
    # Wait Until Element Is Not Visible    xpath://span[contains(text(),"${app_sensor_name}")]
    # Delete New App Sensor in List

    Go into a Webfilter profile    ${webfilter_profile_name} 
    Filter a Category    ${category_name} 
    Change the action    ${category_name}    ${action}    ${time}
    


    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    write test result to file    ${CURDIR}