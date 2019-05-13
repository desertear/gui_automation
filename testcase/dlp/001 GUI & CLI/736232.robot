*** Settings ***
Documentation    Verify DLP file size sensor can be created and modified from GUI
Resource    ../dlp_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${dlp_sensor_name}    gui-filesize
${dlp_file_size1}    20
${dlp_file_size2}    50   
    
*** Test Cases ***
736232
    [Documentation]    
    [Tags]    6.2.0    dlp    chrome    736232    critical    win10    runable

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    
    #Create file-size sensor
    Create New DLP sensor    ${dlp_sensor_name}
    Select DLP sensor action block
    Go to DLP New Filter Type File
    Add DLP filesize    ${dlp_file_size1}

    #Check that filter is created correctly
    select frame    embedded-iframe
    Wait Until Element is Visible    xpath://td[@class="disp_action"][contains(text(),"Block")]  
    Wait Until Element is Visible    xpath://td[@class="disp_filter"][contains(text(),"File Size >= ${dlp_file_size1} KB")]
    Wait Until Element is Visible    xpath://td[@class="disp_proto"][contains(text(),"SMTP, POP3, IMAP, HTTP-GET, HTTP-POST, FTP")]    
    unselect frame

    #Check that filter is displayed in the DLP list
    Go to DLP profile
    select frame    embedded-iframe
    Wait Until Element Is Visible    xpath://td[contains(text(),"${dlp_sensor_name}")]
    unselect frame

    #Edit the filter filesize, action and protocols
    Edit DLP sensor    ${dlp_sensor_name}
    Select DLP sensor action log-only
    Select DLP sensor proto mapi
    Select DLP sensor proto nntp
    Add DLP filesize    ${dlp_file_size2}

    #Check the filter is correctly edited
    select frame    embedded-iframe
    Wait Until Element is Visible    xpath://td[@class="disp_action"][contains(text(),"Log Only")]  
    Wait Until Element is Visible    xpath://td[@class="disp_filter"][contains(text(),"File Size >= ${dlp_file_size2} KB")]
    Wait Until Element is Visible    xpath://td[@class="disp_proto"][contains(text(),"SMTP, POP3, IMAP, HTTP-GET, HTTP-POST, FTP, NNTP, MAPI")]    
    unselect frame

    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    Delete DLP sensor    ${dlp_sensor_name}
    Logout FortiGate
    write test result to file    ${CURDIR}