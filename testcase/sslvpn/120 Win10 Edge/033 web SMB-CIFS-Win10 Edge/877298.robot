*** Settings ***
Documentation    Verify that the rename button correctly renames the file
...   Action:
...    1. login web portal, connect to samba sever.
...    2. choose a file and click on rename icon and input a new filename
...   Expect:
...   the filename ahs been changed successfully
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${file_path}    ${SSLVPN_FILE_UPLOAD_DIR_PATH}
${original_file_name}    1M.dat
${target_file_name}    1M.dat_bak
${smb_upper_most_dir_name}    ${SSLVPN_SMB_MOST_UPPER_DIR}
${smb_host}    ${SSLVPN_SMB_HOST}
${smb_username}    ${SSLVPN_SMB_USERNAME}
${smb_password}    ${SSLVPN_SMB_PASSWORD}
*** Test Cases ***
877298
    [Tags]    v6.0    firefox    chrome    edge    safari    877298    medium    win10,64bit
    Login SSLVPN Portal
    connect to smb    ${smb_host}    username=${smb_username}    password=${smb_password}
    go to smb upper most directory    ${SSLVPN_SMB_MOST_UPPER_DIR}
    go to smb directory    ${SSLVPN_SMB_TEST_DIR}
    upload file to smb    ${file_path}    ${original_file_name}
    rename smb file    ${original_file_name}    ${target_file_name}
    delete smb file    ${target_file_name}
    close window
    select window    MAIN
    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***