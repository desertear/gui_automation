*** Settings ***
Documentation    Verify GUI can change administrator's password
Resource    ../../../system_resource.robot

*** Variables ***
${admin_username}    750622
@{vdom}        ${SYSTEM_TEST_VDOM_NAME_1} 
*** Test Cases ***
750622
    [Documentation]    
    [Tags]    v6.0    chrome   750622    Critical    win10,64bit   runable
    Login FortiGate  
    sleep  2
    Go to system
    go to system_administrators
    Create Administrator   ${admin_username}   123    vdom=${vdom}
    logout FortiGate  
    Login FortiGate   username=${admin_username}    password=123  
    sleep  2
    Go to system
    go to system_administrators
    EDIT ADMINISTRATOR    ${admin_username}
    wait and click        ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_BUTTON}
    sleep   2
    clear element text    ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_OLD}
    input text            ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_OLD}       123
    clear element text    ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_NEW}
    input text            ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_NEW}       456
    clear element text    ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_CONFIRM}
    input text            ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_CONFIRM}   456
    wait and click        ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_OK_BUTTON}
    ${status}=    run keyword and return status    Login FortiGate   username=${admin_username}    password=123  
    should be equal     "${status}"    "False"
    ${status}=    run keyword and return status    Login FortiGate   username=${admin_username}    password=456
    should be equal     "${status}"    "True"
    [Teardown]   case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate   username=${admin_username}  
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}

