*** Settings ***
Documentation    Verify that the directory and file can be renamed properly by clicking rename button
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
${original_file_name}    10M.dat
${target_file_name}    10M.dat_bak
${ftp_host}    ${SSLVPN_FTP_HOST}
${ftp_username}    ${SSLVPN_FTP_USERNAME}
${ftp_password}    ${SSLVPN_FTP_PASSWORD}
*** Test Cases ***
831380
    [Tags]    v6.0    no_grid   firefox    chrome    edge    safari    831380    medium    win10,64bit
    Login SSLVPN Portal
    connect to ftp    ${ftp_host}    username=${ftp_username}    password=${ftp_password}
    go to ftp directory    ${SSLVPN_FTP_TEST_DIR}
    upload file to ftp    ${file_path}    ${original_file_name}
    rename ftp file    ${original_file_name}    ${target_file_name}
    delete ftp file    ${target_file_name}
    close window
    select window    MAIN
    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***