*** Settings ***
Documentation    Verify ips sensor filter can be created
Resource    ../ips_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${ips_sensor_name}    test-gui-205789
${ips_filter_category}    Application
${ips_filter_subcategory}    Apache         

*** Test Cases ***
205789
    [Documentation]    
    [Tags]    6.2.0    ips    chrome    205789    critical    win10    runable

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}

    #Create IPS sensor with IPS Filter
    Create New IPS sensor    ${ips_sensor_name}
    Add IPS Filter  ${ips_filter_category}  ${ips_filter_subcategory}
    wait and click    ${IPS_SENSOR_OK_BUTTON}
    unselect frame
   

    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    Delete IPS sensor    ${ips_sensor_name}
    Logout FortiGate
    write test result to file    ${CURDIR}


