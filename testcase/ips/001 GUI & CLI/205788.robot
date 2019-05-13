*** Settings ***
Documentation    Verify ips sensor can be deleted
Resource    ../ips_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${ips_sensor_name}    test-gui-205788 

*** Test Cases ***
205788
    [Documentation]    
    [Tags]    6.2.0    ips    chrome    205788    high    win10    runable    jon

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}

    #Create IPS sensor with IPS Filter
    Create New IPS sensor    ${ips_sensor_name}
    wait and click    ${IPS_SENSOR_OK_BUTTON}  
    unselect frame

    #Go to IPS sensor list and delete the created sensor
    Delete IPS sensor    ${ips_sensor_name}
   

    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    write test result to file    ${CURDIR}


