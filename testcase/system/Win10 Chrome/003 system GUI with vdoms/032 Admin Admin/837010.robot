*** Settings ***
Documentation    Verify api-user can be created correctly with only super-admin
Resource    ../../../system_resource.robot

*** Variables ***
${admin_username}    837010
${admin_rest_username}    837010_REST
${admin_profile}    837010_REST
@{vdom}        ${SYSTEM_TEST_VDOM_NAME_1} 
*** Test Cases ***
837010
    [Documentation]    
    [Tags]    v6.0    chrome   837010    Critical    win10,64bit   runable   
    Login FortiGate  
    sleep  2
    Go to system
    go to system_admin_profiles
    Create Admin Profile  ${admin_profile} 
    Go to system
    Go to System_administrators
    Create Administrator  ${admin_username}    123    admin_profile=prof_admin    vdom=${vdom}
    Create API_ADMIN      ${admin_rest_username}    ${admin_profile}   vdom=${vdom}
    logout FortiGate  
    Login FortiGate   username=${admin_username}    password=123  
    sleep  2
    ${status}=   run keyword and return status    Create API_ADMIN   test    ${admin_profile}   vdom=${vdom}
    should be equal    "${status}"    "False"
    [Teardown]   case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate   username=${admin_username}
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file   ${CURDIR}

