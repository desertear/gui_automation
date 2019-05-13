*** Settings ***
Documentation    Verify that the rename button correctly renames the directory
...   Action:
...    1. login web portal, connect to samba sever.
...    2. choose a directory and click on rename icon and input a new directory name
...   Expect:
...   the directory has been changed successfully
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${original_dir_name}    test_directory
${target_dir_name}    test_directory_updated
${smb_host}    ${SSLVPN_SMB_HOST}
${smb_username}    ${SSLVPN_SMB_USERNAME}
${smb_password}    ${SSLVPN_SMB_PASSWORD}
*** Test Cases ***
877270
    [Tags]    v6.0    firefox    chrome    edge    safari    877270    medium    win10,64bit
    Login SSLVPN Portal
    connect to smb    ${smb_host}    username=${smb_username}    password=${smb_password}
    go to smb upper most directory    ${SSLVPN_SMB_MOST_UPPER_DIR}
    go to smb directory    ${SSLVPN_SMB_TEST_DIR}
    create new smb directory    ${original_dir_name}
    rename smb directory    ${original_dir_name}    ${target_dir_name}
    delete smb directory    ${target_dir_name}
    close window
    select window    MAIN
    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***