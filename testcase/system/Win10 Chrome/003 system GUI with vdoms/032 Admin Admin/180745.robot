*** Settings ***
Documentation    Verify debug log can be downloaded from GUI
Resource    ../../../system_resource.robot

*** Variables ***

*** Test Cases ***
180745
    [Documentation]    
    [Tags]    v6.0    chrome   180745    High    win10,64bit   runable
    Login FortiGate   browser=chrome
    sleep  2
    Go to Global
    Go to system
    go to system_advanced
    sleep   2
    ${status}=    run keyword and return status    checkbox should be selected    ${SYSTEM_ADVANCED_DOWNLOAD_DEBUG_LOG_CHECKBOX}
    run keyword if   "${status}"=="False"     wait and click    ${SYSTEM_ADVANCED_DOWNLOAD_DEBUG_LOG_LABEL}
    wait and click    ${SYSTEM_ADVANCED_DOWNLOAD_DEBUG_LOG_DOWNLOAD_BUTTON}
    sleep   20
    ftp file download should be done    ${SYSTEM_FILE_DOWNLOAD_DIR_PATH}${/}${FGT_SN}_debug.log
    Remove file    ${SYSTEM_FILE_DOWNLOAD_DIR_PATH}${/}${FGT_SN}_debug.log
    [Teardown]   case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate  
    Close All Browsers
    write test result to file    ${CURDIR}

