*** Settings ***
Documentation      Verify Captive-portal authenticated user can be deleted from GUI
Resource    ../../../system_resource.robot

*** Variables ***
${username}    741879
${password}    123
${test_url}    ${FGT_HTTP_PROTOCOL}://www.google.com
${usergroup}   741879
${policyname}  741879
*** Test Cases ***
741879
    [Tags]    v6.0    chrome   741879    High    win10,64bit    browsers   runable env2fail
    Run Cli commands in File on Terminal Server       ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login FortiGate
    sleep  2
    Go to network
    Go to network_Interfaces
    network edit interface    ${SYSTEM_TEST_INTF_3}
    Set Interface Role To     LAN
    network edit interface    ${SYSTEM_TEST_INTF_3}
    sleep  2
    wait and click   ${NETWORK_INTERFACES_CAPTIVE_MENU}
    wait and click   ${NETWORK_INTERFACES_CAPTIVE_MENU_OP_CAPTIVE}
    sleep   2
    ${status}=   run keyword and return status    Radio Button should be set to    user-access    restrict-access
    run keyword if    "${status}"=="False"        wait and click    ${NETWORK_INTERFACES_CAPTIVE_USERACCESS_RESTRICT_LABEL}
    wait and click   ${NETWORK_INTERFACES_CAPTIVE_USERGROUP_ADD_BUTTON}
    SELECT MENU BAR FROM SELECTION PANE  ${usergroup}
    sleep   1
    wait and click   ${SUBMIT_OK_BUTTON}
    unselect frame
    Go to network_Interfaces
    sleep   2
    Go to VDOM  ${SYSTEM_TEST_VDOM_NAME_1}
    Go to policy and objects
    Go to IPv4 policy
    system create ipv4 policy  ${policyname}  ${SYSTEM_TEST_INTF_2}  ${SYSTEM_TEST_INTF_1}
    sleep  2
    Go to IPv4 policy
    sleep  2
    Logout FortiGate  
    open browser        ${test_url} 
    wait and click      ${NETWORK_INTERFACES_CAPTIVE_PORTALPAGE_USERNAME}      
    clear element text  ${NETWORK_INTERFACES_CAPTIVE_PORTALPAGE_USERNAME}
    input text          ${NETWORK_INTERFACES_CAPTIVE_PORTALPAGE_USERNAME}   ${username} 
    wait and click      ${NETWORK_INTERFACES_CAPTIVE_PORTALPAGE_PASSWORD}  
    clear element text  ${NETWORK_INTERFACES_CAPTIVE_PORTALPAGE_PASSWORD}
    input text          ${NETWORK_INTERFACES_CAPTIVE_PORTALPAGE_PASSWORD}   ${password} 
    wait and click      ${NETWORK_INTERFACES_CAPTIVE_PORTALPAGE_CONTINUE}
    Login FortiGate  
    Go to VDOM  ${SYSTEM_TEST_VDOM_NAME_1}
    Go to Monitor
    go to monitor_firewall_User
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${MONITOR_FIREWALLUSER_USER_ENTRY}    ${username}
    wait and click    ${new_locator}
    wait and click    ${MONITOR_FIREWALLUSER_USER_DEAUTHEN_BUTTON}
    wait and click    ${CONFIRM_OK_BUTTON}
    sleep   1
    ${status}=    run keyword and return status    wait and click    ${new_locator}
    should be equal    "${status}"    "False"
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Close All Browsers
    Run Cli commands in File on Terminal Server       ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
