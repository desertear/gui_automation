*** Settings ***
Documentation    Verify files and folders under current directory type and size are correct
...   Action:
...    1. login web portal, connect to ftp sever.
...    2. choose a directory not empty and click on delete icon.
...   Expect:
...    error message displayed that the directory can\'t be deleted.
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${file_path}    ${SSLVPN_FILE_UPLOAD_DIR_PATH}
${file_name}    10M.dat
${file_size_in_bit}    ${10*1024*1024}
${ftp_host}    ${SSLVPN_FTP_HOST}
${ftp_username}    ${SSLVPN_FTP_USERNAME}
${ftp_password}    ${SSLVPN_FTP_PASSWORD}
*** Test Cases ***
801103
    [Tags]    v6.0    firefox    chrome    edge    safari    801103    low    win10,64bit
    Login SSLVPN Portal
    connect to ftp    ${ftp_host}    username=${ftp_username}    password=${ftp_password}
    go to ftp directory    ${SSLVPN_FTP_TEST_DIR}
    upload file to ftp    ${file_path}    ${file_name}
    check ftp file size    ${file_name}    ${file_size_in_bit}
    close window
    select window    MAIN
    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***