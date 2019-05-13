*** Settings ***
Documentation  Failcase! bug #529347 
...            cannot access USB disk after delete a file on it.  
...            Verify super admin user can backup/restore Full/vdom configuration file via GUI
Resource    ../../../system_resource.robot
*** Variables ***
${username}   admin
${filename_global}    globalbackup
${filename_vdom}      vdombackup
@{cmd_list_1}     config global   exec usb-disk list
@{cmd_list_2}     config global   exec usb-disk delete ${filename_global}.conf
@{cmd_list_3}     config global   exec usb-disk delete ${filename_vdom}.conf
${backup_vdom}    ${SYSTEM_TEST_VDOM_NAME_1}

*** Test Cases ***
710338
    [Tags]     Failcase!Bug#529347    v6.0    chrome   710338    High    win10,64bit    runable   novm   env2fail
    Login FortiGate      browser=chrome
    ${locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${LOGOUT_ICON_BUTTON}    ${username}
    wait and click     ${locator}
    Mouse over         ${ADMIN_CONFIGURATION_BAR}
    wait and click     ${ADMIN_CONFIGURATION_BACKUP_BUTTON}
    sleep   2
    ${backup_scope}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${ADMIN_CONFIGURATION_BACKUP_LABEL}   Global
    wait and click     ${backup_scope}
    ${status}=    run keyword and return status    Radio Button should be set to    backup-to    backup-local-pc
    run keyword if    "${status}"=="False"     select radio button     backup-to    backup-local-pc
    wait and click     ${SUBMIT_OK_BUTTON}
    sleep  30
    ${year}=    Get time   year    NOW
    ${month}=   Get time   month   NOW
    ${day}=     Get time   day     NOW
    ${hour}=    Get time   hour    NOW
    ${date}=    set Variable    ${year}${month}${day}
    ${file_name}=     Set Variable    ${SYSTEM_FILE_DOWNLOAD_DIR_PATH}${/}${FGT_HOSTNAME}_${date}_${hour}??.conf
    Should Exist      ${file_name}
    Remove file       ${file_name}
    
    ${status}=    run keyword and return status    Radio Button should be set to    config-type    config-vdom
    ${backup_scope}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${ADMIN_CONFIGURATION_BACKUP_LABEL}   VDOM
    run keyword if    "${status}"=="False"      wait and click    ${backup_scope}
    ${status}=    run keyword and return status    Radio Button should be set to    backup-to    backup-local-pc
    run keyword if     "${status}"=="False"     select radio button     backup-to    backup-local-pc
    SELECT MEBU BAR FROM DROPDOWN MENU      ${backup_vdom}
    wait and click    ${SUBMIT_OK_BUTTON}
    sleep  30
    ${year}=    Get time   year    NOW
    ${month}=   Get time   month   NOW
    ${day}=     Get time   day     NOW
    ${hour}=    Get time   hour    NOW
    ${date}=    set Variable    ${year}${month}${day}
    ${file_name}=     Set Variable    ${SYSTEM_FILE_DOWNLOAD_DIR_PATH}${/}${FGT_HOSTNAME}_${date}_${hour}??.conf
    Should Exist      ${file_name}
    Remove file       ${file_name}
    
    ${usb_disable}=    get element attribute      ${ADMIN_CONFIGURATION_BACKUP_USB_INPUT}    disabled 
    ${status}=   run keyword and return status    should be equal    "${usb_disable}"    "true"
    run keyword if   "${status}"=="False"    BACKUP TO USB DISK   ${cmd_list_1}   ${cmd_list_2}   ${cmd_list_3}   ${filename_global}    ${filename_vdom}
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Close All Browsers
    write test result to file    ${CURDIR}

BACKUP TO USB DISK
    [Arguments]    ${cmd_list_1}     ${cmd_list_2}     ${cmd_list_3}   ${test_tegx_1}   ${test_tegx_2}  
    ${backup_scope}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${ADMIN_CONFIGURATION_BACKUP_LABEL}   Global
    wait and click      ${backup_scope}
    ${status}=          run keyword and return status    Radio Button should be set to    backup-to    backup-usb-disk
    run keyword if     "${status}"=="False"     wait and click    ${ADMIN_CONFIGURATION_BACKUP_USB_LABEL}
    wait and click      ${ADMIN_CONFIGURATION_BACKUP_USB_FILENAME}
    clear element text  ${ADMIN_CONFIGURATION_BACKUP_USB_FILENAME}
    input text          ${ADMIN_CONFIGURATION_BACKUP_USB_FILENAME}    ${filename_global}.conf
    wait and click      ${SUBMIT_OK_BUTTON}
    sleep  30
    TEST FROM CLI AND CHECK REGXP    ${cmd_list_1}   ${test_tegx_1}
    TEST FROM CLI AND CHECK REGXP    ${cmd_list_2}
    
    ${status}=          run keyword and return status    Radio Button should be set to    config-type    config-vdom
    ${backup_scope}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${ADMIN_CONFIGURATION_BACKUP_LABEL}   VDOM
    run keyword if     "${status}"=="False"      wait and click    ${backup_scope}
    ${status}=          run keyword and return status    Radio Button should be set to    backup-to    backup-usb-disk
    run keyword if     "${status}"=="False"     wait and click    ${ADMIN_CONFIGURATION_BACKUP_USB_LABEL}
    SELECT MEBU BAR FROM DROPDOWN MENU      ${SYSTEM_TEST_VDOM_NAME_1}
    wait and click      ${ADMIN_CONFIGURATION_BACKUP_USB_FILENAME}
    clear element text  ${ADMIN_CONFIGURATION_BACKUP_USB_FILENAME}
    input text          ${ADMIN_CONFIGURATION_BACKUP_USB_FILENAME}    ${filename_vdom}.conf
    wait and click      ${SUBMIT_OK_BUTTON}
    sleep  30
    TEST FROM CLI AND CHECK REGXP    ${cmd_list_1}   ${test_tegx_2}
    TEST FROM CLI AND CHECK REGXP    ${cmd_list_3}
    unselect frame