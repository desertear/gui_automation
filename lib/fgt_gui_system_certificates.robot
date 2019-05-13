*** Settings ***
Documentation     This file contains FortiGate GUI Certificates("System"->"Certificates") Keywords. 

*** Keywords ***
Go to Certificates
    Wait Until element is visible    ${SYSTEM_CERTIFICATES_ENTRY}
    click element    ${SYSTEM_CERTIFICATES_ENTRY}

Generate Certificate Signing Request
    [Documentation]    Generate Certificate Signing Request
    ...    args:
    ...    id_type: one of "Host IP", "Domain Name" and "E-Mail";
    ...    units: list of Organization Unit;
    ...    country: formal country name, i.e Canada, China, and United States;
    ...    key_type: one of "RSA" and "Elliptic Curve";
    ...    key_size: one of "1024 Bit","1536 Bit","2048 Bit" and "4096 Bit";
    ...    curve_name: one of "secp256r1", "secp384r1" and "secp521r1";
    ...    enrollment_method: one of "File Based" and "Online SCEP"
    [Arguments]    ${certificate_name}    ${id_type}    ${common_name}    ${units}=@{EMPTY}   ${organization}=${EMPTY}
    ...    ${locality}=${EMPTY}    ${state}=${EMPTY}    ${country}=${EMPTY}    ${email}=${EMPTY}    ${sna}=${EMPTY}
    ...    ${key_password}=${EMPTY}    ${key_type}=RSA    ${key_size}=2048 Bit    ${curve_name}=secp256r1
    ...    ${enrollment_method}=File Based    ${scep_url}=${EMPTY}    ${password}=${EMPTY}
    Wait Until Element is Visible    ${SYSTEM_CERTIFICATES_FRAME}
    Select Frame    ${SYSTEM_CERTIFICATES_FRAME}
    Wait Until Element is Visible    ${SYSTEM_CERTIFICATES_GENERATE}    
    Click Button    ${SYSTEM_CERTIFICATES_GENERATE}
    Unselect Frame
    Wait Until Element is Visible    ${SYSTEM_CERTIFICATES_GENERATE_HEAD}
    #set certificate Name
    Wait Until Element is Visible    ${SYSTEM_CERTIFICATES_GENERATE_NAME_TEXT}
    Input text    ${SYSTEM_CERTIFICATES_GENERATE_NAME_TEXT}    ${certificate_name}
    #choose ID type and set common name
    set csr common name    ${id_type}    ${common_name}
    #set optional Information
    set csr optional information    units=@{units}   organization=${organization}
    ...    locality=${locality}    state=${state}    country=${country}    email=${email}    sna=${sna}
    ...    key_password=${key_password}
    #set key type and key size/curve name
    set csr key type and key size    ${key_type}    ${key_size}    ${curve_name}
    #Enrollment Method
    set csr enrollment method    ${enrollment_method}    ${scep_url}    ${password}
    #click OK to save the configuration
    Wait Until Element is Visible    ${SYSTEM_CERTIFICATES_GENERATE_OK_BUTTON}
    Click Button    ${SYSTEM_CERTIFICATES_GENERATE_OK_BUTTON}
    Wait Until Element is Visible    ${SYSTEM_CERTIFICATES_FRAME} 
    Select Frame    ${SYSTEM_CERTIFICATES_FRAME}
    #check if the certificate has been created.
    ${locator_created_csr_line}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_SYSTEM_CERTIFICATES_LINE_BY_CERTIFICATE_NAME}    ${certificate_name}
    Wait Until Element is Visible    ${locator_created_csr_line}    
    [Teardown]    Unselect Frame 

set csr common name
    [Documentation]    Generate Certificate Signing Request
    ...    args:
    ...    id_type: one of "Host IP", "Domain Name" and "E-Mail";
    ...    common_name: common name according to id type.
    [Arguments]    ${id_type}    ${common_name}
    #choose ID type
    ${type_label_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_SYSTEM_CERTIFICATES_GENERATE_TYPE_LABEL}    ${id_type}
    Wait Until Element is Visible    ${type_label_locator}
    Click Element    ${type_label_locator}
    #set text's label name according to ID type.
    ${label_name}=    Run keyword if    "${id_type}"=="Host IP"    set variable    IP
    ...    ELSE    "${id_type}"=="Domain Name"    set variable    Domain Name
    ...    ELSE    "${id_type}"=="E-Mail"    set variable    E-Mail
    ...    ELSE    Fail    Unknown ID Type: ${id_type}
    #input common name
    ${common_name_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_SYSTEM_CERTIFICATES_GENERATE_CN_TEXT}    ${label_name}
    Wait Until Element is Visible    ${common_name_locator}
    Input Text    ${common_name_locator}    ${common_name}

set csr optional information
    [Documentation]   Set CSR optional information
    ...    args:
    ...    id_type: one of "Host IP", "Domain Name" and "E-Mail";
    ...    units: list of Organization Unit;
    ...    country: formal country name, i.e Canada, China, and United States;
    ...    key_type: one of "RSA" and "Elliptic Curve";
    ...    key_size: one of "1024 Bit","1536 Bit","2048 Bit" and "4096 Bit";
    ...    curve_name: one of "secp256r1", "secp384r1" and "secp521r1";
    ...    enrollment_method: one of "File Based" and "Online SCEP"
    [Arguments]    ${units}=@{EMPTY}   ${organization}=${EMPTY}    ${locality}=${EMPTY}
    ...    ${state}=${EMPTY}    ${country}=${EMPTY}    ${email}=${EMPTY}    ${sna}=${EMPTY}    ${key_password}=${EMPTY}
    #set Organization Unit
    #To do: at present only one unit is supported
    ${if_list_empty}=    Run keyword and return status    Should Be Empty    ${units}
    ${unit}=    run keyword if    ${if_list_empty}    set variable    ${EMPTY}
    ...    ELSE    set variable    @{units}[0]
    Wait Until Element is visible    ${SYSTEM_CERTIFICATES_GENERATE_OU_TEXT}
    Input Text    ${SYSTEM_CERTIFICATES_GENERATE_OU_TEXT}    ${unit}
    #set Organization
    Wait Until Element is visible    ${SYSTEM_CERTIFICATES_GENERATE_ORGANIZATION_TEXT}
    Input Text    ${SYSTEM_CERTIFICATES_GENERATE_ORGANIZATION_TEXT}    ${organization}
    #set Locality(City)
    Wait Until Element is visible    ${SYSTEM_CERTIFICATES_GENERATE_LOCALITY_TEXT}
    Input Text    ${SYSTEM_CERTIFICATES_GENERATE_LOCALITY_TEXT}    ${locality}
    #set State / Province
    Wait Until Element is visible    ${SYSTEM_CERTIFICATES_GENERATE_STATE_TEXT}
    Input Text    ${SYSTEM_CERTIFICATES_GENERATE_STATE_TEXT}    ${state}
    #set Country / Region
    set csr country or region    ${country}
    #set email
    Wait Until Element is visible    ${SYSTEM_CERTIFICATES_GENERATE_EMAIL_TEXT}
    Input Text    ${SYSTEM_CERTIFICATES_GENERATE_EMAIL_TEXT}    ${email}    
    #set Subject Alternative Name
    Wait Until Element is visible    ${SYSTEM_CERTIFICATES_GENERATE_SAN_TEXT}
    Input Text    ${SYSTEM_CERTIFICATES_GENERATE_SAN_TEXT}    ${sna}
    #set Password for private key
    Wait Until Element is visible    ${SYSTEM_CERTIFICATES_GENERATE_PASSWORD_TEXT}
    Input Text    ${SYSTEM_CERTIFICATES_GENERATE_PASSWORD_TEXT}    ${key_password}

set csr country or region
    [Documentation]   Set CSR optional information
    ...    args:
    ...    country: formal country name, i.e Canada, China, and United States;
    [Arguments]   ${country}
    Return from keyword if    "${country}"=="${EMPTY}"
    Wait Until Element is visible    ${SYSTEM_CERTIFICATES_GENERATE_COUNTRY_CHECKBOX_LABEL}
    Click Element    ${SYSTEM_CERTIFICATES_GENERATE_COUNTRY_CHECKBOX_LABEL}
    Wait Until Element is visible    ${SYSTEM_CERTIFICATES_GENERATE_COUNTRY_DIV}
    Click Element    ${SYSTEM_CERTIFICATES_GENERATE_COUNTRY_DIV}
    ${locator_country_dropdown}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_SYSTEM_CERTIFICATES_GENERATE_COUNTRY_ITEM_DROPDOWN}    ${country}
    Wait Until Element is visible    ${locator_country_dropdown}
    Click Element    ${locator_country_dropdown}
    ${locator_country_selected}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_SYSTEM_CERTIFICATES_GENERATE_COUNTRY_ITEM_IN_DIV}    ${country}
    Wait Until Element is visible    ${locator_country_selected}

set csr key type and key size
    [Documentation]   Set key type and key size
    ...    args:
    ...    key_type: one of "RSA" and "Elliptic Curve";
    ...    key_size: one of "1024 Bit","1536 Bit","2048 Bit" and "4096 Bit";
    ...    curve_name: one of "secp256r1", "secp384r1" and "secp521r1";
    [Arguments]    ${key_type}    ${key_size}    ${curve_name}
    ${locator_key_type_label}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_SYSTEM_CERTIFICATES_GENERATE_KEY_TYPE_LABEL}    ${key_type}
    Wait Until Element is visible    ${locator_key_type_label}
    Click Element    ${locator_key_type_label}
    ${locator_key_size_label}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_SYSTEM_CERTIFICATES_GENERATE_KEY_SIZE_LABEL}    ${key_size}
    ${locator_curve_name_label}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_SYSTEM_CERTIFICATES_GENERATE_CURVE_NAME_LABEL}    ${curve_name}
    Run keyword if    "${key_type}"=="RSA"    Wait Until Element is visible    ${locator_key_size_label}
    ...    ELSE    Wait Until Element is visible    ${locator_curve_name_label}
    Run keyword if    "${key_type}"=="RSA"    Click Element    ${locator_key_size_label}
    ...    ELSE    Click Element    ${locator_curve_name_label}

set csr enrollment method
    [Documentation]    set csr enrollment method
    ...    args:
    ...    enrollment_method: one of "File Based" and "Online SCEP"
    [Arguments]    ${enrollment_method}    ${scep_url}    ${password}
    ${locator_enrollment_label}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_SYSTEM_CERTIFICATES_GENERATE_ENROLLMENT_METHOD_LABEL}    ${enrollment_method}
    Wait Until Element is visible    ${locator_enrollment_label}
    Run keyword if    "${enrollment_method}"=="Online SCEP"    set csr scep    ${scep_url}    ${password}

set csr scep
    [Documentation]    set csr scep parameters
    [Arguments]    ${scep_url}    ${password}
    Wait Until Element is visible    ${SYSTEM_CERTIFICATES_GENERATE_CA_SERVER_URL_TEXT}
    input text    ${SYSTEM_CERTIFICATES_GENERATE_CA_SERVER_URL_TEXT}    ${scep_url}
    Wait Until Element is visible    ${SYSTEM_CERTIFICATES_GENERATE_CHALLENGE_PASSWORD_TEXT}
    input text    ${SYSTEM_CERTIFICATES_GENERATE_CHALLENGE_PASSWORD_TEXT}    ${password}
    ${if_need_confirm_password}=    Run keyword and return status    Wait Until Element is visible    ${SYSTEM_CERTIFICATES_GENERATE_CONFIRM_PASSWORD_TEXT}
    Run keyword if    ${if_need_confirm_password}    input text    ${SYSTEM_CERTIFICATES_GENERATE_CONFIRM_PASSWORD_TEXT}    ${password}

Delete Certificate
    [Documentation]    Delete Certificate or CSR file
    ...    args:
    ...    certificate_name: name of certificate or csr file.
    [Arguments]    ${certificate_name}
    ${status}=    Check if certificate exists    ${certificate_name}
    Return from keyword if    not ${status}    The certificate does not exist
    Wait Until Element is Visible    ${SYSTEM_CERTIFICATES_FRAME}
    Select Frame    ${SYSTEM_CERTIFICATES_FRAME}
    ${locator_created_csr_line}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_SYSTEM_CERTIFICATES_LINE_BY_CERTIFICATE_NAME}    ${certificate_name}
    Click Element    ${locator_created_csr_line}
    Wait Until Element is Visible    ${SYSTEM_CERTIFICATES_DELETE}
    click button    ${SYSTEM_CERTIFICATES_DELETE}
    deal with certificate confirm window
    Wait Until element is not visible    ${locator_created_csr_line}
    [Teardown]    Unselect Frame 

deal with certificate confirm window
    Unselect Frame
    Wait Until Element is Visible    ${SYSTEM_CERTIFICATES_CONFIRM_HEAD}
    Wait Until Element is Visible    ${SYSTEM_CERTIFICATES_CONFIRM_OK_BUTTON}
    Click Button    ${SYSTEM_CERTIFICATES_CONFIRM_OK_BUTTON}
    Wait Until Element is Visible    ${SYSTEM_CERTIFICATES_FRAME}    
    Select Frame    ${SYSTEM_CERTIFICATES_FRAME}

Check if certificate exists
    [Documentation]    Check if certificate or csr exists
    ...    args:
    ...    certificate_name: name of certificate or csr file.
    ...    full_match: boolean value that indicates if the name should be exactly matched. It's ${True} by default. 
    ...    When it's not ${True}, it means partially matched name is recognized also. 
    [Arguments]    ${certificate_name}    ${full_match}=${True}
    Wait Until Element is Visible    ${SYSTEM_CERTIFICATES_FRAME}
    Select Frame    ${SYSTEM_CERTIFICATES_FRAME}
    ${locator_created_csr_line}=    Run keyword if    ${full_match}    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_SYSTEM_CERTIFICATES_LINE_BY_CERTIFICATE_NAME}    ${certificate_name}
    ...    ELSE    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_SYSTEM_CERTIFICATES_LINE_CONTAINS_CERTIFICATE_NAME}    ${certificate_name}
    ${status}=    Run keyword and return status    Wait Until Element is Visible    ${locator_created_csr_line}
    [Return]    ${status}
    [Teardown]    Unselect Frame

Certificate Should Exist
    [Documentation]    Check if certificate or csr exists
    ...    args:
    ...    certificate_name: name of certificate or csr file.
    ...    full_match: boolean value that indicates if the name should be exactly matched. It's ${True} by default. 
    ...    When it's not ${True}, it means partially matched name is recognized also. 
    [Arguments]    ${certificate_name}    ${full_match}=${True}
    ${status}=    Check if certificate exists    ${certificate_name}    ${full_match}
    Should be True    "${status}"=="${True}"

Get Certificate Status
    [Documentation]    Check certificate, CRL or CSR status
    ...    args:
    ...    certificate_name: name of certificate or csr file.
    [Arguments]    ${certificate_name}
    Wait Until Element is Visible    ${SYSTEM_CERTIFICATES_FRAME}
    Select Frame    ${SYSTEM_CERTIFICATES_FRAME}
    ${locator_created_csr_line}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_SYSTEM_CERTIFICATES_STATUS_BY_CERTIFICATE_NAME}    ${certificate_name}
    Wait Until Element is Visible    ${locator_created_csr_line}
    ${status}=    Get Text     ${locator_created_csr_line}
    [Return]    ${status}
    [Teardown]    Unselect Frame

Certificate Status Should Be
    [Documentation]    Check certificate, CRL or CSR status
    ...    args:
    ...    certificate_name: name of certificate or csr file.
    [Arguments]    ${certificate_name}    ${expected_status} 
    ${status}=    Get Certificate Status    ${certificate_name}
    Should be True    "${status}"=="${expected_status}"

Download Certificate
    [Documentation]    Download certificate or csr to browser's default directory.
    ...    args:
    ...    certificate_name: name of certificate or csr file.
    ...    download_dir: directory path of downloaded file which should be configured on browsers in advance.
    [Arguments]    ${certificate_name}    ${download_dir}
    OperatingSystem.Remove File    ${download_dir}${/}${certificate_name}.*
    Wait Until Element is Visible    ${SYSTEM_CERTIFICATES_FRAME}
    Select Frame    ${SYSTEM_CERTIFICATES_FRAME}
    ${locator_created_csr_line}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_SYSTEM_CERTIFICATES_LINE_BY_CERTIFICATE_NAME}    ${certificate_name}
    Wait Until Element is Visible    ${locator_created_csr_line}
    Click element    ${locator_created_csr_line}
    Click button    ${SYSTEM_CERTIFICATES_DOWNLOAD}
    Wait Until Keyword Succeeds    10    5s    OperatingSystem.File Should Exist    ${download_dir}${/}${certificate_name}.*
    [Teardown]    Unselect Frame

Import Local Certificate
    [Documentation]    Import certificate to FortiGate.
    ...    args:
    ...    type: certificate type which can be "Local Certificate", "PKCS #12 Certificate" or "Certificate"
    ...    path_certificate_file: path of certificate file.
    ...    path_certificate_p12_file: path of certificate file which is in p12 format.
    ...    path_certificate_key_file: path of certificate key file which should be imported along with certificate file.
    ...    password: password of p12 file or key file.
    [Arguments]    ${type}    ${path_certificate_file}=${None}    ${path_certificate_p12_file}=${None}    ${path_certificate_key_file}=${None}    ${password}=${EMPTY}
    go to import certificate page    Local Certificate
    Wait Until Element is Visible    ${SYSTEM_CERTIFICATES_IMPORT_FRAME}
    Select Frame    ${SYSTEM_CERTIFICATES_IMPORT_FRAME}
    ${locator_type_label}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_SYSTEM_CERTIFICATES_IMPORT_LOCAL_TYPE_LABEL}    ${type}
    Wait Until Element is Visible    ${locator_type_label}
    Click element    ${locator_type_label}
    #wait until the page has been loaded.
    Run keyword if    "${type}"=="Local Certificate"    Wait Until Page Contains Element    ${SYSTEM_CERTIFICATES_IMPORT_LOCAL_CERTIFICATE_FILE}
    ...    ELSE IF    "${type}"=="PKCS #12 Certificate"    Wait Until Page Contains Element    ${SYSTEM_CERTIFICATES_IMPORT_LOCAL_PKCS_KEY_FILE}
    ...    ELSE IF    "${type}"=="Certificate"    Wait Until Page Contains Element    ${SYSTEM_CERTIFICATES_IMPORT_LOCAL_CERTIFICATE_KEY_FILE}
    ...    ELSE    Fail    Unknown certificate type
    #upload file
    Run keyword if    "${type}"=="Local Certificate"    Choose File    ${SYSTEM_CERTIFICATES_IMPORT_LOCAL_CERTIFICATE_FILE}    ${path_certificate_file}
    ...    ELSE IF    "${type}"=="PKCS #12 Certificate"    Choose File    ${SYSTEM_CERTIFICATES_IMPORT_LOCAL_PKCS_KEY_FILE}    ${path_certificate_p12_file}
    ...    ELSE IF    "${type}"=="Certificate"    Choose File    ${SYSTEM_CERTIFICATES_IMPORT_LOCAL_CERTIFICATE_FILE}    ${path_certificate_file}
    ...    ELSE    Fail    Unknown certificate type
    #upload key if the type is "Certificate"
    Run keyword if    "${type}"=="Certificate"    Choose File    ${SYSTEM_CERTIFICATES_IMPORT_LOCAL_CERTIFICATE_KEY_FILE}    ${path_certificate_key_file}
    #input password
    Run keyword if    "${type}"=="PKCS #12 Certificate" or "${type}"=="Certificate"    Input Text    ${SYSTEM_CERTIFICATES_IMPORT_LOCAL_PASSWORD}    ${password}
    #input confirm password, if required.
    ${if_existed}=    Run keyword and return status    Wait Until Element is Visible    ${SYSTEM_CERTIFICATES_IMPORT_LOCAL_CONFIRM_PASSWORD}
    Run keyword if    ${if_existed}    Input Text    ${SYSTEM_CERTIFICATES_IMPORT_LOCAL_CONFIRM_PASSWORD}    ${password}
    Wait Until Element is Visible    ${SYSTEM_CERTIFICATES_IMPORT_OK_BUTTON}
    Click Button    ${SYSTEM_CERTIFICATES_IMPORT_OK_BUTTON}
    [Teardown]    Unselect Frame

Import CA Certificate
    [Documentation]    Import CA to FortiGate.
    ...    args:
    ...    type: certificate type which can be "Online SCEP", or "File"
    ...    path_ca_file: path of ca file.
    ...    scep_server: URL of the SCEP server.
    ...    scep_id: Optional CA Identifier.
    [Arguments]    ${type}    ${path_ca_file}=${None}    ${scep_server}=${EMPTY}    ${scep_id}=${EMPTY}
    go to import certificate page    CA Certificate
    Wait Until Element is Visible    ${SYSTEM_CERTIFICATES_IMPORT_FRAME}
    Select Frame    ${SYSTEM_CERTIFICATES_IMPORT_FRAME}
    ${locator_type_label}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_SYSTEM_CERTIFICATES_IMPORT_CA_TYPE_LABEL}    ${type}
    Wait Until Element is Visible    ${locator_type_label}
    Click element    ${locator_type_label}
    #wait until the page has been loaded.
    Run keyword if    "${type}"=="Online SCEP"    Wait Until Element is Visible    ${SYSTEM_CERTIFICATES_IMPORT_CA_SCEP_URL_TEXT}
    ...    ELSE IF    "${type}"=="File"    Wait Until Page Contains Element    ${SYSTEM_CERTIFICATES_IMPORT_CA_UPLOAD_FILE}
    ...    ELSE    Fail    Unknown certificate type
    #input scep fields.
    Run keyword if    "${type}"=="Online SCEP"    Input Text    ${SYSTEM_CERTIFICATES_IMPORT_CA_SCEP_URL_TEXT}    ${scep_server}
    Run keyword if    "${type}"=="Online SCEP"    Input Text    ${SYSTEM_CERTIFICATES_IMPORT_CA_SCEP_OPTIONAL_ID_TEXT}    ${scep_id}
    #upload file
    Run keyword if    "${type}"=="File"    Choose File    ${SYSTEM_CERTIFICATES_IMPORT_CA_UPLOAD_FILE}    ${path_ca_file}
    Wait Until Element is Visible    ${SYSTEM_CERTIFICATES_IMPORT_OK_BUTTON}
    Click Button    ${SYSTEM_CERTIFICATES_IMPORT_OK_BUTTON}
    [Teardown]    Unselect Frame

Import Remote Certificate
    [Documentation]    Import Remote Certificate to FortiGate.
    ...    args:
    ...    path_file: path of certificate file.
    [Arguments]    ${path_file}
    go to import certificate page    Remote Certificate
    Wait Until Element is Visible    ${SYSTEM_CERTIFICATES_IMPORT_FRAME}
    Select Frame    ${SYSTEM_CERTIFICATES_IMPORT_FRAME}
    #wait until the page has been loaded.
    Wait Until Page Contains Element    ${SYSTEM_CERTIFICATES_IMPORT_REMOTE_UPLOAD_FILE}
    #upload file
    Choose File    ${SYSTEM_CERTIFICATES_IMPORT_REMOTE_UPLOAD_FILE}    ${path_file}
    Wait Until Element is Visible    ${SYSTEM_CERTIFICATES_IMPORT_OK_BUTTON}
    Click Button    ${SYSTEM_CERTIFICATES_IMPORT_OK_BUTTON}
    [Teardown]    Unselect Frame

Import CRL
    [Documentation]    Import CRL to FortiGate. LDAP and SCEP have not been supported by now.
    ...    args:
    ...    method: inport method which can be "File Based", or "Online Updating".
    ...    path_crl_file: path of CRL file.
    ...    online_dic: dictionary of online update parameters, including key "type" and other keys which are based on value of key "type".
    ...    value of "type" can be "HTTP", "LDAP" and "SCEP".
    ...    when "type" is "HTTP", key "url" indicates URL of the HTTP server;
    ...    when "type" is "LDAP", key "server" indicates entry of LDAP Server, along with other two keys "username" and "password";
    ...    when "type" is "SCEP", key "server" indicates URL of SCEP Server, and another key "certificate".
    ...    i.e. oneline_dic={"type"="HTTP","url"="http://172.16.200.1/test.crl"}
    ...    or oneline_dic={"type"="LDAP","server"="ldap_server","username"="test1","password"="123456"}
    ...    or oneline_dic={"type"="SCEP","server"="http://172.16.200.55/cert/scep","certificate"="Fortinet_Factory"}
    [Arguments]    ${method}    ${path_crl_file}    &{online_dic}
    go to import certificate page    CRL
    Wait Until Element is Visible    ${SYSTEM_CERTIFICATES_IMPORT_FRAME}
    Select Frame    ${SYSTEM_CERTIFICATES_IMPORT_FRAME}
    ${locator_method_label}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_SYSTEM_CERTIFICATES_IMPORT_CRL_METHOD_LABEL}    ${method}
    Wait Until Element is Visible    ${locator_method_label}
    Click element    ${locator_method_label}
    #wait until the page has been loaded.
    Run keyword if    "${method}"=="File Based"    Wait Until Page Contains Element    ${SYSTEM_CERTIFICATES_IMPORT_CRL_UPLOAD_FILE}
    ...    ELSE IF    "${method}"=="Online Updating"    Wait Until Element is visible    ${SYSTEM_CERTIFICATES_IMPORT_CRL_HTTP_LABEL}
    ...    ELSE    Fail    Unknown certificate type
    #upload file
    Run keyword if    "${method}"=="File Based"    Choose File    ${SYSTEM_CERTIFICATES_IMPORT_CRL_UPLOAD_FILE}    ${path_crl_file}
    ...    ELSE IF    "${method}"=="Online Updating"    set online Updating parameters    &{online_dic}
    ...    ELSE    Fail    Unknown certificate type
    Wait Until Element is Visible    ${SYSTEM_CERTIFICATES_IMPORT_OK_BUTTON}
    Click Button    ${SYSTEM_CERTIFICATES_IMPORT_OK_BUTTON}
    [Teardown]    Unselect Frame

set online Updating parameters
    [Documentation]    Only support HTTP by now.
    [Arguments]    &{online_dic}
    ${type}=    set variable    &{online_dic}[type]
    Run keyword if    "${type}"=="HTTP"    Click element    ${SYSTEM_CERTIFICATES_IMPORT_CRL_HTTP_LABEL}
    ...    ELSE IF    "${type}"=="LDAP"    Click element    ${SYSTEM_CERTIFICATES_IMPORT_CRL_LDAP_LABEL}
    ...    ELSE IF    "${type}"=="SCEP"    Click element    ${SYSTEM_CERTIFICATES_IMPORT_CRL_SCEP_LABEL}
    ...    ELSE    Fail    Unknown certificate type
    #input http server url
    Run keyword if    "${type}"=="HTTP"    Wait Until Element is visible    ${SYSTEM_CERTIFICATES_IMPORT_CRL_HTTP_URL}    
    Run keyword if    "${type}"=="HTTP"    Input Text    ${SYSTEM_CERTIFICATES_IMPORT_CRL_HTTP_URL}    &{online_dic}[url]

go to import certificate page
    [Documentation]    open import page.
    ...    args:
    ...    type: certificate type which can be "Local Certificate", "CA Certificate", "Remote Certificate" or "CRL"
    [Arguments]    ${type} 
    Wait Until Element is Visible    ${SYSTEM_CERTIFICATES_FRAME}
    Select Frame    ${SYSTEM_CERTIFICATES_FRAME}
    sleep    1s
    Wait Until Element is Visible    ${SYSTEM_CERTIFICATES_IMPORT}
    Click Button    ${SYSTEM_CERTIFICATES_IMPORT}
    ${locator_certificate_button}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_SYSTEM_CERTIFICATES_IMPORT_CERTIFICATE}    ${type}
    Wait Until Element is Visible    ${locator_certificate_button}
    Click Button    ${locator_certificate_button}
    Unselect Frame
    Run keyword if    "${type}"=="Local Certificate"    Wait Until Element is Visible    ${SYSTEM_CERTIFICATES_IMPORT_LOCAL_HEAD}
    ...    ELSE IF    "${type}"=="CA Certificate"    Wait Until Element is Visible    ${SYSTEM_CERTIFICATES_IMPORT_CA_HEAD}
    ...    ELSE IF    "${type}"=="Remote Certificate"    Wait Until Element is Visible    ${SYSTEM_CERTIFICATES_IMPORT_REMOTE_HEAD}
    ...    ELSE IF    "${type}"=="CRL"    Wait Until Element is Visible    ${SYSTEM_CERTIFICATES_IMPORT_CRL_HEAD}
    ...    ELSE    Fail    Unknown certificate type

