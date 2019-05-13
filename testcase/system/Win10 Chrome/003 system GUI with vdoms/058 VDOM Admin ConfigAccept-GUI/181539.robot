*** Settings ***
Documentation      To verify that an administrator could be created for each vdom
Resource    ../../../system_resource.robot

*** Variables ***
@{vdom_list_1}    ${SYSTEM_TEST_VDOM_NAME_1}
@{vdom_list_2}    ${SYSTEM_TEST_VDOM_NAME_2}
*** Test Cases ***
181539
##
    [Tags]    v6.0    chrome   181539    high    win10,64bit    browsers    runable   rest
    Login FortiGate   
    Go to system
    sleep  2
    Go to System_administrators
    ${status}=    run keyword and return status   Create Administrator  181539_vdom1  123   admin_profile=prof_admin    vdom=${vdom_list_1}
    should be equal    "${status}"    "True"
    ${status}=    run keyword and return status   Create Administrator  181539_root   123    admin_profile=prof_admin   vdom=${vdom_list_2}
    should be equal    "${status}"    "True"

    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file   ${CURDIR}
