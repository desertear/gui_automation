*** Settings ***
Documentation    Verify pre-defined override can be modified
Resource    ../ips_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${ips_sensor_name1}    test-gui-205795
${ips_sensor_name2}    test-gui-205795-edited
${ips_signature_name}      AAEH.Botnet  
${ips_signature_action}    Pass
*** Test Cases ***
205795
    [Documentation]    
    [Tags]    6.2.0    ips    chrome    205795    high    win10    runable    jon

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}

    #Create IPS sensor
    Create New IPS sensor    ${ips_sensor_name1}
    Add IPS Signature    ${ips_signature_name}
    click element    ${IPS_ENTRY}
    select frame    ${IPS_FRAME}
    Wait Until Element is Visible    xpath://td[contains(text(),"${ips_sensor_name1}")]
    
    #Edit IPS sensor name
    double click element    xpath://td[contains(text(),"${ips_sensor_name1}")]
    Wait Until Element Is Visible    ${EDIT_IPS_SENSOR_NAME}
    input text    ${EDIT_IPS_SENSOR_NAME}    ${ips_sensor_name2}

    #Edit IPS signature action
    ${locater_of_action}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${IPS_SENSOR_ACTION_PLACEHOLDER}    ${ips_signature_action}
    Right Click Element  ${IPS_SENSOR_SIGNATURE_LIST_ENTRY}
    wait and click    ${locater_of_action}
    
    #Edit IPS signature packet logging
    Wait Until Element Is Visible    ${IPS_SENSOR_SIGNATURE_LIST_ENTRY}
    Right Click Element    ${IPS_SENSOR_SIGNATURE_LIST_ENTRY}
    Mouse Over IPS Context Popup and Click   ${IPS_SENSOR_PACKET_LOGGING}  ${IPS_SENSOR_PACKET_LOGGING_ENABLE}
    Wait Until Element Is Visible    ${IPS_SENSOR_PACKET_LOGGING_ENABLE_ICON}

    #Apply Changes
    click element    ${IPS_SENSOR_APPLY_BUTTON} 
    unselect frame
    

    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    Delete IPS sensor    ${ips_sensor_name2}
    Logout FortiGate
    write test result to file    ${CURDIR}