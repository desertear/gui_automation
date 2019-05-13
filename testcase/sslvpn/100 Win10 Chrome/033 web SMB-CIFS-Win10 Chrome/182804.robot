*** Settings ***
Documentation    Verify that file can be uploaded successfully using the upload button
...   Action:
...    1. login web portal, connect to samba sever.
...    2. choose a file and click on delete icon.
...   Expect:
...   The file has been deleted.
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${browser}    ${SSLVPN_BROWSER}
${file_path}    ${SSLVPN_FILE_UPLOAD_DIR_PATH}
${file_name}    1M.dat
${smb_host}    ${SSLVPN_SMB_HOST}
${smb_username}    ${SSLVPN_SMB_USERNAME}
${smb_password}    ${SSLVPN_SMB_PASSWORD}
*** Test Cases ***
182804
    [Tags]    v6.0    firefox    chrome    edge    safari    182804    low    win10,64bit
    Login SSLVPN portal    browser=${browser}
    connect to smb    ${smb_host}    username=${smb_username}    password=${smb_password}
    go to smb upper most directory    ${SSLVPN_SMB_MOST_UPPER_DIR}
    go to smb directory    ${SSLVPN_SMB_TEST_DIR}
    upload file to smb    ${file_path}    ${file_name}
    delete smb file    ${file_name}
    close window
    select window    MAIN
    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***