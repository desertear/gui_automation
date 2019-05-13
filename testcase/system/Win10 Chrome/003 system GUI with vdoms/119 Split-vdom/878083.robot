*** Settings ***
Documentation    Verify GUI can enable split-vdom mode and switch between non-vdom/multi-vdom mode
Resource    ../../../system_resource.robot

*** Variables ***

*** Test Cases ***
878083
    [Tags]    v6.0    chrome   878083    Critical    win10,64bit    browsers    runable      rest
    ${vm}=    run keyword and return status   should contain    ${FGT_HW_TYPE}   VM
    Run Keyword If     "${vm}"=="True"    Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}factoryreset_vm_cli.txt
    ...   ELSE   Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}factoryreset_cli.txt
    Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}purge_cli.txt
    Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}novdom_setup_cli.txt
    ### login fortigate and enable split-vdom ####
    Login FortiGate   
    Go to system
    sleep  2
    Go to system_Settings
    sleep  2
    wait and click    ${SYSTEM_SETTINGS_VDOM_ENABLE_LABEL}
    wait and click    ${SYSTEM_SETTINGS_VDOM_SPLITVDOM_LABEL}
    wait and click    ${SUBMIT_OK_BUTTON}
    ## login fortigate and disable vdom ###
    Login FortiGate   
    Go to system
    sleep  2
    Go to system_Settings
    sleep  2
    Wait Until Element Is Visible    ${SYSTEM_SETTINGS_VDOM_ENABLE_LABEL}
    ${status}=    run keyword and return status   checkbox should be selected    ${SYSTEM_SETTINGS_VDOM_ENABLE_INPUT}
    should be equal    "${status}"    "True"
    wait and click    ${SYSTEM_SETTINGS_VDOM_ENABLE_LABEL}
    wait and click    ${SUBMIT_OK_BUTTON}
    ### enable multi-vdom ####
    Login FortiGate   
    Go to system
    sleep  2
    Go to system_Settings
    sleep  2
    Wait Until Element Is Visible    ${SYSTEM_SETTINGS_VDOM_ENABLE_LABEL}
    ${status}=    run keyword and return status   checkbox should be selected    ${SYSTEM_SETTINGS_VDOM_ENABLE_INPUT}
    should be equal    "${status}"    "False"
    wait and click    ${SYSTEM_SETTINGS_VDOM_ENABLE_LABEL}
    wait and click    ${SYSTEM_SETTINGS_VDOM_MULTIVDOM_LABEL}
    wait and click    ${SUBMIT_OK_BUTTON}
    ##   double check multi-vodm is enabled
    Login FortiGate   
    Go to system
    sleep  2
    Go to system_Settings
    sleep  2
    Wait Until Element Is Visible    ${SYSTEM_SETTINGS_VDOM_ENABLE_LABEL}
    ${status}=    run keyword and return status   checkbox should be selected    ${SYSTEM_SETTINGS_VDOM_ENABLE_INPUT}
    should be equal    "${status}"    "True"
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Close All Browsers
    Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}multivdom_setup_cli.txt
    write test result to file    ${CURDIR}

    
