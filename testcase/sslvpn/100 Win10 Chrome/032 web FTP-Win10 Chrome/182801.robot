*** Settings ***
Documentation    Verify that the directory delete button deletes the directory only if it's empty
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
${dir_name}    182801
${subdir_name}    test_sub_directory
${ftp_host}    ${SSLVPN_FTP_HOST}
${ftp_username}    ${SSLVPN_FTP_USERNAME}
${ftp_password}    ${SSLVPN_FTP_PASSWORD}
*** Test Cases ***
182801
    [Tags]    v6.0    firefox    chrome    edge    safari    182801    low    win10,64bit
    Login SSLVPN Portal
    connect to ftp    ${ftp_host}    username=${ftp_username}    password=${ftp_password}
    go to ftp directory    ${SSLVPN_FTP_TEST_DIR}
    create new ftp directory    ${dir_name}
    go to ftp directory    ${dir_name}
    create new ftp directory    ${subdir_name}
    go to upper ftp directory
    ${result_deleting}=     run keyword and return status    delete ftp directory    ${dir_name}
    go to ftp directory    ${dir_name}
    delete ftp directory    ${subdir_name}
    go to upper ftp directory
    delete ftp directory    ${dir_name}
    close window
    select window    MAIN
    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***