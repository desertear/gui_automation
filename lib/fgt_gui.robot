*** Settings ***
Documentation     This file contains FortiGate GUI main page operation

*** Keywords ***
##login/logout FGT portal
Login FortiGate
    [timeout]    ${FGT_KEYWORD_MAX_RUNNING_TIME}
    [Documentation]     Open browser and login to FortiGate's mainpage. 
    ...    The authentication type ${auth_type} can be "password", "token", "email", "sms", "pki" and "sso".
    [Arguments]    ${url}=${FGT_URL}    ${browser}=${FGT_BROWSER}    ${alias}=None    ${username}=${FGT_GUI_USERNAME}    ${password}=${FGT_GUI_PASSWORD}
    ...    ${remote_url}=${FGT_REMOTE_URL}    ${desired_capabilities}=${FGT_DESIRED_CAPABILITIES}    ${ff_profile_dir}=${FGT_FF_PROFILE_DIR}
    ...    ${if_need_pre_banner}=${False}    ${if_need_post_banner}=${False}    ${auth_type}=password    ${pki_auth}=${False}    &{others}
    #open browser
    ${browser_index}=    open browser    ${url}    browser=${browser}    alias=${alias}
    ...    remote_url=${remote_url}    desired_capabilities=${desired_capabilities}    ff_profile_dir=${ff_profile_dir}
    #configure browser
    Run Keyword And Continue On Failure    configure browser
    #wait until pre banner"Login Disclaimer" prompt
    Run Keyword And Continue On Failure    handle disclaimer    ${if_need_pre_banner}
    #process authentication according to authentication type
    Run Keyword And Continue On Failure    process authentication for admin    ${username}    ${password}    ${auth_type}    ${pki_auth}    &{others}
    #Now admin should pass authentication, need to wait until "Login Disclaimer" prompt
    Run Keyword And Continue On Failure    handle disclaimer    ${if_need_post_banner}
    #handle different warnings
    Run Keyword And Continue On Failure    handle different warnings
    #check if admin login successfully
    Run Keyword And Continue On Failure    check if admin login successfully    ${username}
    [return]    ${browser_index}

Logout FortiGate
    [timeout]    ${FGT_KEYWORD_MAX_RUNNING_TIME}
    [Arguments]    ${username}=${FGT_GUI_USERNAME}    ${if_need_pre_banner}=${False}    ${auth_type}=password    ${pki_auth}=${False}
    unselect frame
    ${locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${LOGOUT_ICON_BUTTON}    ${username}
    click button    ${locator}
    sleep    1
    click button    ${LOGOUT_LOGOUT_BUTTON}
    #wait until pre banner"Login Disclaimer" prompt
    handle disclaimer    ${if_need_pre_banner}
    #wait until login button or pki warning
    Run keyword if    "${auth_type}"!="sso" and ${pki_auth}    Wait Until Element Is Visible    ${LOGOUT_PKI_WARNING}
    ...    ELSE    Wait Until Element Is Visible    ${LOGIN_LOGIN_BUTTON}

configure browser
    Maximize Browser Window
    ##A workaround that solves scrrens resolution issue on Robot Env.
    Set Window Size    ${SCREEN_SIZE_WIDTH}    ${SCREEN_SIZE_HEIGTH}
    get all selenium config
    ${window_width}    ${window_height}=    Get Window Size
    ${page_width}    ${page_height}=    Get Element Size    xpath:/html

Process authentication for admin
    [Documentation]    Process authentication according to authentication type. 
    ...    The authentication type ${auth_type} can be "password", "token", "email", "sms", "pki" and "sso".
    [Arguments]    ${username}    ${password}    ${auth_type}    ${pki_auth}    &{others}
    run keyword if    "${auth_type}"=="sso"    redirect to idp authentication page    ${pki_auth}
    run keyword if    not ${pki_auth}    process password authentication    ${username}    ${password}    &{others}
    #when authentication has finished, browser jump back to source page.
    run keyword if    "${auth_type}"=="sso"    redirect back to source page
    #todo: implement other types when it's necessary.

process password authentication
    [Arguments]    ${username}    ${password}    &{others}
    #input username and password
    process regular password authentication    ${username}    ${password}
    ${change_password_status}=    Run keyword and return status    Dictionary Should Contain Key    ${others}    change_password
    Run keyword if    ${change_password_status}    change password and then login    ${username}    ${password}    &{others}
    # ${mobile_token_status}=    Run keyword and return status    Dictionary Should Contain Key    ${others}    fortitoken_mobile
    # Run keyword if    ${mobile_token_status}    get fortitoken mobile and then login    &{others}

process regular password authentication
    [Arguments]    ${username}    ${password}
    #input username and password
    Wait Until Element Is Visible    ${LOGIN_USERNAME_TEXT}
    input text    ${LOGIN_USERNAME_TEXT}    ${username}
    input password    ${LOGIN_PASSWORD_TEXT}    ${password}
    click button    ${LOGIN_LOGIN_BUTTON}

change password and then login
    [Arguments]    ${username}    ${password}    &{others}
    Dictionary Should Contain Key    ${others}    new_password
    ${new_password}=    set variable    &{others}[new_password]
    #input username and password
    Wait Until Element Is Visible    ${LOGIN_CHANGE_PASSWORD_HEAD}
    input password    ${LOGIN_CHANGE_PASSWORD_OLD_PASSWORD}    ${password}
    input password    ${LOGIN_CHANGE_PASSWORD_NEW_PASSWORD}    ${new_password}
    input password    ${LOGIN_CHANGE_PASSWORD_CONFIRM_PASSWORD}    ${new_password}
    click button    ${LOGIN_CHANGE_PASSWORD_OK_BUTTON}
    process regular password authentication    ${username}    ${new_password}

handle disclaimer
    [Arguments]    ${if_need_banner}
    run keyword if    "${if_need_banner}"=="${True}"    Run Keyword And Continue On Failure    Wait Until Page Contains Element    ${FIPS_DISCLAIMER_HEAD}
    run keyword if    "${if_need_banner}"=="${True}"    Run Keyword And Continue On Failure    click button    ${FIPS_ACCEPT_BUTTON}

check if admin login successfully
    [Arguments]    ${username}
    #Judge if the icon of logged in admin is shown to confirm admin has already logged in successfully.
    ${locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${LOGOUT_ICON_BUTTON}    ${username}
    Run Keyword And Continue On Failure    Wait Until Keyword Succeeds    3x    2s    Wait Until Element is visible    ${locator}

Handle different warnings
    [Documentation]    handle different warnings before logging in
    #Judge if warning of "File System Check Recommended" would be shown on GUI
    ${if_check_disk}=    run keyword and return status    Wait Until Page Contains Element    ${LOGIN_FILE_CHECK_HEAD}
    run keyword if    "${if_check_disk}"=="True"    click button    ${LOGIN_FILE_CHECK_LATER}
    #Judge if warning of changing password would be shown on GUI
    ${if_password_change}=    run keyword and return status    Wait Until Page Contains Element    ${PWD_CHANGE_HEAD}
    run keyword if    "${if_password_change}"=="True"    click button    ${PWD_CHANGE_LATER_BUTTON}
    #Judge if warning of being managed by FortiManager device would be shown on GUI
    ${if_managed_by_fmg}=    run keyword and return status    Wait Until Page Contains Element    ${FMG_LOGIN_HEAD}
    run keyword if    "${if_managed_by_fmg}"=="True"    click button    ${FMG_LOGIN_READ_WRITE_BUTTON}
    #Judge if warning of out-of-sync on FortiManager device would be shown on GUI
    ${out_of_sync_warning_fmg}=    run keyword and return status    Wait Until Page Contains Element    ${OUT_OF_SYNC_FMG_TEXT}
    run keyword if    "${out_of_sync_warning_fmg}"=="True"    click button    ${OUT_OF_SYNC_FMG_YES_BUTTON}
    #Judge if warning of out-of-sync on FortiManager device would be shown on GUI
    ${forticare_registration_required}=    run keyword and return status    Wait Until Page Contains    FortiCare Registration Required
    run keyword if    "${forticare_registration_required}"=="True"    click button    ${FORTICARE_REQUIRED_BUTTON}
    # Set Selenium Timeout    ${orig timeout}
    #Check if warning of "File System Check is recommended" is shown, and Check "remind me later"
    #Add it later

redirect to idp authentication page
    [Arguments]    ${pki_auth}
    Wait Until Element is visible    ${SYSTEM_SAML_HREF_ON_LOGIN_PAGE}
    Click element    ${SYSTEM_SAML_HREF_ON_LOGIN_PAGE}
    run keyword if    not ${pki_auth}    Wait Until element is visible    ${SYSTEM_SAML_IDP_PAGE_SSO_HEADER}

redirect back to source page
    log    do nothing at present

##Switch to new vdom from old vdom
Go to VDOM
    [Arguments]    ${new_vdom}=${FW_TEST_VDOM_NAME_1}    ${old_vdom}=Global    
    ${menu_vdom_current}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${MENU_VDOM_LIST_CURRENT_VDOM}    ${old_vdom}
    Wait Until Element Is Visible    ${menu_vdom_current}    
    Click Element    ${menu_vdom_current}
    ${menu_vdom_new}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${MENU_VDOM_LIST_NEW_VDOM}    ${new_vdom}
    Wait Until Element Is Visible    ${menu_vdom_new}
    Click Element    ${menu_vdom_new}
    sleep    2s
    ${menu_vdom_current}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${MENU_VDOM_LIST_CURRENT_VDOM}    ${new_vdom}
    Wait Until Element Is Visible    ${menu_vdom_current}    
    #Wait Until Element Is Visible    ${MENU_VDOM_MONITOR}    

##Operation on Interfaces
Go to network
    Wait Until Element Is Visible    ${NETWORK_ENTRY}
    ${nav_bar_is_not_expanded}=    run keyword and return status    Wait Until Page Contains Element    ${NETWORK_ENTRY}//following-sibling::f-icon[@class="fa-angle-right rotate-0"]
    run keyword if    "${nav_bar_is_not_expanded}"=="True"    click element    ${NETWORK_ENTRY}

##System
Go to system
    Wait Until Element Is Visible    ${SYSTEM_ENTRY}
    ${nav_bar_is_not_expanded}=    run keyword and return status    Wait Until Page Contains Element    ${SYSTEM_ENTRY}//following-sibling::f-icon[@class="fa-angle-right rotate-0"]
    run keyword if    "${nav_bar_is_not_expanded}"=="True"    click element    ${SYSTEM_ENTRY}

##Operation on Policy
Go to policy and objects
    Wait Until Element Is Visible    ${MENU_POLICY_AND_OBJECT}
    ${nav_bar_is_not_expanded}=    run keyword and return status    Wait Until Page Contains Element    ${MENU_POLICY_AND_OBJECT}//following-sibling::f-icon[@class="fa-angle-right rotate-0"]
    run keyword if    "${nav_bar_is_not_expanded}"=="True"    click element    ${MENU_POLICY_AND_OBJECT}

Go to VPN
    Wait Until Element Is Visible    ${VPN_ENTRY}
    ${nav_bar_is_not_expanded}=    run keyword and return status    Wait Until Page Contains Element    ${VPN_ENTRY}//following-sibling::f-icon[@class="fa-angle-right rotate-0"]
    run keyword if    "${nav_bar_is_not_expanded}"=="True"        click element    ${VPN_ENTRY}

Go to User and Device
    Wait Until Element Is Visible    ${USER_DEVICE_ENTRY}
    ${nav_bar_is_not_expanded}=    run keyword and return status    Wait Until Page Contains Element    ${USER_DEVICE_ENTRY}//following-sibling::f-icon[@class="fa-angle-right rotate-0"]
    run keyword if    "${nav_bar_is_not_expanded}"=="True"        click element    ${USER_DEVICE_ENTRY}

Go to Log and Report
    Wait Until Element Is Visible    ${LOG_REPORT_ENTRY}
    ${nav_bar_is_not_expanded}=    run keyword and return status    Wait Until Page Contains Element    ${USER_DEVICE_ENTRY}//following-sibling::f-icon[@class="fa-angle-right rotate-0"]
    run keyword if    "${nav_bar_is_not_expanded}"=="True"        click element    ${LOG_REPORT_ENTRY}

Go to Monitor
    Wait Until Element Is Visible    ${MONITOR_ENTRY}
    ${nav_bar_is_not_expanded}=    run keyword and return status    Wait Until Page Contains Element    ${MONITOR_ENTRY}//following-sibling::f-icon[@class="fa-angle-right rotate-0"]
    run keyword if    "${nav_bar_is_not_expanded}"=="True"        click element    ${MONITOR_ENTRY}


Hide Interim build label
    ${if_label_exists}=    run keyword and return status    wait Until element is Visible    ${INTERIM_VERSION_BUTTON}
    run keyword if    "${if_label_exists}"=="True"    click button    ${INTERIM_VERSION_BUTTON}
    run keyword if    "${if_label_exists}"=="True"    wait Until element is Visible    ${INTERIM_VERSION_HIDE_BUTTON}
    run keyword if    "${if_label_exists}"=="True"    click button    ${INTERIM_VERSION_HIDE_BUTTON}
    wait Until element is not Visible    ${INTERIM_VERSION_BUTTON}

Press Down Key Until an Element is Visible
    [Arguments]   ${xpath}    ${max}=100 
    :FOR    ${i}    IN RANGE    ${max}
    \    ${visible}    ${result}=    Run Keyword And Ignore Error    Element Should Be Visible     ${xpath}    
    \    Press Key    tag=body    \\57365
    \    Press Key    tag=body    \\57365
    \    Exit For Loop If	'${visible}' == 'PASS'	
    \    Press Key    tag=body    \\57365
