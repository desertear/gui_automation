*** Settings ***
Documentation  Verify the restore configuration file from  USB, options will not given if The USB card does not contain a confg file
Resource    ../../../system_resource.robot
*** Variables ***
${username}   admin
${restore_scope}    VDOM
${restore_vdom}     ${SYSTEM_TEST_VDOM_NAME_1}
${ADMIN_CONFIGURATION_RESTORE_FILE_MENU_BAR_OPT2}    /option[2]
*** Test Cases ***
181322
    [Tags]    v6.0    chrome   181322    Medium    win10,64bit    runable    novm
    [Setup]   Run Cli commands in File   ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login FortiGate  
    ${locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${LOGOUT_ICON_BUTTON}    ${username}
    wait and click     ${locator}
    Mouse over         ${ADMIN_CONFIGURATION_BAR}
    wait and click     ${ADMIN_CONFIGURATION_RESTORE_BUTTON}
    sleep   2
    ${restore_scope_button}=  REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${ADMIN_CONFIGURATION_RESTORE_LABEL}     ${restore_scope}
    ${restore_label_usb}=     REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${ADMIN_CONFIGURATION_RESTORE_LABEL}    USB Disk
    wait and click    ${restore_scope_button}
    run keyword if   "${restore_scope}"=="VDOM"    SELECT MEBU BAR FROM DROPDOWN MENU      ${restore_vdom} 
    Wait and click    ${restore_label_usb}
    ## the file selection menu should contains no item ##
    ${menu-bar}=      CATENATE     SEPARATOR=     ${ADMIN_CONFIGURATION_RESTORE_FILE_MENU}    ${ADMIN_CONFIGURATION_RESTORE_FILE_MENU_BAR_OPT2}
    wait and click    ${ADMIN_CONFIGURATION_RESTORE_FILE_MENU}
    ${status}=    run keyword and return status    wait and click    ${menu-bar}
    should be equal  "${status}"    "False"
    unselect frame
    [Teardown]    case teardown
*** Keywords ***
case teardown    
    Logout FortiGate
    Close All Browsers
    write test result to file    ${CURDIR}

