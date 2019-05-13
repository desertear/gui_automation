*** Settings ***
Documentation    Verify that the 'make directory' button creates a new directory
...   Action:
...    1. login web portal, connect to ftp sever.
...    2. click on new directory icon
...   Expect:
...    the new directory has been created successfully
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${file_path}    ${SSLVPN_FILE_UPLOAD_DIR_PATH}
${dir_name}    test_directory
${ftp_host}    ${SSLVPN_FTP_HOST}
${ftp_username}    ${SSLVPN_FTP_USERNAME}
${ftp_password}    ${SSLVPN_FTP_PASSWORD}
*** Test Cases ***
877216
    [Tags]    v6.0    firefox    chrome    edge    safari    877216    low    win10,64bit
    Login SSLVPN Portal
    connect to ftp    ${ftp_host}    username=${ftp_username}    password=${ftp_password}
    go to ftp directory    ${SSLVPN_FTP_TEST_DIR}
    create new ftp directory    ${dir_name}
    delete ftp directory    ${dir_name}
    close window
    select window    MAIN
    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***