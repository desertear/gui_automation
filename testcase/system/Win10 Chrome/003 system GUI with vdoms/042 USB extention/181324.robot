*** Settings ***
Documentation  Verify the saving to USB option is greyed out if the USB card is not inserted into the FGT
Resource    ../../../system_resource.robot
*** Variables ***
${username}   admin
@{ssh_cmd_set}      config global   exec usb-disk list
*** Test Cases ***
181324
    [Tags]    v6.0    chrome   181324    Medium    win10,64bit    runable    novm
    @{responses_ssh}=     Execute CLI commands on FortiGate Via Terminal Server   ${ssh_cmd_set}    
    ${response}=    set variable        @{responses_ssh}[-1]
    ${no_usbdisk}=    run keyword and return status    should match regexp   ${response}   unable to mount usb disk
    Login FortiGate  
    ${locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${LOGOUT_ICON_BUTTON}    ${username}
    wait and click     ${locator}
    Mouse over         ${ADMIN_CONFIGURATION_BAR}
    wait and click     ${ADMIN_CONFIGURATION_BACKUP_BUTTON}
    sleep   2
    wait until element is Visible    ${ADMIN_CONFIGURATION_BACKUP_USB_LABEL}
    ${status}=    get element attribute    ${ADMIN_CONFIGURATION_BACKUP_USB_INPUT}    disabled
    run keyword if    "${no_usbdisk}"=="True"    should be equal  "${status}"    "true"
    unselect frame
    [Teardown]    case teardown
*** Keywords ***
case teardown    
    Logout FortiGate
    Close All Browsers
    write test result to file    ${CURDIR}
