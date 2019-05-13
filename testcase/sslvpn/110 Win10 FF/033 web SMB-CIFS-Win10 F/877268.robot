*** Settings ***
Documentation    Verify that the directory delete button deletes the directory only if it's empty
...   Action:
...    1. login web portal, connect to samba sever.
...    2. choose a directory not empty and click on delete icon.
...   Expect:
...   error message displayed that the directory can\'t be deleted.
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${browser}    ${SSLVPN_BROWSER}
${file_path}    ${SSLVPN_FILE_UPLOAD_DIR_PATH}
${dir_name}    test_directory
${subdir_name}    test_sub_directory
${smb_host}    ${SSLVPN_SMB_HOST}
${smb_username}    ${SSLVPN_SMB_USERNAME}
${smb_password}    ${SSLVPN_SMB_PASSWORD}
*** Test Cases ***
877268
    [Tags]    v6.0    firefox    chrome    edge    safari    877268    medium    win10,64bit
    Login SSLVPN Portal
    connect to smb    ${smb_host}    username=${smb_username}    password=${smb_password}
    go to smb upper most directory    ${SSLVPN_SMB_MOST_UPPER_DIR}
    go to smb directory    ${SSLVPN_SMB_TEST_DIR}
    create new smb directory    ${dir_name}
    go to smb directory    ${dir_name}
    create new smb directory    ${subdir_name}
    go to upper smb directory
    ${result_deleting}=     run keyword and return status    delete smb directory    ${dir_name}
    go to smb directory    ${dir_name}
    delete smb directory    ${subdir_name}
    go to upper smb directory
    delete smb directory    ${dir_name}
    close window
    select window    MAIN
    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***