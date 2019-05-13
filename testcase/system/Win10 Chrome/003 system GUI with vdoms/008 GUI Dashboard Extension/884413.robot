*** Settings ***
Documentation      Verify GUI show HA and Vdom info on top bar (0532554)
Resource    ../../../system_resource.robot

*** Variables ***
${test_vdom}    ${SYSTEM_TEST_VDOM_NAME_1}
${admin_prof_global}     884413g
${admin_name_scope_global}    884413g
${admin_name_scope_vdom}      884413v
${password}    884413
@{ssh_cmd_FGTA_init}     config global    config system ha    set mode standalone    end    end
...                      config global    config sys accpro   edit ${admin_prof_global}    set scope global    set sysgrp read-write    end    end
...                      config global    config sys admin    edit ${admin_name_scope_vdom}    set accprofile prof_admin    set pass ${password}    set vdom ${test_vdom}   end     end
...                      config global    config sys admin    edit ${admin_name_scope_global}    set accprofile ${admin_prof_global}    set pass ${password}   end     end
@{ssh_cmd_FGTA_set_HA}   config global    config system ha    set mode a-p    set hbdev ${SYSTEM_TEST_INTF_3} 10   set group-name 123456    set password 123456    end    end
@{ssh_cmd_FGTA_clean}    config global    config sys admin    delete ${admin_name_scope_vdom}    delete ${admin_name_scope_global}     end     end
...                      config global    config sys accpro   delete ${admin_prof_global}   end    end
...                      config global    config system ha    unset hbdev    unset group-name    unset password    set mode standalone    end    end
*** Test Cases ***
884413
##
    [Tags]    v6.0    chrome   884413    high    win10,64bit    browsers    runable   
    Execute CLI commands on FortiGate Via Direct Telnet     ${ssh_cmd_FGTA_init}
    Login FortiGate     
    ${newlocator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE     ${SYSTEM_MAIN_PORTALPAGE_TOPBAR_VDOM}    ${test_vdom}
    ${status}=    run keyword and return status    Wait Until Element Is Visible     ${newlocator}
    should be equal    "${status}"    "False"
    Logout FortiGate  
    Close All Browsers

    Login FortiGate    username=${admin_name_scope_vdom}      password=${password}
    Wait Until Element Is Visible     ${newlocator}
    sleep   1
    Logout FortiGate    username=${admin_name_scope_vdom}
    Close All Browsers

    Login FortiGate    username=${admin_name_scope_global}      password=${password}
    ${status}=    run keyword and return status    Wait Until Element Is Visible     ${newlocator}
    should be equal    "${status}"    "False"
    Logout FortiGate    username=${admin_name_scope_global}
    Close All Browsers

    Execute CLI commands on FortiGate Via Direct Telnet     ${ssh_cmd_FGTA_set_HA}
    sleep   20
    
    login FortiGate     
    ${newlocator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE     ${SYSTEM_MAIN_PORTALPAGE_TOPBAR_VDOM}    ${test_vdom}
    ${status}=    run keyword and return status    Wait Until Element Is Visible     ${newlocator}
    should be equal    "${status}"    "False"
    Wait Until Element Is Visible    ${SYSTEM_MAIN_PORTALPAGE_TOPBAR_HA}
    Logout FortiGate  
    Close All Browsers

    login FortiGate     username=${admin_name_scope_vdom}    password=${password}
    ${newlocator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE     ${SYSTEM_MAIN_PORTALPAGE_TOPBAR_VDOM}    ${test_vdom}
    Wait Until Element Is Visible     ${newlocator}
    ${status}=    run keyword and return status    Wait Until Element Is Visible    ${SYSTEM_MAIN_PORTALPAGE_TOPBAR_HA}
    should be equal    "${status}"    "False"
    Logout FortiGate    username=${admin_name_scope_vdom}
    Close All Browsers
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Execute CLI commands on FortiGate Via Direct Telnet     ${ssh_cmd_FGTA_clean}
    Close All Browsers
    write test result to file    ${CURDIR}
    
