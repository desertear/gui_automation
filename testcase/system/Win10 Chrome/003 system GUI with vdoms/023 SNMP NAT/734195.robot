*** Settings ***
Documentation    Verify Fortinet SNMP mib can be downloaded from GUI
Resource    ../../../system_resource.robot

*** Variables ***

*** Test Cases ***
734195
    [Documentation]    
    [Tags]    v6.0    chrome   734195    High    win10,64bit    runable
    login FortiGate    browser=chrome
    Go to system
    Go to system_SNMP
    sleep  2
    wait and click   ${SYSTEM_SNMP_DOWNLOAD_MIB_FORTIGATE_BUTTON}
    sleep  30
    ftp file download should be done    ${SYSTEM_FILE_DOWNLOAD_DIR_PATH}${/}FORTINET-FORTIGATE-MIB.mib
    sleep  2
    wait and click   ${SYSTEM_SNMP_DOWNLOAD_MIB_FORTINET_CORE_BUTTON}
    sleep  30
    ftp file download should be done    ${SYSTEM_FILE_DOWNLOAD_DIR_PATH}${/}FORTINET-CORE-MIB.mib
    sleep  2
    Remove file   ${SYSTEM_FILE_DOWNLOAD_DIR_PATH}${/}FORTINET-FORTIGATE-MIB.mib
    Remove file   ${SYSTEM_FILE_DOWNLOAD_DIR_PATH}${/}FORTINET-CORE-MIB.mib
    [teardown]    case teardown

*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    write test result to file    ${CURDIR}
