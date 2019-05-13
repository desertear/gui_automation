*** Settings ***
Documentation    Verify DLP sensor is able to create and modify from policy page GUI
Resource    ../dlp_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${dlp_sensor_name1}    gui-firewall_dlp
${dlp_sensor_name2}    gui-firewall_dlp_edited   
    
*** Test Cases ***
756657
    [Documentation]    
    [Tags]    6.2.0    dlp    chrome    756657    high    win10    runable

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    
    #Go to policy page to create DLP sensor
    Create DLP Sensor in Firewall Policy    ${dlp_sensor_name1}

    #Verify DLP sensor is created
    Go to DLP profile
    select frame    embedded-iframe
    Wait Until Element Is Visible    xpath://td[contains(text(),"${dlp_sensor_name1}")]
    unselect frame

    #Go back policy page to edit DLP sensor
    Edit DLP Sensor in Firewall Policy    ${dlp_sensor_name2}
    Wait Until Element is Visible    ${IPv4_DLP_FRAME}
    select frame    ${IPV4_DLP_FRAME}
    Wait Until Element is Visible    ${FILTER_TYPE_FILE}
    click element    ${FILTER_TYPE_FILE}
    Wait until Element is Visible    ${PROTO_HTTP_GET}
    click element    ${PROTO_HTTP_GET}
    click element    ${FILTER_ACTION}
    Wait Until Element is Visible    ${FILTER_ACTION_BLOCK}
    click element    ${FILTER_ACTION_BLOCK}
    click element    ${SAVE_FILTER}
    unselect frame

    #Check that filter is edited in the DLP
    Go to DLP profile
    select frame    embedded-iframe
    Wait Until Element Is Visible    xpath://td[contains(text(),"${dlp_sensor_name2}")]
    double click element    xpath://td[contains(text(),"${dlp_sensor_name2}")]
    Wait Until Element is Visible    xpath://td[@class="disp_action"][contains(text(),"Block")]  
    Wait Until Element is Visible    xpath://td[@class="disp_filter"][contains(text(),"Containing Credit Card")]
    Wait Until Element is Visible    xpath://td[@class="disp_proto"][contains(text(),"SMTP, POP3, IMAP, HTTP-GET, HTTP-POST")] 
    unselect frame

    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    Remove DLP Sensor in Firewall Policy
    Delete DLP sensor    ${dlp_sensor_name2}
    Logout FortiGate
    write test result to file    ${CURDIR}