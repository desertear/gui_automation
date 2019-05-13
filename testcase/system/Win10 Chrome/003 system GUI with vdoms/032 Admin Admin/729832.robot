*** Settings ***
Documentation    Verified Multi-VDOM Admin user works with IPV6 GUI
Resource    ../../../system_resource.robot

*** Variables ***
${admin_name}   729832
${passwd}   123
@{vdom}     ${SYSTEM_TEST_VDOM_NAME_1}    ${SYSTEM_TEST_VDOM_NAME_2}
*** Test Cases ***
729832
    [Documentation]    
    [Tags]    v6.0    chrome   729832    Critical    win10,64bit   runable
    Login FortiGate
    Go to system
    ##enable IPV6 feature ##
    go to system_feature visibility
    sleep    2
    enable_FGT_feature_noRC    IPv6
    go to network
    Go to network_Interfaces
    ## enable https for IPV6 ##
    network edit interface  ${FGT_VLAN20_INTERFACE}
    wait and click          ${network_interface_addressing mode_ipv6_manual}
    wait and click          ${network_interface_address_ipv6}
    clear element text      ${network_interface_address_ipv6}
    input text              ${network_interface_address_ipv6}      ${FGT_VLAN20_IP_V6}/64
    ${new_checkbox}=  REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACE_ADMINISTRATIVE ACESS_CHECKBOX_IPV6}  https
    ${new_label}=     REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACE_ADMINISTRATIVE ACESS_LABEL_IPV6}     https
    ${status}=        Run Keyword and Return Status    Checkbox Should Be Selected     ${new_checkbox}
    run keyword if     "${status}"=="False"    wait and click    ${new_label}
    wait and click  ${network_interfaces_edit_OK_button}
    ####  add an new administrator  ###
    unselect frame
    Go to system
    go to System_administrators
    Create Administrator    username=${admin_name}    password=${passwd}     vdom=${vdom}   admin_profile=prof_admin
    Logout FortiGate  
    login FortiGate  https://[${FGT_VLAN20_IP_V6}]:${FGT_PORT}   username=${admin_name}   password=${passwd}  
    sleep   2
    Logout FortiGate  username=${admin_name}
    ##  set ipv6 to disable ##
    login FortiGate  
    Go to system
    go to system_feature visibility
    sleep    2
    disable_FGT_feature_noRC    IPv6
    [Teardown]   case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate 
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file   ${CURDIR}