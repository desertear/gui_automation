*** Settings ***
Documentation    Verify sslvpn web mode doesn't support ftp AV scan
...   Action:
...    1. login web portal, connect to ftp sever.
...    2. choose av file and click on download
...   Expect:
...   the file has been downloaded successfully
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
#this case can only be run on Chrome(v56+) and Edge
${file_path}    ${SSLVPN_FILE_UPLOAD_DIR_PATH}
${file_name}    eicar
${ftp_host}    ${SSLVPN_FTP_HOST}
${ftp_username}    ${SSLVPN_FTP_USERNAME}
${ftp_password}    ${SSLVPN_FTP_PASSWORD}

*** Test Cases ***
856961
    [Tags]    v6.0    chrome    firefox    edge    safari    856961    low    win10,64bit
    Login SSLVPN Portal
    connect to ftp    ${ftp_host}    username=${ftp_username}    password=${ftp_password}
    go to ftp directory    ${SSLVPN_FTP_TEST_DIR}
    ${locator_replaced_with_real_value1}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${FTP_VAR_FILE}    ${file_name}
    Wait Until Element Is Visible    ${locator_replaced_with_real_value1}
    ${file_index}=    get ftp file index in table    ${file_name}
    ${js_replaced_with_real_value1}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${JS_FTP_VAR_FILE}    ${file_index}
    execute Javascript    ${js_replaced_with_real_value1}
    sleep    ${JS_WAITING_TIME}

    close window
    select window    MAIN
    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***
