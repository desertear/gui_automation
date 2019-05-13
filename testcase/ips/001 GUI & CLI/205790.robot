*** Settings ***
Documentation    Verify ips sensor filter can be modifed
Resource    ../ips_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${ips_sensor_name}    test-gui-205790
${ips_filter_category}    Protocol
${ips_filter_subcategory}    HTTP  
${ips_filter_action}    Monitor         

*** Test Cases ***
205790
    [Documentation]    
    [Tags]    6.2.0    ips    chrome    205790    high    win10    runable

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}

    #Create IPS sensor with IPS filter
    Create New IPS sensor    ${ips_sensor_name}
    Add IPS Filter  ${ips_filter_category}  ${ips_filter_subcategory}
    wait and click    ${IPS_SENSOR_OK_BUTTON}
    
    #Edit IPS Filter action
    ${locater_of_action}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${IPS_SENSOR_ACTION_PLACEHOLDER}    ${ips_filter_action}
    Wait Until Element Is Visible    ${IPS_SENSOR_ADD_FILTER_LOAD_CHECK}
    Right Click Element    ${IPS_SENSOR_FILTER_ENTRY}
    wait and click    ${locater_of_action}
    ${locator_of_action_verify}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${IPS_SENSOR_ACTION_VERIFY_PLACEHOLDER}    ${ips_filter_action}
    Wait Until Element is Visible    ${locator_of_action_verify}

    #Edit IPS signature packet logging
    Wait Until Element Is Visible    ${IPS_SENSOR_FILTER_ENTRY}
    Right Click Element    ${IPS_SENSOR_FILTER_ENTRY}
    Mouse Over IPS Context Popup and Click   ${IPS_SENSOR_PACKET_LOGGING}  ${IPS_SENSOR_PACKET_LOGGING_ENABLE}
    Wait Until Element Is Visible    xpath://f-icon[@class="fa-enabled"]
    
    #Apply Changes
    click element    ${IPS_SENSOR_APPLY_BUTTON}
    unselect frame
   

    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    Delete IPS sensor    ${ips_sensor_name}
    Logout FortiGate
    write test result to file    ${CURDIR}


