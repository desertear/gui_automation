*** Settings ***
Documentation  Verify that the FGT backs up and restore the system configuration to usb key via GUI NAT/TP and gui works fine
Resource    ../../../system_resource.robot
*** Variables ***
${filename_nat}    181350_nat.conf
${filename_tp}     181350_tp.conf
*** Test Cases ***
181350
    [Tags]    v6.0    chrome   181350    Critical    win10,64bit    runable    novm
    [Setup]   Run Cli commands in File   ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login FortiGate  
    BACKUP CONFIGURATION   username=admin  backup_scope=VDOM     backup_vdom=${SYSTEM_TEST_VDOM_NAME_1}     backup_disk=usb   file_name=${filename_nat}
    sleep  20
    RESTORE CONFIGURATION  username=admin  restore_scope=VDOM    restore_vdom=${SYSTEM_TEST_VDOM_NAME_1}    restore_disk=usb  file_name=${filename_nat}
    sleep  20 
    BACKUP CONFIGURATION   username=admin  backup_scope=VDOM     backup_vdom=${SYSTEM_TEST_VDOM_NAME_tp}    backup_disk=usb   file_name=${filename_tp}
    sleep  20
    RESTORE CONFIGURATION  username=admin  restore_scope=VDOM    restore_vdom=${SYSTEM_TEST_VDOM_NAME_tp}   restore_disk=usb  file_name=${filename_tp}
    sleep  20
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    Close All Browsers
    write test result to file    ${CURDIR}

