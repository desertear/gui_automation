*** Settings ***
Documentation    Verify that file can be downloaded properly by clicking on the filename
...   Action:
...    1. login web portal, connect to samba sever.
...    2. choose a file and click on download
...   Expect:
...   the file has been downloaded successfully
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
#this case can only be run on Chrome(v56+)
${file_path}    ${SSLVPN_FILE_UPLOAD_DIR_PATH}
${file_name}    1M.dat
${smb_host}    ${SSLVPN_SMB_HOST}
${smb_username}    ${SSLVPN_SMB_USERNAME}
${smb_password}    ${SSLVPN_SMB_PASSWORD}
${download_directory}    ${SSLVPN_FILE_DOWNLOAD_DIR_PATH}
*** Test Cases ***
182811
    [Tags]    v6.0    chrome    edge    safari    182811    medium    win10,64bit
    Login SSLVPN Portal
    connect to smb    ${smb_host}    username=${smb_username}    password=${smb_password}
    go to smb upper most directory    ${SSLVPN_SMB_MOST_UPPER_DIR}
    go to smb directory    ${SSLVPN_SMB_TEST_DIR}
    upload file to smb    ${file_path}    ${file_name}
    download smb file by clicking filename    ${file_name}    ${SSLVPN_FILE_DOWNLOAD_DIR_PATH}
    close window
    select window    MAIN
    [Teardown]    write test result to file    ${CURDIR}


*** Keywords ***