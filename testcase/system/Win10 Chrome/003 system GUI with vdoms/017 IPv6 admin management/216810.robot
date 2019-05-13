*** Settings ***
Documentation    GUI:verify FGT can set IPv6 trusthost for admin user bu gui
Resource    ../../../system_resource.robot

*** Variables ***
${username}    216810
${password}    123 
${admin_profile}   super_admin
${logout_icon_button_username}    xpath://button[div/div/span="${username}"]
${system_guiauto_vlan20VDOM_ipv6}    ${PC11_VLAN20_IPV6}
${system_guiauto_vlan20VDOM_ipv6_mask}   64
@{vdom}        ${SYSTEM_TEST_VDOM_NAME_1}   
*** Test Cases ***
216810
    [Documentation]    
    [Tags]    v6.0    chrome   216810    High    win10,64bit    runable
    ######### enable ipv6 and set ipv6 add on vlan20 interface ####
    Login FortiGate
    Go to system
    go to system_feature visibility
    sleep    2
    enable_FGT_feature_noRC    IPv6
    go to network
    Go to network_Interfaces
    network edit interface  ${FGT_VLAN20_INTERFACE}
    wait and click          ${network_interface_addressing mode_ipv6_manual}
    wait and click          ${network_interface_address_ipv6}
    clear element text      ${network_interface_address_ipv6}
    input text              ${network_interface_address_ipv6}    ${FGT_VLAN20_IP_V6}/${system_guiauto_vlan20VDOM_ipv6_mask}
    ${new_checkbox}=  REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACE_ADMINISTRATIVE ACESS_CHECKBOX_IPV6}  https
    ${new_label}=     REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACE_ADMINISTRATIVE ACESS_LABEL_IPV6}     https
    ${status}=        Run Keyword and Return Status    Checkbox Should Be Selected     ${new_checkbox}
    run keyword if     "${status}"=="False"    wait and click    ${new_label}
    wait and click  ${network_interfaces_edit_OK_button}
    ####  add an new administrator  ###
    unselect frame
    Go to system
    go to system_administrators
    Create Administrator    ${username}     ${password}   admin_profile=${admin_profile}    vdom=${vdom}
    ####  set the an new administrator  to trust hosts ###
    Go to system
    go to system_administrators
    EDIT ADMINISTRATOR  ${username}
    sleep   2
    ${status}=          Run Keyword and Return Status    Checkbox Should Be Selected    ${system_administrators_edit_admin_trust host_input}
    run keyword if     "${status}"=="False"    wait and click    ${system_administrators_edit_admin_trust host_label} 
    wait and click      ${system_administrators_edit_admin_trust host_Ipv6_1} 
    clear element text  ${system_administrators_edit_admin_trust host_Ipv6_1} 
    input text          ${system_administrators_edit_admin_trust host_Ipv6_1}   ${system_guiauto_vlan20VDOM_ipv6}/${system_guiauto_vlan20VDOM_ipv6_mask}
    wait and click      ${system_administrators_edit_admin_OK_button}
    Logout FortiGate
    ####   login with new trusted host  ####
    login FortiGate  https://[${FGT_VLAN20_IP_V6}]:${FGT_PORT}   chrome   none   ${username}   ${password}   ${FGT_REMOTE_URL}  ${FGT_DESIRED_CAPABILITIES}   ${FGT_FF_PROFILE_DIR}
    sleep  2
    ####  logout fortigate  ####
    wait and click    ${logout_icon_button_username}
    wait and click    ${LOGOUT_LOGOUT_BUTTON}
    
    ###  change the trusted IPv6 add and relogin, should cannot login successfully ####
    login FortiGate  
    Go to system
    go to system_administrators
    EDIT ADMINISTRATOR  ${username}
    sleep   2
    ${status}=        Run keyword and return status   Checkbox Should Be Selected    ${system_administrators_edit_admin_trust host_input}
    run keyword if   "${status}"=="False"    wait and click    ${system_administrators_edit_admin_trust host_label} 
    wait and click    ${system_administrators_edit_admin_trust host_Ipv6_1} 
    clear element text   ${system_administrators_edit_admin_trust host_Ipv6_1} 
    input text        ${system_administrators_edit_admin_trust host_Ipv6_1}    ${system_administrators_edit_admin_trust host_Ipv6_1_testip}
    wait and click    ${system_administrators_edit_admin_OK_button}
    Logout FortiGate
    ${status}=        run keyword and return status    login FortiGate  https://[${FGT_VLAN20_IP_V6}]:${FGT_PORT}   chrome   none   ${username}   ${password}   ${FGT_REMOTE_URL}  ${FGT_DESIRED_CAPABILITIES}   ${FGT_FF_PROFILE_DIR}
    Should be equal  "${status}"    "False"

    ####   clear test data ####
    login FortiGate  
    Go to system
    go to system_administrators
    DELETE ADMINISTRATOR  ${username}
    Go to system
    go to system_feature visibility
    sleep    2
    disable_FGT_feature_noRC    IPv6
    
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}


