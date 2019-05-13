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
${file_name}    5GBfile
${smb_host}    ${SSLVPN_SMB_HOST}
${smb_username}    tester
${smb_password}    123456
${download_directory}    ${SSLVPN_FILE_DOWNLOAD_DIR_PATH}
*** Test Cases ***
819209
    [Timeout]    20 min
    [Tags]    v6.0    chrome    edge    safari    819209    high    win10,64bit    time_consuming
    Login SSLVPN Portal
    connect to smb    ${smb_host}    username=${smb_username}    password=${smb_password}
    go to smb directory    ${SSLVPN_SMB_TEST_DIR}
    download smb file by clicking filename    ${file_name}    ${download_directory}
    upload file to smb    ${download_directory}    ${file_name}
    close window
    select window    MAIN
    [Teardown]    write test result to file    ${CURDIR}


*** Keywords ***