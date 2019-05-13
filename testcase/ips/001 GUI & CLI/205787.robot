*** Settings ***
Documentation    Verify ips sensor can be modified
Resource    ../ips_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${ips_sensor_name1}    test-gui-205787 
${ips_sensor_name2}    test-gui-205787-edited

*** Test Cases ***
205787
    [Documentation]    
    [Tags]    6.2.0    ips    chrome    205787    high    win10    runable    jon

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}

    #Create IPS sensor with IPS Filter
    Create New IPS sensor    ${ips_sensor_name}
    wait and click    ${IPS_SENSOR_OK_BUTTON}

    #Edit IPS sensor name
    Wait Until Element Is Visible    ${EDIT_IPS_SENSOR_NAME}
    input text    ${EDIT_IPS_SENSOR_NAME}    ${ips_sensor_name2}

    #Enable block malicious URLs
    wait and click    ${IPS_SENSOR_BLOCK_MALICIOUS_URLS}

    #Set botnet C&C to Monitor
    wait and click    ${IPS_SENSOR_BOTNET_MONITOR}
    
    #Apply IPS sensor changes
    wait and click    ${IPS_SENSOR_APPLY_BUTTON}

    #Verify block malicious is enabled and Botnet is monitor
    Wait Until Element is Visible    xpath://input[@id="block-malicious-url" and @checked="checked"]
    Wait Until Element is Visible    xpath://input[@value="monitor" and @checked="checked"]

    #Set botnet C&C to Block apply and verify setting
    wait and click    ${IPS_SENSOR_BOTNET_BLOCK}
    wait and click    ${IPS_SENSOR_APPLY_BUTTON}
    Wait Until Element is Visible    xpath://input[@id="scan-botnet-connections-block" and @checked="checked"]

    unselect frame
   

    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    Delete IPS sensor    ${ips_sensor_name2}
    Logout FortiGate
    write test result to file    ${CURDIR}


