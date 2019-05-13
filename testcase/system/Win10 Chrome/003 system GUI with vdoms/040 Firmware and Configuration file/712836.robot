*** Settings ***
Documentation    Verify read-only user can't backup configure file via GUI
Resource    ../../../system_resource.robot

*** Variables ***
${username}    712836
${password}    123
@{vdom}        ${SYSTEM_TEST_VDOM_NAME_1} 
*** Test Cases ***
712836
    [Tags]    v6.0    chrome   712836    High    win10,64bit    runable
    Login FortiGate  
    ####   create a read-only profile first and create a read-only admin user  ###
    Go to system
    go to system_admin_profiles
    Create Admin Profile  ${username} 
    Go to system
    Go to System_administrators
    Create Administrator  ${username}   ${password}   admin_profile=${username}   vdom=${vdom}
    sleep  2
    logout FortiGate
    Close All Browsers
    ##  login with the read-only user and check the backup menu bar, the bar should not exist ##
    Login FortiGate    username=${username}   password=${password}
    sleep  2
    ${locator}=     REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${LOGOUT_ICON_BUTTON}    ${username}
    wait and click  ${locator}
    ${status}=      run keyword and return status    wait until Element Is Visible    ${ADMIN_CONFIGURATION_BAR}
    should be equal  "${status}"    "False"
    wait and click    ${locator}
    sleep   2
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate  username=${username}
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
