*** Settings ***
Documentation    Verify api-user can be edited/deleted correctly with only super-admin
Resource    ../../../system_resource.robot

*** Variables ***
${admin_username}    837011
${admin_rest_username}    837011_REST
${old_profile}    admin_no_access
${admin_profile}    837011_REST
@{vdom}        ${SYSTEM_TEST_VDOM_NAME_1} 
@{edit_vdom}        ${SYSTEM_TEST_VDOM_NAME_2}
*** Test Cases ***
837011
    [Documentation]    
    [Tags]    v6.0    chrome   837011    Critical    win10,64bit   runable  test12
    Login FortiGate  
    sleep  2
    Go to system
    go to system_admin_profiles
    Create Admin Profile  ${admin_profile} 
    Go to system
    Go to System_administrators
    Create Administrator  ${admin_username}    123    admin_profile=prof_admin    vdom=${vdom}
    Create API_ADMIN      ${admin_rest_username}    admin_profile=${old_profile}    vdom=${vdom}
    EDIT ADMINISTRATOR    ${admin_rest_username}    REST API
    Change Admin Profile and Vdom    REST   ${admin_profile}    vdom=${edit_vdom}
    Test If Profile and Vdom Changed   REST   ${admin_rest_username}   ${admin_profile}   ${edit_vdom}
    logout FortiGate  

    Login FortiGate   username=${admin_username}    password=123  
    sleep  2
    Go to system
    Go to System_administrators
    SELECT ADMINISTRATOR    ${admin_rest_username}    REST API Administrator
    ${status}=    run keyword and return status    wait and click    ${SYSTEM_ADMINISTRATORS_EDIT}
    should be equal   "${status}"    "False"
    SELECT ADMINISTRATOR    ${admin_rest_username}    REST API Administrator
    ${status}=    run keyword and return status    wait and click    ${SYSTEM_ADMINISTRATORS_DELETE}
    should be equal   "${status}"    "False"
    logout FortiGate   username=${admin_username}
    Login FortiGate  
    Go to system
    Go to System_administrators
    SELECT ADMINISTRATOR    ${admin_rest_username}    REST API Administrator
    Wait and click     ${SYSTEM_ADMINISTRATORS_DELETE}
    Wait and click     ${SYSTEM_ADMINISTRATORS_DELETE_OK_BUTTON}
    sleep   2
    Reload Page
    ${status}=    run keyword and return status    SELECT ADMINISTRATOR    ${admin_rest_username}    REST API Administrator
    should be equal    "${status}"    "False"
    [Teardown]   case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate   
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file   ${CURDIR}

