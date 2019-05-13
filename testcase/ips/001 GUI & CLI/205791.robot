*** Settings ***
Documentation    Verify ips sensor filter can be deleted
Resource    ../ips_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${ips_sensor_name}    test-gui-205791
${ips_filter_category}    Protocol
${ips_filter_subcategory}    FTP           

*** Test Cases ***
205791
    [Documentation]    
    [Tags]    6.2.0    ips    chrome    205791    high    win10    runable

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}

    #Create IPS sensor with IPS filter
    Create New IPS sensor    ${ips_sensor_name}
    Add IPS Filter  ${ips_filter_category}  ${ips_filter_subcategory}
    wait and click    ${IPS_SENSOR_OK_BUTTON}

    #Delete IPS filter
    wait and click    ${IPS_SENSOR_FILTER_ENTRY}
    wait and click    ${IPS_SENSOR_FILTER_DELETE}
    Wait Until Element is Not Visible    xpath://td[@class="filter_details" and text() = "${ips_filter_category}: ${ips_filter_subcategory}"]    
    
    #Apply Changes
    click element    ${IPS_SENSOR_APPLY_BUTTON}
    unselect frame
   

    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    Delete IPS sensor    ${ips_sensor_name}
    Logout FortiGate
    write test result to file    ${CURDIR}


