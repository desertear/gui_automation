*** Settings ***
Documentation    Verify that file can be uploaded using the upload button
...   Action:
...    1. login web portal, connect to ftp sever.
...    2. click on upload and choose the file to upload
...   Expect:
...   the file has been uploaded successfully
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
877193
    [Tags]    v6.0    firefox    chrome    edge    safari    877193    critical    win10,64bit
    Login SSLVPN Portal
    connect to ftp    ${ftp_host}    username=${ftp_username}    password=${ftp_password}
    go to ftp directory    ${SSLVPN_FTP_TEST_DIR}
    upload file to ftp    ${file_path}    ${file_name}
    # Execute javascript    document.getElementById('del_img_1').click()
    close window
    select window    MAIN
    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***