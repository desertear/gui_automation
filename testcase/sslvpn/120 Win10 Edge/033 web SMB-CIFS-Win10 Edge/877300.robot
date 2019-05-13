*** Settings ***
Documentation    Verify that the 'make directory' button creates a new directory
...   Action:
...    1. login web portal, connect to samba sever.
...    2. click on new directory icon
...   Expect:
...   the new directory has been created successfully
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${dir_name}    test_directory
${smb_host}    ${SSLVPN_SMB_HOST}
${smb_username}    ${SSLVPN_SMB_USERNAME}
${smb_password}    ${SSLVPN_SMB_PASSWORD}
*** Test Cases ***
877300
    [Tags]    v6.0    firefox    chrome    edge    safari    877300    medium    win10,64bit
    Login SSLVPN Portal
    connect to smb    ${smb_host}    username=${smb_username}    password=${smb_password}
    go to smb upper most directory    ${SSLVPN_SMB_MOST_UPPER_DIR}
    go to smb directory    ${SSLVPN_SMB_TEST_DIR}
    create new smb directory    ${dir_name}
    delete smb directory    ${dir_name}
    close window
    select window    MAIN
    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***