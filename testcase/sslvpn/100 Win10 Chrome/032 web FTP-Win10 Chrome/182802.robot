*** Settings ***
Documentation    Verify 2G file can be successfully ftp download in web mode
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
${file_name}    5GBfile
${ftp_host}    ${SSLVPN_FTP_HOST}
${ftp_username}    tester
${ftp_password}    123456
${download_directory}    ${SSLVPN_FILE_DOWNLOAD_DIR_PATH}

*** Test Cases ***
182802
    [Timeout]    20 min
    [Tags]    v6.0    chrome    firefox    edge    safari    182802    low    win10,64bit    time_consuming
    Login SSLVPN Portal
    connect to ftp    ${ftp_host}    username=${ftp_username}    password=${ftp_password}
    # need 30 minutes to upload the file
    download ftp file by clicking filename    ${file_name}    ${download_directory}
    # need 30 minutes to download the file
    upload file to ftp    ${download_directory}    ${file_name}

    close window
    select window    MAIN
    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***
