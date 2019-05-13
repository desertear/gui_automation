*** Settings ***
Documentation   Verify GUI can start/delete/download scripts result on System->Advanced page after config auto-scripts by cli 
Resource    ../../../system_resource.robot

*** Variables ***
@{com_list}    Run Schedul    Clear    Run Schedul     Download
${test_file_name}   872906.out
*** Test Cases ***
872906
    [Documentation]    
    [Tags]    v6.0    chrome   872906    High    win10,64bit    runable   rest
    [Setup]   Run Cli commands in File   ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    login FortiGate    browser=chrome
    Go to System
    Go to system_advanced
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_ADVANCED_SCHEDULED_SCRIPT_ITEM}   872906
    :FOR   ${element}   IN   @{com_list}
         \   wait and click    ${new_locator}
         \   ${button_xpath}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_ADVANCED_SCHEDULED_SCRIPT_ITEM_STATUS}   ${element}
         \   ${button}=    CATENATE  SEPARATOR=   ${new_locator}    ${button_xpath}
         \   wait and click   ${button}
         \   sleep   5
    ${file_name}=     Set Variable    ${SYSTEM_FILE_DOWNLOAD_DIR_PATH}${/}${test_file_name}
    Should Exist      ${file_name}
    Remove file       ${file_name}
    wait and click    ${new_locator}
    wait and click    ${SYSTEM_ADVANCED_SCHEDULED_SCRIPT_ITEM_DELETE_BUTTON}
    wait and click    ${SUBMIT_APPLY_BUTTON}
    sleep   2
    go to system
    sleep  2
    [Teardown]    Case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    write test result to file    ${CURDIR}
