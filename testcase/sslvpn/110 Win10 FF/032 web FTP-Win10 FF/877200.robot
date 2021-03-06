*** Settings ***
Documentation    Verify that sslvpn web mode FTP connection allow selecting and deleting multiple files at the same time
...   Action:
...    1. check boxes are added beside each file, so any files can be selected/deselect
...    2. select all check box is added so all files can be selected
...    3. download or delete all buttons are added
...    4. multiple files can be selected, downloaded and deleted
...   Expect:
...   the file has been downloaded successfully
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
#this case can only be run on Chrome(v56+)
#${browser}    gc
${file_path}    ${SSLVPN_FILE_UPLOAD_DIR_PATH}
${file_name1}    10M.dat
${file_name2}    20M.dat
${ftp_host}    ${SSLVPN_FTP_HOST}
${ftp_username}    ${SSLVPN_FTP_USERNAME}
${ftp_password}    ${SSLVPN_FTP_PASSWORD}
${download_directory}    ${SSLVPN_FILE_DOWNLOAD_DIR_PATH}
*** Test Cases ***
877200
    [Tags]    v6.0    firefox    chrome    edge    safari    877200    medium    win10,64bit
    Login SSLVPN Portal
    connect to ftp    ${ftp_host}    username=${ftp_username}    password=${ftp_password}
    go to ftp directory    ${SSLVPN_FTP_TEST_DIR}
    upload file to ftp    ${file_path}    ${file_name1}
    upload file to ftp    ${file_path}    ${file_name2}
    ${file_names}=    create list    ${file_name1}    ${file_name2}
    delete mutiple ftp files    ${file_names}    ${download_directory}
    close window
    select window    MAIN
    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***