*** Settings ***
Documentation     This file contains FortiGate GUI Policy and Objects operation

*** Keywords ***
###Policy & Objects###    
##Policy & Objects ->IPv4 Policy##
Go to IPv4 policy
    Wait Until Element Is Visible    ${MENU_POLICY_IPV4_POLICY}
    click element    ${MENU_POLICY_IPV4_POLICY}
    Wait Until Element Is Visible    ${POLICY_V4V6_TABLE}

Go to Consolidated Policy
    Wait Until Element Is Visible    ${MENU_POLICY_CONSOLIDATED_POLICY}
    click element    ${MENU_POLICY_CONSOLIDATED_POLICY}
    Wait Until Element Is Visible    ${POLICY_V4V6_TABLE}

create ip policy
    [Arguments]     ${policy_name}    ${incoming}    ${outgoing}
    ...    ${source_addresses}    ${destination_addresses}
    ...    ${schedule}    ${service}    ${action}    ${nat}    ${ippool_config_mode}=Outgoing Interface   ${ippool_name}=NONE    ${preserve_source_port}=disable    ${protocol_option}=default
    ...    ${inspection_mode}=Flow-based    ${security_profile}=NONE   ${multi_intf}=disable    ${ip_version}=4    ${consolidated}=NO
    [Documentation]    possible item of list @{incoming}/@{outgoing}: port1,port8,mgmt1,mgmt2,any and SSL-VPN tunnel interface (ssl.root)
    ...    format and meaning of source/destination ip address:
    ...    ADDRESS:all--->ADDRESS indicates this is an address, and "all" is the address name
    ...    USER:test--->USER indicates this is a user, and test is the user name
    ...    GROUP:testgrp---->GROUP indicates this is a group, and testgrp is the group name
    clean same name policy and click create new    ${policy_name}    ${consolidated}
    set address to policy    ${source_addresses}    ${destination_addresses}    ${ip_version}
    set general config to policy   ${policy_name}    ${incoming}    ${outgoing}   ${schedule}    ${service}    ${action}    
    ...      ${nat}   ${ippool_config_mode}   ${ippool_name}    ${preserve_source_port}     ${protocol_option}
    ...      ${inspection_mode}   ${security_profile}   ${multi_intf}    
    click button    ${GENERAL_EDITOR_OK_BUTTON}
    deal with certificate warning and verify if policy created    ${policy_name}    ${consolidated}

edit ip policy
    [Arguments]   ${policy_name_old}   ${policy_name_new}    ${incoming}    ${outgoing}
    ...    ${source_addresses}    ${destination_addresses}
    ...    ${schedule}    ${service}    ${action}    ${nat}   ${ippool_config_mode}=Outgoing Interface   ${ippool_name}=NONE  ${preserve_source_port}=disable    ${protocol_option}=default
    ...    ${inspection_mode}=Flow-based   ${security_profile}=NONE   ${multi_intf}=disable   ${ip_version}=4   ${consolidated}=NO
    [Documentation]    possible item of list @{incoming}/@{outgoing}: port1,port8,mgmt1,mgmt2,any and SSL-VPN tunnel interface (ssl.root)
    ...    format and meaning of source/destination ip address:
    ...    ADDRESS:all--->ADDRESS indicates this is an address, and "all" is the address name
    ...    USER:test--->USER indicates this is a user, and test is the user name
    ...    GROUP:testgrp---->GROUP indicates this is a group, and testgrp is the group name
    Edit Policy By NAME on Policy list    ${policy_name_old}    ${consolidated}
    remove element config in policy editing    Source
    remove element config in policy editing    Destination
    set address to policy     ${source_addresses}    ${destination_addresses}    ${ip_version}
    set general edit config to policy   ${policy_name_new}    ${incoming}    ${outgoing}   ${schedule}    ${service}    ${action}
    ...    ${nat}     ${ippool_config_mode}   ${ippool_name}    ${preserve_source_port}    ${protocol_option}
    ...    ${inspection_mode}    ${security_profile}   ${multi_intf}    
    click button    ${GENERAL_EDITOR_OK_BUTTON}
    deal with certificate warning and verify if policy created    ${policy_name_new}    ${consolidated}

if ip policy exists
    [Arguments]   ${policy_name}    ${consolidated}=NO
    run keyword if    "${consolidated}"!="YES"     Wait Until Element Is Visible    ${POLICY_V4V6_VIEW_SEQUENCE_BUTTON}
    run keyword if    "${consolidated}"!="YES"     click button    ${POLICY_V4V6_VIEW_SEQUENCE_BUTTON}
    run keyword if    "${consolidated}"!="YES"     Wait Until Element Is Visible    ${POLICY_V4V6_VIEW_SEQUENCE_BUTTON_SELECTED}
    ${policy_in_table}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_IN_TABLE}    ${policy_name}
    ${status}=    run keyword and return status    Wait Until Element Is Visible    ${policy_in_table}
    [return]    ${status}

delete ip policy
    [Arguments]   ${policy_name}    
    ${policy_in_table}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_IN_TABLE}    ${policy_name}
    click element    ${policy_in_table}
    click button    ${POLICY_V4V6_DELETE_BUTTON_E}
    Wait Until Element Is Visible    ${POLICY_V4V6_DELETE_CONFIRM_HEAD}
    Wait Until Element Is Visible    ${POLICY_V4V6_DELETE_CONFIRM_OK_BUTTON}
    click button    ${POLICY_V4V6_DELETE_CONFIRM_OK_BUTTON}
    sleep    1
    #verify if the address is deleted successfully
    reload page
    sleep    2
    wait until page does not contain element    ${policy_in_table}

set address to policy
    [Arguments]    ${source_addresses}    ${destination_addresses}  ${ip_version}=4
    #add source address
    click element    ${POLICY_V4V6_SOURCE_DIV}
    sleep   1
    Wait Until Element Is Visible    ${POLICY_V4V6_SELECTION_PANE_H1}
    :FOR    ${source_address}    IN    @{source_addresses}
    \    @{split_addr}=    Split String    ${source_address}    :
    \    run keyword if   "${ip_version}"=="4"  select address to policy4     @{split_addr}[0]    @{split_addr}[1]
    \    ...    ELSE IF    "${ip_version}"=="6"  select address to policy6     @{split_addr}[0]    @{split_addr}[1]
    click button    ${POLICY_V4V6_ENTRY_CLOSE_BUTTON}
    sleep    3

    #add destination address
    click element    ${POLICY_V4V6_DESTINATION_DIV}
    sleep   1
    Wait Until Element Is Visible    ${POLICY_V4V6_SELECTION_PANE_H1}
    :FOR    ${destination_address}    IN    @{destination_addresses}
    \    @{split_addr}=    Split String    ${destination_address}    :
    \    run keyword if   "${ip_version}"=="4"  select address to policy4     @{split_addr}[0]    @{split_addr}[1]
    \    ...    ELSE IF    "${ip_version}"=="6"  select address to policy6     @{split_addr}[0]    @{split_addr}[1]
    click button    ${POLICY_V4V6_ENTRY_CLOSE_BUTTON}
    sleep    3
   
deal with certificate warning and verify if policy created
    [Arguments]   ${policy_name}    ${consolidated}
    #deal with certificate warning
    ${if_certificate_warning}=    run keyword and return status    wait until element is visible    ${POLICY_V4V6_CERTIFICATE_CONFIRM_HEAD}
    run keyword if    "${if_certificate_warning}"=="True"    wait until element is visible    ${POLICY_V4V6_CERTIFICATE_CONFIRM_OK_BUTTON}
    run keyword if    "${if_certificate_warning}"=="True"    click button    ${POLICY_V4V6_CERTIFICATE_CONFIRM_OK_BUTTON}
    Wait Until Page Does Not Contain Element    ${POLICY_V4V6_CERTIFICATE_CONFIRM_HEAD}

    #verify if the policy is created successfully
    run keyword if     "${consolidated}"!="YES"     View By Sequence
    ${policy_in_table}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_IN_TABLE}    ${policy_name}
    wait until element is visible    ${policy_in_table}

clean same name policy and click create new
    [Arguments]    ${policy_name}   ${consolidated}
    Wait Until Element Is Visible    ${GENERAL_LIST_CREATE_NEW_BUTTON}
    ${status}=    if ip policy exists    ${policy_name}    ${consolidated}
    run keyword if    "${status}"=="True"     delete ip policy    ${policy_name}
    click button    ${GENERAL_LIST_CREATE_NEW_BUTTON}
    sleep   2

check policy exist and click edit
    [Arguments]    ${policy_name}    ${consolidated}
    Wait Until Element Is Visible    ${GENERAL_LIST_EDIT_BUTTON}
    ${status}=    if ip policy exists    ${policy_name}    ${consolidated}
    run keyword if    "${status}"=="True"    click button    ${GENERAL_LIST_CREATE_NEW_BUTTON}

set general config to policy
    [Arguments]    ${policy_name}    ${incoming}    ${outgoing}
    ...    ${schedule}    ${service}    ${action}    ${nat}    ${ippool_config_mode}   ${ippool_name}   ${preserve_source_port}    ${protocol_option}
    ...    ${inspection_mode}   ${security_profile}   ${multi_intf}

    Wait Until Element Is Visible    ${POLICY_V4V6_POLICY_H1}
    Wait Until Element Is Visible    ${POLICY_V4V6_NAME_TEXT}
    input text    ${POLICY_V4V6_NAME_TEXT}    ${policy_name}

    run keyword if   "${multi_intf}"=="disable"    add single-interface in policy creating    ${incoming}    ${outgoing}
    ...     ELSE   add multi-interfaces in policy creating    ${incoming}    ${outgoing}
    
    # #config schedule:
    # click element    ${POLICY_V4V6_SCHEDULE_DIV}
    # ${locator_schedule_in_dropdown}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_SCHEDULE_IN_DROPDOWN}    ${schedule}   
    # wait until element is visible    ${locator_schedule_in_dropdown}   
    # click element    ${locator_schedule_in_dropdown}
    # ${locator_schedule_in_div}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_SCHEDULE_IN_DIV}    ${schedule} 
    # wait until element is visible    ${locator_schedule_in_div}
    
    #set service
    click element    ${POLICY_V4V6_SERVICE_DIV}
    Wait Until Element Is Visible    ${POLICY_V4V6_SERVICE_ENTRY_LIST}
    ${locator_service_in_list}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_SERVICE_ENTRY_IN_LIST}    ${service}
    wait until element is visible    ${locator_service_in_list}
    click element    ${locator_service_in_list}
    click button    ${POLICY_V4V6_ENTRY_CLOSE_BUTTON}
    ${locator_service_in_div}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_SERVICE_IN_DIV}    ${service}    
    wait until element is visible    ${locator_service_in_div}

    #set action
    run keyword if    "${action}"=="DENY"    click element    ${POLICY_V4V6_ACTION_DENY_LABEL}
    ...    ELSE    click element    ${POLICY_V4V6_ACTION_ACCEPT_LABEL}
    
    run keyword if    "${action}"=="ACCEPT"    set accept action based features in policy editing    ${nat}    ${ippool_config_mode}    ${ippool_name}     ${preserve_source_port}     ${protocol_option}    
    ...     ${inspection_mode}    ${security_profile}



set accept action based features in policy editing
    [Arguments]     ${nat}    ${ippool_config_mode}    ${ippool_name}     ${preserve_source_port}     ${protocol_option}    
    ...     ${inspection_mode}    ${security_profile}
    ##set nat and ippool
    set item enable disable in policy edit page     NAT    ${nat}
    run keyword if    "${nat}"=="enable"    set ippool in policy edit page   ${ippool_config_mode}   ${ippool_name}    
    run keyword if    "${nat}"=="enable"    set item enable disable in policy edit page       Preserve Source Port    ${preserve_source_port} 
    set protocol options in policy edit page    ${protocol_option}

    ## set inspection mode  
    set inspection mode in policy edit page    ${inspection_mode}

    ###   set security profiles  ###
    run keyword if    "${security_profile}"!="NONE"    set security profiles to policy4    ${security_profile}
 
remove element config in policy editing
    [Documentation]    remove exist config in policy editing
    ...                element is the entry name, such as Incoming ...
    [Arguments]    ${element}
    ${entry_exist}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${POLICY_EDIT_PAGE_ELEMENT_FIRST_ENTRY_SELECTED}   ${element}
    ${remove_button}=    CATENATE   SEPARATOR=    ${entry_exist}    ${POLICY_EDIT_PAGE_ELEMENT_REMOVE_BUTTON}
    :FOR    ${i}    IN RANGE   1  100
    \    ${exist}=    run keyword and return status    wait until element is visible    ${entry_exist}
    \    EXIT FOR LOOP IF    "${exist}"=="False"
    \    wait and click  ${remove_button}

set general edit config to policy
    [Arguments]    ${policy_name}    ${incoming}    ${outgoing}
    ...    ${schedule}    ${service}    ${action}    ${nat}    ${ippool_config_mode}   ${ippool_name}   ${preserve_source_port}   ${protocol_option}
    ...    ${inspection_mode}    ${security_profile}   ${multi_intf}

    Wait Until Element Is Visible    ${POLICY_V4V6_POLICY_H1_EDIT}
    Wait Until Element Is Visible    ${POLICY_V4V6_NAME_TEXT}
    clear element text    ${POLICY_V4V6_NAME_TEXT}
    input text    ${POLICY_V4V6_NAME_TEXT}    ${policy_name}
    run keyword if   "${multi_intf}"=="disable"    add single-interface in policy creating    ${incoming}    ${outgoing}
    ...     ELSE   remove element config in policy editing    Incoming

    run keyword if   "${multi_intf}"!="disable"     remove element config in policy editing    Outgoing
    run keyword if   "${multi_intf}"!="disable"    add multi-interfaces in policy creating    ${incoming}    ${outgoing}
    
    # #config schedule:
    # click element    ${POLICY_V4V6_SCHEDULE_DIV}
    # ${locator_schedule_in_dropdown}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_SCHEDULE_IN_DROPDOWN}    ${schedule}   
    # wait until element is visible    ${locator_schedule_in_dropdown}
    # click element    ${locator_schedule_in_dropdown}
    # ${locator_schedule_in_div}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_SCHEDULE_IN_DIV}    ${schedule} 
    # wait until element is visible    ${locator_schedule_in_div}

    #set service
    remove element config in policy editing    Service
    click element    ${POLICY_V4V6_SERVICE_DIV}
    Wait Until Element Is Visible    ${POLICY_V4V6_SERVICE_ENTRY_LIST}
    ${locator_service_in_list}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_SERVICE_ENTRY_IN_LIST}    ${service}
    wait until element is visible    ${locator_service_in_list}
    click element    ${locator_service_in_list}
    click button    ${POLICY_V4V6_ENTRY_CLOSE_BUTTON}
    ${locator_service_in_div}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_SERVICE_IN_DIV}    ${service}    
    wait until element is visible    ${locator_service_in_div}

    #set action
    run keyword if    "${action}"=="DENY"    click element    ${POLICY_V4V6_ACTION_DENY_LABEL}
    ...    ELSE    click element    ${POLICY_V4V6_ACTION_ACCEPT_LABEL}
    
    run keyword if    "${action}"=="ACCEPT"    set edit accept action based features in policy editing    ${nat}    ${ippool_config_mode}   ${ippool_name}    ${preserve_source_port}    
    ...    ${protocol_option}    ${inspection_mode}    ${security_profile}

set edit accept action based features in policy editing
    [Arguments]    ${nat}    ${ippool_config_mode}   ${ippool_name}    ${preserve_source_port}    
    ...     ${protocol_option}    ${inspection_mode}    ${security_profile}
    ##set nat and ippool
    set item enable disable in policy edit page     NAT    ${nat}
    run keyword if    "${nat}"=="enable"    remove all ippools in policy editing
    run keyword if    "${nat}"=="enable"    set ippool in policy edit page   ${ippool_config_mode}   ${ippool_name}    
    run keyword if    "${nat}"=="enable"    set item enable disable in policy edit page       Preserve Source Port    ${preserve_source_port} 
    set protocol options in policy edit page    ${protocol_option}

    ## set inspection mode  
    set inspection mode in policy edit page    ${inspection_mode}

    ###   set security profiles  ###
    run keyword if    "${security_profile}"!="NONE"    set security profiles to policy4    ${security_profile}


add multi-interfaces in policy creating
    [Arguments]    ${incoming}    ${outgoing}
    #add incoming interface
    wait and click   ${SYSTEM_POLICY_IPV4_POLICY_INCOME_INT_LABEL}
    Wait Until Element Is Visible    ${POLICY_V4V6_SELECTION_PANE_H1}
    :FOR    ${incoming_itf}    IN    @{incoming}
    \    wait until element is visible    xpath://div[span/span="${incoming_itf}"]
    \    click element    xpath://div[span/span="${incoming_itf}"]
    click button    ${POLICY_V4V6_ENTRY_CLOSE_BUTTON}
    sleep    3

    #add outgoing interface
    wait and click   ${SYSTEM_POLICY_IPV4_POLICY_OUTGO_INT_LABEL}
    Wait Until Element Is Visible    ${POLICY_V4V6_SELECTION_PANE_H1}
    :FOR    ${outgoing_itf}    IN    @{outgoing}
    \    wait until element is visible    xpath://div[span/span="${outgoing_itf}"]
    \    click element    xpath://div[span/span="${outgoing_itf}"]
    click button    ${POLICY_V4V6_ENTRY_CLOSE_BUTTON}
    sleep    3

add single-interface in policy creating
    [Arguments]    ${incoming}    ${outgoing}
    wait and click   ${SYSTEM_POLICY_IPV4_POLICY_INCOME_INT_LABEL}
    ${incoming_itf}=      Set Variable    @{incoming}[0]
    ${menu_bar}=     REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_SELECT_INTERFACE_MEMBER_MENU_BAR}    ${incoming_itf}
    wait and click   ${menu_bar}
    
    wait and click   ${SYSTEM_POLICY_IPV4_POLICY_OUTGO_INT_LABEL}
    ${outgoing_itf}=      Set Variable    @{outgoing}[0]
    ${menu_bar}=     REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_SELECT_INTERFACE_MEMBER_MENU_BAR}    ${outgoing_itf}
    wait and click   ${menu_bar}

get policy multi_intf status from cli
    [Arguments]    ${vdom}
    @{command}=    Create List    config vdom  edit ${vdom}  config system settings  get | grep gui-multiple-interface-policy
    @{response_ssh}=  Execute CLI commands on FortiGate Via Direct Telnet     ${command}   
    ${response}=   Set Variable    @{response_ssh}[-1]
    ${multi_intf}=   FETCH FROM RIGHT   ${response}     :
    ${multi_intf}=   FETCH FROM LEFT    ${multi_intf}   \r
    ${multi_intf}=   STRIP STRING    ${multi_intf}
    [Return]    ${multi_intf}

select address to policy4
    [Arguments]    ${address_type}    ${name}
    #click tab to choose address type
    wait until element is visible    ${POLICY_V4V6_ENTRY_ADDRESS_TAB}
    sleep    5
    # run keyword if    "${address_type}"=="ADDRESS"    click element    ${POLICY_V4V6_ENTRY_ADDRESS_TAB}
    # ...    ELSE IF    "${address_type}"=="USER"    click element    ${POLICY_V4V6_ENTRY_USER_TAB}
    # ...    ELSE IF    "${address_type}"=="GROUP"    click element    ${POLICY_V4V6_ENTRY_USER_TAB}
    # ...    ELSE    Fail    wrong address type, it should be one of ADDRESS, USER, GROUP

    #choose entry
    # run keyword if    "${address_type}"=="ADDRESS"    click element    xpath://label[contains(span,"Address \(")]/following-sibling::div[span/span[text()="${name}"]]
    # ...    ELSE IF    "${address_type}"=="USER"    click element    xpath://label[contains(span,"User \(")]/following-sibling::div[span/span[text()="${name}"]]
    # ...    ELSE IF    "${address_type}"=="GROUP"    click element    xpath://label[contains(span,"User Group \(")]/following-sibling::div[span/span[text()="${name}"]]
    # ...    ELSE    Fail    wrong address type, it should be one of ADDRESS, USER, GROUP
    click element     ${POLICY_V4V6_ENTRY_${address_type}_TAB}
    ${entry}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_${address_type}_IN_SELECT_ENTRY}    ${name}
    wait and click     ${entry}
    #move out of selected entry, to avoid to be obscured by bubble message.
    Mouse Out    ${POLICY_V4V6_SELECTION_PANE_DIV}
    #make user it's Selected
    Wait Until Element Is Visible    xpath://label[span="Source" or contains(span,"Destination")]/following-sibling::div//span[text()="${name}"]

get name list from action list
    [Arguments]   ${action_list}
    ${name_list}=  create list
    :FOR    ${element}    IN    @{action_list}
    \    @{split_profile}=    Split String    ${element}    :
    \    Append to list   ${name_list}    @{split_profile}[0]    
    [Return]    ${name_list}

get value list from action list
    [Arguments]    ${action_list}
    ${values_return}=    create list
    :FOR    ${element}    IN    @{action_list}
    \    @{split_addr}=    Split String    ${element}    :
    \    Append to list    ${values_return}    @{split_addr}[1]
    [Return]    ${values_return}

set security profiles to policy4
    [Arguments]   ${security_profile}
    ${enable_label}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${POLICY_V4V6_POLICY_EDIT_CHECKBOX_LABEL}    Eable this policy
    Press Down Key Until an Element is Visible    ${enable_label}    10
    :FOR    ${profile}    IN    @{security_profile}
    \    @{split_profile}=    Split String    ${profile}    :
    \    set security profile in policy edit page    @{split_profile}[0]    @{split_profile}[1]

set security profile in policy edit page
    [Arguments]   ${profile_type}   ${profile_name}
    [Documentation]   this keyword is to set security profile in policy edit page, SSL do not have the checkbox button
    ...               if won't enable a profile, profile_name should be set to "disable"
    ${profile_disable}=   run keyword and return status    should be true  "${profile_name}"=="disable"
    ${action}=   set variable if    "${profile_disable}"=="True"    disable    enable
    ${if_ssl}=   run keyword and return status    should contain    ${profile_type}   SSL
    run keyword if    "${if_ssl}"=="False"    set checkbox in policy edit page    ${action}    ${profile_type}   
    ${security_menu}=  REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${POLICY_V4V6_SECURITY_PROFILE_SELECT_MENU}    ${profile_type}
    run keyword if   "${profile_disable}"=="False" and "${if_ssl}"=="False"    wait and click    ${security_menu} 
    ...    ELSE IF    "${if_ssl}"=="True"    wait and click    ${security_menu} 
    sleep   2
    ${menu_bar}=     REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_SELECT_INTERFACE_MEMBER_MENU_BAR}    ${profile_name}
    run keyword if   "${profile_disable}"=="False" and "${if_ssl}"=="False"    wait and click    ${menu_bar} 
    ...    ELSE IF    "${if_ssl}"=="True"    wait and click    ${menu_bar} 

set checkbox in policy edit page
    [Arguments]        ${enable}    ${chkbox_name}
    ${enable}=    Convert To lowercase    ${enable}
    ${new_input}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${POLICY_V4V6_POLICY_EDIT_CHECKBOX_INPUT}    ${chkbox_name}
    ${new_label}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${POLICY_V4V6_POLICY_EDIT_CHECKBOX_LABEL}    ${chkbox_name}
    ${status}=    run keyword and return status    checkbox should be selected    ${new_input}
    run keyword if    "${status}"=="False" and "${enable}"=="enable"    wait and click    ${new_label}
    ...   ELSE IF     "${status}"=="True" and "${enable}"=="disable"    wait and click    ${new_label}
    ${status}=    run keyword and return status    checkbox should be selected    ${new_input}
    run keyword if    "${enable}"=="enable"     should be equal    "${status}"    "True"
    run keyword if    "${enable}"=="disable"    should be equal    "${status}"    "False"

set protocol options in policy edit page
    [Arguments]    ${pro_opt_name}
    wait and click   ${POLICY_V4V6_PROTOCOL_OPTION_SELECT_MENU}
    ${menu_bar}=     REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_SELECT_INTERFACE_MEMBER_MENU_BAR}    ${pro_opt_name}
    wait and click   ${menu_bar} 

set ippool in policy edit page
    [Arguments]    ${ippool_config_mode}    ${ippool_name}
    [Documentation]   this keyword is to set ippool on policy edit page, pool name is a list
    ...               ippool only be set as mode is "Dynamic"
    set ippool config mode in policy edit page    ${ippool_config_mode}
    ${dynamic}=    run keyword and return status    should contain    ${ippool_config_mode}    Dynamic
    run keyword if    "${dynamic}"=="True"    add ipppol in policy edit page    ${ippool_name}

set ippool config mode in policy edit page
    [Arguments]    ${ippool_config_mode}
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${POLICY_V4V6_IPPOOL_CONFIG_MODE}    ${ippool_config_mode}
    wait and click    ${new_locator}
    
add ipppol in policy edit page
    [Arguments]    ${ippool_name}
    :FOR   ${element}   IN    @{ippool_name}
    \    wait and click    ${POLICY_V4V6_IPPOOL_CONFIG_ADD_BUTTON}
    \    SELECT MENU BAR FROM SELECTION PANE  ${element}
    \    ${pool_shown}=     REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${POLICY_EDIT_PAGE_IPPOOL_ENTRY}    ${element}
    \    Wait Until Element Is Visible     ${pool_shown}

remove a ipppol in policy edit page
    [Arguments]    ${ippool_name}
    ${pool_shown}=     REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${POLICY_EDIT_PAGE_IPPOOL_ENTRY}    ${ippool_name}
    #check if ippool is on the page
    Wait Until Element Is Visible     ${pool_shown}
    wait and click    ${POLICY_V4V6_IPPOOL_CONFIG_ADD_BUTTON}
    SELECT MENU BAR FROM SELECTION PANE  ${ippool_name}
    Wait Until Element Is NOT Visible     ${pool_shown}

remove all ippools in policy editing
    [Documentation]    remove all ippols configed in policy editing
    ${remove_button}=    CATENATE   SEPARATOR=    ${POLICY_EDIT_PAGE_IPPOOL_FIRST_ENTRY_SELECTED}    ${POLICY_EDIT_PAGE_ELEMENT_REMOVE_BUTTON}
    :FOR    ${i}    IN RANGE   1  100
    \    ${exist}=    run keyword and return status    wait until element is visible    ${POLICY_EDIT_PAGE_IPPOOL_FIRST_ENTRY_SELECTED}
    \    EXIT FOR LOOP IF    "${exist}"=="False"
    \    wait and click  ${remove_button}


set inspection mode in policy edit page
    [Arguments]    ${inspection_mode}
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${POLICY_V4V6_INSPECTION_MODE}    ${inspection_mode}
    wait and click    ${new_locator}

set action in policy edit page
    [Arguments]    ${action}
    ${action}=    Convert To Uppercase    ${action}
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${POLICY_V4V6_ACTION}    ${action}
    wait and click    ${new_locator}

set ssl inspection in policy edit page
    [Arguments]   ${ssl_insepction_mode}
    ${security_menu}=  REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${POLICY_V4V6_SECURITY_PROFILE_SELECT_MENU}    SSL Inspection
    wait and click    ${security_menu} 
    ${menu_bar}=     REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_SELECT_INTERFACE_MEMBER_MENU_BAR}    ${ssl_insepction_mode}
    wait and click   ${menu_bar}

set log allowed traffic in policy edit page
    [Arguments]     ${profile_name}
    ${profile_disable}=   run keyword and return status    should be true  "${profile_name}"=="disable"
    ${new_input}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${POLICY_V4V6_POLICY_EDIT_CHECKBOX_INPUT}    Log Allowed Traffic
    ${new_label}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${POLICY_V4V6_POLICY_EDIT_CHECKBOX_LABEL}    Log Allowed Traffic
    ${status}=   run keyword and return status      checkbox should be selected   ${new_input}
    run keyword if   "${status}"=="False" and "${profile_disable}"=="False"   wait and click  ${new_label}
    ${pro_label}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${POLICY_V4V6_LOG_ALLOWED_TRAFFIC}    ${profile_name}
    run keyword if   "${profile_disable}"=="False"   wait and click   ${pro_label}
    run keyword if   "${status}"=="True" and "${profile_disable}"=="True"    wait and click  ${new_label}

set item enable disable in policy edit page
    [Arguments]    ${item}   ${action}
    [Documentation]   this keyword is to click checkbox in policy edit page, "item" is the name of before the checkbox,
    ...               item should be "NAT", "Preserve Source Port" ..., same as that on the web page
    ...               action should be enable or disable
    ${action}=    Convert To lowercase    ${action}
    ${new_input}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${POLICY_V4V6_POLICY_EDIT_CHECKBOX_INPUT}    ${item}
    ${new_label}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${POLICY_V4V6_POLICY_EDIT_CHECKBOX_LABEL}    ${item}
    ${status}=   run keyword and return status    checkbox should be selected    ${new_input}
    run keyword if   "${status}"=="False" and "${action}"=="enable"   wait and click   ${new_label}
    run keyword if   "${status}"=="True" and "${action}"=="disable"   wait and click   ${new_label}

# set ip pool in policy edit page
#     [Arguments]        ${preserve_source_port}    ${ippool_mode}=Interface   ${ippool_name}=NONAME    
#     ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${POLICY_V4V6_IPPOOL_MODE}    ${ippool_mode}
#     wait and click    ${new_locator}
#     ${dynamic}=   run keyword and return status    should contain    ${ippool_mode}   Dynamic
#     run keyword if   ${dynamic}    select Dynamic ippool in policy edit page    ${ippool_name}
#     ${new_input}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${POLICY_V4V6_POLICY_EDIT_CHECKBOX_INPUT}    Preserve Source Port
#     ${new_label}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${POLICY_V4V6_POLICY_EDIT_CHECKBOX_LABEL}    Preserve Source Port
#     ${status}=   run keyword and return status    checkbox should be selected    ${new_input}
#     run keyword if   "${status}"=="False" and "${preserve_source_port}"=="enable"   wait and click   ${new_label}
#     run keyword if   "${status}"=="True" and "${preserve_source_port}"=="disable"   wait and click   ${new_label}
#     wait and click    ${SUBMIT_OK_BUTTON}

# select Dynamic ippool in policy edit page
#     [Arguments]    ${ippool_name}
#     wait and click    ${POLICY_V4V6_IP_POOL_DYNAMIC_POOL_DIV}
#     Select Element in Selection Pane   ${ippool_name}
#     Close Selection Pane


Add Index to XPATH
    [Arguments]   ${xpath}    ${index}
    [Documentation]    This keyword add index to the end of a xpath
    ...    ${locator}: the original xpath;    ${index}: index of the matching xpath argument
    ...    ${full_xpath}:  will look like $xpath[$index]
    ${temp1} =   Catenate    SEPARATOR=  ${xpath}   [
    ${temp2} =   Catenate    SEPARATOR=  ${temp1}   ${index}
    ${full_xpath} =   Catenate    SEPARATOR=  ${temp2}   ]
    [return]    ${full_xpath}  

Verify Policy Order by ID
    [Arguments]   ${order_list}
    [Documentation]    This keyword verify if the displayed policy list order is the same as ${order_list}
    ...    ${order_list}: expected policy order, this order contains a list of policy id
    ${index}=    Set Variable    0
    :FOR    ${item}    IN    @{order_list}
    \    ${index}=    Evaluate    ${index} + 1
    \    ${locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_COLUMN_ID_SETTING}    policyid
    \    ${locator_with_index}=    Add Index to XPATH    ${locator}    ${index}
    #get text inside the Policy ID column and remove extra char. ex. \n and space
    \    ${return}=   Get Text    ${locator_with_index}
    \    ${return_text}=    Remove Extra Character in Text    ${return}
    \    Should Be True    "${return_text}"=="${item}"

Get Config by Column Name and Key
    [Arguments]   ${column_list}    ${key}    ${dictionary}    ${var_setting}
    [Documentation]    This keyword return the displayed text in request columns 
    ...    ${column_list}: a list of column names;    ${key}: key to indicate the request row  
    ...    ${dictionary}: maping of displayed column and column id;    ${var_setting}: locator for the specific column setting 
    ...    ${config_list}: a list of text displayed in the requested columns
    ${config_list}=   Create List    config
    :FOR    ${column_name}    IN    @{column_list}
    \    ${column_id}=    Get From Dictionary    ${dictionary}    ${column_name}   
    \    ${variable_list}=    Create List    ${key}    ${column_id}    
    \    ${locator}=    REPLACE PLACEHOLDERS IN LOCATOR WITH VALUE    ${var_setting}    ${variable_list}
    \    Press Down Key Until an Element is Visible    ${locator}
    \    ${return}=   Get Text    ${locator}
    \    ${return_text}=    Remove Extra Character in Text    ${return}
    \    Append To List    ${config_list}    ${return_text}	            
    [return]    ${config_list} 

Get Policy Config by Column Name and Policy ID    
    [Arguments]   ${column_list}    ${policy_id} 
    [Documentation]    This keyword return the displayed text in request columns 
    ...    ${column_list}: a list of column names;    ${policy_id}: the policy id  
    ...    ${config_list}: a list of text displayed in the requested columns of the policy id
    ${config_list}=    Get Config by Column Name and Key    ${column_list}    ${policy_id}    ${D_POLICY_DISPLAY_NAME_TO_COLUMN_ID}    ${VAR_POLICY_V4V6_COLUMN_GENERAL_SETTING}            
    [return]    ${config_list}

Get Policy Config by Column Name and Policy NAME    
    [Arguments]   ${column_list}    ${policy_name}    ${consolidated}=NO
    [Documentation]    This keyword return the displayed text in request columns 
    ...    ${column_list}: a list of column names;    ${policy_name}: the policy name
    ...    ${config_list}: a list of text displayed in the requested columns of the policy name
    ${config_list}=    run keyword if    "${consolidated}"!="YES"     Get Config by Column Name and Key    ${column_list}    ${policy_name}    ${D_POLICY_DISPLAY_NAME_TO_COLUMN_ID}    ${VAR_POLICY_V4V6_COLUMN_GENERAL_SETTING_BY_NAME}
    ...      ELSE    Get Config by Column Name and Key    ${column_list}    ${policy_name}    ${D_CONSOLIDATED_POLICY_DISPLAY_NAME_TO_COLUMN_ID}    ${VAR_POLICY_V4V6_COLUMN_GENERAL_SETTING_BY_NAME}
    [return]    ${config_list}

Get Policy Security Profile Config by Policy NAME    
    [Arguments]   ${security_profile_list}    ${policy_name}   
    ${config_list}=   Create List
    ${loactor_list}=   create list   ${policy_name}   profile
    ${locator_header}=   REPLACE PLACEHOLDERS IN LOCATOR WITH VALUE   ${VAR_POLICY_V4V6_COLUMN_GENERAL_SETTING_BY_NAME}   ${loactor_list}
    :FOR    ${profile_name}    IN    @{security_profile_list}
    \    ${lower_name}=    Get From Dictionary    ${D_POLICY_DISPLAY_SECURITY_PROFILE_TO_ICON}    ${profile_name}
    \    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_COLUMN_SETTING_SECURITY_PROFILE}    ${lower_name}
    \    ${new_locator}=   Catenate   SEPARATOR=   ${locator_header}    ${new_locator}
    \    ${exist}=   run keyword and return status   wait until element is visible   ${new_locator} 
    \    ${config}=  run keyword if    ${exist}    GET TEXT    ${new_locator}    ELSE    set variable   disable
    \    Append To List    ${config_list}     ${profile_name}:${config}
    [return]    ${config_list}

test if ippool exist in nat column
    [Arguments]       ${policy_name}    ${ippol_name}=Enabled
    ${config_list}=   Create List
    ${loactor_list}=   create list   ${policy_name}   poolname
    ${locator_header}=   REPLACE PLACEHOLDERS IN LOCATOR WITH VALUE   ${VAR_POLICY_V4V6_COLUMN_GENERAL_SETTING_BY_NAME}   ${loactor_list}
    :FOR    ${name}    IN    @{ippol_name}
    \    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_COLUMN_SETTING_IPPOOL_NAME}   ${name}
    \    ${new_locator}=   Catenate   SEPARATOR=   ${locator_header}    ${new_locator}
    \    wait until element is visible   ${new_locator} 

Policy Displayed on Cloumn Should be The Same
    [Arguments]   ${column_list}    ${policy_id_1}    ${policy_id_2}
    [Documentation]    This keyword verfiy if two policies display the same text in certain column
    ...    ${column_list}: a list of column names
    ${config_list_1}=    Get Policy Config by Column Name and Policy ID    ${column_list}    ${policy_id_1}
    ${config_list_2}=    Get Policy Config by Column Name and Policy ID    ${column_list}    ${policy_id_2}
    Lists Should Be Equal    ${config_list_1}    ${config_list_2}


Check Policy Exists or Not by ID
    [Arguments]   ${policy_id}    ${exist}=YES
    View By Sequence
    ${policy_in_table}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_ID_COLUMN}    ${policy_id}
    Run Keyword If    "${exist}"=="YES"     Wait Until Element Is Visible    ${policy_in_table}
    ...    ELSE    Wait Until Element Is Not Visible    ${policy_in_table}

Check Policy Exists or Not in Interface Pair View
    [Documentation]    Check Policy in Interface Pair View by it's src/dst interface and number of pairs.
    ...    when ${exist} is not "YES", ${count} doesn't work
    [Arguments]    ${from}    ${to}    ${count}=NONE    ${exist}=YES
    View By Interface Pair View
    ${values}=    Run Keyword If    "${exist}"=="YES"     Create List    ${from}    ${to}    ${count}
    ...    ELSE    Create List    ${from}    ${to}
    ${interface_pair_label}=    Run Keyword If    "${exist}"=="YES"     REPLACE PLACEHOLDERS IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_VIEW_PAIR_TOGGLE_LABEL}   ${values} 
    ...    ELSE         REPLACE PLACEHOLDERS IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_VIEW_PAIR_TOGGLE_LABEL_NO_COUNT}   ${values} 
    Run Keyword If    "${exist}"=="YES"     Wait Until Element Is Visible    ${interface_pair_label}
    ...    ELSE    Wait Until Element Is Not Visible    ${interface_pair_label}

# Select a policy by its ID and Click Edit
# ipv4, ipv6, NAT64, NAT46 and multicast have the same xpath. use one function to handle both.
Edit Policy By ID on Policy list
    [Arguments]   ${policy_id}
    Click Policy By ID on Policy List    ${policy_id}
    Click Edit Button on Policy List

Click Policy By ID on Policy List
    [Arguments]   ${policy_id}
    View By Sequence
    ${policy_in_table}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_NAME_BY_ID_COLUMN}    ${policy_id}
    Click Element    ${policy_in_table}
    Wait Until Element Is Visible    xpath://div[contains(@class,"selected")]//div[@column-id="policyid"]
    Mouse Out    ${policy_in_table}    #this is to avoid tooltips making the edit button not visible

Edit Policy By NAME on Policy list
    [Arguments]   ${policy_name}    ${consolidated}
    Click Policy By NAME on Policy List    ${policy_name}    ${consolidated}
    Click Edit Button on Policy List

Click Policy By NAME on Policy List
    [Arguments]   ${policy_name}    ${consolidated}
    run keyword if     "${consolidated}"!="YES"     View By Sequence
    ${policy_in_table}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_NAME_BY_NAME_COLUMN}    ${policy_name}
    Click Element    ${policy_in_table}
    Wait Until Element Is Visible    xpath://div[contains(@class,"selected")]//div[@column-id="name"]
    Mouse Out    ${policy_in_table}    #this is to avoid tooltips making the edit button not visible

Right Click Policy By ID on Policy List
    [Arguments]   ${policy_id}
    View By Sequence
    ${policy_in_table}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_NAME_BY_ID_COLUMN}    ${policy_id}
    Open Context Menu    ${policy_in_table}
    Wait Until Element Is Visible    ${POLICY_V4V6_CONTEXT_MENU}

Right Click Policy Column By ID on Policy List
    [Documentation]   This keyword it to select a column on policy list, and right click it
    ...               should find the column_id from webpage and add it for a new column that not involved in this keyword
    [Arguments]   ${policy_id}   ${column}
    View By Sequence
    ${column_id}=    SET Variable If    "${column}"=="NAT"    poolname
    ${column_id}=    SET Variable If    "${column}"=="Action"    action    ${column_id}
    @{list}=    create list    ${policy_id}    ${column_id}
    ${column_in_table}=    REPLACE PLACEHOLDERS IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_NAME_BY_ID_AND_COLUMN}    ${list}
    Open Context Menu    ${column_in_table}
    Wait Until Element Is Visible    ${POLICY_V4V6_CONTEXT_MENU}

#Drag and Drop keyword in SeleniumLibrary does not work with reorderable mutable
#Ues mouse keyword to simulate the operation
#Note: Because each policy has different height according to its configuration. Sometime mouse move has one policy difference.
Drag And Drop Policy
    [Arguments]   ${current_id}    ${target_id}
    ${policy}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_ID_COLUMN}    ${current_id}
    ${target}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_ID_COLUMN}    ${target_id}
    Click Policy By ID on Policy List     ${current_id}
    SeleniumLibrary.Mouse Down    ${policy}
    SeleniumLibrary.Mouse Over    ${target}
    SeleniumLibrary.Mouse up    ${policy}
    sleep    1s
    Wait Until Element Is Visible    ${POLICY_V4V6_NOTIFY_MSG_SAVED}    

Click Button in Context Menu
    [Arguments]   ${button_name}
    ${button_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_CONTEXT_MENU_BUTTON}    ${button_name}
    Wait Until Element Is Visible    ${button_locator}
    Click Button    ${button_locator}

Mouse Over Button in Context Menu
    [Arguments]   ${button_name}
    ${button_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_CONTEXT_MENU_BUTTON}    ${button_name}
    Wait Until Element Is Visible    ${button_locator}
    Mouse Over    ${button_locator}  

Click Button in Context Submenu
    [Documentation]   This keyword it to select a submenu bar, and click a button belong to the bar
    ...               should find the "f-menu-item-submenu" from webpage as submenu_id and add it for a new column that not involved in this keyword
    [Arguments]   ${submenu}    ${button_name}
    ${submenu_id}=    SET Variable If    "${submenu}"=="Insert Empty Policy"    insertSubmenu
    ${submenu_id}=    SET Variable If    "${submenu}"=="Paste"    pasteSubmenu    ${submenu_id}
    ${submenu_id}=    SET Variable If    "${submenu}"=="NAT"    natSubmenu    ${submenu_id}
    ${list}=    create list    ${submenu_id}    ${button_name}
    ${button_locator}=    REPLACE PLACEHOLDERS IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_CONTEXT_MENU_POLICY_SUBMENU}    ${list}
    #Run Keyword If    "${submenu}"=="Paste"    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_CONTEXT_MENU_PASTE_SUBMENU}    ${button_name}
    #...                          ELSE IF    "${submenu}"=="Insert Empty Policy"    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_CONTEXT_MENU_INSERT_POLICY_SUBMENU}    ${button_name}
    Click Button    ${button_locator} 

Copy Policy And Paste Above 
    [Arguments]   ${policy_id}
    Right Click Policy By ID on Policy List    ${policy_id}
    Click Button in Context Menu    Copy
    Right Click Policy By ID on Policy List    ${policy_id}
    Mouse Over Button in Context Menu    Paste
    Click Button in Context Submenu    Paste    Above 
    Wait Until Element Is Visible    ${POLICY_V4V6_NOTIFY_MSG_SAVED}

Copy Policy And Paste Below
    [Arguments]   ${policy_id}
    Right Click Policy By ID on Policy List    ${policy_id}
    Click Button in Context Menu    Copy
    Right Click Policy By ID on Policy List    ${policy_id}
    Mouse Over Button in Context Menu    Paste
    Click Button in Context Submenu    Paste    Below
    Wait Until Element Is Visible    ${POLICY_V4V6_NOTIFY_MSG_SAVED}

Insert Empty Policy Above
    [Arguments]   ${policy_id}
    Right Click Policy By ID on Policy List    ${policy_id}
    Mouse Over Button in Context Menu    Insert Empty Policy
    Click Button in Context Submenu    Insert Empty Policy   Above
    Wait Until Element Is Visible    ${POLICY_V4V6_NOTIFY_MSG_SAVED}

Insert Empty Policy Below 
    [Arguments]   ${policy_id}
    Right Click Policy By ID on Policy List    ${policy_id}
    Mouse Over Button in Context Menu    Insert Empty Policy
    Click Button in Context Submenu    Insert Empty Policy    Below
    Wait Until Element Is Visible    ${POLICY_V4V6_NOTIFY_MSG_SAVED} 
      

Delete Button Should be Disabled for Policy ID
    [Arguments]   ${policy_id}
    Click Policy By ID on Policy List    ${policy_id}
    Element Attribute Value Should Be    ${POLICY_V4V6_DELETE_BUTTON}    disabled    true
    Right Click Policy By ID on Policy List    ${policy_id}
    ${delete_button}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_CONTEXT_MENU_BUTTON}    Delete Policy
    Element Attribute Value Should Be    ${delete_button}    disabled    true
    Close Context Menu on Policy List   

#Close context menu by clicking the policy menu
Close Context Menu on Policy List
    SeleniumLibrary.Mouse Down    ${MENU_POLICY_AND_OBJECT}    # this is just to get ride of the context menu
    SeleniumLibrary.Mouse Up    ${MENU_POLICY_AND_OBJECT}    # this is just to get ride of the context menu
    Wait Until Element Is not Visible    xpath://div[@ng-controller="PolicyListMenuItems" and ./div//div[span="Policy Status"]]     

# Click By Sequence button on the policy list
# ipv4, ipv6, NAT64, NAT46 and multicast have the same xpath. use one function to handle both.
View By Sequence
    Wait Until Element Is Visible    ${POLICY_V4V6_VIEW_SEQUENCE_BUTTON}
    Click Button    ${POLICY_V4V6_VIEW_SEQUENCE_BUTTON}
    Wait Until Element Is Visible    ${POLICY_V4V6_VIEW_SEQUENCE_BUTTON_SELECTED}

# Click Interface Pair View button on the policy list
# ipv4, ipv6, NAT64, NAT46 and multicast have the same xpath. use one function to handle both.
View By Interface Pair View
    Wait Until Element Is Visible    ${POLICY_V4V6_VIEW_PAIR_BUTTON}
    Click Button    ${POLICY_V4V6_VIEW_PAIR_BUTTON}
    Wait Until Element Is Visible    ${POLICY_V4V6_VIEW_PAIR_BUTTON_SELECTED}        

# ipv4, ipv6, NAT64, NAT46 and multicast have the same xpath. use one function to handle both.
Click Create New Button on Policy List
    Click Button    ${GENERAL_LIST_CREATE_NEW_BUTTON}
    Wait Until Element Is Visible    ${POLICY_V4V6_POLICY_H1}
    Wait Until Element Is Visible    ${POLICY_V4V6_ACTION_ACCEPT_LABEL}

# ipv4, ipv6, NAT64, NAT46 and multicast have the same xpath. use one function to handle both.
Click Edit Button on Policy List
    Wait Until Element Is Visible    ${POLICY_V4V6_EDIT_BUTTON_E}
    Click Button    ${POLICY_V4V6_EDIT_BUTTON_E}
    Wait Until Element Is Visible    ${POLICY_V4V6_POLICY_H1_EDIT}
    Wait Until Element Is Visible    ${POLICY_V4V6_ACTION_ACCEPT_LABEL}
    
# ipv4 and ipv6 have the same xpath. use one function to handle both.
Click Policy Lookup Button on Policy List
    Wait Until Element Is Visible    ${POLICY_V4V6_POLICY_LOOKUP_BUTTON}
    Click Element    ${POLICY_V4V6_POLICY_LOOKUP_BUTTON}
    Wait Until Element Is Visible    ${POLICY_V4V6_POLICY_LOOKUP_H1} 
    Wait Until Element Is Visible    ${POLICY_V4V6_POLICY_LOOKUP_BUTTON_SEARCH}

# ipv4 and ipv6 have the same xpath. use one function to handle both.
Click Search Button on Policy Lookup
    Click Element    ${POLICY_V4V6_POLICY_LOOKUP_BUTTON_SEARCH}
    Wait Until Page Does Not Contain     ${POLICY_V4V6_POLICY_LOOKUP_DIV}
    Wait Until Element Is Visible    ${POLICY_V4V6_TABLE_NAME}

Click Cancel Button on Policy Lookup
    Click Element    ${POLICY_V4V6_POLICY_LOOKUP_BUTTON_CANCEL}
    Wait Until Page Does Not Contain     ${POLICY_V4V6_POLICY_LOOKUP_DIV}
    Wait Until Element Is Visible    ${POLICY_V4V6_TABLE_NAME}

Search Policy Entry With Search Field
    [Arguments]    ${text}
    wait and click   ${POLICY_V4V6_POLICY_SEARCH_INPUT}    
    input text   ${POLICY_V4V6_POLICY_SEARCH_INPUT}    ${text}
    wait and click    ${POLICY_V4V6_POLICY_SEARCH_BUTTON}


Verify Matched Policy in Policy Lookup
    [Arguments]   ${src_intf}    ${protocol}    ${protocol_number}    ${src_ip}    ${src_port}    ${dest_ip}    ${dest_port}    ${matched_policy_id}
    Click Policy Lookup Button on Policy List
    Select Source Intf on Policy Lookup    ${src_intf}
    Select From List By Value    ${POLICY_V4V6_POLICY_LOOKUP_PROTOCOL}    ${protocol}  
    Run Keyword If    "${protocol}" == "tcp" or "${protocol}" == "udp"    policy lookup tcp or udp    ${src_ip}    ${src_port}    ${dest_ip}    ${dest_port}
    ...    ELSE IF    "${protocol}" == "ip"    policy lookup ip     ${protocol_number}     ${src_ip}    ${dest_ip}
    ...    ELSE IF    "${protocol}" == "ICMP ping request" or "${protocol}" == "ICMPv6 ping request"    policy lookup icmp ping request     ${src_ip}    ${dest_ip}
    Click Search Button on Policy Lookup
    Run Keyword If    "${matched_policy_id}" == "NO"    policy lookup no matched    ${src_intf}    ${dest_ip}    
    ...       ELSE    policy lookup matched    ${matched_policy_id}    
     
policy lookup no matched
    [Arguments]   ${src_intf}    ${dest_ip}
    Wait Until Element Is Visible    ${POLICY_V4V6_POLICY_LOOKUP_NO_MATCH_MSG}
    Wait Until Element Contains    ${POLICY_V4V6_POLICY_LOOKUP_NO_MATCH_MSG}    Policy lookup matches the implicit deny policy.
    Wait Until Element Contains    ${POLICY_V4V6_POLICY_LOOKUP_NO_MATCH_MSG}    No explicit policy exists from source interface "${src_intf}" to destination interface
    Wait Until Element Contains    ${POLICY_V4V6_POLICY_LOOKUP_NO_MATCH_MSG}    determined by a route lookup to "${dest_ip}"

policy lookup matched
    [Arguments]   ${matched_policy_id}
    ${selected_policy}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_V4V6_POLICY_LOOKUP_LOCATED_POLICY}    ${matched_policy_id}
    Wait Until Page Contains Element    ${selected_policy}
    Wait Until Element Is Visible    ${selected_policy}   

policy lookup tcp or udp
    [Arguments]   ${src_ip}    ${src_port}    ${dest_ip}    ${dest_port}
    Input Text    ${POLICY_V4V6_POLICY_LOOKUP_SOURCE}    ${src_ip}
    Input Text    ${POLICY_V4V6_POLICY_LOOKUP_SOURCE_PORT}     ${src_port}
    Input Text    ${POLICY_V4V6_POLICY_LOOKUP_DESTINATION}    ${dest_ip}
    Input Text    ${POLICY_V4V6_POLICY_LOOKUP_DESTINATION_PORT}    ${dest_port}

policy lookup ip
    [Arguments]   ${protocol_number}    ${src_ip}    ${dest_ip}
    Input Text    ${POLICY_V4V6_POLICY_LOOKUP_PROTOCOL_NUMBER}    ${protocol_number}
    Input Text    ${POLICY_V4V6_POLICY_LOOKUP_SOURCE}    ${src_ip}
    Input Text    ${POLICY_V4V6_POLICY_LOOKUP_DESTINATION}    ${dest_ip}    

policy lookup icmp ping request
    [Arguments]   ${src_ip}    ${dest_ip}
    Input Text    ${POLICY_V4V6_POLICY_LOOKUP_SOURCE}    ${src_ip}
    Input Text    ${POLICY_V4V6_POLICY_LOOKUP_DESTINATION}    ${dest_ip}   


Select Source Intf on Policy Lookup
    [Arguments]    ${setting}
    Click Element    ${POLICY_V4V6_POLICY_LOOKUP_SRC_INTF}  
    ${selection_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_V4V6_POLICY_LOOKUP_SRC_INTF_SELECTION}    ${setting}
    Wait Until Element Is Visible    ${selection_locator}  
    Click Element    ${selection_locator}
    ${setting_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_V4V6_POLICY_LOOKUP_SRC_INTF_ITEM}    ${setting}
    Wait Until Element Is Visible    ${setting_locator}  

# following policies have the same xpath. Can use this function
# ipv4, ipv6
Change Action to Deny on Policy Editor
    Click Element    ${POLICY_V4V6_ACTION_DENY_LABEL}
    Wait Until Element Is Not Visible    ${POLICY_V4V6_POLICY_NETWORK_H2}
    Wait Until Element Is Not Visible    ${POLICY_V4V6_POLICY_UTM_H2}

# following policies have the same xpath. Can use this function
# ipv4, ipv6
Change Action to Accept on Policy Editor
    Click Element    ${POLICY_V4V6_ACTION_ACCEPT_LABEL}
    Wait Until Element Is Visible    ${POLICY_V4V6_POLICY_NETWORK_H2}
    Wait Until Element Is Visible    ${POLICY_V4V6_POLICY_UTM_H2}

# following policies have the same xpath. Can use this function
# ipv4, ipv6
Change IP Pool to Dynamic Pool on Policy Editor
    Click Element    ${POLICY_V4V6_IP_POOL_DYNAMIC_POOL_LABEL}
    Element Attribute Value Should Be    ${POLICY_V4V6_IP_POOL_DYNAMIC_POOL_INPUT}    checked    true

# following policies have the same xpath. Can use this function
# ipv4, ipv6
Change IP Pool to Interface IP on Policy Editor
    Click Element    ${POLICY_V4V6_IP_POOL_INTF_LABEL}
    Element Attribute Value Should Be    ${POLICY_V4V6_IP_POOL_INTF_INPUT}    checked    true     

# following policies have the same xpath. Can use this function
# ipv4, ipv6
Change Log to ALL on Policy Editor
    Click Element    ${POLICY_V4V6_LOG_ALL_LABEL}
    Element Attribute Value Should Be    ${POLICY_V4V6_LOG_ALL_INPUT}    checked    true

# following policies have the same xpath. Can use this function
# ipv4, ipv6
Change Log to UTM on Policy Editor
    Click Element    ${POLICY_V4V6_LOG_UTM_LABEL}
    Element Attribute Value Should Be    ${POLICY_V4V6_LOG_UTM_INPUT}    checked    true        

# following policies have the same xpath. Can use this function
# ipv4, ipv6, NAT64, NAT46, multicast and shaping policy have the same xpath. use one function to handle both.
Click Cancel Button on Policy Editor
    Click Button    ${GENERAL_EDITOR_CANCEL_BUTTON}
    Wait Until Element Is Visible    ${POLICY_V4V6_TABLE_ACTION}

# following policies have the same xpath. Can use this function
# ipv4, ipv6, NAT64, NAT46, multicast and shaping policy have the same xpath. use one function to handle both.
Click Ok Button on Policy Editor
    Click Button    ${GENERAL_EDITOR_OK_BUTTON}
    Wait Until Element Is Visible    ${POLICY_V4V6_TABLE_ACTION}

# ipv4 and ipv6 have the same xpath. use one function to handle both.
# this function is to check the current setting in the selection field
# design for those attributes formate as "attribute name: checkbox: selection". for example, traffic shaper, profile group...
Verify Setting By Attribute on Policy Editor
    [Arguments]    ${attribute}    ${setting}
    ${attribute_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_DIV_LIST_SELECTION}    ${attribute}
    Wait Until Element Contains    ${attribute_locator}    ${setting}

# ipv4 and ipv6 have the same xpath. use one function to handle both.
# this function is to check the current settings (one or more than one) in the selection field
Verify Settings By locator on Policy Editor
    [Arguments]    ${selection_locator}    ${list}    
    :FOR    ${item}    IN    @{list}
    \    Wait Until Element Contains    ${selection_locator}    ${item}

Select from List on Policy Editor
    [Arguments]    ${attribute}    ${setting}
    ${attribute_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_DIV_LIST_PLACEHOLDER}    ${attribute}
    Wait Until Element Is Visible    ${attribute_locator}
    Click Element    ${attribute_locator}
    ${setting_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_DIV_LIST_ITEM}    ${setting}
    Wait Until Element Is Visible    ${setting_locator}
    Click Element    ${setting_locator}    
    Wait Until Element Is Visible    ${attribute_locator}
    Verify Setting By Attribute on Policy Editor    ${attribute}    ${setting}

select or unselect address from slide in window
    [Arguments]    ${address_type}    ${name}    ${multiple_tab}=YES    ${operation}=Select
    #click tab to choose address type
    Wait Until Element Is Visible    ${POLICY_V4V6_ENTRY_ADDRESS_LIST}
    Run Keyword If    "${address_type}"=="ADDRESS" and "${multiple_tab}"=="YES"    Click Element    ${POLICY_V4V6_ENTRY_ADDRESS_TAB}
    ...    ELSE IF    "${address_type}"=="USER" and "${multiple_tab}"=="YES"    Click Element    ${POLICY_V4V6_ENTRY_USER_TAB}
    ...    ELSE IF    "${address_type}"=="GROUP" and "${multiple_tab}"=="YES"    Click Element    ${POLICY_V4V6_ENTRY_USER_TAB}
    ...    ELSE IF    "${address_type}"=="ADDRESS" and "${multiple_tab}"=="NO"    Log    Add Destination Address in IPV6 Policy
    ...    ELSE    Fail    wrong address type, it should be one of ADDRESS, USER, GROUP

    #replace locator variables with real entries.
    ${locator_entry}=    Run Keyword If    "${address_type}"=="ADDRESS"    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_ADDRESS_IN_SELECT_ENTRY}    ${name}
    ...    ELSE IF    "${address_type}"=="USER"    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_USER_IN_SELECT_ENTRY}    ${name}
    ...    ELSE IF    "${address_type}"=="GROUP"    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_GROUP_IN_SELECT_ENTRY}    ${name}
    ...    ELSE    Fail    wrong address type, it should be one of ADDRESS, USER, GROUP
    #choose entry
    run keyword if    "${address_type}"=="ADDRESS"    Click Element    ${locator_entry}
    ...    ELSE IF    "${address_type}"=="USER"    Click Element    ${locator_entry}
    ...    ELSE IF    "${address_type}"=="GROUP"    Click Element    ${locator_entry}
    ...    ELSE    Fail    wrong address type, it should be one of ADDRESS, USER, GROUP
    #move out of selected entry, to avoid to be obscured by bubble message.
    Mouse Out    ${POLICY_V4V6_SELECTION_PANE_DIV}
    #make user it's Selected or Unselected
    ${locator_address_in_div}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_ADDRESS_IN_DIV}    ${name}
    Run Keyword If    "${operation}" == "Select"    Wait Until Element Is Visible    ${locator_address_in_div}
    ...    ELSE IF    "${operation}" == "Unselect"    Wait Until Element Is Not Visible    ${locator_address_in_div}
    ...    ELSE    Fail    wrong operation type, it should be Select or Unselect

check if address exist or not on Policy Editor
    [Arguments]     ${direction}    ${addr_list}     ${exist}
    :FOR    ${address}    IN    @{addr_list}
    \       @{split_addr}=    Split String    ${address}    :    1
    \    ${locator_address_in_div}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_ADDRESS_IN_DIV_${direction}}    @{split_addr}[1]
    \    Run Keyword If    "${exist}" == "EXIST"    Wait Until Element Is Visible    ${locator_address_in_div}
    \    ...    ELSE IF    "${exist}" == "NOT EXIST"    Wait Until Element Is Not Visible    ${locator_address_in_div}
    \    ...    ELSE    Fail    wrong operation type, it should be Select or Unselect

Select or Unselect Address on Policy Editor
    [Arguments]    ${direction}    ${addr_list}    ${operation}
    [Documentation]    ${direction} could be "Source", "Destination" and "Destination Address"
    ...    ${addr_list} could be a list of ADDRESS/USER/GROUP combination. for example: @{source_addresses}    ADDRESS:all    USER:local
    Run Keyword If    "${direction}" == "Source"    Click Element    ${POLICY_V4V6_SOURCE_DIV}
    ...    ELSE    Click Element    ${POLICY_V4V6_DESTINATION_DIV}
    Wait Until Element Is Visible    ${POLICY_V4V6_SELECTION_PANE_H1}
    :FOR    ${address}    IN    @{addr_list}
    \    @{split_addr}=    Split String    ${address}    :    1
    \    Run Keyword If    "${direction}" == "Destination Address" and "${operation}" == "Select"    select or unselect address from slide in window     @{split_addr}[0]    @{split_addr}[1]    NO    Select    #ipv6 dst addr does not have multiple tab
    \    ...    ELSE IF    "${direction}" == "Destination Address" and "${operation}" == "Unselect"    select or unselect address from slide in window     @{split_addr}[0]    @{split_addr}[1]    NO    Unselect
    \    ...    ELSE IF    "${operation}" == "Select"    select or unselect address from slide in window     @{split_addr}[0]    @{split_addr}[1]    YES    Select
    \    ...    ELSE IF    "${operation}" == "Unselect"    select or unselect address from slide in window     @{split_addr}[0]    @{split_addr}[1]    YES    Unselect
    \    ...    ELSE    Fail    wrong operation type, it should be Select or Unselect        
    click button    ${POLICY_V4V6_ENTRY_CLOSE_BUTTON}

Select Address on Policy Editor
    [Arguments]    ${direction}    ${addr_list}
    Select or Unselect Address on Policy Editor    ${direction}    ${addr_list}    Select

Unselect Address on Policy Editor
    [Arguments]    ${direction}    ${addr_list}
    Select or Unselect Address on Policy Editor    ${direction}    ${addr_list}    Unselect         

Select or Unselect Service on Policy Editor
    [Arguments]    ${service_list}    ${operation}    
    Click Element    ${POLICY_V4V6_SERVICE_DIV}
    Wait Until Element Is Visible    ${POLICY_V4V6_SERVICE_ENTRY_LIST}
    :FOR    ${service}    IN    @{service_list}
    \    ${locator_service_in_list}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_SERVICE_ENTRY_IN_LIST}    ${service}
    \    wait until element is visible    ${locator_service_in_list}
    \    click element    ${locator_service_in_list} 
    \    ${locator_service_in_div}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_SERVICE_IN_DIV}    ${service}
    \    Run Keyword If    "${operation}" == "Select"    Wait Until Element Is Visible    ${locator_service_in_div}
    \    ...    ELSE IF    "${operation}" == "Unselect"    Wait Until Element Is Not Visible    ${locator_service_in_div}
    \    ...    ELSE    Fail    wrong operation type, it should be Select or Unselect       
    Click Button    ${POLICY_V4V6_ENTRY_CLOSE_BUTTON}

Select Service on Policy Editor
    [Arguments]    ${service_list}   
    Select or Unselect Service on Policy Editor    ${service_list}    Select

Unselect Service on Policy Editor
    [Arguments]    ${service_list}   
    Select or Unselect Service on Policy Editor    ${service_list}    Unselect

check service exist or not on Policy Editor
    [Arguments]    ${service_list}     ${exist}
    :FOR    ${service}    IN    @{service_list}
    \    ${locator_service_in_div}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_SERVICE_IN_DIV}    ${service}
    \    Run Keyword If    "${exist}" == "EXIST"    Wait Until Element Is Visible    ${locator_service_in_div}  
    \    ...    ELSE IF    "${exist}" == "NOT EXIST"    Wait Until Element Is Not Visible    ${locator_service_in_div}

# Keyword "Unselect Checkbox" does not work on Policy Editor. Use javascript to do the job
Unselect Checkbox by JS on Policy Editor
    [Arguments]    ${name}    ${checkbox_id}    ${checkbox_xpath}    ${with_list}=YES
    ${selected}    ${result}=    Run Keyword And Ignore Error    Checkbox Should Be Selected    ${checkbox_xpath}
    Run Keyword If    "${selected}" == "PASS"  Execute Javascript    document.getElementById('${checkbox_id}').click()
    Checkbox Should Not Be Selected    ${checkbox_xpath}
    ${setting_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_DIV_LIST_SELECTION}    ${name}
    Run Keyword If    "${with_list}" == "YES"    Wait Until Element Is Not Visible    ${setting_locator}   

# Keyword "Select Checkbox" does not work on Policy Editor. Use javascript to do the job
Select Checkbox by JS on Policy Editor
    [Arguments]    ${name}    ${checkbox_id}    ${checkbox_xpath}    ${with_list}=YES
    ${unselected}    ${result}=    Run Keyword And Ignore Error    Checkbox Should Not Be Selected    ${checkbox_xpath}
    Run Keyword If    "${unselected}" == "PASS"  Execute Javascript    document.getElementById('${checkbox_id}').click()
    Checkbox Should Be Selected    ${checkbox_xpath}
    ${setting_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_DIV_LIST_SELECTION}    ${name}
    Run Keyword If    "${with_list}" == "YES"    Wait Until Element Is Visible    ${setting_locator}

# Verify that a element is not visible in the slide in selection pane
Check Element Visibility in Selection Pane
    [Arguments]    ${list}    ${visibility}    ${existing_item}
    [Documentation]    ${visibility} could be YES or NO
    ...   ${existing_item} is an item that is showing in the list, this is to guarantee that the list is loaded successfully
    Wait Until Element Is Visible    ${POLICY_V4V6_SELECTION_PANE_H1}
    Wait Until Element Is Visible    ${POLICY_V4V6_SELECTION_PANE_LIST}
    run keyword if    '${existing_item}'!='NA'    Wait Until Element Is Visible    ${existing_item}         
    :FOR    ${item}    IN    @{list}
    #\    ${item_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_SELECTION_PANE_ITEM}    ${item}
    #\    Element Should Not Be Visible    ${item_locator}  
    \    ${item_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_SELECTION_PANE_ITEM}    ${item}
    \    run keyword if    "${visibility}"=="YES"    Wait Until Element Is Visible    ${item_locator}
    \    ...    ELSE IF    "${visibility}"=="NO"    Wait Until Element Is Not Visible    ${item_locator}
    
Select Element in Selection Pane
    [Arguments]    ${list}  
    Wait Until Element Is Visible    ${POLICY_V4V6_SELECTION_PANE_H1}
    Wait Until Element Is Visible    ${POLICY_V4V6_SELECTION_PANE_LIST}
    :FOR    ${item}    IN    @{list}
    \    ${item_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_SELECTION_PANE_ITEM}    ${item}
    \    Click Element    ${item_locator}         

Close Selection Pane
    Click Element    ${POLICY_V4V6_SELECTION_PANE_CLOSE}
    Wait Until Page Does Not Contain    ${POLICY_V4V6_SELECTION_PANE_H1}
    Wait Until Page Does Not Contain    ${POLICY_V4V6_SELECTION_PANE_LIST}

Verify Address Visibility in policy editor
    [Arguments]       ${type}    ${test_list}    ${visibility}    ${policy_type}=V4V6
    [Documentation]    ${type} could be "Source Address" and "Destination Address"
    ${type_1}=   run keyword and return status   should contain   ${type}   Source
    ${type_2}=   run keyword and return status   should contain   ${type}   Destination
    run keyword if    ${type_1}    Click Element    ${POLICY_${policy_type}_SOURCE_DIV}
    ...    ELSE IF    ${type_2}    Click Element    ${POLICY_${policy_type}_DESTINATION_DIV}
    ...    ELSE    Fail    wrong type    
    sleep    2
    Check Element Visibility in Selection Pane    ${test_list}    ${visibility}    ${POLICY_V4V6_ADDRESS_NONE_IN_SELECT_ENTRY} 
    click button    ${POLICY_V4V6_ENTRY_CLOSE_BUTTON}

Verify Interface Visibility in policy editor
    [Arguments]       ${type}    ${test_list}    ${visibility}    ${policy_type}=V4V6
    [Documentation]    ${type} could be "Income" and "Outgo"
    ...                ${policy_type} should be V4V6, ACL, NAT64, NAT46, MULTICAST, SHAPING
    ${policy_type}=    Convert To Uppercase    ${policy_type}
    ${type}=    Convert To Uppercase    ${type}
    ${type_1}=   run keyword and return status   should contain   ${type}   INCOM
    ${type_2}=   run keyword and return status   should contain   ${type}   OUTGO
    run keyword if    ${type_1}    Click Element    ${POLICY_${policy_type}_INCOMING_INTERFACE_DIV}
    ...    ELSE IF    ${type_2}    Click Element    ${POLICY_${policy_type}_OUTGOING_INTERFACE_DIV}
    ...    ELSE    Fail    wrong type    
    :FOR    ${item}    IN    @{test_list}
    \    ${mebu_bar}=     REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_SELECT_INTERFACE_MEMBER_MENU_BAR}    ${item}
    \    ${item_bar}=     REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_SELECTION_PANE_ITEM}    ${item}
    \    ${mebu_bar}=     Set Variable if    "${policy_type}"=="SHAPING"    ${item_bar}    ${mebu_bar}
    \    run keyword if    "${visibility}"=="YES"    Wait Until Element Is Visible    ${mebu_bar}
    \    ...    ELSE IF    "${visibility}"=="NO"    Wait Until Element Is Not Visible    ${mebu_bar}
    Click Element    ${MENU_DROPDOWN_SELECTION}

##Policy & Objects ->IPv6 Policy##
Go to IPv6 policy
    Wait Until Element Is Visible    ${MENU_POLICY_IPV6_POLICY}
    click element    ${MENU_POLICY_IPV6_POLICY}
    Wait Until Element Is Visible    ${POLICY_V4V6_TABLE}

select address to policy6
    [Arguments]    ${address_type}    ${name}
    #click tab to choose address type
    run keyword if    "${address_type}"!="NONE"    Wait Until Element Is Visible    ${POLICY_V4V6_ENTRY_ADDRESS_TAB}
    ...    ELSE    Wait Until Element Is Visible    ${POLICY_IPV6_ENTRY_LIST_SPAN}
    sleep    5
    run keyword if    "${address_type}"=="ADDRESS"    click element    ${POLICY_V4V6_ENTRY_ADDRESS_TAB}
    ...    ELSE IF    "${address_type}"=="USER"    click element    ${POLICY_V4V6_ENTRY_USER_TAB}
    ...    ELSE IF    "${address_type}"=="GROUP"    click element    ${POLICY_V4V6_ENTRY_USER_TAB}
    ...    ELSE IF    "${address_type}"=="NONE"    log    do nothing
    ...    ELSE    Fail    wrong address type, it should be one of ADDRESS, USER, GROUP
    #replace locator variables with real entries.
    ${locator_entry}=    run keyword if    "${address_type}"=="ADDRESS"    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_ADDRESS_IN_SELECT_ENTRY}    ${name}
    ...    ELSE IF    "${address_type}"=="USER"    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_USER_IN_SELECT_ENTRY}    ${name}
    ...    ELSE IF    "${address_type}"=="GROUP"    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_GROUP_IN_SELECT_ENTRY}    ${name}
    ...    ELSE IF    "${address_type}"=="NONE"    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_IPV6_DES_ADDRESS_IN_SELECT_ENTRY}    ${name}
    ...    ELSE    Fail    wrong address type, it should be one of ADDRESS, USER, GROUP

    #choose entry
    run keyword if    "${address_type}"=="ADDRESS"    click element    ${locator_entry}
    ...    ELSE IF    "${address_type}"=="USER"    click element    ${locator_entry}
    ...    ELSE IF    "${address_type}"=="GROUP"    click element    ${locator_entry}
    ...    ELSE IF    "${address_type}"=="NONE"    click element    ${locator_entry}
    ...    ELSE    Fail    wrong address type, it should be one of ADDRESS, USER, GROUP
    #move out of selected entry, to avoid to be obscured by bubble message.
    Mouse Out    ${POLICY_V4V6_SELECTION_PANE_DIV}
    #make user it's Selected
    ${locator_address_in_div}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_ADDRESS_IN_DIV}    ${name}
    Wait Until Element Is Visible    ${locator_address_in_div}


##Policy & Objects ->Local In Policy##
Go to Local In Policy
    Wait Until Element Is Visible    ${MENU_POLICY_LOCAL_IN_POLICY}
    Click Element    ${MENU_POLICY_LOCAL_IN_POLICY}
    Select Frame    ${POLICY_OBJECT_FRAME}    
    Wait Until Element Is Visible    ${POLICY_LOCAL_IN_H}
    Wait Until Element Is Visible    ${POLICY_LOCAL_IN_TABLE_APP}   

Open All Local In Policy Sections
    Open Local In Policy Section By Name    Administrative Access
    Open Local In Policy Section By Name    Default
    Open Local In Policy Section By Name    Networking & Routing
    Open Local In Policy Section By Name    Other
    Open Local In Policy Section By Name    System
    Open Local In Policy Section By Name    VPN

Open Local In Policy Section By Name
    [Arguments]   ${name}=Administrative Access
    #ipv4 section
    ${section_toggle_button}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_LOCAL_IN_TOGGLE_BUTTON}    ${name}
    ${toggle_open}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_LOCAL_IN_TOGGLE_OPEN}    ${name}
    #click the toggle only when it exists
    ${toggle_exist}    ${result}=    Run Keyword And Ignore Error    Wait Until Page Contains Element    ${section_toggle_button}
    Run Keyword If    "${toggle_exist}" == "PASS"  click toggle when it exists   ${toggle_open}    ${section_toggle_button}    


##Configure Policy Table Columns
Select Policy Table Columns
    [Documentation]    Select Columns specified by argument ${column_name}, which is list of all columns name user want to select
    ...    All other columns that are not specified will be removed.
    [Arguments]    ${column_names}    ${ip_version}=4    ${by_sequence}=${True}
    @{column_from_to}=    Run keyword if    ${by_sequence}    create list    From    To
    ...    ELSE    create list  
    #bug 0546953 
    #    @{all_columns_4_vm}=    Create List    Log    Bytes    Action    Active Sessions    Application Control    AV    Comments    Destination
    #...    Destination Address    DNS Filter    First Used    @{column_from_to}    Groups    Hit Count    ID    Inspection Mode    IPS    Last Used    Name
    #...    NAT    Packets    Profile Group    Protocol Options    Schedule    Security Profiles    Service    Software Bytes
    #...    Software Packets    Source    Source Address    SPU Bytes    SPU Packets    SSL Inspection    Status    Users    VPN Tunnel
    #...    Web Filter
    #@{all_columns_4}=    Create List    Log    Bytes    Action    Active Sessions    Application Control    AV    Comments    Destination
    #...    Destination Address    DNS Filter    First Used    @{column_from_to}    Groups    Hit Count    ID    Inspection Mode    IPS    Last Used    Name
    #...    NAT    nTurbo Bytes    nTurbo Packets    Packets    Profile Group    Protocol Options    Schedule    Security Profiles    Service    Software Bytes
    #...    Software Packets    Source    Source Address    SPU Bytes    SPU Packets    SSL Inspection    Status    Users    VPN Tunnel
    #...    Web Filter
    #@{all_columns_6_vm}=    Create List    Log    Bytes    Action    Active Sessions    Application Control    AV    Comments
    #...    Destination Address    DNS Filter    First Used    @{column_from_to}    Groups    Hit Count    ID    Inspection Mode    IPS    Last Used    Name
    #...    NAT    Packets    Profile Group    Protocol Options    Schedule    Security Profiles    Service    Software Bytes
    #...    Software Packets    Source    Source Address    SPU Bytes    SPU Packets    SSL Inspection    Status    Users    VPN Tunnel
    #...    Web Filter
    #bug 0546953 
    #@{all_columns_6}=    Create List    Log    Bytes    Action    Active Sessions    Application Control    AV    Comments
    #...    Destination Address    DNS Filter    First Used    @{column_from_to}    Groups    Hit Count    ID    Inspection Mode    IPS    Last Used    Name
    #...    NAT    nTurbo Bytes    nTurbo Packets    Packets    Profile Group    Protocol Options    Schedule    Security Profiles    Service    Software Bytes
    #...    Software Packets    Source    Source Address    SPU Bytes    SPU Packets    SSL Inspection    Status    Users    VPN Tunnel
    #...    Web Filter   
    @{all_columns_4_vm}=    Create List    Log    Bytes    Action    Active Sessions    Application Control    AV    Comments    Destination
    ...    Destination Address    DNS Filter    First Used    @{column_from_to}    Groups    Hit Count    ID    Inspection Mode    IPS    Last Used    Name
    ...    NAT    Packets    Protocol Options    Schedule    Security Profiles    Service    Software Bytes
    ...    Software Packets    Source    Source Address    SPU Bytes    SPU Packets    SSL Inspection    Status    Users    VPN Tunnel
    ...    Web Filter
    @{all_columns_4}=    Create List    Log    Bytes    Action    Active Sessions    Application Control    AV    Comments    Destination
    ...    Destination Address    DNS Filter    First Used    @{column_from_to}    Groups    Hit Count    ID    Inspection Mode    IPS    Last Used    Name
    ...    NAT    nTurbo Bytes    nTurbo Packets    Packets    Protocol Options    Schedule    Security Profiles    Service    Software Bytes
    ...    Software Packets    Source    Source Address    SPU Bytes    SPU Packets    SSL Inspection    Status    Users    VPN Tunnel
    ...    Web Filter 
    @{all_columns_6_vm}=    Create List    Log    Bytes    Action    Active Sessions    Application Control    AV    Comments
    ...    Destination Address    First Used    @{column_from_to}    Groups    Hit Count    ID    Inspection Mode    IPS    Last Used    Name
    ...    NAT    Packets    Protocol Options    Schedule    Security Profiles    Service    Software Bytes
    ...    Software Packets    Source    Source Address    SPU Bytes    SPU Packets    SSL Inspection    Status    Users    VPN Tunnel
    ...    Web Filter
    @{all_columns_6}=    Create List    Log    Bytes    Action    Active Sessions    Application Control    AV    Comments
    ...    Destination Address    First Used    @{column_from_to}    Groups    Hit Count    ID    Inspection Mode    IPS    Last Used    Name
    ...    NAT    nTurbo Bytes    nTurbo Packets    Packets    Protocol Options    Schedule    Security Profiles    Service    Software Bytes
    ...    Software Packets    Source    Source Address    SPU Bytes    SPU Packets    SSL Inspection    Status    Users    VPN Tunnel
    ...    Web Filter
    
    @{all_columns}=    Run keyword if    "${ip_version}"=="6" and "${FGT_HW_SIZE}"=="VM"   set variable    ${all_columns_6_vm}
    ...    ELSE IF    "${ip_version}"=="6" and "${FGT_HW_SIZE}"!="VM"    set variable    ${all_columns_6}
    ...    ELSE IF    "${ip_version}"=="4" and "${FGT_HW_SIZE}"=="VM"    set variable    ${all_columns_4_vm}
    ...    ELSE IF    "${ip_version}"=="4" and "${FGT_HW_SIZE}"!="VM"    set variable    ${all_columns_4}

    wait until element is visible    ${POLICY_V4V6_TABLE_HEADER_FIRST_DIV}
    Mouse Over    ${POLICY_V4V6_TABLE_HEADER_FIRST_DIV}
    wait until element is visible    ${POLICY_V4V6_POLICY_CONFIGURE_TABLE_BUTTON}
    click button    ${POLICY_V4V6_POLICY_CONFIGURE_TABLE_BUTTON}
    sleep    1
    wait until element is visible    ${POLICY_V4V6_POLICY_CONFIGURE_TABLE_DIV}
    ${length}=    Get Length    ${all_columns}
    :FOR    ${index}    IN RANGE    ${length}
    \    ${column_name}=    set variable    @{all_columns}[${index}]
    \    ${locator_column_button}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_POLICY_CONFIGURE_TABLE_ITEM_BUTTON}    ${column_name}
    \    wait until element is visible    ${locator_column_button}
    \    ${if_selected}=    if column is Selected    ${column_name}
    \    ${if_need_to_select}=    Run keyword and return status    List Should contain Value    ${column_names}    ${column_name}
    \    Run keyword if    "${if_selected}"!="${if_need_to_select}"    click button    ${locator_column_button}
    ${if_disabled}=    Get Element Attribute    ${POLICY_V4V6_POLICY_CONFIGURE_TABLE_APPLY_BUTTON}    disabled
    Run keyword if    "${if_disabled}"!="disabled"    Click button    ${POLICY_V4V6_POLICY_CONFIGURE_TABLE_APPLY_BUTTON}
    ...    ELSE    Click button    ${POLICY_V4V6_POLICY_CONFIGURE_TABLE_CANCEL_BUTTON}

Reset Policy Table Columns
    [Documentation]    Select Columns specified by argument ${column_name}, which is list of all columns name user want to select
    ...    All other columns that are not specified will be removed.
    wait until element is visible    ${POLICY_V4V6_TABLE_HEADER_FIRST_DIV}
    Mouse Over    ${POLICY_V4V6_TABLE_HEADER_FIRST_DIV}
    wait until element is visible    ${POLICY_V4V6_POLICY_CONFIGURE_TABLE_BUTTON}
    click button    ${POLICY_V4V6_POLICY_CONFIGURE_TABLE_BUTTON}
    sleep    1
    wait until element is visible    ${POLICY_V4V6_POLICY_CONFIGURE_TABLE_DIV}
    wait until element is visible    ${POLICY_V4V6_POLICY_CONFIGURE_TABLE_RESET_BUTTON}
    Click button    ${POLICY_V4V6_POLICY_CONFIGURE_TABLE_RESET_BUTTON}

if column is Selected
    [Documentation]    Judge if the column has been selected in Configure Table Context Menu
    [Arguments]    ${column_name}
    ${locator_column}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_POLICY_CONFIGURE_TABLE_ITEM_ICON}    ${column_name}
    wait until element is visible    ${locator_column}
    ${icon_class}=    Get Element Attribute    ${locator_column}    class
    ${status}=    Run keyword and return status    Should Be True    "${icon_class}"=="fa-apply"
    [Return]    ${status}

Check If Columns are Displayed in Policy Table
    [Documentation]    Columns specified by argument ${column_name}. Check if the columns are displayed in Policy Table
    [Arguments]    ${column_names}    ${ip_version}=4
    ${length}=    Get Length    ${column_names}
    :FOR    ${index}    IN RANGE    ${length}
    \    ${column_name}=    Set variable    @{column_names}[${index}]
    \    ${if_displayed}=    Check If Column is Displayed in Policy Table    ${column_name}   ${ip_version}
    \    Return From Keyword If    not ${if_displayed}    ${False}
    Return From Keyword    ${True}

Check If Columns are Not Displayed in Policy Table
    [Documentation]    Columns specified by argument ${column_name}. Check if the columns are not displayed in Policy Table
    [Arguments]    ${column_names}    ${ip_version}=4
    ${length}=    Get Length    ${column_names}
    :FOR    ${index}    IN RANGE    ${length}
    \    ${column_name}=    Set variable    @{column_names}[${index}]
    \    ${if_displayed}=    Check If Column is Displayed in Policy Table    ${column_name}   ${ip_version}
    \    Return From Keyword If    ${if_displayed}    ${False}
    Return From Keyword    ${True}

Check If Column is Displayed in Policy Table
    [Documentation]    Columns specified by argument ${column_name}. Check if the column is displayed in Policy Table
    [Arguments]    ${column_name}    ${ip_version}=4
    ${locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_TABLE_HEADER}    ${column_name}
    ${if_displayed}=    Run keyword and Return status    wait until Page contains element    ${locator}
    [Return]    ${if_displayed}


Set Policy Column Filter
    [Documentation]    Apply Filter to Policy Column
    ...    Args:
    ...    1. column_name can be one of all columns: Log    Bytes    Action    Active Sessions    Application Control    AV    Comments    Destination
    ...    Destination Address    Devices    DNS Filter    First Used    From    Groups    Hit Count    ID    IPS    Last Used    Name
    ...    NAT    nTurbo Bytes    nTurbo Packets    Packets    Profile Group    Schedule    Security Profiles    Service    Software Bytes
    ...    Software Packets    Source    Source Address    SPU Bytes    SPU Packets    SSL Inspection    Status    To    Users    VPN Tunnel
    ...    Web Filter
    ...
    ...    2. ip_version: IP Address type, it can be 4 or 6.
    ...    3. filter_dict: dictionary of filters, keys of items contain "filter_type", "operator" and "value" as below:
    ...        a. filter_type: 2 types of filter "number" and "string" are supported by now. More types will be supported in the future.
    ...        b. operator: when filter_type is number, the operator can be "=", ">=", "<=" and "Range"; when filter_type is string, the operator can be
    ...        "Contains", "Does Not Contain" and "Regex".
    ...        c. value: value of filter that is applied by operator.
    ...        d. set_method: Method of how to set value. It can be "text" or "list". There are two methods: input text or select item from list.
    [Arguments]    ${column_name}    ${ip_version}=4    &{filter_dict}
    ${locator_column}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_TABLE_HEADER}    ${column_name}
    Wait Until Element is visible    ${locator_column}
    Mouse Over    ${locator_column}
    ${locator_column_filter_button}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_TABLE_HEADER_FILTER_BUTTON}    ${column_name}
    Wait Until Element is visible    ${locator_column_filter_button}
    Click Button      ${locator_column_filter_button}
    sleep    1s
    Wait Until Element is visible    ${POLICY_V4V6_TOOLTIPS}
    ${filter_type}=    Get From Dictionary    ${filter_dict}    filter_type
    ${operator}=    Get From Dictionary    ${filter_dict}    operator
    ${value}=    Get From Dictionary    ${filter_dict}    value
    ${set_method}=    Get From Dictionary    ${filter_dict}    set_method
    Run keyword if    "${filter_type}"=="number"    Apply numerical filter to Policy Column    ${operator}    ${value}    ${set_method}
    ...    ELSE IF        "${filter_type}"=="string"    Apply string filter to Policy Column    ${operator}    ${value}    ${set_method}
    ...    ELSE    FAIL    Unknown filter type

Set Policy Interface Pair Filter
    [Documentation]    Apply Interface Pair Filter to Policy Interface Pair
    ...    Args:
    ...    1. ip_version: IP Address type, it can be 4 or 6.
    ...    2. filter_dict: dictionary of filters, keys of items contain "filter_type", "operator" and "value" as below:
    ...        a. operator: the operator can be "Contains", "Does Not Contain" and "Regex".
    ...        b. from: source interface name.
    ...        c. to: destination interface name.
    ...        d. set_method: Method of how to set value. It can be "text" or "list". There are two methods: input text or select item from list.
    [Arguments]    ${ip_version}=4    &{filter_dict}
    Wait Until Element is visible    ${POLICY_V4V6_VIEW_PAIR_TOGGLE_FIRST_LABEL}
    Mouse Over    ${POLICY_V4V6_VIEW_PAIR_TOGGLE_FIRST_LABEL}
    Wait Until Element is visible    ${POLICY_V4V6_VIEW_PAIR_TOGGLE_FILTER_BUTTON_ON_FIRST_LABEL}
    Click Button      ${POLICY_V4V6_VIEW_PAIR_TOGGLE_FILTER_BUTTON_ON_FIRST_LABEL}
    sleep    1s
    Wait Until Element is visible    ${POLICY_V4V6_TOOLTIPS}
    ${operator}=    Get From Dictionary    ${filter_dict}    operator
    ${from}=    Get From Dictionary    ${filter_dict}    from
    ${to}=    Get From Dictionary    ${filter_dict}    to
    ${set_method}=    Get From Dictionary    ${filter_dict}    set_method
    Apply Interface Pair filter to Policy    ${operator}    ${from}    ${to}    ${set_method}

Remove Policy Column Filters
    [Documentation]    Remove Filters on Policy Column
    [Arguments]    ${column_name}
    ${locator_column}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_TABLE_HEADER}    ${column_name}
    Wait Until Element is visible    ${locator_column}
    Mouse Over    ${locator_column}
    ${locator_column_filter_button}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_TABLE_HEADER_FILTER_BUTTON}    ${column_name}
    Wait Until Element is visible    ${locator_column_filter_button}
    Click Button      ${locator_column_filter_button}
    sleep    1s
    Wait Until Element is visible    ${POLICY_V4V6_TOOLTIPS}
    Wait Until Element is visible    ${POLICY_V4V6_TABLE_HEADER_FILTER_REMOVE_BUTTON}
    Click Button    ${POLICY_V4V6_TABLE_HEADER_FILTER_REMOVE_BUTTON}
    sleep    1s

apply numerical filter to Policy Column
    [Arguments]    ${operator}    ${value}    ${set_method}
    select filter tab    ${operator}
    Wait Until Element is visible    ${POLICY_V4V6_TABLE_HEADER_FILTER_INPUT}
    input text    ${POLICY_V4V6_TABLE_HEADER_FILTER_INPUT}    ${value}
    Click Button    ${POLICY_V4V6_TABLE_HEADER_FILTER_APPLY_BUTTON}

apply string filter to Policy Column
    [Arguments]    ${operator}    ${value}    ${set_method}
    select filter tab    ${operator}
    ${locator_filter_item}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_TABLE_HEADER_FILTER_ITEM_BUTTON}    ${value}
    Run keyword if    "${set_method}"=="text"    Wait Until Element is visible    ${POLICY_V4V6_TABLE_HEADER_FILTER_INPUT}
    Run keyword if    "${set_method}"=="list"    Wait Until Element is visible    ${locator_filter_item}
    Run keyword if    "${set_method}"=="text"    input text    ${POLICY_V4V6_TABLE_HEADER_FILTER_INPUT}    ${value}
    Run keyword if    "${set_method}"=="list"    Click Button    ${locator_filter_item}
    Click Button    ${POLICY_V4V6_TABLE_HEADER_FILTER_APPLY_BUTTON}

apply Interface Pair filter to Policy
    [Arguments]    ${operator}    ${from}    ${to}    ${set_method}
    select filter tab    ${operator}
    ${value_list}=    create list    ${from}    ${to}
    ${value}=    Run keyword if    "${operator}"!="Regex"    Set Variable     ${from} →${to}
    ...    ELSE    set variable    ${from}
    ${locator_filter_item}=    REPLACE PLACEHOLDERS IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_INTERFACE_PAIR_FILTER_ITEM_BUTTON}    ${value_list}
    Run keyword if    "${set_method}"=="text"    Wait Until Element is visible    ${POLICY_V4V6_TABLE_HEADER_FILTER_INPUT}
    Run keyword if    "${set_method}"=="list"    Wait Until Element is visible    ${locator_filter_item}
    Run keyword if    "${set_method}"=="text"    input text    ${POLICY_V4V6_TABLE_HEADER_FILTER_INPUT}    ${value}
    Run keyword if    "${set_method}"=="list"    Click Button    ${locator_filter_item}
    Click Button    ${POLICY_V4V6_TABLE_HEADER_FILTER_APPLY_BUTTON}

Remove Policy Interface Pair Filters
    [Documentation]    Remove Interface Pair Filters on Policy Interface Pair
    Wait Until Element is visible    ${POLICY_V4V6_VIEW_PAIR_TOGGLE_FIRST_LABEL}
    Mouse Over    ${POLICY_V4V6_VIEW_PAIR_TOGGLE_FIRST_LABEL}
    Wait Until Element is visible    ${POLICY_V4V6_VIEW_PAIR_TOGGLE_FILTER_BUTTON_ON_FIRST_LABEL}
    Click Button      ${POLICY_V4V6_VIEW_PAIR_TOGGLE_FILTER_BUTTON_ON_FIRST_LABEL}
    sleep    1s
    Wait Until Element is visible    ${POLICY_V4V6_TOOLTIPS}
    Wait Until Element is visible    ${POLICY_V4V6_TABLE_HEADER_FILTER_REMOVE_BUTTON}
    Click Button    ${POLICY_V4V6_TABLE_HEADER_FILTER_REMOVE_BUTTON}
    sleep    1s

Get Filter Text from Policy Filter by Order Number
    [Documentation]    Get Item Text name from Policy Filter Item according to the order number.
    ...    order_number starts from 1.
    [Arguments]    ${column_name}    ${order_number}
    ${locator_column}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_TABLE_HEADER}    ${column_name}
    Wait Until Element is visible    ${locator_column}
    Mouse Over    ${locator_column}
    ${locator_column_filter_button}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_TABLE_HEADER_FILTER_BUTTON}    ${column_name}
    Wait Until Element is visible    ${locator_column_filter_button}
    Click Button      ${locator_column_filter_button}
    sleep    1s
    Wait Until Element is visible    ${POLICY_V4V6_TOOLTIPS}
    ${filter_button}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_TABLE_HEADER_FILTER_ITEM_BUTTON_BY_ORDER}    ${order_number}
    Wait Until Element is visible    ${filter_button}
    Wait Until Element is visible    ${filter_button}/div/div/div//span
    ${filter_text}=    Get Text    ${filter_button}/div/div/div//span
    Click Button    ${POLICY_V4V6_TABLE_HEADER_FILTER_APPLY_BUTTON}    
    [Return]    ${filter_text}

select filter tab
    [Arguments]    ${tab_name}
    ${if_selected}=    if Filter tab is selected    ${tab_name}
    ${locator_column_filter_tab}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_TABLE_HEADER_FILTER_TAB}    ${tab_name}
    Run keyword if   not ${if_selected}     Wait Until Element is visible     ${locator_column_filter_tab}
    Run keyword if   not ${if_selected}     Click button    ${locator_column_filter_tab}

if Filter tab is selected
    [Arguments]    ${tab_name}
    ${locator_column_filter_selected_tab}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_TABLE_HEADER_FILTER_TAB_SELECTED}    ${tab_name}
    ${if_selected}=    Run keyword and return status    Wait Until Element is visible    ${locator_column_filter_selected_tab}    3s
    [Return]    ${if_selected}

get wildcard fqdn list from cli
    @{cmd_list}=   create list    config vdom    edit ${FW_TEST_VDOM_NAME_1}    config firewall wildcard-fqdn custom    show | grep edit
    @{responses}=   Execute CLI commands on FortiGate Via Terminal Server   ${cmd_list}
    ${resonse}=   SET VARIABLE   @{responses}[-1]
    ${wildcard}=    Get Regexp Matches   ${resonse}    g-.+[^\"\\s]
    [Return]   ${wildcard}


####### VWP policy   ####
create vwp policy
    [Arguments]   ${vwp_name}    ${policy_name}    
    ...    ${source_addresses}    ${destination_addresses}
    ...    ${schedule}    ${service}    ${action}    ${direction}=bi    ${inspection_mode}=Flow-based   ${protocol_option}=default
    ...    ${security_profile}=NONE    ${ip_version}=4    ${consolidated}=NO
    [Documentation]    possible item of list @{incoming}/@{outgoing}: port1,port8,mgmt1,mgmt2,any and SSL-VPN tunnel interface (ssl.root)
    ...    format and meaning of source/destination ip address:
    ...    ADDRESS:all--->ADDRESS indicates this is an address, and "all" is the address name
    ...    USER:test--->USER indicates this is a user, and test is the user name
    ...    GROUP:testgrp---->GROUP indicates this is a group, and testgrp is the group name
    ...    Direction:   left   right   bi
    clean same name vwp policy and click create new    ${vwp_name}    ${policy_name}    ${consolidated}
    set general config to vwp policy      ${policy_name}    ${schedule}    ${service}    ${action}    ${direction}   
    ...    ${inspection_mode}   ${protocol_option}   ${security_profile}
    set address to policy    ${source_addresses}    ${destination_addresses}    ${ip_version}
    click button    ${GENERAL_EDITOR_OK_BUTTON}
    deal with certificate warning and verify if policy created    ${policy_name}    ${consolidated}

edit vwp policy
    [Arguments]    ${vwp_name}    ${policy_name}    ${policy_name_new}    
    ...    ${source_addresses}    ${destination_addresses}
    ...    ${schedule}    ${service}    ${action}    ${direction}=bi    ${inspection_mode}=Flow-based   ${protocol_option}=default
    ...    ${security_profile}=NONE    ${ip_version}=4    ${consolidated}=NO
    wait and click    ${POLICY_VWP_PAIR_SELECT_MENU}
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${POLICY_VWP_PAIR_SELECT_MENU_BAR}    ${vwp_name}
    wait and click    ${new_locator}
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${POLICY_VWP_PAIR_SELECTED}    ${vwp_name}
    Wait Until Element Is Visible    ${new_locator}
    Edit Policy By NAME on Policy list    ${policy_name}    ${consolidated}
    set general edit config to vwp policy      ${policy_name_new}    ${schedule}    ${service}    ${action}    ${direction}
    ...    ${inspection_mode}   ${protocol_option}   ${security_profile}
    set address to policy    ${source_addresses}    ${destination_addresses}    ${ip_version}
    click button    ${GENERAL_EDITOR_OK_BUTTON}
    deal with certificate warning and verify if policy created    ${policy_name_new}    ${consolidated}

clean same name vwp policy and click create new
    [Arguments]   ${vwp_name}    ${policy_name}    ${consolidated}
    wait and click    ${POLICY_VWP_PAIR_SELECT_MENU}
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${POLICY_VWP_PAIR_SELECT_MENU_BAR}    ${vwp_name}
    wait and click    ${new_locator}
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${POLICY_VWP_PAIR_SELECTED}    ${vwp_name}
    Wait Until Element Is Visible    ${new_locator}
    ## create policy for the vwp
    Wait Until Element Is Visible    ${GENERAL_LIST_CREATE_NEW_BUTTON}
    ${status}=    if ip policy exists    ${policy_name}    ${consolidated}
    run keyword if    "${status}"=="True"     delete ip policy    ${policy_name}
    click button    ${GENERAL_LIST_CREATE_NEW_BUTTON}

set general config to vwp policy
    [Arguments]     ${policy_name}
    ...    ${schedule}    ${service}    ${action}    ${direction}    ${inspection_mode}    ${protocol_option}    ${security_profile}
    ## select vwp and check if it has been select ##
    Wait Until Element Is Visible    ${POLICY_V4V6_POLICY_H1}
    Wait Until Element Is Visible    ${POLICY_V4V6_NAME_TEXT}
    input text    ${POLICY_V4V6_NAME_TEXT}    ${policy_name}
    
    ## direction ##
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${POLICY_VWP_DIRECTION_LABEL}   ${direction}
    wait and click    ${new_locator}

    # #config schedule:
    # click element    ${POLICY_V4V6_SCHEDULE_DIV}
    # ${locator_schedule_in_dropdown}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_SCHEDULE_IN_DROPDOWN}    ${schedule}   
    # wait until element is visible    ${locator_schedule_in_dropdown}
    # click element    ${locator_schedule_in_dropdown}
    # ${locator_schedule_in_div}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_SCHEDULE_IN_DIV}    ${schedule} 
    # wait until element is visible    ${locator_schedule_in_div}

    #set service
    click element    ${POLICY_V4V6_SERVICE_DIV}
    Wait Until Element Is Visible    ${POLICY_V4V6_SERVICE_ENTRY_LIST}
    ${locator_service_in_list}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_SERVICE_ENTRY_IN_LIST}    ${service}
    wait until element is visible    ${locator_service_in_list}
    click element    ${locator_service_in_list}
    click button    ${POLICY_V4V6_ENTRY_CLOSE_BUTTON}
    ${locator_service_in_div}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_SERVICE_IN_DIV}    ${service}    
    wait until element is visible    ${locator_service_in_div}

    #set action
    run keyword if    "${action}"=="DENY"    click element    ${POLICY_V4V6_ACTION_DENY_LABEL}
    ...    ELSE    click element    ${POLICY_V4V6_ACTION_ACCEPT_LABEL}
    run keyword if    "${action}"=="ACCEPT"    set accept action based features in vwp policy editing   ${inspection_mode}   ${protocol_option}   ${security_profile}

set accept action based features in vwp policy editing
    [Arguments]    ${inspection_mode}   ${protocol_option}   ${security_profile}
    ## set inspection mode  
    set inspection mode in policy edit page    ${inspection_mode}
    ##  set protocol_option
    set protocol options in policy edit page    ${protocol_option}
    ###   set security profiles  ###
    run keyword if    "${security_profile}"!="NONE"     set security profiles to policy4    ${security_profile}

set general edit config to vwp policy
    [Arguments]    ${policy_name}
    ...    ${schedule}    ${service}    ${action}    ${direction}    ${inspection_mode}   ${protocol_option}   ${security_profile}
    Wait Until Element Is Visible    ${POLICY_V4V6_POLICY_H1_EDIT}
    Wait Until Element Is Visible    ${POLICY_V4V6_NAME_TEXT}
    clear element text    ${POLICY_V4V6_NAME_TEXT}
    input text    ${POLICY_V4V6_NAME_TEXT}    ${policy_name}

    ## direction ##
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${POLICY_VWP_DIRECTION_LABEL}   ${direction}
    wait and click    ${new_locator}
    sleep   2

    remove element config in policy editing    Source
    remove element config in policy editing    Destination
    
    # #config schedule:
    # click element    ${POLICY_V4V6_SCHEDULE_DIV}
    # ${locator_schedule_in_dropdown}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_SCHEDULE_IN_DROPDOWN}    ${schedule}   
    # wait until element is visible    ${locator_schedule_in_dropdown}
    # click element    ${locator_schedule_in_dropdown}
    # ${locator_schedule_in_div}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_SCHEDULE_IN_DIV}    ${schedule} 
    # wait until element is visible    ${locator_schedule_in_div}

    #set service
    remove element config in policy editing    Service
    click element    ${POLICY_V4V6_SERVICE_DIV}
    Wait Until Element Is Visible    ${POLICY_V4V6_SERVICE_ENTRY_LIST}
    ${locator_service_in_list}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_SERVICE_ENTRY_IN_LIST}    ${service}
    wait until element is visible    ${locator_service_in_list}
    click element    ${locator_service_in_list}
    click button    ${POLICY_V4V6_ENTRY_CLOSE_BUTTON}
    ${locator_service_in_div}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_SERVICE_IN_DIV}    ${service}    
    wait until element is visible    ${locator_service_in_div}

    #set action
    run keyword if    "${action}"=="DENY"    click element    ${POLICY_V4V6_ACTION_DENY_LABEL}
    ...    ELSE    click element    ${POLICY_V4V6_ACTION_ACCEPT_LABEL}
    
    run keyword if    "${action}"=="ACCEPT"    set accept action based features in vwp policy editing   ${inspection_mode}   ${protocol_option}   ${security_profile}
