*** Settings ***
Documentation    Verify Multi-VDOM Admin user can switch vdom GUI
Resource    ../../../system_resource.robot

*** Variables ***
${admin_name}   729821
${passwd}   123
@{vdom}     ${SYSTEM_TEST_VDOM_NAME_1}    ${SYSTEM_TEST_VDOM_NAME_2}
*** Test Cases ***
729821
    [Documentation]    
    [Tags]    v6.0    chrome   729821    Critical    win10,64bit   runable
    Login FortiGate  
    Go to system
    go to System_administrators
    Create Administrator    username=${admin_name}    password=${passwd}     vdom=${vdom}   admin_profile=prof_admin
    Logout FortiGate  
    Login FortiGate  username=${admin_name}    password=${passwd}
    GO TO VDOM   ${SYSTEM_TEST_VDOM_NAME_2}   ${SYSTEM_TEST_VDOM_NAME_1}
    GO TO VDOM   ${SYSTEM_TEST_VDOM_NAME_1}   ${SYSTEM_TEST_VDOM_NAME_2}
    sleep   2
    [Teardown]   case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate    username=${admin_name}
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file   ${CURDIR}