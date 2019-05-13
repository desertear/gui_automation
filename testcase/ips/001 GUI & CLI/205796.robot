*** Settings ***
Documentation    Verify pre-defined override can be deleted
Resource    ../ips_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${ips_sensor_name}    test-gui-205796
${ips_signature_name}      Adobe.Acrobat.CVE-2019-7047.Information.Disclosure  

*** Test Cases ***
205796
    [Documentation]    
    [Tags]    6.2.0    ips    chrome    205796    high    win10    runable    jon

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}

    #Create IPS sensor with signature
    Create New IPS sensor    ${ips_sensor_name}
    Add IPS Signature    ${ips_signature_name}
    
    #Delete IPS signature
    Wait Until Element is Visible    ${IPS_FRAME}
    select frame    ${IPS_FRAME}
    Wait Until Element is Visible    ${IPS_SENSOR_SIGNATURE_LIST_ENTRY}
    click element    ${IPS_SENSOR_SIGNATURE_LIST_ENTRY}
    click element    ${IPS_SENSOR_DELETE_SIGNATURE}
    click element    ${IPS_SENSOR_APPLY_BUTTON}
    Wait Until Element is Not Visible    xpath://td[contains(text(),"${ips_sensor_name}")]
    unselect frame

    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    Delete IPS sensor    ${ips_sensor_name}
    Logout FortiGate
    write test result to file    ${CURDIR}


    