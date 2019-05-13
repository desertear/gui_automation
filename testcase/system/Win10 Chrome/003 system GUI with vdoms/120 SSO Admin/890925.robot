*** Settings ***
Documentation    Verify vdom admin can create sso-admin from GUI (0547935)
Resource    ../../../system_resource.robot

*** Variables ***
${admin_name}   890925
${passwd}   123
@{vdom}     ${SYSTEM_TEST_VDOM_NAME_1}    ${SYSTEM_TEST_VDOM_NAME_2}
${sso_admin_name}   890925_SSO
*** Test Cases ***
890825
    [Documentation]    
    [Tags]    v6.0    chrome   890825    Medium    win10,64bit   runable
    Login FortiGate  
    Go to system
    go to System_administrators
    Create Administrator    ${admin_name}    password=${passwd}     vdom=${vdom}   admin_profile=prof_admin
    Logout FortiGate  
    Login FortiGate  username=${admin_name}  password=${passwd}
    Create SSO_ADMIN  username=${sso_admin_name}  admin_profile=prof_admin  vdom=${vdom}
    sleep   2
    [Teardown]   case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt