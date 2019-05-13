*** Settings ***
Documentation      Verify embedded console can be connected and working with a vdom admin
Resource    ../../../system_resource.robot

*** Variables ***
${admin_name}     590374
@{cmd_list}       config global    get system status
${test_tegx_1}    build
${test_tegx_2}    BIOS
${test_tegx_3}    System time
*** Test Cases ***
590374
    [Tags]    v6.0    chrome   590374    High    win10,64bit    browsers    runable   rest
    [Setup]   Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    ${vm}=    run keyword and return status   should contain    ${FGT_HW_TYPE}   VM
    Login FortiGate  username=${admin_name}  password=123
    sleep   3
    popup embed console
    go to embed console
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${system_embeded_console_connected}    ${FGT_HOSTNAME}
    Wait Until Element Is Visible     ${new_locator}
    sleep  2
    TEST FROM CLI AND CHECK REGXP    ${cmd_list}   ${test_tegx_1}
    Run Keyword If     "${vm}"=="False"    TEST FROM CLI AND CHECK REGXP    ${cmd_list}   ${test_tegx_2}
    TEST FROM CLI AND CHECK REGXP    ${cmd_list}   ${test_tegx_3}
    sleep   2
    Unselect Frame
        
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate  username=${admin_name}
    Run Cli commands in File on Terminal Server    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    Close All Browsers
    write test result to file    ${CURDIR}
