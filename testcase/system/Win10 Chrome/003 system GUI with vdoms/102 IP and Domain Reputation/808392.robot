*** Settings ***
Documentation   Verify function works when vdom is enabled or disabled and search is per vdom
Resource    ../../../system_resource.robot

*** Variables ***
${ip_domain_list}    8.8.8.8
*** Test Cases ***
808392
    [Documentation]    
    [Tags]    v6.0    chrome   808392    High     win10,64bit   runable    env2fail
    ${vm}=    run keyword and return status   should contain    ${FGT_HW_TYPE}   VM
    Run Keyword If     "${vm}"=="True"    Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}factoryreset_vm_cli.txt
    ...   ELSE   Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}factoryreset_cli.txt
    Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}purge_cli.txt
    Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}novdom_setup_cli.txt
    login FortiGate
    Go to system
    go to system_feature visibility
    Enable_FGT_Feature_Additional   Reputation
    sleep   2
    Go to system_reputation
    wait and click    ${SYSTEM_REPUTATION_IP_DOMAIN_INPUT} 
    clear element text   ${SYSTEM_REPUTATION_IP_DOMAIN_INPUT} 
    input text    ${SYSTEM_REPUTATION_IP_DOMAIN_INPUT}     ${ip_domain_list}
    sleep   1
    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_REPUTATION_URL_LIST}    Google-Web
    Wait Until Element Is Visible     ${new_locator}
    Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}multivdom_setup_cli.txt
    login FortiGate
    go to vdom    ${SYSTEM_TEST_VDOM_NAME_2}
    Go to system
    Go to system_reputation
    wait and click    ${SYSTEM_REPUTATION_IP_DOMAIN_INPUT} 
    clear element text   ${SYSTEM_REPUTATION_IP_DOMAIN_INPUT} 
    input text    ${SYSTEM_REPUTATION_IP_DOMAIN_INPUT}     ${ip_domain_list}
    sleep   1
    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_REPUTATION_URL_LIST}    Google-Web
    Wait Until Element Is Visible     ${new_locator}

    go to vdom    ${SYSTEM_TEST_VDOM_NAME_1}    ${SYSTEM_TEST_VDOM_NAME_2}
    Go to system
    sleep   2
    ${status}=    run keyword and return status    Go to system_reputation
    should be equal     "${status}"    "False"
    [Teardown]    Case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}multivdom_setup_cli.txt
    Close All Browsers
    write test result to file    ${CURDIR}
