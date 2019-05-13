*** Settings ***
Documentation    Verified create Multi-VDOM Admin user GUI
Resource    ../../../system_resource.robot

*** Variables ***
${admin_name}   729817
@{vdom}     ${SYSTEM_TEST_VDOM_NAME_1}    ${SYSTEM_TEST_VDOM_NAME_2}
*** Test Cases ***
729817
    [Documentation]    
    [Tags]    v6.0    chrome   729817    Critical    win10,64bit   runable
    Login FortiGate  
    Go to system
    go to System_administrators
    Create Administrator    ${admin_name}    password=123     vdom=${vdom}   admin_profile=prof_admin
    EDIT ADMINISTRATOR      ${admin_name}
    wait and click  ${SUBMIT_OK_SPAN}
    [Teardown]   case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file   ${CURDIR}

