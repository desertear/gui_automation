*** Settings ***
Documentation      To verify virtual domain could be enabled and disabled
Resource    ../../../system_resource.robot

*** Variables ***

*** Test Cases ***
181533
    [Tags]    v6.0    chrome   181533    Critical    win10,64bit    browsers    runable       rest
    ${vm}=    run keyword and return status   should contain    ${FGT_HW_TYPE}   VM
    Run Keyword If     "${vm}"=="True"    Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}factoryreset_vm_cli.txt
    ...   ELSE   Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}factoryreset_cli.txt
    Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}purge_cli.txt
    Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}novdom_setup_cli.txt
    Login FortiGate   
    Go to system
    sleep  2
    Go to system_Settings
    sleep  2
    wait and click    ${SYSTEM_SETTINGS_VDOM_ENABLE_LABEL}
    wait and click    ${SYSTEM_SETTINGS_VDOM_MULTIVDOM_LABEL}
    wait and click    ${SUBMIT_OK_BUTTON}
    Login FortiGate   
    Go to system
    sleep  2
    Go to system_Settings
    sleep  2
    Wait Until Element Is Visible    ${SYSTEM_SETTINGS_VDOM_ENABLE_LABEL}
    ${status}=    run keyword and return status   checkbox should be selected    ${SYSTEM_SETTINGS_VDOM_ENABLE_INPUT}
    should be equal  "${status}"    "True"
    wait and click    ${SYSTEM_SETTINGS_VDOM_ENABLE_LABEL}
    wait and click    ${SUBMIT_OK_BUTTON}
    Login FortiGate   
    Go to system
    sleep  2
    Go to system_Settings
    sleep  2
    Wait Until Element Is Visible    ${SYSTEM_SETTINGS_VDOM_ENABLE_LABEL}
    ${status}=    run keyword and return status   checkbox should be selected    ${SYSTEM_SETTINGS_VDOM_ENABLE_INPUT}
    should be equal    "${status}"    "False"
    
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Close All Browsers
    Run Cli commands in File on Terminal Server    ${SYSTEM_CLI_FILE_DIR}${/}multivdom_setup_cli.txt
    write test result to file    ${CURDIR}
