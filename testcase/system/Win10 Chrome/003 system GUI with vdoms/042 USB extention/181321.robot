*** Settings ***
Documentation  Verify the saving to USB prompt is greyed out if The USB card is not inserted into the FGT
Resource    ../../../system_resource.robot
*** Variables ***
${username}   admin
@{command}    config global    diag hardware deviceinfo disk | grep USB
*** Test Cases ***
181321
    [Tags]    v6.0    chrome   181321    Medium    win10,64bit    runable    novm
    Login FortiGate  
    @{response}=    Execute CLI commands on FortiGate Via Terminal Server     ${command}  
    ${resp}=        SET VARIABLE    @{response}[-1]
    ${status}=      run keyword and return status    Should Contain  ${resp}    type:
    ${locator}=     REPLACE PLACEHOLDER IN LOCATOR WITH VALUE        ${LOGOUT_ICON_BUTTON}    ${username}
    wait and click  ${locator}
    Mouse over      ${ADMIN_CONFIGURATION_BAR}
    wait and click  ${ADMIN_CONFIGURATION_BACKUP_BUTTON}
    sleep   2
    ${usb_disable}=    get element attribute  ${ADMIN_CONFIGURATION_BACKUP_USB_INPUT}    disabled 
    run keyword if    "${status}"=="False"    should be equal    "${usb_disable}"    "true"
    unselect frame
    [Teardown]    case teardown
*** Keywords ***
case teardown    
    Logout FortiGate
    Close All Browsers
    write test result to file    ${CURDIR}

