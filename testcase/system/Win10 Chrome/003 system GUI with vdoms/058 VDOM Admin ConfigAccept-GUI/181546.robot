*** Settings ***
Documentation      To verify that after a vdom is disabled, all logged-in vdom admin are kicked out
Resource    ../../../system_resource.robot

*** Variables ***
${test_admin}   181546
${test_psswd}   123
@{vdom}        ${SYSTEM_TEST_VDOM_NAME_2}
@{cmd_list}     config global   get system admin list
${test_tegx}    ${test_admin}
*** Test Cases ***
181546
    [Tags]    v6.0    chrome   181546    high    win10,64bit    browsers    runable      rest
    [setup]   Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login FortiGate     
    Go to system
    Go to System_administrators
    Create Administrator  ${test_admin}    ${test_psswd}    admin_profile=prof_admin   vdom=${vdom}
    Logout FortiGate  
    Login FortiGate  username=${test_admin}  password=${test_psswd}
    login FortiGate  
    sleep  2
    go to system
    go to system_VDOM
    select frame       ${NETWORK_FRAME}
    SET VDOM DISABLE   ${SYSTEM_TEST_VDOM_NAME_2}
    unselect frame
    ${status}=    run keyword and return status    TEST FROM CLI AND CHECK REGXP    ${cmd_list}   ${test_tegx}
    should be equal    "${status}"    "False"
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Close All Browsers
    Run Cli commands in File on Terminal Server    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}

