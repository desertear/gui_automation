*** Settings ***
Documentation    Verified Multi-VDOM Admin user login default VDOM be the one that the connecting interface belongs to,GUI
Resource    ../../../system_resource.robot

*** Variables ***
${admin_name}   729824
${passwd}   123
@{vdom}     ${SYSTEM_TEST_VDOM_NAME_1}    ${SYSTEM_TEST_VDOM_NAME_2}
*** Test Cases ***
729824
    [Documentation]    
    [Tags]    v6.0    chrome   729824    High    win10,64bit   runable
    Login FortiGate  
    Go to system
    go to System_administrators
    Create Administrator    username=${admin_name}    password=${passwd}     vdom=${vdom}   admin_profile=prof_admin
    Logout FortiGate  
    Login FortiGate         username=${admin_name}     password=${passwd}
    sleep  2
    Wait Until Element Is Visible   ${SYSTEM_VDOMMENU_DROP_DOWN_MENU_BAR_DEFAULT}
    ${text}=   get text             ${SYSTEM_VDOMMENU_DROP_DOWN_MENU_BAR_DEFAULT}
    should be equal    "${text}"   "${SYSTEM_TEST_VDOM_NAME_1}"
    [Teardown]   case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate    username=${admin_name}
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file   ${CURDIR}

