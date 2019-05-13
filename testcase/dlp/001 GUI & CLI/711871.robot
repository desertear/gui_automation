*** Settings ***
Documentation    Verify DLP file filter can be created and modified from GUI
Resource    ../dlp_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${dlp_sensor_name}    gui-filetype
${dlp_file_type}    PDF
${dlp_quarantine_time}  5    
    
*** Test Cases ***
711871
    [Documentation]    
    [Tags]    6.2.0    dlp    chrome    711871    high    win10    runable

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    
    #Create file-type sensor
    Create New DLP sensor    ${dlp_sensor_name}
    Select DLP sensor action quarantine    ${dlp_quarantine_time}
    Go to DLP New Filter Type File
    Add DLP filetype    ${dlp_file_type}

    #Check that filter is created correctly
    select frame    embedded-iframe
    Wait Until Element is Visible    xpath://td[@class="disp_action"][contains(text(),"Quarantine IP Address")]  
    Wait Until Element is Visible    xpath://td[@class="disp_filter"][contains(text(),"Specified File Types")]
    Wait Until Element is Visible    xpath://td[@class="disp_proto"][contains(text(),"SMTP, POP3, IMAP, HTTP-GET, HTTP-POST, FTP")]    
    unselect frame

    #Check that filter is displayed in the DLP list
    Go to DLP profile
    select frame    embedded-iframe
    Wait Until Element Is Visible    xpath://td[contains(text(),"${dlp_sensor_name}")]
    unselect frame

    #Edit the filter action and protocols
    Edit DLP sensor    ${dlp_sensor_name}
    Select DLP sensor action block
    Select DLP sensor proto http-post
    Select DLP sensor proto http-get
    Select DLP sensor proto ftp
    Save DLP Filter

    #Check the filter is correctly edited
    select frame    embedded-iframe
    Wait Until Element is Visible    xpath://td[@class="disp_action"][contains(text(),"Block")]  
    Wait Until Element is Visible    xpath://td[@class="disp_filter"][contains(text(),"Specified File Types")]
    Wait Until Element is Visible    xpath://td[@class="disp_proto"][contains(text(),"SMTP, POP3, IMAP")]    
    unselect frame

    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    Delete DLP sensor    ${dlp_sensor_name}
    Logout FortiGate
    write test result to file    ${CURDIR}