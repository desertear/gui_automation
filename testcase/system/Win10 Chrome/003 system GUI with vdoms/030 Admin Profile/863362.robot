*** Settings ***
Documentation    Verify GUI main dashboard and interface page works well when login with readonly admin
Resource    ../../../system_resource.robot

*** Variables ***
@{list_defult}   Security Fabric   CPU   Memory   Sessions
*** Test Cases ***
863362
    [Documentation]    
    [Tags]    v6.0    chrome   863362    Medium    win10,64bit    runable
    [setup]    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    login FortiGate   username=863362  password=123
    sleep  2
    go to dashboard
    go to dashboard_main
    sleep  2
    check if the widget is reset to default    @{list_defult} 
    Go to network
    Go to network_Interfaces
    select frame     ${NETWORK_FRAME}
    sleep  2
    ${interface_type}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACES_TYPE}    Physical
    :FOR    ${i}  IN RANGE    1   5
        \   ${phy_int_locator}=   CATENATE  SEPARATOR=    ${interface_type}/following-sibling::tbody[1]    /tr[${i}]/
        \   ${vdom_locator}=      CATENATE  SEPARATOR=    ${phy_int_locator}    ${NETWORK_INTERFACES_TABLE_VDOM_SPAN}
        \   ${vdom}=   get text   ${vdom_locator}
        \   should be equal      "${vdom}"    "${SYSTEM_TEST_VDOM_NAME_1}"
    
    :FOR    ${i}  IN RANGE    5   7
        \   ${phy_int_locator}=   CATENATE  SEPARATOR=    ${interface_type}    /tr[${i}]/
        \   ${vdom_locator}=      CATENATE  SEPARATOR=    ${phy_int_locator}    ${NETWORK_INTERFACES_TABLE_VDOM_SPAN}
        \   ${vdom}=    run keyword and return status     get text    ${vdom_locator}
        \   should be equal    "${vdom}"    "False"
    
    [Teardown]   case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate  username=863362
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file   ${CURDIR}

   
