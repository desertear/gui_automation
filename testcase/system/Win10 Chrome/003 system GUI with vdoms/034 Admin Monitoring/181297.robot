*** Settings ***
Documentation    Verify that the admin with super_admin privilege is able to rename or delete any other admins via GUI
Resource    ../../../system_resource.robot

*** Variables ***
${admin_username}    181297
${admin_username_new}    181297_new
@{vdom}        ${SYSTEM_TEST_VDOM_NAME_1} 
*** Test Cases ***
181297
    [Documentation]    
    [Tags]    v6.0    chrome   181297    Critical    win10,64bit   runable 
    Login FortiGate  
    sleep  2
    Go to system
    Go to System_administrators
    Create Administrator   ${admin_username}    123    admin_profile=prof_admin    vdom=${vdom}
    EDIT ADMINISTRATOR  ${admin_username}
    sleep   2
    Change Admin Name To  ${admin_username_new}
    sleep  2
    DELETE ADMINISTRATOR  ${admin_username_new}
    sleep   2
    Reload Page
    ${status}=    run keyword and return status    Wait Until Element Is Visible    ${name_entry}
    should be equal   "${status}"   "False"
    go to dashboard
    [Teardown]   case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate  
    Close All Browsers
    write test result to file    ${CURDIR}

