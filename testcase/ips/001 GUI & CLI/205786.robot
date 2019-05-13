*** Settings ***
Documentation    Verify ips sensor can be created
Resource    ../ips_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${ips_sensor_name}    test-gui-205786        

*** Test Cases ***
205786
    [Documentation]    
    [Tags]    6.2.0    ips    chrome    205786    critical    win10    runable    jon

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}

    #Create IPS sensor with IPS Filter
    Create New IPS sensor    ${ips_sensor_name}
    wait and click    ${IPS_SENSOR_OK_BUTTON}
    Wait Until Element is Visible    ${IPS_SENSOR_ADD_SIGNATURE}
    #Verify default settings for Block malicious URLs and Botnet C&C
    Wait Until Element is Not Visible    xpath://input[@id="block-malicious-url" and @checked="checked"]
    Wait Until Element is Visible    xpath://input[@value="disable" and @checked="checked"]
    unselect frame
   

    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    Delete IPS sensor    ${ips_sensor_name}
    Logout FortiGate
    write test result to file    ${CURDIR}


