*** Settings ***
Documentation   Verify GUI be able to upload and run script 
Resource    ../../../system_resource.robot

*** Variables ***
${script_filename}    814013_testscript.txt
*** Test Cases ***
814013
    [Documentation]    
    [Tags]    v6.0    chrome   814013    Low     win10,64bit    runable   rest
    login FortiGate
    Go to System
    Go to system_advanced
    ${status}=    run keyword and return status    CHECKBOX SHOULD BE SELECTED    ${SYSTEM_ADVANCED_CONFIG_SCRIPT_CHECKBOX}
    run keyword if    "${status}"=="False"    wait and click    ${SYSTEM_ADVANCED_CONFIG_SCRIPT_LABEL}
    Choose File        ${SYSTEM_ADVANCED_CONFIG_SCRIPT_FILE_LABEL}     ${SYSTEM_CLI_DATA_DIR}${/}${script_filename}
    sleep   3
    go to system_advanced
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_ADVANCED_CONFIG_SCRIPT_HISTORY_ITEM}  ${script_filename}  
    wait and click    ${new_locator}
    wait and click    ${SYSTEM_ADVANCED_CONFIG_SCRIPT_HISTORY_DELETE_BUTTON}
    wait and click    ${SUBMIT_APPLY_BUTTON}
    sleep  2
    go to system_advanced
    sleep  2
    [Teardown]    Case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    write test result to file    ${CURDIR}
