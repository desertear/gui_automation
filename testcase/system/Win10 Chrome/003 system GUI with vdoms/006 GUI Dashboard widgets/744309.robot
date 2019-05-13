*** Settings ***
Documentation    System resources widget (or admin->system drop down list), Verify reboot and shutdown buttons work fine.
Resource    ../../../system_resource.robot

*** Variables ***
${username}   admin
${admin_system_bar}    xpath://f-header-admin-menu//span[text()="System"]
${admin_system_bar_reboot_button}    xpath://span[text()="Reboot"]
${admin_system_bar_reboot_ok_button}    xpath://button[@id="submit_ok"]
*** Test Cases ***
744309
## verify reboot and shutdown buttons work fine in GUI ##
    [Tags]    v6.0    chrome   744309    High    win10,64bit    browsers    norun
    Login FortiGate  
    ${locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${LOGOUT_ICON_BUTTON}    ${username}
    wait and click    ${locator}
    Mouse over        ${admin_system_bar}
    wait and click    ${admin_system_bar_reboot_button}    
    wait and click    ${admin_system_bar_reboot_ok_button}
    sleep   180
    Close All Browsers
    Login FortiGate  
    go to dashboard
    go to dashboard_main
    ${reboot_uptime}=   Get text    ${system_info_widget_uptime}
    Should start with   ${reboot_uptime}    00:00:0
    sleep   10
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Close All Browsers
    write test result to file    ${CURDIR}
