*** Settings ***
Documentation    Verified edit/delete Multi-VDOM Admin user GUI
Resource    ../../../system_resource.robot

*** Variables ***
${admin_name}   729819
${passwd_old}   123
${passwd_new}   456
@{vdom}     ${SYSTEM_TEST_VDOM_NAME_1}    ${SYSTEM_TEST_VDOM_NAME_2}
*** Test Cases ***
729819
    [Documentation]    
    [Tags]    v6.0    chrome   729819    Critical    win10,64bit   runable
    Login FortiGate  
    Go to system
    go to System_administrators
    Create Administrator    ${admin_name}    password=${passwd_old}     vdom=${vdom}   admin_profile=prof_admin
    EDIT ADMINISTRATOR      ${admin_name}
    Change Admin Password   ${passwd_old}    ${passwd_new} 
    wait and click  ${SUBMIT_OK_SPAN}
    DELETE ADMINISTRATOR    ${admin_name}
    sleep   2
    [Teardown]   case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    write test result to file   ${CURDIR}

