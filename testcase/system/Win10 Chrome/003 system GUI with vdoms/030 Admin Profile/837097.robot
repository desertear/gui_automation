*** Settings ***
Documentation    Verify Override Idle Timeout can work properly on GUI
...              BUG#479482
Resource    ../../../system_resource.robot

*** Variables ***
@{vdom}        ${SYSTEM_TEST_VDOM_NAME_1}   

*** Test Cases ***
837097
    [Documentation]    
    [Tags]    v6.0    chrome   837097    Critical    win10,64bit    runable    test06
    login FortiGate
    Go to Global
    Go to system
    go to system_admin_profiles
    Create Admin Profile    837097           time_out=1
    go to system_administrators
    Create Administrator    837097     123   admin_profile=837097      vdom=${vdom}
    go to system_admin_profiles
    Create Admin Profile    837097_n         time_out=never
    go to system_administrators
    Create Administrator    837097_n   123   admin_profile=837097_n    vdom=${vdom}
    Logout FortiGate  
    Close All Browsers
    Login FortiGate       username=837097    password=123
    sleep   70
    Wait Until Element Is Visible    ${SYSTEM_LOGIN_TIMEOUT_WAN_MSG}
    Close All Browsers
    Login FortiGate       username=837097_n  password=123  
    sleep   70
    logout FortiGate   username=837097_n
    [Teardown]   case Teardown
*** Keywords ***
case Teardown
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}

   

