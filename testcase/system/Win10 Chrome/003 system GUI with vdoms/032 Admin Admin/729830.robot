*** Settings ***
Documentation    Verified Multi-VDOM Admin user works with Trusted hosts GUI
Resource    ../../../system_resource.robot

*** Variables ***
${username}     729830
${passwd}       123
${column_id}    trusthostsIpv4
@{vdom}         ${SYSTEM_TEST_VDOM_NAME_1}   ${SYSTEM_TEST_VDOM_NAME_2}
${trust_host}   ${PC11_VLAN20_IPV4}/32
*** Test Cases ***
729830
    [Documentation]    
    [Tags]    v6.0    chrome   729830    High    win10,64bit   runable
    Login FortiGate  
    sleep  2
    Go to system
    go to System_administrators
    Create Administrator   username=${username}   password=${passwd}   vdom=${vdom}   admin_profile=prof_admin
    EDIT ADMINISTRATOR     ${username}
    ${status}=          Run Keyword and Return Status    Checkbox Should Be Selected    ${system_administrators_edit_admin_trust host_input}
    run keyword if     "${status}"=="False"    wait and click    ${system_administrators_edit_admin_trust host_label} 
    ${host_input}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_TRUST HOST_IPV4}   1
    wait and click      ${host_input}
    clear element text  ${host_input}
    input text          ${host_input}    ${trust_host}
    wait and click      ${system_administrators_edit_admin_OK_button}
    go to System_administrators
    Logout FortiGate  
    Login FortiGate    username=${username}   password=${passwd} 
    GO TO VDOM   ${SYSTEM_TEST_VDOM_NAME_2}   ${SYSTEM_TEST_VDOM_NAME_1}
    GO TO VDOM   ${SYSTEM_TEST_VDOM_NAME_1}   ${SYSTEM_TEST_VDOM_NAME_2}
    Logout FortiGate    username=${username}
    Login FortiGate  
    sleep  2
    Go to system
    go to System_administrators
    EDIT ADMINISTRATOR    ${username}
    ${status}=          Run Keyword and Return Status    Checkbox Should Be Selected    ${system_administrators_edit_admin_trust host_input}
    run keyword if     "${status}"=="False"    wait and click    ${system_administrators_edit_admin_trust host_label} 
    ${host_input}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_TRUST HOST_IPV4}   1
    wait and click      ${host_input}
    clear element text  ${host_input}
    input text          ${host_input}    1.1.1.1/32
    wait and click      ${system_administrators_edit_admin_OK_button}
    go to System_administrators
    Logout FortiGate  
    ${status}=   run keyword and return status   Login FortiGate    username=${username}   password=${passwd}
    should be equal    "${status}"    "False"
    [Teardown]   case Teardown
*** Keywords ***
case Teardown
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file   ${CURDIR}

