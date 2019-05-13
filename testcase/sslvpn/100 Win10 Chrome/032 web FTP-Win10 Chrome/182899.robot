*** Settings ***
Documentation    Verify that the file delete button deletes the file correctly
...   Action:
...    1. login web portal, connect to ftp sever.
...    2. choose a file and click on delete icon.
...   Expect:
...    The file has been deleted.
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${file_path}    ${SSLVPN_FILE_UPLOAD_DIR_PATH}
${file_name}    10M.dat
${ftp_host}    ${SSLVPN_FTP_HOST}
${ftp_username}    ${SSLVPN_FTP_USERNAME}
${ftp_password}    ${SSLVPN_FTP_PASSWORD}
*** Test Cases ***
182899
    [Tags]    v6.0    firefox    chrome    edge    safari    182899    medium    win10,64bit
    Login SSLVPN Portal
    connect to ftp    ${ftp_host}    username=${ftp_username}    password=${ftp_password}
    go to ftp directory    ${SSLVPN_FTP_TEST_DIR}
    go to upper ftp directory
    close window
    select window    MAIN
    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***