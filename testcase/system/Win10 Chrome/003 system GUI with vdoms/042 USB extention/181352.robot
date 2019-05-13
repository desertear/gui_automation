*** Settings ***
Documentation  Verify that the FGT backs up and restore the encrypted system configuration to usb key via GUI NAT/TP
Resource    ../../../system_resource.robot
*** Variables ***
${filename_nat}    181352_nat.conf
${filename_tp}     181352_tp.conf
${passwd}    123
*** Test Cases ***
181352
    [Tags]    v6.0    chrome   181352    High    win10,64bit    runable   novm  
    [Setup]    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login FortiGate  
    BACKUP CONFIGURATION   username=admin  backup_scope=VDOM     backup_vdom=${SYSTEM_TEST_VDOM_NAME_1}     backup_disk=usb   file_name=${filename_nat}    encrypt_passwd=${passwd}
    sleep  20
    RESTORE CONFIGURATION  username=admin  restore_scope=VDOM    restore_vdom=${SYSTEM_TEST_VDOM_NAME_1}    restore_disk=usb  file_name=${filename_nat}   encrypt_passwd=${passwd}
    sleep  20
    BACKUP CONFIGURATION   username=admin  backup_scope=VDOM     backup_vdom=${SYSTEM_TEST_VDOM_NAME_tp}    backup_disk=usb   file_name=${filename_tp}    encrypt_passwd=${passwd}
    sleep  20
    RESTORE CONFIGURATION  username=admin  restore_scope=VDOM    restore_vdom=${SYSTEM_TEST_VDOM_NAME_tp}   restore_disk=usb  file_name=${filename_tp}   encrypt_passwd=${passwd}
    sleep  20
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    Close All Browsers
    write test result to file    ${CURDIR}

