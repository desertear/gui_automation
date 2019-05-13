*** Settings ***
Documentation    Verify ips sensor filter rule can be viewed
Resource    ../ips_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${ips_sensor_name}    test-gui-205793
@{ips_filter_category}    Application    OS    Protocol    Severity    Target          

*** Test Cases ***
205793
    [Documentation]    
    [Tags]    6.2.0    ips    chrome    205793    low    win10    runable

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}

    #Create IPS sensor
    Create New IPS sensor    ${ips_sensor_name}
    click element   ${IPS_SENSOR_ADD_FILTER}
    unselect frame


    #Go through each filter category and verify the options can be viewed
    :FOR    ${item}    IN    @{ips_filter_category}
        #Click a category and wait till options load. Then remove the filter
    \   Wait Until Element Is Visible    ${IPS_SENSOR_ADD_FILTER_LOAD_CHECK}
    \   click element    ${IPS_SENSOR_ADD_FILTER_ADD_FILTER}
    \   ${locator_of_category}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${IPS_SENSOR_ADD_FILTER_PLACEHOLDER}    ${item}
    \   wait and click    ${locator_of_category}
    \   Wait Until Element Is Visible    ${IPS_SENSOR_FILTER_OPTIONS_LIST}
    \   wait and click    ${IPS_SENSOR_FILTER_REMOVE_FILTER}

    #Close Add Filter page abd New IPS Sensor page
    wait and click    ${IPS_SENSOR_FILTER_CANCEL}
    select frame    ${IPS_FRAME}
    wait and click    ${IPS_SENSOR_FILTER_CANCEL}
    


    
   

    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    #Delete IPS sensor    ${ips_sensor_name}
    Logout FortiGate
    write test result to file    ${CURDIR}


