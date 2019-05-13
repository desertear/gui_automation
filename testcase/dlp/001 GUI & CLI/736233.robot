*** Settings ***
Documentation    Verify DLP regexp can be created and modified from GUI
Resource    ../dlp_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${dlp_sensor_name}    gui-regexp
${dlp_regexp1}    this is a test
${dlp_regexp2}    this is an edit      
    
*** Test Cases ***
736233
    [Documentation]    
    [Tags]    6.2.0    dlp    chrome    736233    critical    win10    runable

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    
    #Create file regexp sensor
    Create New DLP sensor    ${dlp_sensor_name}
    Select DLP sensor action allow
    Go to DLP New Filter Type File
    Add DLP regexp    ${dlp_regexp1}

    #Check that filter is created correctly
    select frame    embedded-iframe
    Wait Until Element is Visible    xpath://td[@class="disp_action"][contains(text(),"Allow")]  
    Wait Until Element is Visible    xpath://td[@class="disp_filter"][contains(text(),"Regular Expression matches: ${dlp_regexp1}")]
    Wait Until Element is Visible    xpath://td[@class="disp_proto"][contains(text(),"SMTP, POP3, IMAP, HTTP-GET, HTTP-POST, FTP")]    
    unselect frame

    #Check that filter is displayed in the DLP list
    Go to DLP profile
    select frame    embedded-iframe
    Wait Until Element Is Visible    xpath://td[contains(text(),"${dlp_sensor_name}")]
    unselect frame

    #Edit the filter from file to message, change regexp phrase, and change action
    Edit DLP sensor    ${dlp_sensor_name}
    Go to DLP New Filter Type Message
    Select DLP sensor action block
    Add DLP regexp    ${dlp_regexp2}

    #Check the filter is correctly edited
    select frame    embedded-iframe
    Wait Until Element is Visible    xpath://td[@class="disp_action"][contains(text(),"Block")]  
    Wait Until Element is Visible    xpath://td[@class="disp_filter"][contains(text(),"Regular Expression matches: ${dlp_regexp2}")]   
    Wait Until Element is Visible    xpath://td[@class="disp_proto"][contains(text(),"SMTP, POP3, IMAP, HTTP-POST")]
    unselect frame

    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    Delete DLP sensor    ${dlp_sensor_name}
    Logout FortiGate
    write test result to file    ${CURDIR}