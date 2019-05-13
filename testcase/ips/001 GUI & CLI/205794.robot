*** Settings ***
Documentation    Verify pre-defined override can be created base on filter or specific choice
Resource    ../ips_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${ips_sensor_name}    test-gui-205794
${ips_signature_name}      AAEH.Botnet
${ips_signature_click}    2Wire.Wireless.Router.XSRF.Password.Reset

*** Test Cases ***
205794
    [Documentation]    
    [Tags]    6.2.0    ips    chrome    205794    critical    win10    runable    jon

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}

    #Create IPS sensor
    Create New IPS sensor    ${ips_sensor_name}

    #Add signature by filtering by name
    Add IPS Signature    ${ips_signature_name}

    #Add signature by clicking
    wait and select frame    ${IPS_FRAME}
    wait and click    ${IPS_SENSOR_ADD_SIGNATURE}
    unselect frame
    wait and click    xpath://span[contains(text(),"${ips_signature_click}")]
    click element    ${IPS_SENSOR_USE_SELECTED_SIGNATURE}
    wait and select frame    ${IPS_FRAME}
    Wait Until Element Is Visible    xpath://span[contains(text(),"${ips_signature_click}")]
    wait and click    ${IPS_SENSOR_APPLY_BUTTON}
    unselect frame
    
    #Verify IPS sensor is created
    click element    ${IPS_ENTRY}
    select frame    ${IPS_FRAME}
    Wait Until Element is Visible    xpath://td[contains(text(),"${ips_sensor_name}")]
    unselect frame

    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    Delete IPS sensor    ${ips_sensor_name}
    Logout FortiGate
    write test result to file    ${CURDIR}