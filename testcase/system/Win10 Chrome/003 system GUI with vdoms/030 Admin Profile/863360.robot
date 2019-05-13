*** Settings ***
Documentation    Verify GUI main dashboard and interface page works well when login with super admin
Resource    ../../../system_resource.robot

*** Variables ***
@{list_defult}   System Information   License Status    Administrators  CPU   Memory   Sessions
@{vdom}        ${SYSTEM_TEST_VDOM_NAME_1} 
*** Test Cases ***
863360
    [Documentation]    
    [Tags]    v6.0    chrome   863360    Medium    win10,64bit    runable
    login FortiGate
    Go to Global
    Go to system
    go to system_administrators
    Create Administrator  863360   123   admin_profile=super_admin   vdom=${vdom}
    Logout FortiGate
    login FortiGate  username=863360  password=123
    sleep  2
    check if the widget is reset to default    @{list_defult}    
    ### go to interface page and check if the super admin can see more interface than one vdom ###
    Go to network
    Go to network_Interfaces
    select frame     ${NETWORK_FRAME}
    sleep   2
    ${count_v}=    EVALUATE   0
    ${count_g}=    EVALUATE   0
    ${interface_type}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACES_TYPE}    Physical
    :FOR    ${i}  IN RANGE    1   100
        \   ${phy_int_locator}=   CATENATE  SEPARATOR=    ${interface_type}/following-sibling::tbody[1]    /tr[${i}]/
        \   ${vdom_locator}=      CATENATE  SEPARATOR=    ${phy_int_locator}    ${NETWORK_INTERFACES_TABLE_VDOM_SPAN}
        \   ${vdom}=     run keyword and return status    wait until element is visible   ${vdom_locator}
        \   ${vdom}=     run keyword if   "${vdom}"=="True"    get text    ${vdom_locator}
        \   ...  ELSE    EXIT FOR LOOP
        \   ${count_v}=  run keyword if   "${vdom}"=="${SYSTEM_TEST_VDOM_NAME_1}"    EVALUATE   ${count_v}+1   
        \   ...          ELSE   EVALUATE   ${count_v}+0
        \   ${status}=   run keyword and return status    should be equal   "${vdom}"   "${SYSTEM_TEST_VDOM_NAME_1}"
        \   ${count_g}=  run keyword if   "${status}"=="False"    EVALUATE   ${count_g}+1    
        \   ...          ELSE   EVALUATE   ${count_g}+0
    should be true     ${count_v}==4
    should be true     ${count_g}>=4
    [Teardown]   case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate  username=863360
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file   ${CURDIR}

   
