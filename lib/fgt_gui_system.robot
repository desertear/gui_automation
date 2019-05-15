*** Settings ***
Documentation     This file contains FortiGate GUI System Feature operation

*** Keywords ***
#### base config ###
Go to Global
    Wait Until Element Is Visible    ${system_vdommenu_drop_down_button}
    click Element    ${system_vdommenu_drop_down_button}
    sleep    2
    Wait Until Element Is Visible    ${system_vdommenu_drop_down_menu_Global}
    click Element    ${system_vdommenu_drop_down_menu_Global}
    sleep    2

Go to Security Profiles
    Wait Until Element Is Visible    ${ SECURITY PROFILES_ENTRY}
    ${nav_bar_is_not_expanded}=    run keyword and return status    Wait Until Page Contains Element    ${ SECURITY PROFILES_ENTRY}//following-sibling::f-icon[@class="fa-angle-right rotate-0"]
    run keyword if    "${nav_bar_is_not_expanded}"=="True"    click element    ${ SECURITY PROFILES_ENTRY}
    sleep    2

##Firmware##
Go to Firmware
    Wait Until Element Is Visible    ${SYSTEM_FIRMWARE_ENTRY}
    click element    ${SYSTEM_FIRMWARE_ENTRY}
    sleep    2

go to Login page
    [Documentation]    this keyword is for some case test about login page, just go to login page, you need input username manually
    [timeout]    ${FGT_KEYWORD_MAX_RUNNING_TIME}
    [Arguments]    ${url}=${FGT_URL}    ${browser}=${FGT_BROWSER}    ${alias}=None    ${username}=${FGT_GUI_USERNAME}    ${password}=${FGT_GUI_PASSWORD}
    ...    ${remote_url}=${FGT_REMOTE_URL}    ${desired_capabilities}=${FGT_DESIRED_CAPABILITIES}    ${ff_profile_dir}=${FGT_FF_PROFILE_DIR}
    ###
    ${browser_index}=    open browser    ${url}    browser=${browser}    alias=${alias}
    ...    remote_url=${remote_url}    desired_capabilities=${desired_capabilities}    ff_profile_dir=${ff_profile_dir}
    Maximize Browser Window
    get all selenium config
    ${window_width}    ${window_height}=    Get Window Size
    ${page_width}    ${page_height}=    Get Element Size    xpath:/html
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${LOGIN_USERNAME_TEXT}

go to dashboard
    Wait Until Element Is Visible    ${SYSTEM_DASHBOARD_ENTRY} 
    ${nav_bar_is_not_expanded}=    run keyword and return status    Wait Until Page Contains Element    ${SYSTEM_DASHBOARD_ENTRY}//following-sibling::f-icon[@class="fa-angle-right rotate-0"]
    run keyword if    "${nav_bar_is_not_expanded}"=="True"    click element    ${SYSTEM_DASHBOARD_ENTRY} 
    sleep    2

go to dashboard_main
    Wait Until Element Is Visible    ${SYSTEM_DASHBOARD_MAIN_ENTRY}
    click element    ${SYSTEM_DASHBOARD_MAIN_ENTRY}
    sleep    2

go to system_feature visibility
    Wait Until Element Is Visible    ${SYSTEM_Feature visibility_ENTRY}
    Click Element    ${SYSTEM_Feature visibility_ENTRY}
    sleep    2

Go to system_Settings
    Wait Until Element Is Visible    ${SYSTEM_SETTINGS_ENTRY}
    click element    ${SYSTEM_SETTINGS_ENTRY}
    sleep    2

Go to system_SNMP
    Wait Until Element Is Visible    ${SYSTEM_SNMP_ENTRY}
    click element    ${SYSTEM_SNMP_ENTRY}
    sleep    2

Go to system_Replacement_Messages
    Wait Until Element Is Visible    ${SYSTEM_RPLCE_MSG_ENTRY}
    click element    ${SYSTEM_RPLCE_MSG_ENTRY}
    sleep    2

Go to system_Tags
    Wait Until Element Is Visible    ${SYSTEM_TAG_ENTRY}
    click element    ${SYSTEM_TAG_ENTRY}
    sleep    2

Go to System_FortiGuard
    wait and click  ${System_Fortiguard}    
    sleep    2


Go to System_administrators
    wait and click    ${SYSTEM_ADMINISTRATORS_ENTRY}
    sleep    2


go to system_admin_profiles
    wait and click    ${SYSTEM_ADMIN_PROFILES_ENTRY}
    sleep    2


Go to system_advanced
    wait and click    ${SYSTEM_ADVANCED_ENTRY}
    sleep    2

Go to system_reputation
    wait and click    ${SYSTEM_REPUTATION_ENTRY}
    sleep    2

Go to system_VDOM
    wait and click    ${SYSTEM_VDOM_ENTRY}
    sleep    2

go to network_dns_server
    Wait Until Element Is Visible    ${NETWORK_DNS Servers_ENTRY} 
    click element    ${NETWORK_DNS Servers_ENTRY} 
    sleep    2


go to network_dns
    Wait Until Element Is Visible    ${NETWORK_DNS_ENTRY} 
    click element    ${NETWORK_DNS_ENTRY} 
    sleep    2


go to network_SDWAN
    wait and click    ${NETWORK_SDWAN_ENTRY}
    sleep    2


Go to network_Interfaces
    Wait Until Element Is Visible    ${NETWORK_INTERFACES_ENTRY}    10
    click element    ${NETWORK_INTERFACES_ENTRY}
    sleep    2


Go to network_packet_capture
  wait and click  ${NETWORK_PACKET_CAPTURE_ENTRY}
    sleep    2


Go to Policy_IPV4_VWP_Policy
  wait and click     ${POLICY_IPV4_VWP_ENTRY}
    sleep    2

Go to Policy_IPV6_VWP_Policy
  wait and click     ${POLICY_IPV6_VWP_ENTRY}
    sleep    2

Go to user and device_device_inventory
    wait and click   ${USER AND DEVICE_DEVICE_INVENTORY}
    sleep    2


Go to Monitor_dhcp
    wait and click    ${MONITOR_DHCP_ENTRY}
    sleep    2

Go to Monitor_firewall_user
    wait and click    ${MONITOR_FIREWALL_USER_ENTRY}
    sleep    2

Go to Log and Report_compliance
    wait and click    ${LOG_REPORT_COMPLIANCE_EVENTS_ENTRY} 
    sleep    2

######### MAIN BAR APPLICATIONS #######
wait and click
    [Arguments]    ${wait and click_button}
    Wait Until Element Is Visible     ${wait and click_button}
    sleep  2
    Click Element     ${wait and click_button}

set checkbox
    [Arguments]        ${enable}    ${chkbox_name}
    ${enable}=    Convert To lowercase    ${enable}
    ${new_input}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_GERERAL_CHKBOX_INPUT}    ${chkbox_name}
    ${new_label}=     REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_GERERAL_CHKBOX_LABEL}   ${chkbox_name}
    ${status}=    run keyword and return status    checkbox should be selected    ${new_input}
    run keyword if    "${status}"=="False" and "${enable}"=="enable"    wait and click    ${new_label}
    ...   ELSE IF     "${status}"=="True" and "${enable}"=="disable"    wait and click    ${new_label}
    ${status}=    run keyword and return status    checkbox should be selected    ${new_input}
    run keyword if    "${enable}"=="enable"    should be equal    "${status}"    "True"
    run keyword if    "${enable}"=="disable"    should be equal    "${status}"    "False"

popup embed console 
    Wait Until Element Is Visible     ${system_embed_console_button}
    Click Element     ${system_embed_console_button}
    sleep   2
    
go to embed console
    wait until element is visible     ${system_embed_slide_frame}
    select frame    ${system_embed_slide_frame}    
    wait until element is visible    ${system_embed_console_frame} 
    select frame    ${system_embed_console_frame}  
    sleep   2
    wait and click   ${SYSTEM_EMBED_CURSOR}
    sleep   2

close embed console
    Unselect Frame
    Click Button    ${system_embed_close_button}
    Wait Until Page Does Not Contain    ${system_embed_console_slider_area}

Verify Display in Embed Console
    [Arguments]   ${expect_list}
    go to embed console
    :FOR    ${line}    IN    @{expect_list}
    \    Element Should Contain    ${system_embed_console_content}    ${line}
    close embed console    

go_to_global_prompt
    [Arguments]    ${hostname}=${FGT_HOSTNAME} 
    [Documentation]  this keyword is to change the prompt to the top level in the embeded console
   :FOR    ${i}    IN RANGE    1    10
      \    ${prompt}    Get Text    ${system_embed_console_current_promt} 
      \    ${prompt_strip}    Strip String    ${prompt}
      \    ${hostname_strip}    Strip String     ${hostname}
      \    Exit For Loop if    '${prompt_strip}'== '${hostname_strip} #'
      \    typewrite    end\n

get system_time_in_main_widget
    ##redo get until get system time##
    :FOR    ${i}   IN RANGE   1     100
    \    ${time}=    Get Text     ${system_info_widget_system_time_value}   
    \    ${lenth}=   Get Length    ${time}
    \    EXIT FOR LOOP IF     ${lenth}>0
    [Return]    ${time}

set ntp listen on interface to 
    [Arguments]    ${interface}
    ${new_locator}=  REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_GERERAL_ADD_ENTRY_BUTTON}  Listen on Interfaces
    wait and click   ${new_locator}
    SELECT MENU BAR FROM POLICY SELECTION PANE    ${interface}

#### SYSTEM ####
##  ENABLE VDOM ####
SET VDOM ENABLE 
    [Arguments]    ${vdom}
    [Documentation]  this keyword it to enable a vdom on System Vdom page
    ${vdom_entry}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_VDOM_TABLE_ENTRY_DISABLED}      ${vdom}
    wait until element is visible    ${vdom_entry}
    OPEN CONTEXT MENU   ${vdom_entry}
    wait and click   ${SYSTEM_VDOM_TABLE_ENTRY_ENABLE_BUTTON}
    sleep   2


SET VDOM DISABLE 
    [Arguments]    ${vdom}
    [Documentation]  this keyword it to disable a vdom on System Vdom page
    ${vdom_entry}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_VDOM_TABLE_ENTRY}   ${vdom}
    wait until element is visible    ${vdom_entry}
    OPEN CONTEXT MENU   ${vdom_entry}
    wait and click   ${SYSTEM_VDOM_TABLE_ENTRY_DISABLE_BUTTON}
    sleep   2

DELETE VDOM
    [Arguments]    ${vdom}
    [Documentation]  this keyword it to enable a vdom on System Vdom page
    ${vdom_entry}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_VDOM_TABLE_ENTRY}      ${vdom}
    wait and click    ${vdom_entry}
    wait and click    ${SYSTEM_VDOM_DELETE_BUTTON}
    sleep   1
    unselect frame
    wait and click    ${CONFIRM_OK_BUTTON}
    sleep   2
    select frame    ${NETWORK_FRAME}
    
##### SYSTEM   ADMIN #####
Create Administrator
    [Arguments]      ${username}    ${password}    ${vdom}    ${admin_profile}=super_admin    ${none_vdom}=NO
    [Documentation]  this keyword is to create a admin for the fortigate, admin_profile should 
    ...              be the same words on the menu, such as "super_admin", vdom. If the forigate doesn't have vdom,
    ...              none_vdom should be set manually.
    wait and click    ${system_administrators_create new}
    ${admin_menu_bar}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_ADMINISTRATORS_CREATE_ADMINISTRATOR}    Administrator
    ##pop_up sometimes is not shown, and clicking "Create New" will go to edit page directly.
    ${if_pop_up}=    Run keyword and return status    Wait Until Element Is Visible     ${admin_menu_bar}
    Run keyword if    ${if_pop_up}    wait and click    ${admin_menu_bar}
    wait and click    ${system_administrators_edit_admin_username}
    clear element text   ${system_administrators_edit_admin_username}
    input text        ${system_administrators_edit_admin_username}   ${username}
    wait and click    ${system_administrators_edit_admin_password}
    input text        ${system_administrators_edit_admin_password}    ${password}
    wait and click    ${system_administrators_edit_admin_password_confirm}
    input text        ${system_administrators_edit_admin_password_confirm}    ${password}
    wait and click    ${system_administrators_edit_admin_admin_profile}
    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${system_administrators_edit_admin_admin_profile_select}    ${admin_profile}
    wait and click    ${new_locator}    
    ${super}=    run keyword and return status  should contain   ${admin_profile}   super_admin
    ${admmin_no_access}=    run keyword and return status  should contain   ${admin_profile}   admin_no_access
    ${novdom_admin}=    evaluate    ${super} or ${admmin_no_access}
    run keyword if    "${novdom_admin}"=="False" and "${none_vdom}"=="NO"    wait and click    ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_VDOM_DESELECT}
    run keyword if    "${novdom_admin}"=="False" and "${none_vdom}"=="NO"    Set Admin Vdom   ${vdom}
    wait and click    ${SUBMIT_OK_BUTTON}
    ## double check if the administrator has been created ####
    Open Toggle Button     System Administrator
    ${name_entry}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_ADMINISTRATORS_TABLE_NAME_ENTRY}    ${username}
    Wait Until Element Is Visible    ${name_entry}
    Close Toggle Button    System Administrator

Set Admin Vdom
    [Arguments]   ${vdom}
    :FOR   ${ELEMENT}    IN      @{vdom}
           \   ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SELECTION_SPAN_MENU_BAR}   ${ELEMENT}
           \   wait and click   ${new_locator}

Create Admin Profile
   [Arguments]   ${name}   ${access}=Read   ${time_out}=default
   [Documentation]  this keyword is to create an admin profile, access should be the same word as the menu such as 
   ...              "None"  "Read"   "Read/Write", Readonly if by default
   wait and click   ${SYSTEM_ADMINISTRATORS_CREATE NEW}
   sleep  2
   click element   ${SYSTEM_ADMIN_PROFILES_NAME_INPUT}
   clear element text     ${SYSTEM_ADMIN_PROFILES_NAME_INPUT}
   input text    ${SYSTEM_ADMIN_PROFILES_NAME_INPUT}    ${name} 
   wait and click    ${SYSTEM_ADMIN_PROFILES_ACCESS_PERMISSION_MENU}
   ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_ADMIN_PROFILES_ACCESS_PERMISSION_MENU_BAR}    ${access}
   wait and click     ${new_locator}
   ${default}=    run keyword and return status    should be equal   "${time_out}"     "default"
   ${status}=     run keyword and return status    checkbox should be selected    ${SYSTEM_ADMIN_PROFILES_OVERRIDE_IDEL_CHECKBOX}
   ${never}=      run keyword and return status    should be equal   "${time_out}"     "never"
   ${never_label}=    run keyword and return status    checkbox should be selected    ${SYSTEM_ADMIN_PROFILES_OVERRIDE_IDEL_NEVER_CHECKBOX}
   run key word if    "${default}"=="False" and "${status}"=="False"    wait and click     ${SYSTEM_ADMIN_PROFILES_OVERRIDE_IDEL_LABEL}
   run key word if    "${default}"=="False" and "${never}"=="True" and "${never_label}"=="False"   wait and click     ${SYSTEM_ADMIN_PROFILES_OVERRIDE_IDEL_NEVER_LABEL}
   run key word if    "${default}"=="False" and "${never}"=="False"   wait and click     ${SYSTEM_ADMIN_PROFILES_OVERRIDE_IDEL_OFFLINE}
   run key word if    "${default}"=="False" and "${never}"=="False"   clear element text    ${SYSTEM_ADMIN_PROFILES_OVERRIDE_IDEL_OFFLINE}
   run key word if    "${default}"=="False" and "${never}"=="False"   input text    ${SYSTEM_ADMIN_PROFILES_OVERRIDE_IDEL_OFFLINE}   ${time_out}
   wait and click   ${SUBMIT_OK_BUTTON}
   ## double check if the admin profile has been created ##
   ${name_entry}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_ADMIN_PROFILE_TABLE_NAME_ENTRY}    ${name}
   Wait Until Element Is Visible    ${name_entry}

Create API_ADMIN
    [Arguments]      ${username}      ${admin_profile}    ${vdom}    ${trust_host}=10.10.10.10/32   ${none_vdom}=NO
    [Documentation]  this keyword is to create a REST API admin for the fortigate, admin_profile should 
    ...              be created first
    wait and click    ${system_administrators_create new}
    ${admin_menu_bar}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_ADMINISTRATORS_CREATE_ADMINISTRATOR}    REST API Admin
    ##pop_up sometimes is not shown, and clicking "Create New" will go to edit page directly.
    ${if_pop_up}=    Run keyword and return status    Wait Until Element Is Visible     ${admin_menu_bar}
    Run keyword if    ${if_pop_up}    wait and click    ${admin_menu_bar}
    wait and click    ${SYSTEM_ADMINISTRATORS_EDIT_REST_USERNAME}
    clear element text   ${SYSTEM_ADMINISTRATORS_EDIT_REST_USERNAME}
    input text        ${SYSTEM_ADMINISTRATORS_EDIT_REST_USERNAME}   ${username}
    wait and click    ${SYSTEM_ADMINISTRATORS_EDIT_REST_ADMIN_PROFILE}
    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${system_administrators_edit_admin_admin_profile_select}    ${admin_profile}
    wait and click    ${new_locator}    
    ${staus}=    run keyword and return status     checkbox should be selected   ${SYSTEM_ADMINISTRATORS_EDIT_REST_API_PKI_CHECKBOX}
    run keyword if   "${staus}"=="True"    wait and click    ${SYSTEM_ADMINISTRATORS_EDIT_REST_API_PKI_LABEL}
    wait and click    ${SYSTEM_ADMINISTRATORS_EDIT_REST_API_TRUSTED_HOST}
    clear element text    ${SYSTEM_ADMINISTRATORS_EDIT_REST_API_TRUSTED_HOST}
    input text    ${SYSTEM_ADMINISTRATORS_EDIT_REST_API_TRUSTED_HOST}    ${trust_host}
    ${super}=    run keyword and return status  should contain   ${admin_profile}   super_admin
    ${admmin_no_access}=    run keyword and return status  should contain   ${admin_profile}   admin_no_access
    ${novdom_admin}=    evaluate    ${super} or ${admmin_no_access}
    run keyword if    "${novdom_admin}"=="False" and "${none_vdom}"=="NO"    wait and click    ${SYSTEM_ADMINISTRATORS_EDIT_REST_API_FIRSTVDOM_REMOVE_BUTTON}
    run keyword if    "${novdom_admin}"=="False" and "${none_vdom}"=="NO"    Set Admin Vdom   ${vdom}
    wait and click    ${SUBMIT_OK_BUTTON}
    wait and click    ${SYSTEM_ADMINISTRATORS_EDIT_REST_APIK_CLOSE_BUTTON}
    sleep    1
    ## double check if the admin user has been created ##
    Open Toggle Button     REST API Administrator
    ${name_entry}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_ADMINISTRATORS_TABLE_NAME_ENTRY}   ${username}
    Wait Until Element Is Visible    ${name_entry}
    Close Toggle Button     REST API Administrator

Create SSO_ADMIN
    [Arguments]      ${username}      ${admin_profile}     ${vdom}    ${none_vdom}=NO
    [Documentation]  this keyword is to create a SSO admin for the fortigate, admin_profile should 
    ...              be created first
    wait and click    ${system_administrators_create new}
    ${admin_menu_bar}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_ADMINISTRATORS_CREATE_ADMINISTRATOR}    SSO Admin
    ##pop_up sometimes is not shown, and clicking "Create New" will go to edit page directly.
    ${if_pop_up}=    Run keyword and return status    Wait Until Element Is Visible     ${admin_menu_bar}
    Run keyword if    ${if_pop_up}    wait and click    ${admin_menu_bar}
    wait and click    ${SYSTEM_ADMINISTRATORS_EDIT_SSO_USERNAME}
    clear element text   ${SYSTEM_ADMINISTRATORS_EDIT_SSO_USERNAME}
    input text        ${SYSTEM_ADMINISTRATORS_EDIT_SSO_USERNAME}   ${username}
    wait and click    ${SYSTEM_ADMINISTRATORS_EDIT_REST_ADMIN_PROFILE}
    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${system_administrators_edit_admin_admin_profile_select}    ${admin_profile}
    wait and click    ${new_locator}    
    ${super}=    run keyword and return status  should contain   ${admin_profile}   super_admin
    ${admmin_no_access}=    run keyword and return status  should contain   ${admin_profile}   admin_no_access
    ${novdom_admin}=    evaluate    ${super} or ${admmin_no_access}
    run keyword if    "${novdom_admin}"=="False" and "${none_vdom}"=="NO"    wait and click    ${SYSTEM_ADMINISTRATORS_EDIT_REST_API_FIRSTVDOM_REMOVE_BUTTON}
    run keyword if    "${novdom_admin}"=="False" and "${none_vdom}"=="NO"    Set Admin Vdom   ${vdom}
    wait and click    ${SUBMIT_OK_BUTTON}
    ## double check if the admin user has been created ##
    Open Toggle Button     Single Sign-On Administrator
    ${name_entry}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_ADMINISTRATORS_TABLE_NAME_ENTRY}   ${username}
    Wait Until Element Is Visible    ${name_entry}
    Close Toggle Button    Single Sign-On Administrator

EDIT ADMINISTRATOR
   [Arguments]     ${admin_name}    ${admin_type}=System Administrator
   [Documentation]  this keyword is to go to  admin edit page, admin_type should be "System Administrator"
    ...              "REST"  or  "Single Sign-On Administrator"
   SELECT ADMINISTRATOR   ${admin_name}    ${admin_type}
   wait and click   ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_EDIT_BUTTON}

DELETE ADMINISTRATOR
   [Arguments]     ${admin_name}    ${admin_type}=System Administrator
   [Documentation]  this keyword is to delete an admin, admin_type should be "System Administrator"
    ...              "REST"  or  "Single Sign-On Administrator"
   SELECT ADMINISTRATOR   ${admin_name}    ${admin_type} 
   wait and click   ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_DELETE_BUTTON}
   wait and click   ${CONFIRM_OK_BUTTON}

SELECT ADMINISTRATOR
   [Arguments]     ${admin_name}    ${admin_type}=System Administrator
   Open Toggle Button    ${admin_type}   
   ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_NAME_COLUMN}    ${admin_name}
   wait and click   ${new_locator}

Open Toggle Button
    [Arguments]    ${section_name}
    ${button}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_SECTION_TOGGLE_BUTTON}    ${section_name}
    ${status}=   Get Element Attribute  ${button}    className 
    ${status}=   run keyword and return status    should contain    ${status}    active
    Run Keyword If     "${status}"=="False"    wait and click    ${button}

Close Toggle Button
    [Arguments]    ${section_name}
    ${button}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_SECTION_TOGGLE_BUTTON}    ${section_name}
    ${status}=   Get Element Attribute  ${button}    className 
    ${status}=   run keyword and return status    should contain    ${status}    active
    Run Keyword If     "${status}"=="True"    wait and click    ${button}

Change Admin Password
    [Arguments]    ${old_password}    ${new_password}
    [Documentation]   This keyword it to change the Password of an admininistrator after going on the edit page
    wait and click    ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_BUTTON}
    ${status}=   run keyword and return status    wait until element is visible    ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_OLD}
    Run Keyword If    "${status}"=="True"    clear element text    ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_OLD}
    Run Keyword If    "${status}"=="True"    input text    ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_OLD}    ${old_password}
    wait until element is visible    ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_NEW}
    clear element text    ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_NEW}
    input text    ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_NEW}    ${new_password}
    wait until element is visible    ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_CONFIRM}
    clear element text    ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_CONFIRM}
    input text    ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_CONFIRM}    ${new_password}
    wait and click    ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_OK_BUTTON}

Change Admin Name To
    [Arguments]    ${admin_username_new}
    [Documentation]   This keyword it to change the Name of an admininistrator after going on the edit page
    wait and click    ${system_administrators_edit_admin_username}
    clear element text   ${system_administrators_edit_admin_username}
    input text        ${system_administrators_edit_admin_username}    ${admin_username_new}
    wait and click    ${SUBMIT_OK_BUTTON}


Change Admin Profile and Vdom
    [Arguments]      ${admin_type}     ${profile}     ${vdom}
    wait and click    ${SYSTEM_ADMINISTRATORS_EDIT_REST_ADMIN_PROFILE}
    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${system_administrators_edit_admin_admin_profile_select}    ${profile}
    wait and click    ${new_locator}    
    run keyword if    "${profile}"=="prof_admin"     change admin vdom to    ${vdom}
    wait and click    ${SUBMIT_OK_BUTTON}

Change Admin Vdom To
    [Arguments]       ${vdom}
    wait and click    ${SYSTEM_ADMINISTRATORS_EDIT_REST_API_FIRSTVDOM_REMOVE_BUTTON}
    wait and click    ${SYSTEM_ADMINISTRATORS_EDIT_REST_API_VDOM_ADD_BUTTON}
    :FOR   ${ELEMENT}    IN      @{vdom}
           \   ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SELECTION_SPAN_MENU_BAR}   ${ELEMENT}
           \   wait and click   ${new_locator}

Test If Profile and Vdom Changed
    [Arguments]     ${admin_type}    ${admin_name}    ${profile}    ${vdom}
    Open Toggle Button     ${admin_type}
    ${name_entry}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_ADMINISTRATORS_TABLE_NAME_ENTRY_DIV}   ${admin_name}
    Wait Until Element Is Visible    ${name_entry}
    ${profile_entry}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_ADMINISTRATORS_TABLE_PROFILE_ENTRY}    ${profile} 
    ${profile_entry}=   CATENATE   SEPARATOR=    ${name_entry}    ${profile_entry}
    Wait Until Element Is Visible   ${profile_entry}
    :FOR   ${ELEMENT}    IN      @{vdom}
        \    ${vdom_entry}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_ADMINISTRATORS_TABLE_VDOM_ENTRY}    ${ELEMENT}
        \    ${vdom_entry}=   CATENATE   SEPARATOR=    ${name_entry}    ${vdom_entry}
        \    Wait Until Element Is Visible   ${vdom_entry}        
    Close Toggle Button     ${admin_type}

Set SAML Idp
    [Arguments]    ${idp_ip}    ${cert}
    ${idp_label}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_COMMON_LABEL}   Identity
    wait and click   ${idp_label}
    ${idp_addr}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_COMMON_INPUT_BOX}    IdP addr
    input text     ${idp_addr}    ${idp_ip}
    SELECT MEBU BAR FROM DROPDOWN MENU     ${cert}     IdP certificate 
    ${download_button}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_COMMON_HREF_BUTTON}   Download
    wait and click   ${download_button}

Create SP On Idp and Return Prefix
    [Arguments]    ${sp_name}   ${sp_ip}
    ${create_button}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_COMMON_BUTTON}    Create New
    wait and click    ${create_button}
    wait and click    ${SYSTEM_SAML_CREATE_SP_NAME_INPUT}
    INPUT TEXT    ${SYSTEM_SAML_CREATE_SP_NAME_INPUT}    ${sp_name}
    ${sp_addr}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_COMMON_INPUT_BOX}    SP address
    INPUT TEXT    ${sp_addr}    ${sp_ip}
    wait and click    ${SUBMIT_OK_SPAN} 
    ${sp_entry}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_SAML_SP_LIST_NAME}    ${sp_name}
    ${sp_entry}=    CATENATE    SEPARATOR=    ${sp_entry}    ${SYSTEM_SAML_SP_LIST_PREFIX}
    Wait Until Element Is Visible    ${sp_entry}
    ${prefix}=    Get Text    ${sp_entry}
    [Return]    ${prefix}

Set SAML SP
    [Arguments]    ${sp_ip}   ${default_login}  ${profile}
    ${sp_label}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_COMMON_LABEL}   Service Provider
    wait and click   ${sp_label}
    ${sp_addr}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_COMMON_INPUT_BOX}    SP addr
    input text     ${sp_addr}    ${sp_ip}    
    ${login_page}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_COMMON_LABEL}    ${default_login}
    wait and click   ${login_page}
    SELECT MEBU BAR FROM DROPDOWN MENU     ${profile}     Default admin profile
    
Set SP Idp Info of Type Fortinet
    [Arguments]    ${idp_type}    ${prefix}    ${idp_ip}    ${cert}    ${cert_menubar}=REMOTE_Cert_1
    ${idp_type_label}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_COMMON_LABEL}   ${idp_type}
    wait and click   ${idp_type_label}
    ${idp_addr}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_COMMON_INPUT_BOX}    IdP addr
    input text     ${idp_addr}    ${idp_ip}
    ${prefix_input}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_COMMON_INPUT_BOX}    Prefix
    input text     ${prefix_input}    ${prefix}
    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_COMON_DROPDOWN_MENU_MULTMENU}    IdP certificate
    wait and click    ${new_locator}
    wait and click    ${SYSTEM_SAML_SP_IDP_CERT_IMPORT_BUTTON}
    Wait Until Element Is Visible    ${SYSTEM_SLIDE_IFRAME}
    select frame      ${SYSTEM_SLIDE_IFRAME}
    Choose File       ${SYSTEM_SAML_SP_IDP_CERT_UPLOAD_INPUT}     ${SYSTEM_FILE_DOWNLOAD_DIR_PATH}${/}${cert}.cer
    wait and click    ${SUBMIT_OK_BUTTON}
    unselect frame
    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_COMON_DROPDOWN_MENU_BAR}     ${cert_menubar}
    wait and click    ${new_locator}
    wait and click    ${SUBMIT_APPLY_BUTTON}

go to SSO_ADMIN login page
    [Documentation]    this keyword is for some case test about login page, just go to login page, before input username dialog box shown
    ...             to test pre_banner
    [timeout]    ${FGT_KEYWORD_MAX_RUNNING_TIME}
    [Arguments]    ${url}=${FGT_URL}    ${browser}=${FGT_BROWSER}    ${alias}=None    ${username}=${FGT_GUI_USERNAME}    ${password}=${FGT_GUI_PASSWORD}
    ...    ${remote_url}=${FGT_REMOTE_URL}    ${desired_capabilities}=${FGT_DESIRED_CAPABILITIES}    ${ff_profile_dir}=${FGT_FF_PROFILE_DIR}
    ###
    ${browser_index}=    open browser    ${url}    browser=${browser}    alias=${alias}
    ...    remote_url=${remote_url}    desired_capabilities=${desired_capabilities}    ff_profile_dir=${ff_profile_dir}
    Maximize Browser Window
    get all selenium config
    ${window_width}    ${window_height}=    Get Window Size
    ${page_width}    ${page_height}=    Get Element Size    xpath:/html
    [return]

login SSO_ADMIN
    [Arguments]    ${url}=${FGT_URL}    ${browser}=${FGT_BROWSER}    ${alias}=None    ${username}=${FGT_GUI_USERNAME}    ${password}=${FGT_GUI_PASSWORD}
    ...    ${remote_url}=${FGT_REMOTE_URL}    ${desired_capabilities}=${FGT_DESIRED_CAPABILITIES}    ${ff_profile_dir}=${FGT_FF_PROFILE_DIR}
    ...    ${if_need_pre_banner}=${False}    ${if_need_post_banner}=${False}
    go to Login page 
    wait and click    ${SYSTEM_SAML_HREF_ON_LOGIN_PAGE}
    #input username and password
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${LOGIN_USERNAME_TEXT}
    Run Keyword And Continue On Failure    input text    ${LOGIN_USERNAME_TEXT}    ${username}
    Run Keyword And Continue On Failure    input password    ${LOGIN_PASSWORD_TEXT}    ${password}
    Run Keyword And Continue On Failure    click button    ${LOGIN_LOGIN_BUTTON}
    sleep   2
    ${continue}=    run keyword and return status    Wait Until Element Is Visible    ${SYSTEM_SAML_CONTINUE_BUTTON_LOGIN_PAGE}
    run keyword if    "${continue}"=="True"    click button    ${SYSTEM_SAML_CONTINUE_BUTTON_LOGIN_PAGE}
    #wait until "Login Disclaimer" prompt
    run keyword if    "${FGT_FIPS_CC_MODE}"=="${True}" or "${if_need_post_banner}"=="${True}"    Run Keyword And Continue On Failure    Wait Until Page Contains Element    ${FIPS_DISCLAIMER_HEAD}
    run keyword if    "${FGT_FIPS_CC_MODE}"=="${True}" or "${if_need_post_banner}"=="${True}"    Run Keyword And Continue On Failure    click button    ${FIPS_ACCEPT_BUTTON}
    #Judge if warning of "File System Check Recommended" would be shown on GUI
    ${if_check_disk}=    run keyword and return status    Wait Until Page Contains Element    ${LOGIN_FILE_CHECK_HEAD}
    run keyword if    "${if_check_disk}"=="True"    Run Keyword And Continue On Failure    click button    ${LOGIN_FILE_CHECK_LATER}
    #Judge if warning of changing password would be shown on GUI
    ${if_password_change}=    run keyword and return status    Wait Until Page Contains Element    ${PWD_CHANGE_HEAD}
    run keyword if    "${if_password_change}"=="True"    Run Keyword And Continue On Failure    click button    ${PWD_CHANGE_LATER_BUTTON}
    #Judge if warning of being managed by FortiManager device would be shown on GUI
    ${if_managed_by_fmg}=    run keyword and return status    Wait Until Page Contains Element    ${FMG_LOGIN_HEAD}
    run keyword if    "${if_managed_by_fmg}"=="True"    Run Keyword And Continue On Failure    click button    ${FMG_LOGIN_READ_WRITE_BUTTON}
    #Judge if warning of out-of-sync on FortiManager device would be shown on GUI
    ${out_of_sync_warning_fmg}=    run keyword and return status    Wait Until Page Contains Element    ${OUT_OF_SYNC_FMG_TEXT}
    run keyword if    "${out_of_sync_warning_fmg}"=="True"    Run Keyword And Continue On Failure    click button    ${OUT_OF_SYNC_FMG_YES_BUTTON}
    #Judge if warning of out-of-sync on FortiManager device would be shown on GUI
    ${forticare_registration_required}=    run keyword and return status    Wait Until Page Contains    FortiCare Registration Required
    run keyword if    "${forticare_registration_required}"=="True"    Run Keyword And Continue On Failure    click button    ${FORTICARE_REQUIRED_BUTTON}
    # Set Selenium Timeout    ${orig timeout}
    #Check if warning of "File System Check is recommended" is shown, and Check "remind me later"
    #Add it later
    Run Keyword And Continue On Failure    Wait Until Keyword Succeeds    3x    2s    Element Text Should Be    ${PLTF_TYPE_DIV}    ${FGT_HW_TYPE}
    [return]    ${browser_index}

###  firmware ####
upgrade firmware
    [Arguments]   ${firmware_dir}    ${firmware_file_name}
    Go to system
    Go to Firmware
    wait until page contains element    ${SYSTEM_FIRMWARE_H1}
    Choose File    ${SYSTEM_FIRMWARE_BROWSE}    ${firmware_dir}${/}${firmware_file_name}
    Wait Until Page Does Not Contain Element    ${SYSTEM_FIRMWARE_WRONG_PLTF_WARNING}

backup system configuration
    [Arguments]   ${url}=${FGT_URL}
    Go to    ${url}/ng/system/config/backup
    wait until page contains element    ${SYSTEM_BACKUP_CONFIG_H1}
    click button    ${SYSTEM_BACKUP_CONFIG_OK_BUTTON}

###### SYSTEM DHCP #####
Create Standard dhcp server
    [Arguments]      ${start_ip}=10.10.10.10   ${end_ip}=10.10.10.20   ${netmask}=255.255.255.0
    [Documentation]  this keyword is to create a basic dhcp server on a interface
    Wait Until Element Is Visible    ${network_interface_dhcp_server_label}
    ${status}=   run keyword and return status     checkbox should be selected   ${network_interface_dhcp_server_enable button}
    run keyword if   "${status}"=="False"   wait and click   ${network_interface_dhcp_server_label}
    sleep    2
    ${startip_inputbox}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${network_interface_dhcp_server_address range_startip}   1
    ${endip_inputbox}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${network_interface_dhcp_server_address range_endip}   1
    ${entry}=       REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${network_interface_dhcp_server_address range_entry}   1
    wait and click  ${entry}
    wait and click  ${network_interface_dhcp_server_address range_delete}      
    wait and click  ${network_interface_dhcp_server_address range_create_new}
    ${entry}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${network_interface_dhcp_server_address range_entry}   1
    ${startip_inputbox}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${network_interface_dhcp_server_address range_startip}   1
    ${endip_inputbox}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${network_interface_dhcp_server_address range_endip}   1
    wait and click  ${entry}
    clear element text   ${startip_inputbox}
    input text   ${startip_inputbox}   ${start_ip}
    clear element text   ${endip_inputbox}
    input text   ${endip_inputbox}   ${end_ip}
    wait and click  ${network_interface_dhcp_server_netmask}
    clear element text   ${network_interface_dhcp_server_netmask}
    input text   ${network_interface_dhcp_server_netmask}   ${netmask}
    wait and click  ${SUBMIT_OK_BUTTON}
    unselect frame

    
#### SYSTEM  featrue status change ###
Enable_FGT_Feature_Additional
    [Documentation]   addtional features on the "feature visibility" page have two element for each feature,"row and column"
    ...               this keyword is to enable the feature visibility if there is the feature visibility on the page.
    [Arguments]    ${feature_name}
    ${exist}=      feature_vis_wait_for_feature_vis    ${feature_name}
    ${exist}=      Convert to Integer   ${exist}
    ${status}=     Evaluate   ${exist}>0
    ${enable_status}=    run keyword if   "${status}"=="True"  feature_vis_if_status_enabled   ${feature_name}
    Run keyword if   "${status}"=="True" and "${enable_status}"=="False"   feature_vis_click_status_button     ${feature_name}
    Run keyword if   "${status}"=="True" and "${enable_status}"=="False"   wait and click    ${system_feature_vis_apply_button}     

Disable_FGT_Feature_Additional
    [Documentation]   addtional features on the "feature visibility" page have two element for each feature,"row and column"
    ...               this keyword is to disable the feature visibility if there is the feature visibility on the page.
    [Arguments]    ${feature_name}
    ${exist}=      feature_vis_wait_for_feature_vis    ${feature_name}
    ${exist}=      Convert to Integer   ${exist}
    ${status}=     Evaluate   ${exist}>0
    ${enable_status}=    run keyword if   "${status}"=="True"  feature_vis_if_status_enabled   ${feature_name}
    Run keyword if   "${status}"=="True" and "${enable_status}"=="True"   feature_vis_click_status_button     ${feature_name}
    Run keyword if   "${status}"=="True" and "${enable_status}"=="True"   wait and click    ${system_feature_vis_apply_button}     

Enable_FGT_feature_noRC
    [Documentation]   this keyword is to enable the feature visibility which do not have row and colum selection in the developing program
    ...               code on the page. "noRC" means "no Row Column"
    [Arguments]    ${feature_name}
    ${enabled}=    Feature_vis_if_status_enabled_No row_col   ${feature_name}
    Run keyword if   "${enabled}"=="False"    Feature_vis_click_status_button_No row_col  ${feature_name}
    Run keyword if   "${enabled}"=="False"    wait and click    ${system_feature_vis_apply_button} 

disable_FGT_feature_noRC
    [Documentation]   this keyword is to disable the feature visibility which do not have row and colum selection in the developing program
    ...               code on the page. "noRC" means "no Row Column"
    [Arguments]    ${feature_name}
    ${enabled}=    Feature_vis_if_status_enabled_No row_col   ${feature_name}
    Run keyword if   "${enabled}"=="True"    Feature_vis_click_status_button_No row_col  ${feature_name}
    Run keyword if   "${enabled}"=="True"    wait and click    ${system_feature_vis_apply_button}  

Feature_vis_if_status_enabled
    [Documentation]   this keyword is to check if the feature of addtional feature  visibility (which has row and column) is enabled.
    [Arguments]    ${feature_name}
    ${vis}=     feature_vis_wait_for_feature_vis  ${feature_name}
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${system_feature_vis_status_${vis}}   ${feature_name}
    ${already_enabled}=    Run keyword and return status    Checkbox Should Be Selected    ${new_locator}
    [Return]    ${already_enabled}
    
Feature_vis_wait_for_feature_vis
    [Arguments]    ${feature_name}
    [Documentation]  addtional features on the "feature visibility" page have two element for each feature,"row and column"
    ...              this keyword act as "wait until element is visible", the return number is the elementlabel,
    ...              return 0 means there is no this feature on the page
    ${new_locator_1}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${system_feature_vis_label_1}   ${feature_name}
    ${new_locator_2}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${system_feature_vis_label_2}   ${feature_name}
    ${status1}=    Run keyword and return status    Wait Until Element Is Visible    ${new_locator_1}
    ${i}=    Set Variable if   "${status1}"=="${True}"    1  0
    ${status2}=    Run keyword and return status    Wait Until Element Is Visible    ${new_locator_2}
    ${j}=    Set Variable if   "${status2}"=="${True}"    2  0
    ${i}=    Evaluate   ${i}+${j}
    [Return]    ${i}

Feature_vis_click_status_button
    [Documentation]   this keyword is to click the button of the feature of addtional feature  visibility (which has row and column).
    [Arguments]    ${feature_name}
    ${vis}=      feature_vis_wait_for_feature_vis  ${feature_name}
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${system_feature_vis_button_${vis}}   ${feature_name}
    wait and click     ${new_locator}

Feature_vis_if_status_enabled_No row_col
    [Documentation]   this keyword is to check if the feature of addtional feature  visibility (which do not have row and column) is enabled.
    [Arguments]    ${feature_name}
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${system_feature_vis_label}   ${feature_name}
    Wait Until Element Is Visible     ${new_locator}
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${system_feature_vis_status}   ${feature_name}
    ${already_enabled}=    Run keyword and return status    Checkbox Should Be Selected    ${new_locator}
    [Return]    ${already_enabled}

Feature_vis_click_status_button_No row_col
    [Documentation]   this keyword is to click the button of the feature of addtional feature  visibility (which do not have row and column).
    [Arguments]    ${feature_name}
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${system_feature_vis_button}    ${feature_name}
    wait and click    ${new_locator}

################### END OF SYSTEM ####
    
### Policy  ####

system create ipv4 policy
    [Arguments]   ${policy_name}   ${income_int}    ${outgo_int}    ${source}=all    ${destination}=all    ${service}=ALL
    [Documentation]   this keyword is to creat a basic policy for system test use
    ...               policyname and interface is mandatory, others are set to all by default
    wait and click   ${SYSTEM_POLICY_IPV4_POLICY_CREATE_NEW}
    Wait Until Element Is Visible    ${SYSTEM_POLICY_IPV4_POLICY_NAME_LABEL}   
    click Element    ${SYSTEM_POLICY_IPV4_POLICY_NAME_INPUT}
    clear element text   ${SYSTEM_POLICY_IPV4_POLICY_NAME_INPUT}
    input text       ${SYSTEM_POLICY_IPV4_POLICY_NAME_INPUT}    ${policy_name} 
    wait and click   ${SYSTEM_POLICY_IPV4_POLICY_INCOME_INT_LABEL}
    ${mebu_bar}=     REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_SELECT_INTERFACE_MEMBER_MENU_BAR}    ${income_int}
    wait and click   ${mebu_bar}
    wait and click   ${SYSTEM_POLICY_IPV4_POLICY_OUTGO_INT_LABEL}
    ${mebu_bar}=     REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_SELECT_INTERFACE_MEMBER_MENU_BAR}    ${outgo_int} 
    wait and click   ${mebu_bar}
    ${new_locator}=  REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_POLICY_IPV4_POLICY_SERV}  Source
    wait and click   ${new_locator}
    SELECT MENU BAR FROM POLICY SELECTION PANE    all  
    ${new_locator}=  REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_POLICY_IPV4_POLICY_SERV}  Destination
    wait and click   ${new_locator}
    SELECT MENU BAR FROM POLICY SELECTION PANE    all
    ${new_locator}=  REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_POLICY_IPV4_POLICY_SERV}  Service
    wait and click   ${new_locator}
    SELECT MENU BAR FROM POLICY SELECTION PANE    ALL
    wait and click   ${SUBMIT_OK_BUTTON}
    


###  network ####
Create Network Interface
    [Arguments]      ${name}    ${type}    ${physical_interface}    ${vlan_id}=30    ${vdom}=${SYSTEM_TEST_VDOM_NAME_1}    ${ipmask}=0.0.0.0/0.0.0.0   ${vdom_mode_tp}=no   ${wifi_psk}=12345678
    ...              ${start_ip}=10.10.10.10     ${end_ip}=10.10.10.20     ${netmask}=255.255.255.0
    [Documentation]  this keyword is to create a basic network interface on network interface create new page,
    ...              after click the "create new" button, then run the keyword
    ...              physical_interface is a list, type words as "VLAN" "Aggregate" "Redundant" "Loopback" ... same as the menu bar or the name is 
    ...              contianed in the name on menu bar and unique,  such as "Aggre"
    ...              VDOM mode should be selected, because tp vdom do not have IP add, default is NAT mode
    select frame     ${NETWORK_FRAME}
    wait and click   ${network_interfaces_create new_button}
    wait and click   ${NETWORK_INTERFACES_CREATE NEW_MENU_BAR_INTERFACE}
    Wait Until Element Is Visible    ${network_interfaces_create or edit_Interface Name}
    Input Text       ${network_interfaces_create or edit_Interface Name}    ${name}
    ${type_selected}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${network_interfaces_create or edit_Type_selected}    ${type}
    wait and click   ${network_interfaces_create or edit_Type}
    wait and click   ${type_selected}  
    ${type_is_vlan}=    run keyword and return status    should be equal   ${type}   VLAN
    ${type_is_evlan}=   run keyword and return status    should Contain    ${type}   EMAC
    ${type_is_wifi}=    run keyword and return status    should Contain    ${type}   WiFi
    ${type_is_Agg}=     run keyword and return status    should Contain    ${type}   Agg
    ${type_is_Redun}=   run keyword and return status    should Contain    ${type}   Redu
    ${type_is_Switch}=  run keyword and return status    should Contain    ${type}   Soft
    ${physical_interface_nolist}=    GET FROM LIST    ${physical_interface}     0
    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACES_CREATE OR EDIT_INTERFACE_INTERFACE}   ${physical_interface_nolist}
    run keyword if   "${type_is_vlan}"=="True" or "${type_is_evlan}"=="True"    wait and click   ${network_interfaces_create or edit_Interface}
    run keyword if   "${type_is_vlan}"=="True" or "${type_is_evlan}"=="True"    wait and click   ${new_locator}
    run keyword if   "${type_is_vlan}"=="True"    wait and click   ${network_interfaces_create or edit_VLAN ID}
    run keyword if   "${type_is_vlan}"=="True"    clear element text    ${network_interfaces_create or edit_VLAN ID}
    run keyword if   "${type_is_vlan}"=="True"    Input text    ${network_interfaces_create or edit_VLAN ID}  ${vlan_id}
    :FOR    ${element}   IN   @{physical_interface}
        \   run keyword if    ${type_is_Agg} or ${type_is_Redun} or ${type_is_Switch}   wait and click    ${network_interfaces_create or edit_Interface_members_button}    
        \   Run Keyword If    ${type_is_Agg} or ${type_is_Redun} or ${type_is_Switch}   SELECT MENU BAR FROM SELECTION PANE   ${element}
    ${select_vdom}=   run keyword and return status    wait Until Element Is Visible    ${NETWORK_INTERFACES_CREATE OR EDIT_Virtual DOMAIN}
    run keyword if   "${select_vdom}"=="True"    wait and click    ${NETWORK_INTERFACES_CREATE OR EDIT_Virtual DOMAIN}
    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_COMON_DROPDOWN_MENU_BAR}    ${vdom}
    run keyword if   "${select_vdom}"=="True"     wait and click   ${new_locator}
    run keyword if   "${vdom_mode_tp}"=="no"      Wait Until Element Is Visible     ${network_interfaces_create or edit_IP Mask}
    run keyword if   "${vdom_mode_tp}"=="no"      clear element text    ${network_interfaces_create or edit_IP Mask}
    run keyword if   "${vdom_mode_tp}"=="no"      Input text    ${network_interfaces_create or edit_IP Mask}    ${ipmask}
    run keyword if   "${type_is_wifi}"=="True"    Create Standard dhcp server   ${start_ip}   ${end_ip}  ${netmask}
    run keyword if   "${type_is_wifi}"=="True"    select frame     ${NETWORK_FRAME}
    run keyword if   "${type_is_wifi}"=="True"    wait and click   ${NETWORK_INTERFACES_EDIT_WIFI_PSKEY_INPUT}
    run keyword if   "${type_is_wifi}"=="True"    clear element text   ${NETWORK_INTERFACES_EDIT_WIFI_PSKEY_INPUT}
    run keyword if   "${type_is_wifi}"=="True"    Input text    ${NETWORK_INTERFACES_EDIT_WIFI_PSKEY_INPUT}    ${wifi_psk}
    wait and click    ${SUBMIT_OK_BUTTON}
    unselect frame


network edit interface
    [Arguments]    ${main_interface_name}    ${subside_interface_name}=nologic   ${table_type}=Physical
    [Documentation]    this keyword is to edit an interface on network interface page
    network select interface   ${main_interface_name}    ${subside_interface_name}   ${table_type}
    wait and click    ${network_interfaces_edit_button}
    sleep   2

network delete interface
    [Arguments]    ${main_interface_name}    ${subside_interface_name}=nologic   ${table_type}=Physical
    [Documentation]    this keyword is to delete an interface on network interface page
    network select interface   ${main_interface_name}    ${subside_interface_name}    ${table_type}
    wait and click    ${network_interfaces_delete_button}
    Unselect frame
    wait and click    ${NETWORK_INTERFACES_DELETE_OK_BUTTON}

network delete interface ref
    [Arguments]    ${main_interface_name}    ${ref_table}    ${ref_name}    ${subside_interface_name}=nologic   ${table_type}=Physical    
    [Documentation]    this keyword is to delete a ref of an interface on network interface page, just delete the first level ref
    ...                if need to delete the second level, this keyword need to be optimized
    ${int_locator}=    network select interface   ${main_interface_name}    ${subside_interface_name}    ${table_type}    
    ${ref_locator}=    CATENATE  SEPARATOR=    ${int_locator}    ${NETWORK_INTERFACES_TABLE_REF}
    wait and click   ${ref_locator}
    unselect frame
    ${ref_item_table}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACES_REF_TYPE}    ${ref_table}
    ${ref_item_name}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACES_REF_ITEM}    ${ref_name}
    ${ref_item_locator}=    CATENATE  SEPARATOR=    ${ref_item_table}    ${ref_item_name}
    wait and click    ${ref_item_locator}
    wait and click    ${NETWORK_INTERFACES_REF_ITEM_DELETE_BUTTON}
    wait and click    ${CONFIRM_OK_BUTTON}
    sleep  2
    wait and click    ${NETWORK_INTERFACES_REF_ITEM_CLOSE_BUTTON}

create zone
    [Arguments]    ${zone_name}    ${interface_name}
    [Documentation]   this keyword is to create a zone, and add an interface to the zone
    select frame      ${NETWORK_FRAME}
    wait and click    ${NETWORK_INTERFACES_CREATE NEW_BUTTON}
    wait and click    ${NETWORK_INTERFACES_CREATE NEW_MENU_BAR_ZONE}
    wait until element is visible   ${NETWORK_INTERFACES_CREATE NEW_ZONE_NAME}
    sleep  1
    wait and click    ${NETWORK_INTERFACES_CREATE NEW_ZONE_NAME_INPUT}
    clear element text    ${NETWORK_INTERFACES_CREATE NEW_ZONE_NAME_INPUT}
    input text   ${NETWORK_INTERFACES_CREATE NEW_ZONE_NAME_INPUT}     ${zone_name}
    wait and click   ${NETWORK_INTERFACES_CREATE NEW_ZONE_INTERFACE}
    SELECT MENU BAR FROM SELECTION PANE        ${interface_name}
    wait and click    ${SUBMIT_OK_BUTTON}

delete zone interface
    [Arguments]     ${zone_name}     ${interface_name}
    [Documentation]   this keyword is to unbound an interface from a zone
    network edit interface    ${zone_name}    table_type=Zone
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_INTERFACES_CREATE NEW_ZONE_INTERFACE_UNSELECT}   ${interface_name}
    wait and click   ${new_locator}
    wait and click   ${SUBMIT_OK_BUTTON}    

network select interface
    [Arguments]      ${main_interface_name}    ${subside_interface_name}=nologic   ${table_type}=Physical
    [Documentation]  this keyword is to select an interface from network interface table, arguments are 
    ...              main interface, subside interface name such as vlan under port or ports under VWP
    ...              table type is the subtable name in the web page, such as physical, zone, virtual wire pair
    ...              table name should be equal or sub-word of the table name shown in the web page
    ...              the return value is the XPATH of the interface
    select frame   ${NETWORK_FRAME}
    ${table_type}=   SET Variable IF  "${table_type}"=="VLAN"    Physical     ${table_type}
    ${interface_type}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACES_TYPE}    ${table_type}
    ${interface_xpath}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACES_TABLE_INTERFACE}    ${main_interface_name}
    ${phy_int_locator}=   CATENATE  SEPARATOR=    ${interface_type}    ${interface_xpath}
    ${status}=    Run Keyword and Return Status   should be equal      ${subside_interface_name}   nologic
    ${vir_interface_xpath}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACES_TABLE_INTERFACE}    ${subside_interface_name}
    ${vir_int_locator}=     CATENATE  SEPARATOR=    ${interface_type}    ${vir_interface_xpath}
    ${new_expand_button}=   CATENATE  SEPARATOR=    ${phy_int_locator}   ${NETWORK_INTERFACES_EXPAND_BUTTON}
    ${expand}=    Run Keyword and Return Status    wait until element is visible    ${new_expand_button}
    ${expand_status}=    Run Keyword If   "${expand}"=="True"    get toggle_button status    ${new_expand_button}
    Run keyword if   "${expand}"=="True" and "${expand_status}"=="False"    wait and click    ${new_expand_button}
    sleep   1
    run keyword if   "${status}"=="False"   wait and click   ${vir_int_locator}
    run keyword if   "${status}"=="False"   wait and click   ${vir_int_locator}
    run keyword if   "${status}"=="True"    wait and click   ${phy_int_locator}
    run keyword if   "${status}"=="True"    wait and click   ${phy_int_locator}
    ${int_locator}=   Set Variable IF  "${status}"=="False"  ${vir_int_locator}    ${phy_int_locator}
    [Return]   ${int_locator}

get toggle_button status  
   [Arguments]    ${button_name}
   [Documentation]  this keyword is a subfunction of network select interface
   ...              to get the status of the expand button 
   ${class}=   Get element attribute    ${button_name}   class
   ${expand_status}=   Run Keyword and Return Status    Should Contain   ${class}   active
   [Return]    ${expand_status}

Create Network Vwp Interface
    [Arguments]    ${vwp_name}   ${interface1}    ${interface2}    ${vlan_start}=0   ${vlan_end}=0
    [Documentation]  this keyword is to create a pair of Virtual wire pair interface
    ...              vlan range filter is optional
    select frame          ${NETWORK_FRAME}
    wait and click        ${NETWORK_INTERFACES_CREATE NEW_BUTTON}
    wait and click        ${NETWORK_INTERFACES_CREATE NEW_MENU_BAR_VIRTUAL}
    wait until element is visible   ${NETWORK_INTERFACES_CREATE NEW_VWP_NAME}
    clear element text    ${NETWORK_INTERFACES_CREATE NEW_VWP_NAME_INPUT}
    input text            ${NETWORK_INTERFACES_CREATE NEW_VWP_NAME_INPUT}    ${vwp_name}
    wait and click        ${NETWORK_INTERFACES_CREATE NEW_VWP_INTERFACE}
    SELECT MENU BAR FROM SELECTION PANE        ${interface1}
    wait and click        ${NETWORK_INTERFACES_CREATE NEW_VWP_INTERFACE}
    SELECT MENU BAR FROM SELECTION PANE        ${interface2}
    ${range}=    evaluate    ${vlan_start}*${vlan_end}
    run keyword if    ${range}>0   vwp interface vlan range input    ${vlan_start}    ${vlan_end}
    wait and click        ${SUBMIT_OK_BUTTON}
    unselect frame

Create Network vdom_link
    [Arguments]    ${vdomlink_name}    ${vdom_0}   ${vdom_1}   ${vdom_0_ip}=0.0.0.0/0.0.0.0   ${vdom_1_ip}=0.0.0.0/0.0.0.0   ${vdom_0_mode}=NAT     ${vdom_1_mode}=NAT
    [Documentation]  this keyword is to create a vdom-link interface              
    select frame      ${NETWORK_FRAME}
    wait and click    ${NETWORK_INTERFACES_CREATE NEW_BUTTON}
    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACES_CREATE NEW_MENU_BAR}    VDOM
    wait and click    ${new_locator}
    sleep  2
    wait until element is visible   ${NETWORK_INTERFACES_VDOMLINK_NAME_INPUT}
    clear element text    ${NETWORK_INTERFACES_VDOMLINK_NAME_INPUT}
    input text            ${NETWORK_INTERFACES_VDOMLINK_NAME_INPUT}    ${vdomlink_name}
    :FOR   ${i}   IN RANGE   0   2
        \  ${div_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACES_VDOMLINK_INT_DIV}   Interface ${i}
        \  wait and click    ${div_locator}${NETWORK_INTERFACES_VDOMLINK_INT_DIV_VDOM}
        \  ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_COMON_DROPDOWN_MENU_BAR}    ${vdom_${i}}
        \  wait and click    ${new_locator}
        \  ${ip_locator}=    set variable    ${div_locator}${NETWORK_INTERFACES_VDOMLINK_INT_DIV_IPMASK}  
        \  run keyword if   "${vdom_${i}_mode}"=="NAT"    wait until element is visible   ${ip_locator}
        \  run keyword if   "${vdom_${i}_mode}"=="NAT"    clear element text    ${ip_locator}
        \  run keyword if   "${vdom_${i}_mode}"=="NAT"    input text            ${ip_locator}    ${vdom_${i}_ip}
        \  ${status}=    run keyword and return status   checkbox should be selected  ${NETWORK_INTERFACES_VDOMLINK_INT${i}_IPV4_PING}
        \  run keyword if    "${status}"=="False"    wait and click   ${NETWORK_INTERFACES_VDOMLINK_INT${i}_IPV4_PING}
    wait and click   ${SUBMIT_OK_BUTTON}
    


vwp interface vlan range input
    [Arguments]    ${vlan1}    ${vlan2}
    [Documentation]  this keyword is the sub funtion of "Create Network Vwp Interface"
    ${status}=    run keyword and return status   checkbox should be selected    ${NETWORK_INTERFACES_VWP_VLANFILTER_CHECKBOX}
    run keyword if   "${status}"=="False"    wait and click   ${NETWORK_INTERFACES_VWP_VLANFILTER_LABEL}
    wait and click       ${NETWORK_INTERFACES_VWP_VLANFILTER_VALUE_START_INPUT}
    clear element text   ${NETWORK_INTERFACES_VWP_VLANFILTER_VALUE_START_INPUT}
    input text           ${NETWORK_INTERFACES_VWP_VLANFILTER_VALUE_START_INPUT}    ${vlan1}
    wait and click       ${NETWORK_INTERFACES_VWP_VLANFILTER_VALUE_END_INPUT}
    clear element text   ${NETWORK_INTERFACES_VWP_VLANFILTER_VALUE_END_INPUT}
    input text           ${NETWORK_INTERFACES_VWP_VLANFILTER_VALUE_END_INPUT}      ${vlan2}

Network Add interface to SDWAN
  [Arguments]   ${interface}    ${gateway}
  [Documentation]  this keyword is to add an interface to SD-WAN, no matter if there are some
  ...              interfaces already in the SD-WAN
  ### Check how many interfaces have already been configed in the SD-WAN  ###
  :FOR   ${i}    IN RANGE  1  10
      \   ${new_interface}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_SDWAN_MEMBER_ADD_INTERFACE_XPATH_HEAD}   ${i}
      \   ${status}=   run keyword and return status     wait until element is Visible     ${new_interface}
      \   exit for loop if     "${status}"=="False"
  ## add a new interface in the SD-WAN ###
  wait and click   ${NETWORK_SDWAN_INTERFACE_MEMBER_ADD_BUTTON}
  ${interface_select_menu}=    Catenate     SEPARATOR=     ${new_interface}    ${NETWORK_SDWAN_MEMBER_ADD_INTERFACE_MENU}
  ${gateway_input}=   Catenate     SEPARATOR=    ${new_interface}     ${NETWORK_SDWAN_MEMBER_ADD_INTERFACE_GATEWAY}
  ${status_label}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE       ${NETWORK_SDWAN_MEMBER_ADD_INTERFACE_STATUS_LABEL}    Enable
  ${status_value}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE       ${NETWORK_SDWAN_MEMBER_ADD_INTERFACE_STATUS_VALUE}    Enable
  ${status_label}=    Catenate     SEPARATOR=     ${new_interface}    ${status_label}
  ${status_value}=    Catenate     SEPARATOR=     ${new_interface}    ${status_value}
  ${interface_menu_bar}=     REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_SELECT_INTERFACE_MEMBER_MENU_BAR}    ${interface}
  wait and click    ${interface_select_menu}
  wait and click    ${interface_menu_bar}
  wait and click    ${gateway_input}
  clear element text    ${gateway_input}
  input text   ${gateway_input}    ${gateway}
  ${status}=    get element attribute    ${status_value}    class
  ${status}=    run keyword and return status    should contain    ${status}    valid-parse
  run keyword if     "${status}"=="False"    wait and click    ${status_label}

Set Interface Role To
    [Arguments]    ${role}
    [Documentation]  this keyword is to set interface role to LAN WAN DMZ or Udefined from the role menu on the edit page
    wait and click   ${NETWORK_INTERFACES_EDIT_ROLE_SELECT_MENU}
    ${new_locator}=  REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_INTERFACES_EDIT_ROLE_SELECT_MENUBAR}   ${role}
    wait and click   ${new_locator}
    wait and click   ${SUBMIT_OK_BUTTON}
    unselect frame

Set Interface Addressing Mode To
    [Arguments]    ${add_mode}
    [Documentation]   this keyword is to set interface addressing mode to Manual    DHCP    PPPOE 
    ...               One-Arm Sniffer    Dedicate to FortiSwitch 
    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACE_ADDRESSING MODE}    ${add_mode}
    wait and click    ${new_locator}     
    wait and click    ${SUBMIT_OK_BUTTON}
    unselect frame    

network_Interfaces_admin access_ipv6_select
    [Arguments]      ${application_name}
    ${new_label}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACE_ADMINISTRATIVE ACESS_LABEL_IPV6}       ${application_name}
    ${new_locator}=  REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACE_ADMINISTRATIVE ACESS_CHECKBOX_IPV6}    ${application_name}
    wait until Element Is Visible   ${new_locator}
    ${status}=   run keyword and return status   Checkbox Should Be Selected    ${new_locator}
    Run keyword if   "${status}"=="False"   wait and click     ${new_label}


Change Interface Vdom To  
   [Arguments]   ${interface}   ${new_vdom}
   [Documentation]   This keyword is to change VDOM of an interface to a new one
   network edit interface   ${interface}
   wait and click    ${NETWORK_INTERFACE_VDOM_SELECT_BUTTON} 
   ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_INTERFACE_VDOM_SELECT_MENU_BAR}  ${new_vdom}
   wait and click    ${new_locator}
   wait and click    ${SUBMIT_OK_BUTTON}

Set Capture Interface 
    [Arguments]       ${capture_interface}   ${max}=4000    ${filter}=nofilter   ${ipv6}=noipv6   ${non_ip}=non_ip
    ...               ${host}=none    ${port}=none    ${vlan}=none    ${protocol}=none
    [Documentation]   this keyword is to set an interface to be captured
    select frame      ${NETWORK_FRAME}
    sleep   2
    wait and click    ${NETWORK_PACKET_CAPTURE_CREATE_NEW_BUTTON}
    wait and click    ${NETWORK_PACKET_CAPTURE_CREATE_NEW_INTERFACE}
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_PACKET_CAPTURE_CREATE_NEW_INTERFACE_ITEM}   ${capture_interface}
    wait and click    ${new_locator}
    wait and click    ${NETWORK_PACKET_CAPTURE_CREATE_NEW_MAX}
    clear element text    ${NETWORK_PACKET_CAPTURE_CREATE_NEW_MAX}
    input text    ${NETWORK_PACKET_CAPTURE_CREATE_NEW_MAX}     ${max}
    @{filter_list}=     Create List    Host    Port    VLAN    Protocol
    ${status_filter}=   run keyword and return status    checkbox should be selected    ${NETWORK_PACKET_CAPTURE_CREATE_NEW_FILTER_CHECKBOX}
    ${status_ipv6}=     run keyword and return status    checkbox should be selected    ${NETWORK_PACKET_CAPTURE_CREATE_NEW_IPV6_CHECKBOX}
    ${status_nonip}=    run keyword and return status    checkbox should be selected    ${NETWORK_PACKET_CAPTURE_CREATE_NEW_NON_IP_CHECKBOX}
    ${host_input}=      REPLACE PLACEHOLDER IN LOCATOR WITH VALUE     ${NETWORK_PACKET_CAPTURE_CREATE_NEW_FILTER_ITEM}   Host 
    ${port_input}=      REPLACE PLACEHOLDER IN LOCATOR WITH VALUE     ${NETWORK_PACKET_CAPTURE_CREATE_NEW_FILTER_ITEM}   Port 
    ${vlan_input}=      REPLACE PLACEHOLDER IN LOCATOR WITH VALUE     ${NETWORK_PACKET_CAPTURE_CREATE_NEW_FILTER_ITEM}   VLAN
    ${protocol_input}=      REPLACE PLACEHOLDER IN LOCATOR WITH VALUE     ${NETWORK_PACKET_CAPTURE_CREATE_NEW_FILTER_ITEM}   Protocol
    run keyword if     "${status_filter}"=="False" and "${filter}"=="filter"    wait and click    ${NETWORK_PACKET_CAPTURE_CREATE_NEW_FILTER_LABEL}
    sleep   1
    :FOR    ${element}   IN   @{filter_list}
    \       ${input}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE     ${NETWORK_PACKET_CAPTURE_CREATE_NEW_FILTER_ITEM}   ${element}
    \       run keyword if    "${filter}"=="filter"    clear element text    ${input}    
    \       run keyword if    "${filter}"=="filter"    input text    ${input}    ${${element}}
    run keyword if    "${status_ipv6}"=="False" and "${ipv6}"=="ipv6"       wait and click    ${NETWORK_PACKET_CAPTURE_CREATE_NEW_IPV6_LABEL}
    run keyword if    "${status_nonip}"=="False" and "${non_ip}"=="non_ip"   wait and click    ${NETWORK_PACKET_CAPTURE_CREATE_NEW_NON_IP_LABEL}
    wait and click  ${SUBMIT_OK_BUTTON}
    unselect frame

Edit Capture 
    [Arguments]       ${capture_interface}
    [Documentation]   this keyword is to edit an interface is being captured
    select frame      ${NETWORK_FRAME}
    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_PACKET_CAPTURE_SNIFFER_ITEMS}    ${capture_interface}
    wait and click    ${new_locator}
    wait and click    ${NETWORK_PACKET_EDIT_BUTTON}

COUNT INTERFACES OF VDOM
    [Arguments]      ${vdom_name}
    [Documentation]  this keyword it to count interface numbers of a vdom on GUI network interface page
    select frame     ${NETWORK_FRAME}
    sleep   2
    ${count_v}=    EVALUATE   0
    ${count_g}=    EVALUATE   0
    ${interface_type}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACES_TYPE}    Physical
    :FOR    ${i}   IN RANGE   1   100
        \   ${phy_int_locator}=   CATENATE  SEPARATOR=    ${interface_type}/following-sibling::tbody[1]    /tr[${i}]/
        \   ${vdom_locator}=      CATENATE  SEPARATOR=    ${phy_int_locator}    ${NETWORK_INTERFACES_TABLE_VDOM_SPAN}
        \   ${vdom}=    Run Keyword and Return Status   wait until element is visible   ${vdom_locator}
        \   ${vdom}=    Run Keyword If    "${vdom}"=="True"    get text    ${vdom_locator}
        \   ...  ELSE   EXIT FOR LOOP
        \   ${count_v}=   Run Keyword If    "${vdom}"=="${vdom_name}"    EVALUATE   ${count_v}+1   
        \   ...           ELSE   EVALUATE   ${count_v}+0
        \   ${status}=    Run Keyword and Return Status    should be equal   "${vdom}"   "${vdom_name}"
        \   ${count_g}=   Run Keyword If    "${status}"=="False"    EVALUATE   ${count_g}+1    
        \   ...           ELSE   EVALUATE   ${count_g}+0
    [Return]    ${count_v}

## netwrok dns server ###
Set DNS over TLS 
    [Arguments]   ${type}
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_DNS_DNS SETTINGS_TLS_BUTTON}    ${type}
    wait and click    ${new_locator}

Set DNS SSL Cert 
    [Arguments]    ${cert}
    SELECT MEBU BAR FROM DROPDOWN MENU  ${cert}  SSL Certificate

Test Dns Latency Color
    [Arguments]     ${dnsname}    ${dns_ip}
    ${latency_ban}=      GET TEXT    ${NETWORK_DNS_DNS SETTINGS_LATENCY_${dnsname}}
    ${latency_attr}=    GET element attribute    ${NETWORK_DNS_DNS SETTINGS_LATENCY_${dnsname}_SPAN}    className
    ${unreach}=    run keyword and return status    should contain    ${latency_ban}    Unreachable
    ${latency}=    FETCH FROM RIGHT    ${latency_ban}    ${dns_ip}
    ${latency}=    FETCH FROM LEFT     ${latency}    ms
    ${latency}=    STRIP STRING    ${latency}
    ${latency}=    REPLACE STRING   ${latency}    ,    ${EMPTY}
    ${length}=     GET LENGTH   ${latency}
    ${latency}=    GET SUBSTRING    ${latency}    0   ${length}
    ${latency}=     Set Variable If    ${unreach}   10000   ${latency}
    ${speed_1}=    EVALUATE   ${latency}<100
    ${speed_2}=    EVALUATE   100<${latency}<200
    ${speed_3}=    EVALUATE   ${latency}>200
    run keyword if    ${speed_1}    should contain    ${latency_attr}    severity-none
    run keyword if    ${speed_2}    should contain    ${latency_attr}    severity-medium
    run keyword if    ${speed_3}    should contain    ${latency_attr}    severity-critical

Test Ipv4 Dns Latency
    [Arguments]    ${type}
    @{command}=    CREATE LIST    config global     diag test application dnsproxy 2
    ${latency_ban}=      GET TEXT    ${NETWORK_DNS_DNS SETTINGS_LATENCY_${type}}
    ${latency_ip}=     Get Regexp Matches    ${latency_ban}   ([0-9]{1,3}\.){3}[0-9]{1,3}
    ${latency_ip}=   GET FROM LIST   ${latency_ip}   0
    ${latency}=    FETCH FROM RIGHT    ${latency_ban}    ${latency_ip}
    ${latency}=    FETCH FROM LEFT     ${latency}    ms
    ${latency}=    STRIP STRING    ${latency}
    ${latency}=    REPLACE STRING   ${latency}    ,    ${EMPTY}
    ${length}=     GET LENGTH   ${latency}
    ${length}=     EVALUATE    ${length}-1
    ${latency}=     GET SUBSTRING    ${latency}    0   ${length}
    ${unreach}=    run keyword and return status    should contain    ${latency_ban}    Unreachable
    ${latency}=     Set Variable If    ${unreach}   -1   ${latency}
    @{response_ssh}=  Execute CLI commands on FortiGate Via Direct Telnet     ${command}   
    ${response}=      Set Variable    @{response_ssh}[-1]
    ${cli_list_pri}=     CATENATE     server=${latency_ip}   latency=\-?[1-9][0-9]*,?[0-9]*
    ${latency_cli}=   Get Regexp Matches    ${response}    ${cli_list_pri}
    ${latency_cli}=   GET FROM LIST   ${latency_cli}   0
    ${latency_cli}=   FETCH FROM RIGHT   ${latency_cli}    latency=
    should be equal    "${latency}"     "${latency_cli}"

Test Ipv6 Dns Latency
    [Arguments]    ${type}     ${dns_ip}
    @{command}=    CREATE LIST    config global     diag test application dnsproxy 2
    ${latency_ban}=      GET TEXT    ${NETWORK_DNS_DNS SETTINGS_LATENCY_${type}_IPV6}
    ${latency}=    FETCH FROM RIGHT    ${latency_ban}    ${dns_ip}
    ${latency}=    FETCH FROM LEFT     ${latency}    ms
    ${latency}=    STRIP STRING    ${latency}
    ${latency}=    REPLACE STRING   ${latency}    ,    ${EMPTY}
    ${length}=     GET LENGTH   ${latency}
    ${length}=     EVALUATE    ${length}-1
    ${latency}=    GET SUBSTRING    ${latency}    0   ${length}
    ${unreach}=    run keyword and return status    should contain    ${latency_ban}    Unreachable
    ${latency}=    Set Variable If    ${unreach}   -1   ${latency}
    @{response_ssh}=  Execute CLI commands on FortiGate Via Direct Telnet     ${command}   
    ${response}=      Set Variable    @{response_ssh}[-1]
    ${cli_list_pri}=     CATENATE     server=${dns_ip}   latency=\-?[1-9][0-9]*,?[0-9]*
    ${latency_cli}=   Get Regexp Matches    ${response}    ${cli_list_pri}
    ${latency_cli}=   GET FROM LIST   ${latency_cli}   0
    ${latency_cli}=   FETCH FROM RIGHT   ${latency_cli}    latency=
    should be equal    "${latency}"     "${latency_cli}"

######### DASHBOARD ################################################################################
###  DASHBOARD widget #######
system_test_if_widget_exist  
    [Arguments]    ${widget_name} 
    [Documentation]   This keyword is to test if a widget is already exsit on the dashboard page
    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${system_widget_widgetbanner}   ${widget_name} 
    ${new_locator}=   Set Variable If   "${widget_name}"=="License Status"   ${system_widget_Licenses_widgetbanner}    ${new_locator}
    sleep  1
    Wait Until Element is visible   ${new_locator}

system_Add_widget
    [Arguments]    ${widget_name}   
    [Documentation]   This keyword it to add a widget to the dashboard page
    system_click_widget_setting_button
    Wait and click    ${system_widget_setting_add_widget_button}
    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${system_widget_setting_add_widget_name}   ${widget_name} 
    ${disable}=       check if the widget button is add_disable    ${widget_name}
    run keyword if    "${disable}"=="False"   Wait and click    ${new_locator}     
    run keyword if    "${disable}"=="False"   Wait and click   ${system_widget_setting_add_widget_close_button}

system_reset_dashboard
    [Documentation]   This keyword is to reset dashboard to default
    system_click_widget_setting_button
    Wait and click     ${system_widget_setting_reset_dashboards_button}
    Wait and click     ${system_widget_setting_reset_dashboards_OK_button}

system_click_widget_setting_button
    Mouse Over      ${system_widget_dashboard_blank_page}
    Wait Until Element Is Visible    ${system_widget_setting_button}
    Click Element   ${system_widget_setting_button}

    

system_Add_widget_bandwith
    [Arguments]     ${interface}
    system_click_widget_setting_button
    Wait and click     ${system_widget_setting_add_widget_button}
    Wait and click     ${system_widget_setting_add_widget_Interface Bandwith_button}
    Wait and click     ${system_widget_setting_add_widget_Interface Bandwith_popup_menu}
    ${exist}=   Run keyword and return status    Wait Until Element Is Visible   xpath://div[span/span[contains(text(),"${interface}")]]
    Run keyword if   "${exist}"=="True"     Wait and click     xpath://div[span/span[contains(text(),"${interface}")]]
    Run keyword if   "${exist}"=="True"     Wait and click     ${system_widget_setting_add_widget_Interface Bandwith_Add Widget_button} 
    Run keyword if   "${exist}"=="False"    Wait and click     ${system_widget_setting_add_widget_Interface Bandwith_window_banner}
    Run keyword if   "${exist}"=="False"    Wait and click     ${system_widget_setting_add_widget_Interface Bandwith_Back_button} 
    Wait and click    ${system_widget_setting_add_widget_close_button}


check if the Bandwidth of interface widget is appeared in the main page 
    [Arguments]   ${interface}
    ${interface_xpath_mainpage_widget}=     REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_WIDGET_Bandwith_interface}    ${interface}
    ${exist}=    run keyword and return status    Wait Until Element Is Visible   ${interface_xpath_mainpage_widget}
    [Return]    ${exist}



check if the widget button is add_disable 
    [Arguments]   ${_widget_name}
    [Documentation]   This keyword it to check if the widget's button can be clicked on the add widget page
    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${system_widget_setting_add_widget_name}   ${widget_name} 
    Wait Until Element Is Visible    ${new_locator}
    ${if_disable}=    Get Element Attribute   ${new_locator}    disabled
    ${disabled}=      Set variable if   "${if_disable}"=="true"       True    False
    [Return]    ${disabled}
    
check if the added widget is appeared in the main page 
    [Arguments]    @{list_added_widget}
    [Documentation]   This keyword is to check if the widgets are on the dashboard page, the widgets should be put in a list
    ...               the License widget if different from others, so need to set seperately.
    :FOR   ${element}   IN    @{list_added_widget}
    \   ${new_locator}=  REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${system_widget_widgetbanner}   ${element}
    \   ${new_locator}=  Set variable if  "${element}"=="License Status"   ${system_widget_Licenses_widgetbanner}    ${new_locator}
    \   Wait Until Element Is Visible    ${new_locator}
    
check if the widget is reset to default
    [Arguments]     @{list}  
    :FOR   ${element}   IN    @{list} 
        \    loop_for_waiting_element   ${element}
    
    

loop_for_waiting_element
    [Arguments]    ${element}
    :FOR   ${i}    IN RANGE  1    10
        \    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${system_widget_widgetbanner}   ${element}
        \    ${new_locator}=   Set variable if  "${element}"=="License Status"   ${system_widget_Licenses_widgetbanner}    ${new_locator}
        \    ${exist}=    Run keyword and return status    Wait Until Element Is Visible   ${new_locator}
        \    Exit For Loop If    "${exist}"=="True"
    
system_Add_widget_bandwith_firtst_interface_on_menu
    system_click_widget_setting_button
    Wait and click    ${system_widget_setting_add_widget_button}
    Wait and click    ${system_widget_setting_add_widget_Interface Bandwith_button}
    Wait and click    ${system_widget_setting_add_widget_Interface Bandwith_popup_menu}
    sleep   2
    ${interface}=     Get Text   ${system_widget_setting_add_widget_Interface Bandwith_firstinterface_menu_bar_span}
    Wait and click    ${system_widget_setting_add_widget_Interface Bandwith_firstinterface_menu_bar}
    Wait and click    ${system_widget_setting_add_widget_Interface Bandwith_Add Widget_button} 
    Wait and click    ${system_widget_setting_add_widget_close_button}
    [Return]          ${interface}

system_Add_widget_bandwith_second_interface_on_menu
    system_click_widget_setting_button
    Wait and click    ${system_widget_setting_add_widget_button}
    Wait and click    ${system_widget_setting_add_widget_Interface Bandwith_button}
    Wait and click    ${system_widget_setting_add_widget_Interface Bandwith_popup_menu}
    sleep   2
    ${interface}=     Get Text   ${system_widget_setting_add_widget_Interface Bandwith_secondinterface_menu_bar_span}
    Wait and click    ${system_widget_setting_add_widget_Interface Bandwith_secondinterface_menu_bar}
    Wait and click    ${system_widget_setting_add_widget_Interface Bandwith_Add Widget_button} 
    Wait and click    ${system_widget_setting_add_widget_close_button}
    [Return]          ${interface}

system_Add_widget_fortiview
    [Arguments]    ${title}   
    system_click_widget_setting_button
    Wait and click    ${system_widget_setting_add_widget_button}
    Wait and click    ${system_widget_setting_add_widget_FortiView_button}
    Input Text   ${system_widget_setting_add_widget_Fortiview_add_title}    ${title}
    SELECT MEBU BAR FROM DROPDOWN MENU    Applications      FortiView 
    Wait and click    ${system_widget_setting_add_widget_Fortiview_Add Widget_button} 
    Wait and click    ${system_widget_setting_add_widget_close_button}

get element in add widget
    [Documentation]   this keyword is to get the xpath of widgets, which widget is not known at this time when write the script
    ...               return a dictionary of button and xpath, the keyword maybe need to be optimized, it hasn't run at this time
     &{widget_dic}=    Create dictionary 
     :FOR  ${i}    IN RANGE   1   10
     \  ${exist}=    Run Keyword and Return Status    wait until element is Visible   xpath://form//div/section[${i}]  
     \  exit for loop if  "${exist}"=="False"
     \  ${widget_dic}=    get button xpath   ${i}  ${widget_dic}
     [Return]   ${widget_dic}

get button xpath
    [Arguments]   ${i}  ${widget_dic}
    [Documentation]    this keyword is a sub-function of "get element in add widget"
     :FOR  ${j}    IN RANGE  1   10
     \  ${exist}=    Run Keyword and Return Status    wait until element is Visible   xpath://form//div/section[${i}]/button[${j}]  
     \  exit for loop if  "${exist}"=="False"
     \  ${widget}=   Set Variable   widget${i}_${j}
     \  Set To Dictionary   ${widget_dic}   ${widget}   xpath://form//div/section[${i}]/button[${j}] 
    [Return]   ${widget_dic}


SELECT MENU BAR FROM SELECTION PANE
   [Arguments]   ${menu_bar}
   [Documentation]  this keyword is used to select menubar from the slide pane
   ${new_locator}=  REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SELECTION_SPAN_MENU_BAR}   ${menu_bar}
   wait and click   ${new_locator}
   wait and click   ${SELECTION_SPAN_MENU_CLOSE_BUTTON}

SELECT MENU BAR FROM POLICY SELECTION PANE
   [Arguments]         ${menu_bar}    ${menu_title}=Address
   [Documentation]  this keyword is used to select menubar from the slide pane of policy
   ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SELECTION_POLICY_TITLE_MENU}    ${menu_title}
   ${status}=        run keyword and return status     Wait Until Element Is Visible   ${new_locator}
   run keyword if    "${status}"=="True"     wait and click   ${new_locator}
   ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SELECTION_SPAN_MENU_BAR}   ${menu_bar}
   wait and click   ${new_locator}
   wait and click   ${SELECTION_SPAN_MENU_CLOSE_BUTTON}

SELECT MEBU BAR FROM DROPDOWN MENU
    [Arguments]       ${menu_bar}    ${menu_name}=NONE
    [Documentation]   this keyword is to common select a menubar from a dropdown menu, no fit to all type of menu
    ...               menu name is normaly the name on the left of the menu on the web page
    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_COMON_DROPDOWN_MENU_MULTMENU}    ${menu_name}
    RUN KEYWORD IF     "${menu_name}"=="NONE"    wait and click        ${SYSTEM_COMON_DROPDOWN_MENU_ONEMENU}
    ...                ELSE    wait and click    ${new_locator}
    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_COMON_DROPDOWN_MENU_BAR}    ${menu_bar}
    wait and click    ${new_locator}


TEST FROM CLI AND CHECK REGXP
    [Arguments]     ${cmd_list}   ${regx}=${EMPTY}   ${ip_address}=${FGT_CLI_FGT_INTERNAL_IP}   ${prompt}=${FGT_CLI_PROMPT}   ${username}=admin   ${password}=${EMPTY}  ${response_index}=-1
    [Documentation]   This keyword is to do a test in CLI line and check if a REGX is in the output
    @{tel_cmd_FGT_test}=   Create List    
    APPEND TO LIST    ${tel_cmd_FGT_test}    @{cmd_list}
    @{response_ssh}=  Execute CLI commands on FortiGate Via Direct Telnet     ${tel_cmd_FGT_test}   ip_address=${ip_address}   prompt=${prompt}   username=${username}   password=${password}
    ${response}=      Set Variable    @{response_ssh}[${response_index}]
    should match regexp    ${response}   ${regx}

BACKUP CONFIGURATION
    [Arguments]     ${username}=admin    ${backup_scope}=Global   ${backup_vdom}=${SYSTEM_TEST_VDOM_NAME_1}    ${backup_disk}=local-pc     ${file_name}=backup.conf   ${encrypt_passwd}=${NONE}
    [Documentation]   This keyword is to backup config to a disk
    ${locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${LOGOUT_ICON_BUTTON}    ${username}
    wait and click     ${locator}
    Mouse over         ${ADMIN_CONFIGURATION_BAR}
    ${exist}=    run keyword and return status    wait until element is visible     ${ADMIN_CONFIGURATION_BACKUP_BUTTON}
    run keyword if    "${exist}"=="False"   wait and click    ${ADMIN_CONFIGURATION_BAR}
    wait and click     ${ADMIN_CONFIGURATION_BACKUP_BUTTON}
    sleep   2
    @{cmd_list_usb}=    create list  
    APPEND TO LIST    ${cmd_list_usb}    config global   exec usb-disk list
    ${backup_scope_button}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${ADMIN_CONFIGURATION_BACKUP_LABEL}    ${backup_scope}
    wait and click    ${backup_scope_button}
    run keyword if   "${backup_scope}"=="VDOM"    SELECT MEBU BAR FROM DROPDOWN MENU      ${backup_vdom}
    ${disk_usb}=    run keyword and return status   should contain    ${backup_disk}   usb
    run keyword if    "${disk_usb}"=="True"    wait and click    ${ADMIN_CONFIGURATION_BACKUP_USB_LABEL}   ELSE   wait and click    ${ADMIN_CONFIGURATION_BACKUP_PC_LABEL}
    run keyword if    "${disk_usb}"=="True"    wait and click    ${ADMIN_CONFIGURATION_BACKUP_USB_FILENAME}
    run keyword if    "${disk_usb}"=="True"    clear element text    ${ADMIN_CONFIGURATION_BACKUP_USB_FILENAME}
    run keyword if    "${disk_usb}"=="True"    input text    ${ADMIN_CONFIGURATION_BACKUP_USB_FILENAME}    ${file_name}
    ${status}=    run keyword and return status    checkbox should be selected    ${ADMIN_CONFIGURATION_BACKUP_ENCRYPT_CHKBOX}
    run keyword if    "${encrypt_passwd}"!="${NONE}" and "${status}"=="False"   wait and click    ${ADMIN_CONFIGURATION_BACKUP_ENCRYPT_LABEL}
    run keyword if    "${encrypt_passwd}"!="${NONE}"    clear element text   ${ADMIN_CONFIGURATION_BACKUP_ENCRYPT_PWD}
    run keyword if    "${encrypt_passwd}"!="${NONE}"    input text    ${ADMIN_CONFIGURATION_BACKUP_ENCRYPT_PWD}    ${encrypt_passwd}
    run keyword if    "${encrypt_passwd}"!="${NONE}"    clear element text   ${ADMIN_CONFIGURATION_BACKUP_ENCRYPT_PWD_CONFIRM}
    run keyword if    "${encrypt_passwd}"!="${NONE}"    input text    ${ADMIN_CONFIGURATION_BACKUP_ENCRYPT_PWD_CONFIRM}    ${encrypt_passwd}
    wait and click     ${SUBMIT_OK_BUTTON}
    sleep  30
    ##check if the backup_file is in usb-disk
    run keyword if    "${disk_usb}"=="True"    TEST FROM CLI AND CHECK REGXP    ${cmd_list_usb}   ${file_name}
    ${year}=    Get time   year    NOW
    ${month}=   Get time   month   NOW
    ${day}=     Get time   day     NOW
    ${hour}=    Get time   hour    NOW
    ${date}=    set Variable    ${year}${month}${day}
    ${file_name_return}=    Set Variable    ${FGT_HOSTNAME}_${date}_${hour}??.conf
    ${file_name_pc}=        Set Variable    ${SYSTEM_FILE_DOWNLOAD_DIR_PATH}${/}${FGT_HOSTNAME}_${date}_${hour}??.conf
    run keyword if    "${disk_usb}"=="False"    Should Exist   ${file_name_pc}
    unselect frame
    [Return]    ${file_name_return}

RESTORE CONFIGURATION
    [Arguments]     ${username}=admin    ${restore_scope}=Global   ${restore_vdom}=${SYSTEM_TEST_VDOM_NAME_1}    ${restore_disk}=local-pc     ${file_name}=backup.conf   ${encrypt_passwd}=${NONE}
    [Documentation]   This keyword is to restore config from a disk
    ${locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${LOGOUT_ICON_BUTTON}    ${username}
    wait and click     ${locator}
    Mouse over         ${ADMIN_CONFIGURATION_BAR}
    ${exist}=    run keyword and return status    wait until element is visible     ${ADMIN_CONFIGURATION_RESTORE_BUTTON}
    run keyword if    "${exist}"=="False"   wait and click    ${ADMIN_CONFIGURATION_BAR}
    wait and click    ${ADMIN_CONFIGURATION_RESTORE_BUTTON}
    sleep   2
    ${restore_scope_button}=  REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${ADMIN_CONFIGURATION_BACKUP_LABEL}     ${restore_scope}
    ${restore_label_pc}=      REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${ADMIN_CONFIGURATION_RESTORE_LABEL}    Local PC
    ${restore_label_usb}=     REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${ADMIN_CONFIGURATION_RESTORE_LABEL}    USB Disk
    wait and click    ${restore_scope_button}
    run keyword if   "${restore_scope}"=="VDOM"    SELECT MEBU BAR FROM DROPDOWN MENU      ${restore_vdom} 
    ${disk_usb}=    run keyword and return status   should contain    ${restore_disk}   usb
    ${disk}=   SET Variable If   "${disk_usb}"=="True"    usb    pc
    wait and click    ${restore_label_${disk}}
    ${restore_file_name}=     Set Variable    ${SYSTEM_FILE_DOWNLOAD_DIR_PATH}${/}${file_name}
    ${menu-bar}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${ADMIN_CONFIGURATION_RESTORE_FILE_MENU_BAR}   ${file_name}
    ${menu-bar}=    CATENATE     SEPARATOR=     ${ADMIN_CONFIGURATION_RESTORE_FILE_MENU}    ${menu-bar}
    run keyword if    "${disk_usb}"=="True"    wait and click    ${ADMIN_CONFIGURATION_RESTORE_FILE_MENU}
    run keyword if    "${disk_usb}"=="True"    wait and click    ${menu-bar}
    ...    ELSE   choose file     ${ADMIN_CONFIGURATION_RESTORE_FILE_PC}   ${restore_file_name}
    run keyword if    "${encrypt_passwd}"!="${NONE}"    clear element text   ${ADMIN_CONFIGURATION_BACKUP_ENCRYPT_PWD}
    run keyword if    "${encrypt_passwd}"!="${NONE}"    input text    ${ADMIN_CONFIGURATION_BACKUP_ENCRYPT_PWD}    ${encrypt_passwd}
    wait and click     ${SUBMIT_OK_BUTTON}
    run keyword if    "${restore_scope}"=="Global"    wait and click     ${CONFIRM_OK_BUTTON}
    sleep  30  
    unselect frame