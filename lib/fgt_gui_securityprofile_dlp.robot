*** Settings ***
Documentation     This file contains FortiGate GUI Policy and Objects operation

*** Keywords ***
###Data Leak Prevention###    
##Security Profile -> Data Leak Prevention##

Go to DLP profile
    Go to Security Profiles
    Wait Until Element Is Visible    ${DLP_ENTRY}
    click element    ${DLP_ENTRY}
    select frame    embedded-iframe
    Wait Until Element Is Visible    ${CREATE_DLP_SENSOR}
    unselect frame

Create New DLP sensor
    [Arguments]    ${dlp_sensor_name}
    [Documentation]    Leaves user in Edit Filter page
    Go to DLP profile 
    select frame    embedded-iframe
    Wait Until Element Is Visible    ${CREATE_DLP_SENSOR}
    click element    ${CREATE_DLP_SENSOR}
    Wait Until Element Is Visible    ${EDIT_DLP_SENSOR_NAME}
    input text    ${EDIT_DLP_SENSOR_NAME}    ${dlp_sensor_name}
    click element    ${ADD_DLP_FILTER}
    unselect frame

Delete DLP sensor
    [Arguments]    ${dlp_sensor_name}
    Go to DLP profile
    select frame    embedded-iframe
    Wait Until Element is Visible    xpath://td[contains(text(),"${dlp_sensor_name}")]
    click element    xpath://td[contains(text(),"${dlp_sensor_name}")]
    click element    ${DELETE_DLP_FILTER}
    unselect frame
    Wait Until Element is Visible    ${DELETE_DLP_CONFIRM}
    click element    ${DELETE_DLP_CONFIRM}
    select frame    embedded-iframe
    Wait Until Element is Not Visible    xpath://td[contains(text(),"${dlp_sensor_name}")]
    unselect frame

Edit DLP sensor
    [Arguments]    ${dlp_sensor_name}
    [Documentation]    Leaves user in Edit Filter page
    Go to DLP profile
    select frame    embedded-iframe 
    Wait Until Element is Visible    xpath://td[contains(text(),"${dlp_sensor_name}")]
    click element    xpath://td[contains(text(),"${dlp_sensor_name}")]
    click element    ${EDIT_DLP_SENSOR} 
    Wait Until Element is Visible    ${DLP_FILTER_ENTRY}
    click element    ${DLP_FILTER_ENTRY} 
    click element    ${EDIT_DLP_FILTER}  
    unselect frame

Go to DLP New Filter Type File 
    [Documentation]    Must be ran during "Edit Filter" or "Add Filter" page
    select frame    embedded-iframe
    Wait Until Element Is Visible    ${FILTER_TYPE_FILE}
    click element    ${FILTER_TYPE_FILE}
    unselect frame

Go to DLP New Filter Type Message
    [Documentation]    Must be ran during "Edit Filter" or "Add Filter" page
    select frame    embedded-iframe
    Wait Until Element Is Visible    ${FILTER_TYPE_MESSAGE}
    click element    ${FILTER_TYPE_MESSAGE}
    unselect frame

Add DLP filetype
    [Arguments]    ${dlp_file_type} 
    [Documentation]    Must be ran during "Edit Filter" or "Add Filter" page  
    select frame    embedded-iframe
    #select filetype option
    Wait Until Element is Visible    ${SELECT_FILETYPE}
    click element    ${SELECT_FILETYPE}
    #add filetype
    Wait Until Element is Visible    ${ADD_FILETYPE}
    click element    ${ADD_FILETYPE}
    Wait Until Element Is Visible    ${FILETYPE_SELECTION_PANE}
    sleep    5
    Wait Until Element Is Visible    ${FILETYPE_SEARCH}
    input text    ${FILETYPE_SEARCH}    ${dlp_file_type}
    sleep    2
    Press Key    ${FILETYPE_SEARCH}     \\13
    unselect frame
    #save sensor
    Save DLP Filter

Add DLP regexp
    [Arguments]    ${dlp_regexp}
    [Documentation]    Adds regexp expression into Regular Expression field. Must be ran on "Edit Filter or "New Filter" page
    select frame    embedded-iframe
    #select regexp and enter expression
    Wait Until Element Is Visible    ${SELECT_REGEXP}
    click element    ${SELECT_REGEXP}
    Wait Until Element Is Visible    ${REGEXP_FIELD}
    input text    ${REGEXP_FIELD}    ${dlp_regexp}
    unselect frame
    #save sensor
    Save DLP Filter

Add DLP filesize
    [Arguments]    ${dlp_file_size}
    [Documentation]    Must be ran after "Go to DLP New Filter Type File"
    select frame    embedded-iframe
    #select filesize
    Wait Until Element is Visible    ${SELECT_FILESIZE}
    click element    ${SELECT_FILESIZE}
    input text    ${FILESIZE_FIELD}    ${dlp_file_size}
    unselect frame
    #save sensor
    Save DLP Filter

Add DLP filepattern
    [Arguments]    ${dlp_file_pattern}
    

Save DLP Filter
    [Documentation]    Clicks OK on "Edit Filter" or "New Filter" page
    select frame    embedded-iframe
    Wait Until Element is Visible    ${SAVE_FILTER}
    click element    ${SAVE_FILTER}
    unselect frame

Select DLP sensor action block
    [Documentation]    Must be ran during "Edit Filter" or "Add Filter" page or "Edit DLP sensor"
    select frame    embedded-iframe
    click element    ${FILTER_ACTION}
    Wait Until Element is Visible    ${FILTER_ACTION_BLOCK}
    click element    ${FILTER_ACTION_BLOCK}
    unselect frame

#In future can create a single function "Select DLP sensor action" and use arguments
Select DLP sensor action allow
    [Documentation]    Must be ran during "Edit Filter" or "Add Filter" page or "Edit DLP sensor"
    select frame    embedded-iframe
    click element    ${FILTER_ACTION}
    Wait Until Element is Visible    ${FILTER_ACTION_ALLOW}
    click element    ${FILTER_ACTION_ALLOW}
    unselect frame

Select DLP sensor action log-only
    [Documentation]    Must be ran during "Edit Filter" or "Add Filter" page or "Edit DLP sensor"
    select frame    embedded-iframe
    click element    ${FILTER_ACTION}
    Wait Until Element is Visible    ${FILTER_ACTION_LOG}
    click element    ${FILTER_ACTION_LOG}
    unselect frame

Select DLP sensor action quarantine
    [Arguments]    ${dlp_quarantine_time}
    [Documentation]    Must be ran during "Edit Filter" or "Add Filter" page or "Edit DLP sensor"
    select frame    embedded-iframe
    click element    ${FILTER_ACTION}
    Wait Until Element is Visible    ${FILTER_ACTION_QUARANTINE}
    click element    ${FILTER_ACTION_QUARANTINE}
    Wait Until Element is Visible    ${QUARANTINE_FIELD}
    input text    ${QUARANTINE_FIELD}    ${dlp_quarantine_time}
    unselect frame

#In future can create a single function "Select DLP sensor proto" and use arguments
Select DLP sensor proto http-post
    [Documentation]    Must be ran during "Edit Filter" or "Add Filter" page or "Edit DLP sensor"
    select frame    embedded-iframe
    click element    ${PROTO_HTTP_POST}
    unselect frame

Select DLP sensor proto http-get
    [Documentation]    Must be ran during "Edit Filter" or "Add Filter" page or "Edit DLP sensor"
    select frame    embedded-iframe
    click element    ${PROTO_HTTP_GET}
    unselect frame

Select DLP sensor proto smtp
    [Documentation]    Must be ran during "Edit Filter" or "Add Filter" page or "Edit DLP sensor"
    select frame    embedded-iframe
    click element    ${PROTO_SMTP}
    unselect frame

Select DLP sensor proto pop3
    [Documentation]    Must be ran during "Edit Filter" or "Add Filter" page or "Edit DLP sensor"
    select frame    embedded-iframe
    click element    ${PROTO_POP3}
    unselect frame

Select DLP sensor proto imap
    [Documentation]    Must be ran during "Edit Filter" or "Add Filter" page or "Edit DLP sensor"
    select frame    embedded-iframe
    click element    ${PROTO_IMAP}
    unselect frame

Select DLP sensor proto mapi
    [Documentation]    Must be ran during "Edit Filter" or "Add Filter" page or "Edit DLP sensor"
    select frame    embedded-iframe
    click element    ${PROTO_MAPI}
    unselect frame

Select DLP sensor proto ftp
    [Documentation]    Must be ran during "Edit Filter" or "Add Filter" page or "Edit DLP sensor"
    select frame    embedded-iframe
    click element    ${PROTO_FTP}
    unselect frame

Select DLP sensor proto nntp
    [Documentation]    Must be ran during "Edit Filter" or "Add Filter" page or "Edit DLP sensor"
    select frame    embedded-iframe
    click element    ${PROTO_NNTP}
    unselect frame

Create DLP Sensor in Firewall Policy
    [Arguments]    ${dlp_sensor_name}
    [Documentation]    Goes to IPv4 Policy Page to create DLP sensor
    Go to policy and objects
    Go to IPv4 policy
    Wait Until Element Is Visible    ${IPV4_BY_SEQUENCE}
    click element    ${IPV4_BY_SEQUENCE}
    double click element    xpath://div[contains(text(),"${DLP_IPV4_POLICY_NAME}")]
    sleep    2
    Wait Until Element is Visible    ${IPV4_DLP_ENABLE}
    click element    ${IPV4_DLP_ENABLE}
    Wait Until Element is Visible    ${IPV4_DLP_DROPDOWN}
    click element    ${IPV4_DLP_DROPDOWN}
    Wait Until Element is Visible    ${IPV4_DLP_CREATE}
    click element    ${IPV4_DLP_CREATE}
    Wait Until Element is Visible    ${IPv4_DLP_FRAME}
    select frame    ${IPV4_DLP_FRAME}
    Wait Until Element is Visible    ${EDIT_DLP_SENSOR_NAME}
    input text    ${EDIT_DLP_SENSOR_NAME}    ${dlp_sensor_name}
    click element    ${ADD_DLP_FILTER}
    click element    ${SAVE_FILTER}
    unselect frame
    Wait Until Element is Visible    ${IPV4_DLP_SEARCH}
    input text    ${IPV4_DLP_SEARCH}    ${dlp_sensor_name}
    sleep    2
    Press Key    ${IPV4_DLP_SEARCH}     \\13
    Wait Until Element is Visible    xpath://span[contains(text(),"${dlp_sensor_name}")]
    Wait Until Element is Visible    ${IPV4_OK}
    click button    ${IPV4_OK}

Edit DLP Sensor in Firewall Policy
    [Arguments]    ${dlp_sensor_name}
    [Documentation]    Goes to IPv4 Policy Page to Edit DLP sensor and goes to Edit Filter 
    Go to policy and objects
    Go to IPv4 policy
    Wait Until Element Is Visible    ${IPV4_BY_SEQUENCE}
    click element    ${IPV4_BY_SEQUENCE}
    double click element    xpath://div[contains(text(),"${DLP_IPV4_POLICY_NAME}")]
    Wait Until Element Is Visible    ${IPV4_EDIT}
    click element    ${IPV4_EDIT}
    Wait Until Element is Visible    ${IPv4_DLP_FRAME}
    select frame    ${IPV4_DLP_FRAME}
    Wait Until Element is Visible    ${EDIT_DLP_SENSOR_NAME}
    input text    ${EDIT_DLP_SENSOR_NAME}    ${dlp_sensor_name}
    Wait Until Element is Visible    ${DLP_FILTER_ENTRY}
    double click element    ${DLP_FILTER_ENTRY}
    unselect frame
    

Remove DLP Sensor in Firewall Policy
    Go to policy and objects
    Go to IPv4 policy
    Wait Until Element Is Visible    ${IPV4_BY_SEQUENCE}
    click element    ${IPV4_BY_SEQUENCE}
    double click element    xpath://div[contains(text(),"${DLP_IPV4_POLICY_NAME}")]
    sleep    2
    Wait Until Element is Visible    ${IPV4_DLP_ENABLE}
    click element    ${IPV4_DLP_ENABLE}
    click element    ${IPV4_OK}


