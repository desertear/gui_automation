*** Settings ***
Documentation  Verify that the FGT backs up and restore the system configuration to local disk via GUI NAT/TP
Resource    ../../../system_resource.robot
*** Variables ***

*** Test Cases ***
181351
    [Tags]    v6.0    chrome   181351    Critical    win10,64bit    runable    
    Login FortiGate   browser=chrome  
    ${file_name_nat}=    BACKUP CONFIGURATION   username=admin  backup_scope=VDOM     backup_vdom=${SYSTEM_TEST_VDOM_NAME_1}     backup_disk=pc   
    COPY FILE    ${SYSTEM_FILE_DOWNLOAD_DIR_PATH}${/}${file_name_nat}    ${SYSTEM_FILE_DOWNLOAD_DIR_PATH}${/}${FGT_HOSTNAME}_nat_backup.conf
    sleep  20
    RESTORE CONFIGURATION  username=admin  restore_scope=VDOM    restore_vdom=${SYSTEM_TEST_VDOM_NAME_1}    restore_disk=pc  file_name=${FGT_HOSTNAME}_nat_backup.conf
    sleep  20 
    REMOVE FILE    ${SYSTEM_FILE_DOWNLOAD_DIR_PATH}${/}${file_name_nat}
    REMOVE FILE    ${SYSTEM_FILE_DOWNLOAD_DIR_PATH}${/}${FGT_HOSTNAME}_nat_backup.conf
    sleep  2
    ${file_name_tp}=    BACKUP CONFIGURATION   username=admin  backup_scope=VDOM     backup_vdom=${SYSTEM_TEST_VDOM_NAME_tp}    backup_disk=pc   
    COPY FILE    ${SYSTEM_FILE_DOWNLOAD_DIR_PATH}${/}${file_name_tp}    ${SYSTEM_FILE_DOWNLOAD_DIR_PATH}${/}${FGT_HOSTNAME}_tp_backup.conf
    sleep  20
    RESTORE CONFIGURATION  username=admin  restore_scope=VDOM    restore_vdom=${SYSTEM_TEST_VDOM_NAME_tp}   restore_disk=pc  file_name=${FGT_HOSTNAME}_tp_backup.conf
    sleep  20
    REMOVE FILE  ${SYSTEM_FILE_DOWNLOAD_DIR_PATH}${/}${file_name_tp}
    REMOVE FILE  ${SYSTEM_FILE_DOWNLOAD_DIR_PATH}${/}${FGT_HOSTNAME}_tp_backup.conf
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Close All Browsers
    write test result to file   ${CURDIR}

