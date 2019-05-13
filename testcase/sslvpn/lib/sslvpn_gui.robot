*** Settings ***
Documentation     This file contains FortiGate GUI main page operation

*** Keywords ***
##login/logout FGT portal
Login SSLVPN Portal
    [timeout]    ${FGT_KEYWORD_MAX_RUNNING_TIME}
    [Arguments]    ${url}=${SSLVPN_URL}    ${browser}=${SSLVPN_BROWSER}    ${alias}=None    ${username}=${SSLVPN_GUI_USERNAME}    ${password}=${SSLVPN_GUI_PASSWORD}
    ...    ${remote_url}=${SSLVPN_REMOTE_URL}    ${desired_capabilities}=${SSLVPN_DESIRED_CAPABILITIES}    ${ff_profile_dir}=${SSLVPN_FF_PROFILE_DIR}
    [Documentation]    This keyword is used to login ssl vpn portal
    ${browser_index}=    Open Browser    ${url}    browser=${browser}    alias=${alias}
    ...    remote_url=${remote_url}    desired_capabilities=${desired_capabilities}    ff_profile_dir=${ff_profile_dir}
    Run Keyword And Continue On Failure    Maximize Browser Window
    Run Keyword And Continue On Failure    get all selenium config
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${LOGIN_SSLVPN_USERNAME_TEXT}
    Run Keyword And Continue On Failure    input text    ${LOGIN_SSLVPN_USERNAME_TEXT}    ${username}
    Run Keyword And Continue On Failure    input password    ${LOGIN_SSLVPN_PASSWORD_TEXT}    ${password}
    Run Keyword And Continue On Failure    click button    ${LOGIN_SSLVPN_LOGIN_BUTTON}
    #click "log in anyway" if number of logged in user is limited.
    ${already_logged_in}=    run keyword and return status    Wait Until Page Contains Element    ${LOGIN_SSLVPN_ALREADY_LOGGED_IN}    1s
    run keyword if    "${already_logged_in}"=="True"    Run Keyword And Continue On Failure    click element    ${LOGIN_SSLVPN_LOGGED_IN_ANYWAY}
    #verify if log in SSLVPN portal successfully
    ${right_top_button_containing_username}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${PORTAL_VAR_ICON_BUTTON}    ${username}
    Run Keyword And Continue On Failure    Wait Until Keyword Succeeds    5    5s    page should contain element    ${right_top_button_containing_username}
    [Return]    ${browser_index}

Logout SSLVPN Portal
    [timeout]    ${FGT_KEYWORD_MAX_RUNNING_TIME}
    #[Arguments]    ${username}=${SSLVPN_GUI_USERNAME}
    # ${locator_replaced_with_real_value}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${PORTAL_VAR_ICON_BUTTON}    ${username}
    #log out
    click button  ${PORTAL_ICON_BUTTON}
    Wait Until Element Is Visible    ${PORTAL_LOGOUT}
    click button  ${PORTAL_LOGOUT}
    #check if it returns to main page
    Wait Until Page Contains Element    ${LOGIN_SSLVPN_LOGIN_BUTTON}
    [teardown]    close browser

switch back to ssl vpn portal
    [arguments]    ${older_window}
    #switch back to SSLVPN GUI window
    Select window    ${older_window}
    wait Until page contains element    ${PORTAL_QUICK_CONNECTION_BUTTON}

quick connection of http or https
    [Arguments]    ${url}    ${matching_text}    ${sso_credentials}=False    ${sso_username}=${EMPTY}    ${sso_password}=${EMPTY}
    ...    ${sso_form_data}=False    ${form_key}=${EMPTY}    ${form_value}=${EMPTY}
    [Documentation]    format of arguments:
    ...    ${matching_text}--> text that should be matched in http/https page
    ...    ${sso_credentials}-->False, sslvpn, alternative
    ...    ${sso_username} and ${sso_password} are used only when ${sso_credentials} equals to "alternative"
    ...    ${sso_form_data}--> False, True.
    ...    ${form_key} and ${form_value} are used only when ${sso_form_data} is set to "True"
    click button    ${PORTAL_QUICK_CONNECTION_BUTTON}
    click element    ${QUICK_HTTP_HTTPS_LABEL}
    input text    ${QUICK_HTTP_URL_TEXT}    ${url}
    ###need to implement SSO credentials and SSO form data
    ######################################################
    #record opened windows
    ${exclude}=    Get window handles
    click button    ${QUICK_LAUNCH_BUTTON}
    ${older_window}=    Select window    ${exclude}
    ${if_locator}=    If Text Is Locator    ${matching_text}
    Run keyword if   "${if_locator}"=="True"    wait Until page contains element    ${matching_text}
    ...    ELSE    wait Until page contains    ${matching_text}
    close window
    #switch back to SSLVPN GUI window
    Select window    ${older_window}
    wait Until page contains element    ${PORTAL_QUICK_CONNECTION_BUTTON}

quick connection of ftp
    [Arguments]    ${folder}    ${matching_text}    ${sso_credentials}=False    ${username}=${EMPTY}    ${password}=${EMPTY}
    [Documentation]    format of arguments:
    ...    ${sso_credentials}-->False, sslvpn, alternative
    ...    ${matching_text}--> text that should be matched in http/https page
    click button    ${PORTAL_QUICK_CONNECTION_BUTTON}
    click element    ${QUICK_FTP_LABEL}
    input text    ${QUICK_FTP_FOLDER_TEXT}    ${folder}
    #input SSO credentials and SSO form data
    ${selected_status}=    run keyword and return status    Checkbox Should Be Selected    ${QUICK_FTP_SSO_CHECKBOX}
    run keyword if    "${selected_status}"!="True" and "${sso_credentials}"!="False"    click element    ${QUICK_FTP_SSO_CHECKBOX_LABEL}
    run keyword if    "${sso_credentials}"=="sslvpn"    click element    ${QUICK_FTP_SSO_SSLVPN_LABEL}
    run keyword if    "${sso_credentials}"=="alternative"    click element    ${QUICK_FTP_SSO_ALTERNATIVE_LABEL}
    run keyword if    "${sso_credentials}"=="alternative"    input text    ${QUICK_FTP_SSO_USERNAME_TEXT}    ${username}
    run keyword if    "${sso_credentials}"=="alternative"    input text    ${QUICK_FTP_SSO_PASSWORD_TEXT}    ${password}
    #record opened windows
    ${exclude}=    Get window handles
    #launch ftp bookmark
    click button    ${QUICK_LAUNCH_BUTTON}
    ${older_window}=    Select window    ${exclude}
    run keyword if    "${sso_credentials}"=="False"    wait until element is visible    ${QUICK_FTP_USERNAME_TEXT}
    run keyword if    "${sso_credentials}"=="False"    input text    ${QUICK_FTP_USERNAME_TEXT}    ${username}
    run keyword if    "${sso_credentials}"=="False"    wait until element is visible    ${QUICK_FTP_PASSWORD_TEXT}
    run keyword if    "${sso_credentials}"=="False"    input text    ${QUICK_FTP_PASSWORD_TEXT}    ${password}
    run keyword if    "${sso_credentials}"=="False"    wait until element is visible    ${QUICK_FTP_LOGIN_BUTTON}
    run keyword if    "${sso_credentials}"=="False"    click button    ${QUICK_FTP_LOGIN_BUTTON}
    wait Until page contains    ${matching_text}
    close window
    #switch back to SSLVPN GUI window
    Select window    ${older_window}
    wait Until page contains element    ${PORTAL_QUICK_CONNECTION_BUTTON}

quick connection of sftp
    [Arguments]    ${folder}    ${matching_text}    ${sso_credentials}=False    ${username}=${EMPTY}    ${password}=${EMPTY}
    [Documentation]    format of arguments:
    ...    ${sso_credentials}-->False, sslvpn, alternative
    ...    ${matching_text}--> text that should be matched in http/https page
    click button    ${PORTAL_QUICK_CONNECTION_BUTTON}
    click element    ${QUICK_SFTP_LABEL}
    input text    ${QUICK_SFTP_FOLDER_TEXT}    ${folder}
    #input SSO credentials and SSO form data
    ${selected_status}=    run keyword and return status    Checkbox Should Be Selected    ${QUICK_SFTP_SSO_CHECKBOX}
    run keyword if    "${selected_status}"!="True" and "${sso_credentials}"!="False"    click element    ${QUICK_SFTP_SSO_CHECKBOX_LABEL}
    run keyword if    "${sso_credentials}"=="sslvpn"    click element    ${QUICK_SFTP_SSO_SSLVPN_LABEL}
    run keyword if    "${sso_credentials}"=="alternative"    click element    ${QUICK_SFTP_SSO_ALTERNATIVE_LABEL}
    run keyword if    "${sso_credentials}"=="alternative"    input text    ${QUICK_SFTP_SSO_USERNAME_TEXT}    ${username}
    run keyword if    "${sso_credentials}"=="alternative"    input text    ${QUICK_SFTP_SSO_PASSWORD_TEXT}    ${password}
    #record opened windows
    ${exclude}=    Get window handles
    #launch sftp bookmark
    click button    ${QUICK_LAUNCH_BUTTON}
    ${older_window}=    Select window    ${exclude}
    run keyword if    "${sso_credentials}"=="False"    wait until element is visible    ${QUICK_SFTP_USERNAME_TEXT}
    run keyword if    "${sso_credentials}"=="False"    input text    ${QUICK_SFTP_USERNAME_TEXT}    ${username}
    run keyword if    "${sso_credentials}"=="False"    wait until element is visible    ${QUICK_SFTP_PASSWORD_TEXT}
    run keyword if    "${sso_credentials}"=="False"    input text    ${QUICK_SFTP_PASSWORD_TEXT}    ${password}
    run keyword if    "${sso_credentials}"=="False"    wait until element is visible    ${QUICK_SFTP_LOGIN_BUTTON}
    run keyword if    "${sso_credentials}"=="False"    click button    ${QUICK_SFTP_LOGIN_BUTTON}
    wait Until page contains    ${matching_text}
    close window
    #switch back to SSLVPN GUI window
    Select window    ${older_window}
    wait Until page contains element    ${PORTAL_QUICK_CONNECTION_BUTTON}

quick connection of smb or cifs
    [Arguments]    ${folder}    ${matching_text}    ${sso_credentials}=False    ${username}=${EMPTY}    ${password}=${EMPTY}
    [Documentation]    format of arguments:
    ...    ${sso_credentials}-->False, sslvpn, alternative
    ...    ${matching_text}--> text that should be matched in http/https page
    click button    ${PORTAL_QUICK_CONNECTION_BUTTON}
    click element    ${QUICK_SMB_CIFS_LABEL}
    input text    ${QUICK_SMB_FOLDER_TEXT}    ${folder}
    #SSO credentials and SSO form data
    ${selected_status}=    run keyword and return status    Checkbox Should Be Selected    ${QUICK_SMB_SSO_CHECKBOX}
    run keyword if    "${selected_status}"!="True" and "${sso_credentials}"!="False"    click element    ${QUICK_SMB_SSO_CHECKBOX_LABEL}
    run keyword if    "${sso_credentials}"=="sslvpn"    click element    ${QUICK_SMB_SSO_SSLVPN_LABEL}
    run keyword if    "${sso_credentials}"=="alternative"    click element    ${QUICK_SMB_SSO_ALTERNATIVE_LABEL}
    run keyword if    "${sso_credentials}"=="alternative"    input text    ${QUICK_SMB_SSO_USERNAME_TEXT}    ${username}
    run keyword if    "${sso_credentials}"=="alternative"    input text    ${QUICK_SMB_SSO_PASSWORD_TEXT}    ${password}
    #record opened windows
    ${exclude}=    Get window handles
    #launch bookmark
    click button    ${QUICK_LAUNCH_BUTTON}
    ${older_window}=    Select window    ${exclude}
    run keyword if    "${sso_credentials}"=="False"    wait until element is visible    ${QUICK_SMB_USERNAME_TEXT}
    run keyword if    "${sso_credentials}"=="False"    input text        ${QUICK_SMB_USERNAME_TEXT}    ${username}
    run keyword if    "${sso_credentials}"=="False"    wait until element is visible    ${QUICK_SMB_PASSWORD_TEXT}
    run keyword if    "${sso_credentials}"=="False"    input text        ${QUICK_SMB_PASSWORD_TEXT}    ${password}
    run keyword if    "${sso_credentials}"=="False"    wait until element is visible    ${QUICK_SMB_LOGIN_BUTTON}
    run keyword if    "${sso_credentials}"=="False"    click button    ${QUICK_SMB_LOGIN_BUTTON}
    Wait Until Element Is Visible    ${SMB_HEAD}
    wait Until page contains    ${matching_text}
    close window
    #switch back to SSLVPN GUI window
    Select window    ${older_window}
    wait Until page contains element    ${PORTAL_QUICK_CONNECTION_BUTTON}

quick connection of rdp
    [Arguments]    ${host}    ${port}    ${image_dir}    ${ssl_vpn_credentials}=False    ${username}=${EMPTY}    ${password}=${EMPTY}
    ...    ${keyboard_layout}=English    ${security}=network    ${if_check_rdp_screen}=False
    [Documentation]    format of arguments:
    ...    ${ssl_vpn_credentials}-->False, True
    ...    ${username} and ${password} are used only when ${ssl_vpn_credentials} is False
    ...    ${keyboard_layout}-->English, German, French, Italian, Swedish and Unknown
    ...    ${security}-->standard, network, tls, and server
    click button    ${PORTAL_QUICK_CONNECTION_BUTTON}
    click element    ${QUICK_RDP_LABEL}
    input text    ${QUICK_RDP_HOST_TEXT}    ${host}
    input text    ${QUICK_RDP_PORT_TEXT}    ${port}
    #enable checkbox
    ${selected_status}=    run keyword and return status    Checkbox Should Be Selected    ${QUICK_RDP_CREDENTIALS_CHECKBOX}
    run keyword if    "${selected_status}"!="True" and "${ssl_vpn_credentials}"!="False"    click element    ${QUICK_RDP_CREDENTIALS_CHECKBOX_LABEL}
    #input username/password according to sso checkbox status
    run keyword if    "${ssl_vpn_credentials}"!="True"    input text    ${QUICK_RDP_USERNAME_TEXT}    ${username}
    run keyword if    "${ssl_vpn_credentials}"!="True"    input text    ${QUICK_RDP_PASSWORD_PASSWORD}    ${password}
    #TODO:need to map ${keyboard_layout} and ${security} to certain select items
    ######################################################
    Select From List By Label    ${QUICK_RDP_SECURITY_SELECT}    Network Level Authentication.
    #record opened windows
    ${exclude}=    Get window handles
    click button    ${QUICK_LAUNCH_BUTTON}
    ${older_window}=    Select window    ${exclude}
    ##check FGT monitor info using FGT GUI
    #${browser_index}=    connection check    ${SSLVPN_GUI_USERNAME}    RDP    ${host}
    ##switch to previous broswer which is used to operate SSLVPN GUI
    #switch browser    ${browser_index-1}
    #run keyword if    "${if_check_rdp_screen}"=="True"    RDP screen checking    ${image_dir}
    #[teardown]    switch back to ssl vpn portal    ${older_window}
    #check FGT monitor info using FGT CLI
    check result from CLI    RDP    sslvpn_monitor_cli.txt
    close window
    [teardown]    switch back to ssl vpn portal    ${older_window}

quick connection of vnc
    [Arguments]    ${host}    ${port}    ${image_dir}    ${connection_password}=${EMPTY}    ${password}=${EMPTY}    ${if_check_vnc_screen}=False
    [Documentation]    format of arguments:
    ...    ${matching_text}--> text that should be matched in http/https page
    ...    ${keyboard_layout}-->English, German, French, Italian, Swedish and Unknown
    ...    ${security}-->standard, network, tls, and server
    click button    ${PORTAL_QUICK_CONNECTION_BUTTON}
    click element    ${QUICK_VNC_LABEL}
    input text    ${QUICK_VNC_HOST_TEXT}    ${host}
    input text    ${QUICK_VNC_PORT_TEXT}    ${port}
    input text    ${QUICK_VNC_PASSWORD_PASSWORD}    ${connection_password}
    #record opened windows
    ${exclude}=    Get window handles
    click button    ${QUICK_LAUNCH_BUTTON}
    ${older_window}=    Select window    ${exclude}
    #check FGT monitor info using FGT CLI
    check result from CLI    VNC    sslvpn_monitor_cli.txt
    close window
    [teardown]    switch back to ssl vpn portal    ${older_window}

quick connection of ssh
    [Arguments]    ${host}    ${username}    ${password}
    click button    ${PORTAL_QUICK_CONNECTION_BUTTON}
    click element    ${QUICK_SSH_LABEL}
    input text    ${QUICK_SSH_HOST_TEXT}    ${host}
    #record opened windows
    ${exclude}=    Get window handles
    click button    ${QUICK_LAUNCH_BUTTON}
    ${older_window}=    Select window    ${exclude}
    Wait Until element is Visible    ${QUICK_SSH_HEAD}
    input text    ${QUICK_SSH_USERNAME_TEXT}    ${username}
    input text    ${QUICK_SSH_PASSWORD_PASSWORD}    ${password}
    click button    ${QUICK_SSH_LOGIN_BUTTON}
    Wait Until Element Is Visible    ${QUICK_SSH_IFRAME}
    select frame    ${QUICK_SSH_IFRAME}
    Wait Until keyword Succeeds    5x    ${SELENIUM_TIMEOUT}    Current Frame Should Contain    Welcome to Ubuntu
    # wait Until page contains element    xpath://x-row[contains(text(),"Welcome to Ubuntu")]
    #check FGT monitor info using FGT CLI
    check result from CLI    SSH    sslvpn_monitor_cli.txt
    close window
    [teardown]    switch back to ssl vpn portal    ${older_window}

Fail connection of ssh
    [Arguments]    ${host}
    click button    ${PORTAL_QUICK_CONNECTION_BUTTON}
    click element    ${QUICK_SSH_LABEL}
    input text    ${QUICK_SSH_HOST_TEXT}    ${host}
    #record opened windows
    ${exclude}=    Get window handles
    click button    ${QUICK_LAUNCH_BUTTON}
    ${older_window}=    Select window    ${exclude}
    Wait Until Element Is Visible    ${CONNECT_FAIL}
    click button    ${CONNECT_CLOSE}
    [teardown]    switch back to ssl vpn portal    ${older_window}

quick connection of telnet
    [Arguments]    ${host}    ${username}    ${password}    ${if_login}=False
    click button    ${PORTAL_QUICK_CONNECTION_BUTTON}
    click element    ${QUICK_TELNET_LABEL}
    input text    ${QUICK_TELNET_HOST_TEXT}    ${host}
    #record opened windows
    ${exclude}=    Get window handles
    click button    ${QUICK_LAUNCH_BUTTON}
    ${older_window}=    Select window    ${exclude}
    Wait Until Element Is Visible    ${QUICK_TELNET_IFRAME}
    select frame    ${QUICK_TELNET_IFRAME}
    Wait Until keyword Succeeds    5x    ${SELENIUM_TIMEOUT}    Current Frame Should Contain    Ubuntu
    # wait Until page contains element    xpath://x-row[contains(text(),"Ubuntu")]    30
    run keyword if    "${if_login}"=="True"    telnet login    ${username}    ${password}
    #check FGT monitor info using FGT CLI
    check result from CLI    TELNET    sslvpn_monitor_cli.txt
    close window
    [teardown]    switch back to ssl vpn portal    ${older_window}

Fail connection of telnet
    [Arguments]    ${host}
    click button    ${PORTAL_QUICK_CONNECTION_BUTTON}
    click element    ${QUICK_TELNET_LABEL}
    input text    ${QUICK_TELNET_HOST_TEXT}    ${host}
    #record opened windows
    ${exclude}=    Get window handles
    click button    ${QUICK_LAUNCH_BUTTON}
    ${older_window}=    Select window    ${exclude}
    #Wait Until Element Is Visible    ${CONNECT_FAIL}
    click button    ${CONNECT_CLOSE}
    [teardown]    switch back to ssl vpn portal    ${older_window}

quick connection of ping
    [Arguments]    ${host}
    click button    ${PORTAL_QUICK_CONNECTION_BUTTON}
    click element    ${QUICK_PING_LABEL}
    input text    ${QUICK_PING_HOST_TEXT}    ${host}
    click button    ${QUICK_LAUNCH_BUTTON}
    wait Until page contains element    xpath://*[text()="${host} is reachable."]
    click button    ${QUICK_PING_OK_BUTTON}
    click button    ${QUICK_CANCEL_BUTTON}
    wait Until page contains element    ${PORTAL_QUICK_CONNECTION_BUTTON}

create bookmark for http or https
    [Arguments]    ${bookmark_name}    ${url}    ${description}    ${sso_credentials}=False    ${sso_username}=${EMPTY}    ${sso_password}=${EMPTY}
    ...    ${sso_form_data}=False    ${form_key}=${EMPTY}    ${form_value}=${EMPTY}
    [Documentation]    format of arguments:
    ...    ${matching_text}--> text that should be matched in http/https page
    ...    ${sso_credentials}-->False, sslvpn, alternative
    ...    ${sso_username} and ${sso_password} are used only when ${sso_credentials} equals to "alternative"
    ...    ${sso_form_data}--> False, True.
    ...    ${form_key} and ${form_value} are used only when ${sso_form_data} is set to "True"
    delete bookmark by name if it exists    ${bookmark_name}
    click button    ${PORTAL_NEW_BOOKMARK_BUTTON}
    click element    ${QUICK_HTTP_HTTPS_LABEL}
    input text    ${BOOKMARK_NAME_TEXT}    ${bookmark_name}
    input text    ${QUICK_HTTP_URL_TEXT}    ${url}
    input text    ${BOOKMARK_DESCRIPTION_TEXT}    ${description}
    ###need to implement SSO credentials and SSO form data
    ######################################################
    click button    ${BOOKMARK_SAVE_BUTTON}
    ${locator_replaced_with_real_value}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${PORTAL_VAR_BOOKMARK_BUTTON}    ${bookmark_name}
    wait Until page contains element    ${locator_replaced_with_real_value}

open and check http bookmark
    [Arguments]    ${bookmark_name}    ${matching_text}    ${if_predefined}=${False}
    [Documentation]    format of arguments:
    ...    ${sso_credentials}-->False, sslvpn, alternative
    ...    ${matching_text}--> text that should be matched in http/https page
    ${locator_replaced_with_real_value}=    Run keyword if    ${if_predefined}    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${PORTAL_VAR_PREDEFINED_BOOKMARK_BUTTON}    ${bookmark_name}
    ...    ELSE        REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${PORTAL_VAR_BOOKMARK_BUTTON}    ${bookmark_name}
    wait Until page contains element    ${locator_replaced_with_real_value}
    #record opened windows
    ${exclude}=    Get window handles
    click button    ${locator_replaced_with_real_value}
    #switch back to SSLVPN GUI window
    ${older_window}=    Select window    ${exclude}
    ${if_locator}=    If Text Is Locator    ${matching_text}
    Run keyword if   "${if_locator}"=="True"    wait Until page contains element regardless of iframe    ${matching_text}
    ...    ELSE    Wait Until Page Contains regardless of iframe    ${matching_text}
    #Run keyword if   "${if_locator}"=="True"    wait Until page contains element    ${matching_text}
    #...    ELSE    wait Until page contains    ${matching_text}
    close window
    #switch back to SSLVPN GUI window
    Select window    ${older_window}
    #wait Until page contains element    ${PORTAL_QUICK_CONNECTION_BUTTON}

create bookmark ftp
    [Arguments]    ${bookmark_name}    ${folder}    ${description}    ${sso_credentials}=False    ${username}=${EMPTY}    ${password}=${EMPTY}
    [Documentation]    format of arguments:
    ...    ${sso_credentials}-->False, sslvpn, alternative
    ...    ${matching_text}--> text that should be matched in http/https page
    delete bookmark by name if it exists    ${bookmark_name}
    click button    ${PORTAL_NEW_BOOKMARK_BUTTON}
    click element    ${QUICK_FTP_LABEL}
    input text    ${BOOKMARK_NAME_TEXT}    ${bookmark_name}
    input text    ${QUICK_FTP_FOLDER_TEXT}    ${folder}
    input text    ${BOOKMARK_DESCRIPTION_TEXT}    ${description}
    ###SSO credentials and SSO form data
    ${selected_status}=    run keyword and return status    Checkbox Should Be Selected    ${QUICK_FTP_SSO_CHECKBOX}
    run keyword if    "${selected_status}"!="True" and "${sso_credentials}"!="False"    click element    ${QUICK_FTP_SSO_CHECKBOX_LABEL}
    run keyword if    "${sso_credentials}"=="sslvpn"    click element    ${QUICK_FTP_SSO_SSLVPN_LABEL}
    run keyword if    "${sso_credentials}"=="alternative"    click element    ${QUICK_FTP_SSO_ALTERNATIVE_LABEL}
    run keyword if    "${sso_credentials}"=="alternative"    input text    ${QUICK_FTP_SSO_USERNAME_TEXT}    ${username}
    run keyword if    "${sso_credentials}"=="alternative"    input text    ${QUICK_FTP_SSO_PASSWORD_TEXT}    ${password}
    #save configuration
    click button    ${BOOKMARK_SAVE_BUTTON}
    wait Until page contains element    ${PORTAL_QUICK_CONNECTION_BUTTON}
    ${locator_replaced_with_real_value}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${PORTAL_VAR_BOOKMARK_BUTTON}    ${bookmark_name}
    wait Until page contains element    ${locator_replaced_with_real_value}

open and check ftp bookmark
    [Arguments]    ${bookmark_name}    ${matching_text}    ${username}    ${password}    ${if_predefined}=${False}    ${sso_credentials}=False
    [Documentation]    format of arguments:
    ...    ${sso_credentials}-->False, sslvpn, alternative
    ...    ${matching_text}--> text that should be matched in http/https page
    ${locator_replaced_with_real_value}=    Run keyword if    ${if_predefined}    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${PORTAL_VAR_PREDEFINED_BOOKMARK_BUTTON}    ${bookmark_name}
    ...    ELSE        REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${PORTAL_VAR_BOOKMARK_BUTTON}    ${bookmark_name}
    wait Until page contains element    ${locator_replaced_with_real_value}
    #record opened windows
    ${exclude}=    Get window handles
    click button    ${locator_replaced_with_real_value}
    ${older_window}=    Select window    ${exclude}
    run keyword if    "${sso_credentials}"=="False"    wait until element is visible    ${QUICK_FTP_USERNAME_TEXT}
    run keyword if    "${sso_credentials}"=="False"    input text        ${QUICK_FTP_USERNAME_TEXT}    ${username}
    run keyword if    "${sso_credentials}"=="False"    wait until element is visible    ${QUICK_FTP_PASSWORD_TEXT}
    run keyword if    "${sso_credentials}"=="False"    input text        ${QUICK_FTP_PASSWORD_TEXT}    ${password}
    run keyword if    "${sso_credentials}"=="False"    wait until element is visible    ${QUICK_FTP_LOGIN_BUTTON}
    run keyword if    "${sso_credentials}"=="False"    click button    ${QUICK_FTP_LOGIN_BUTTON}
    wait until element is visible    ${FTP_HEAD}
    wait until page contains element    ${FTP_HEAD}
    wait Until page contains    ${matching_text}
    close window
    #switch back to SSLVPN GUI window
    Select window    ${older_window}
    wait Until page contains element    ${PORTAL_NEW_BOOKMARK_BUTTON}

create bookmark sftp
    [Arguments]    ${bookmark_name}    ${folder}    ${description}    ${sso_credentials}=False    ${username}=${EMPTY}    ${password}=${EMPTY}
    [Documentation]    format of arguments:
    ...    ${sso_credentials}-->False, sslvpn, alternative
    ...    ${matching_text}--> text that should be matched in http/https page
    delete bookmark by name if it exists    ${bookmark_name}
    click button    ${PORTAL_NEW_BOOKMARK_BUTTON}
    click element    ${QUICK_SFTP_LABEL}
    input text    ${BOOKMARK_NAME_TEXT}    ${bookmark_name}
    input text    ${QUICK_SFTP_FOLDER_TEXT}    ${folder}
    input text    ${BOOKMARK_DESCRIPTION_TEXT}    ${description}
    ###SSO credentials and SSO form data
    ${selected_status}=    run keyword and return status    Checkbox Should Be Selected    ${QUICK_SFTP_SSO_CHECKBOX}
    run keyword if    "${selected_status}"!="True" and "${sso_credentials}"!="False"    click element    ${QUICK_SFTP_SSO_CHECKBOX_LABEL}
    run keyword if    "${sso_credentials}"=="sslvpn"    click element    ${QUICK_SFTP_SSO_SSLVPN_LABEL}
    run keyword if    "${sso_credentials}"=="alternative"    click element    ${QUICK_FTP_SSO_ALTERNATIVE_LABEL}
    run keyword if    "${sso_credentials}"=="alternative"    input text    ${QUICK_SFTP_SSO_USERNAME_TEXT}    ${username}
    run keyword if    "${sso_credentials}"=="alternative"    input text    ${QUICK_SFTP_SSO_PASSWORD_TEXT}    ${password}
    #save configuration
    click button    ${BOOKMARK_SAVE_BUTTON}
    wait Until page contains element    ${PORTAL_QUICK_CONNECTION_BUTTON}
    ${locator_replaced_with_real_value}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${PORTAL_VAR_BOOKMARK_BUTTON}    ${bookmark_name}
    wait Until page contains element    ${locator_replaced_with_real_value}

open and check sftp bookmark
    [Arguments]    ${bookmark_name}    ${matching_text}    ${username}    ${password}    ${if_predefined}=${False}    ${sso_credentials}=False
    [Documentation]    format of arguments:
    ...    ${sso_credentials}-->False, sslvpn, alternative
    ...    ${matching_text}--> text that should be matched in http/https page
    ${locator_replaced_with_real_value}=    Run keyword if    ${if_predefined}    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${PORTAL_VAR_PREDEFINED_BOOKMARK_BUTTON}    ${bookmark_name}
    ...    ELSE        REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${PORTAL_VAR_BOOKMARK_BUTTON}    ${bookmark_name}
    wait Until page contains element    ${locator_replaced_with_real_value}
    #record opened windows
    ${exclude}=    Get window handles
    click button    ${locator_replaced_with_real_value}
    ${older_window}=    Select window    ${exclude}
    run keyword if    "${sso_credentials}"=="False"    wait until element is visible    ${QUICK_SFTP_USERNAME_TEXT}
    run keyword if    "${sso_credentials}"=="False"    input text        ${QUICK_SFTP_USERNAME_TEXT}    ${username}
    run keyword if    "${sso_credentials}"=="False"    wait until element is visible    ${QUICK_SFTP_PASSWORD_TEXT}
    run keyword if    "${sso_credentials}"=="False"    input text        ${QUICK_SFTP_PASSWORD_TEXT}    ${password}
    run keyword if    "${sso_credentials}"=="False"    wait until element is visible    ${QUICK_SFTP_LOGIN_BUTTON}
    run keyword if    "${sso_credentials}"=="False"    click button    ${QUICK_SFTP_LOGIN_BUTTON}
    wait until element is visible    ${SFTP_HEAD}
    wait until page contains element    ${SFTP_HEAD}
    wait Until page contains    ${matching_text}
    close window
    #switch back to SSLVPN GUI window
    Select window    ${older_window}
    wait Until page contains element    ${PORTAL_NEW_BOOKMARK_BUTTON}

create bookmark smb or cifs
    [Arguments]    ${bookmark_name}    ${folder}    ${description}    ${sso_credentials}=False    ${username}=${EMPTY}    ${password}=${EMPTY}
    [Documentation]    format of arguments:
    ...    ${sso_credentials}-->False, sslvpn, alternative
    ...    ${matching_text}--> text that should be matched in http/https page
    delete bookmark by name if it exists    ${bookmark_name}
    click button    ${PORTAL_NEW_BOOKMARK_BUTTON}
    click element    ${QUICK_SMB_CIFS_LABEL}
    input text    ${BOOKMARK_NAME_TEXT}    ${bookmark_name}
    input text    ${QUICK_SMB_FOLDER_TEXT}    ${folder}
    input text    ${BOOKMARK_DESCRIPTION_TEXT}    ${description}
    #SSO credentials and SSO form data
    ${selected_status}=    run keyword and return status    Checkbox Should Be Selected    ${QUICK_SMB_SSO_CHECKBOX}
    run keyword if    "${selected_status}"!="True" and "${sso_credentials}"!="False"    click element    ${QUICK_SMB_SSO_CHECKBOX_LABEL}
    run keyword if    "${sso_credentials}"=="sslvpn"    click element    ${QUICK_SMB_SSO_SSLVPN_LABEL}
    run keyword if    "${sso_credentials}"=="alternative"    click element    ${QUICK_SMB_SSO_ALTERNATIVE_LABEL}
    run keyword if    "${sso_credentials}"=="alternative"    input text    ${QUICK_SMB_SSO_USERNAME_TEXT}    ${username}
    run keyword if    "${sso_credentials}"=="alternative"    input text    ${QUICK_SMB_SSO_PASSWORD_TEXT}    ${password}
    #save bookmark
    click button    ${BOOKMARK_SAVE_BUTTON}
    wait Until page contains element    ${PORTAL_QUICK_CONNECTION_BUTTON}
    ${locator_replaced_with_real_value}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${PORTAL_VAR_BOOKMARK_BUTTON}    ${bookmark_name}
    wait Until page contains element    ${locator_replaced_with_real_value}

open and check smb or cifs bookmark
    [Arguments]    ${bookmark_name}    ${matching_text}    ${username}    ${password}    ${if_predefined}=${False}    ${sso_credentials}=False
    ${locator_replaced_with_real_value}=    Run keyword if    ${if_predefined}    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${PORTAL_VAR_PREDEFINED_BOOKMARK_BUTTON}    ${bookmark_name}
    ...    ELSE        REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${PORTAL_VAR_BOOKMARK_BUTTON}    ${bookmark_name}
    wait Until page contains element    ${locator_replaced_with_real_value}
    #record opened windows
    ${exclude}=    Get window handles
    click button    ${locator_replaced_with_real_value}
    ${older_window}=    Select window    ${exclude}
    run keyword if    "${sso_credentials}"=="False"    wait until element is visible    ${QUICK_SMB_USERNAME_TEXT}
    run keyword if    "${sso_credentials}"=="False"    input text        ${QUICK_SMB_USERNAME_TEXT}    ${username}
    run keyword if    "${sso_credentials}"=="False"    wait until element is visible    ${QUICK_SMB_PASSWORD_TEXT}
    run keyword if    "${sso_credentials}"=="False"    input text        ${QUICK_SMB_PASSWORD_TEXT}    ${password}
    run keyword if    "${sso_credentials}"=="False"    wait until element is visible    ${QUICK_SMB_LOGIN_BUTTON}
    run keyword if    "${sso_credentials}"=="False"    click button    ${QUICK_SMB_LOGIN_BUTTON}
    Wait Until Element Is Visible    ${SMB_HEAD}
    wait Until page contains    ${matching_text}
    close window
    #switch back to SSLVPN GUI window
    Select window    ${older_window}
    wait Until page contains element    ${PORTAL_NEW_BOOKMARK_BUTTON}

create bookmark for rdp
    [Arguments]    ${bookmark_name}    ${host}    ${port}    ${description}    ${ssl_vpn_credentials}=False    ${username}=${EMPTY}    ${password}=${EMPTY}
    ...    ${keyboard_layout}=English    ${security}=network
    [Documentation]    format of arguments:
    ...    ${matching_text}--> text that should be matched in http/https page
    ...    ${sso_credentials}-->False, sslvpn, alternative
    ...    ${sso_username} and ${sso_password} are used only when ${sso_credentials} equals to "alternative"
    ...    ${sso_form_data}--> False, True.
    ...    ${form_key} and ${form_value} are used only when ${sso_form_data} is set to "True"
    ...    ${security}:   standard--->Standard RDP encryption.
    ...                   network--->Network Level Authentication.
    ...                   tls--->TLS encryption.
    ...                   server--->Allow the server to choose the type of security.
    delete bookmark by name if it exists    ${bookmark_name}
    click button    ${PORTAL_NEW_BOOKMARK_BUTTON}
    click element    ${QUICK_RDP_LABEL}
    input text    ${BOOKMARK_NAME_TEXT}    ${bookmark_name}
    input text    ${QUICK_RDP_HOST_TEXT}    ${host}
    input text    ${QUICK_RDP_PORT_TEXT}    ${port}
    input text    ${BOOKMARK_DESCRIPTION_TEXT}    ${description}
    #enable checkbox
    ${selected_status}=    run keyword and return status    Checkbox Should Be Selected    ${QUICK_RDP_CREDENTIALS_CHECKBOX}
    run keyword if    "${selected_status}"!="True" and "${ssl_vpn_credentials}"!="False"    click element    ${QUICK_RDP_CREDENTIALS_CHECKBOX_LABEL}
    #input username/password according to sso checkbox status
    run keyword if    "${ssl_vpn_credentials}"!="True"    input text    ${QUICK_RDP_USERNAME_TEXT}    ${username}
    run keyword if    "${ssl_vpn_credentials}"!="True"    input text    ${QUICK_RDP_PASSWORD_PASSWORD}    ${password}
    #TODO:need to map ${keyboard_layout} to certain select items
    ######################################################
    ${security_label_value}=    set variable if
    ...    "${security}"=="standard"    Standard RDP encryption.
    ...    "${security}"=="network"    Network Level Authentication.
    ...    "${security}"=="tls"    TLS encryption.
    ...    "${security}"=="server"    Allow the server to choose the type of security.
    Select From List By Label    ${QUICK_RDP_SECURITY_SELECT}    ${security_label_value}
    click button    ${BOOKMARK_SAVE_BUTTON}
    ${locator_replaced_with_real_value}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${PORTAL_VAR_BOOKMARK_BUTTON}    ${bookmark_name}
    wait Until page contains element    ${locator_replaced_with_real_value}

open and check rdp bookmark
    [Arguments]    ${bookmark_name}    ${host}    ${image_dir}    ${username}=${EMPTY}    ${password}=${EMPTY}    ${if_check_rdp_screen}=False    ${if_predefined}=${False}
    ${locator_replaced_with_real_value}=    Run keyword if    ${if_predefined}    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${PORTAL_VAR_PREDEFINED_BOOKMARK_BUTTON}    ${bookmark_name}
    ...    ELSE        REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${PORTAL_VAR_BOOKMARK_BUTTON}    ${bookmark_name}
    wait Until page contains element    ${locator_replaced_with_real_value}
    #record opened windows
    ${exclude}=    Get window handles
    click button    ${locator_replaced_with_real_value}
    ${older_window}=    Select window    ${exclude}
    ##judge if credentials are need also.
    ${if_credential_is_needed}=    run keyword and return status    Wait Until Page Contains Element    ${QUICK_RDP_CREDENTIALS_PAGE_HEAD}
    run keyword if    "${if_credential_is_needed}"=="True" and "${username}"!="${EMPTY}"    input text    ${QUICK_RDP_CREDENTIALS_PAGE_USERNAME}    ${username}
    run keyword if    "${if_credential_is_needed}"=="True" and "${password}"!="${EMPTY}"    input text    ${QUICK_RDP_CREDENTIALS_PAGE_PASSWORD}    ${password}
    run keyword if    "${if_credential_is_needed}"=="True"    click button    ${QUICK_RDP_CREDENTIALS_PAGE_LOGIN_BUTTON}
    ##check FGT monitor info using FGT GUI
    #${browser_index}=    connection check    ${SSLVPN_GUI_USERNAME}    RDP    ${host}
    ##switch to previous broswer which is used to operate SSLVPN GUI
    #switch browser    ${browser_index-1}
    #check FGT monitor info using FGT CLI
    check result from CLI    RDP    sslvpn_monitor_cli.txt
    run keyword if    "${if_check_rdp_screen}"=="True"    RDP screen checking    ${image_dir}
    #close RDP windows
    close window
    #switch back to SSLVPN GUI window
    Select window    ${older_window}
    wait Until page contains element    ${PORTAL_NEW_BOOKMARK_BUTTON}

open rdp bookmark
    [Arguments]    ${bookmark_name}    ${host}    ${image_dir}    ${username}=${EMPTY}    ${password}=${EMPTY}    ${if_check_rdp_screen}=False    ${if_predefined}=${False}
    ${locator_replaced_with_real_value}=    Run keyword if    ${if_predefined}    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${PORTAL_VAR_PREDEFINED_BOOKMARK_BUTTON}    ${bookmark_name}
    ...    ELSE        REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${PORTAL_VAR_BOOKMARK_BUTTON}    ${bookmark_name}
    wait Until page contains element    ${locator_replaced_with_real_value}
    #record opened windows
    ${exclude}=    Get window handles
    click button    ${locator_replaced_with_real_value}
    ${older_window}=    Select window    ${exclude}
    ##judge if credentials are need also.
    ${if_credential_is_needed}=    run keyword and return status    Wait Until Page Contains Element    ${QUICK_RDP_CREDENTIALS_PAGE_HEAD}
    run keyword if    "${if_credential_is_needed}"=="True" and "${username}"!="${EMPTY}"    input text    ${QUICK_RDP_CREDENTIALS_PAGE_USERNAME}    ${username}
    run keyword if    "${if_credential_is_needed}"=="True" and "${password}"!="${EMPTY}"    input text    ${QUICK_RDP_CREDENTIALS_PAGE_PASSWORD}    ${password}
    run keyword if    "${if_credential_is_needed}"=="True"    click button    ${QUICK_RDP_CREDENTIALS_PAGE_LOGIN_BUTTON}

    ##check FGT monitor info using FGT GUI
    #${browser_index}=    connection check    ${SSLVPN_GUI_USERNAME}    RDP    ${host}
    ##switch to previous broswer which is used to operate SSLVPN GUI
    #switch browser    ${browser_index-1}

    #check FGT monitor info using FGT CLI
    check result from CLI    RDP    sslvpn_monitor_cli.txt
    run keyword if    "${if_check_rdp_screen}"=="True"    RDP screen checking    ${image_dir}

create bookmark for vnc
    [Arguments]    ${bookmark_name}    ${host}    ${port}    ${description}    ${connection_password}=${EMPTY}
    [Documentation]    format of arguments:
    ...    ${matching_text}--> text that should be matched in http/https page
    ...    ${keyboard_layout}-->English, German, French, Italian, Swedish and Unknown
    ...    ${security}-->standard, network, tls, and server
    delete bookmark by name if it exists    ${bookmark_name}
    click button    ${PORTAL_NEW_BOOKMARK_BUTTON}
    click element    ${QUICK_VNC_LABEL}
    input text    ${BOOKMARK_NAME_TEXT}    ${bookmark_name}
    input text    ${QUICK_VNC_HOST_TEXT}    ${host}
    input text    ${QUICK_VNC_PORT_TEXT}    ${port}
    input text    ${BOOKMARK_DESCRIPTION_TEXT}    ${description}
    input text    ${QUICK_VNC_PASSWORD_PASSWORD}    ${connection_password}
    click button    ${BOOKMARK_SAVE_BUTTON}
    ${locator_replaced_with_real_value}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${PORTAL_VAR_BOOKMARK_BUTTON}    ${bookmark_name}
    wait Until page contains element    ${locator_replaced_with_real_value}

open and check vnc bookmark
    [Arguments]    ${bookmark_name}    ${host}    ${image_dir}    ${if_check_vnc_screen}=False    ${if_predefined}=${False}
    ${locator_replaced_with_real_value}=    Run keyword if    ${if_predefined}    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${PORTAL_VAR_PREDEFINED_BOOKMARK_BUTTON}    ${bookmark_name}
    ...    ELSE        REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${PORTAL_VAR_BOOKMARK_BUTTON}    ${bookmark_name}
    wait Until page contains element    ${locator_replaced_with_real_value}
    #record opened windows
    ${exclude}=    Get window handles
    click button    ${locator_replaced_with_real_value}
    #switch back to SSLVPN GUI window
    ${older_window}=    Select window    ${exclude}
    ##check FGT monitor info using FGT GUI
    #${browser_index}=    connection check    ${SSLVPN_GUI_USERNAME}    VNC    ${host}
    ##switch to previous broswer which is used to operate SSLVPN GUI
    #switch browser    ${browser_index-1}

    #check FGT monitor info using FGT CLI
    check result from CLI    VNC    sslvpn_monitor_cli.txt
    run keyword if    "${if_check_vnc_screen}"=="True"    VNC screen checking    ${image_dir}
    #close VNC windows
    close window
    #switch back to SSLVPN GUI window
    Select window    ${older_window}
    wait Until page contains element    ${PORTAL_NEW_BOOKMARK_BUTTON}

open vnc bookmark
    [Arguments]    ${bookmark_name}    ${host}    ${image_dir}    ${if_check_vnc_screen}=False    ${if_predefined}=${False}
    ${locator_replaced_with_real_value}=    Run keyword if    ${if_predefined}    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${PORTAL_VAR_PREDEFINED_BOOKMARK_BUTTON}    ${bookmark_name}
    ...    ELSE        REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${PORTAL_VAR_BOOKMARK_BUTTON}    ${bookmark_name}
    wait Until page contains element    ${locator_replaced_with_real_value}
    #record opened windows
    ${exclude}=    Get window handles
    click button    ${locator_replaced_with_real_value}
    #switch back to SSLVPN GUI window
    ${older_window}=    Select window    ${exclude}
    #check FGT monitor info using FGT CLI
    check result from CLI    VNC    sslvpn_monitor_cli.txt
    run keyword if    "${if_check_vnc_screen}"=="True"    VNC screen checking    ${image_dir}

create bookmark ssh
    [Arguments]    ${bookmark_name}    ${host}    ${description}
    [Documentation]    format of arguments:
    ...    ${sso_credentials}-->False, sslvpn, alternative
    ...    ${matching_text}--> text that should be matched in http/https page
    delete bookmark by name if it exists    ${bookmark_name}
    click button    ${PORTAL_NEW_BOOKMARK_BUTTON}
    click element    ${QUICK_SSH_LABEL}
    input text    ${BOOKMARK_NAME_TEXT}    ${bookmark_name}
    input text    ${QUICK_SSH_HOST_TEXT}    ${host}
    input text    ${BOOKMARK_DESCRIPTION_TEXT}    ${description}
    click button    ${BOOKMARK_SAVE_BUTTON}
    wait Until page contains element    ${PORTAL_NEW_BOOKMARK_BUTTON}
    ${locator_replaced_with_real_value}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${PORTAL_VAR_BOOKMARK_BUTTON}    ${bookmark_name}
    wait Until page contains element    ${locator_replaced_with_real_value}

open and check ssh bookmark
    [Arguments]    ${bookmark_name}    ${host}    ${username}    ${password}    ${if_predefined}=${False}
    ${locator_replaced_with_real_value}=    Run keyword if    ${if_predefined}    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${PORTAL_VAR_PREDEFINED_BOOKMARK_BUTTON}    ${bookmark_name}
    ...    ELSE        REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${PORTAL_VAR_BOOKMARK_BUTTON}    ${bookmark_name}
    wait Until page contains element    ${locator_replaced_with_real_value}
    #record opened windows
    ${exclude}=    Get window handles
    click button    ${locator_replaced_with_real_value}
    ${older_window}=    Select window    ${exclude}
    Wait Until element is Visible    ${QUICK_SSH_HEAD}
    input text    ${QUICK_SSH_USERNAME_TEXT}    ${username}
    input text    ${QUICK_SSH_PASSWORD_PASSWORD}    ${password}
    click button    ${QUICK_SSH_LOGIN_BUTTON}
    Wait Until Element Is Visible    ${QUICK_SSH_IFRAME}
    select frame    ${f}
    Wait Until keyword Succeeds    5x    ${SELENIUM_TIMEOUT}    Current Frame Should Contain    Welcome to Ubuntu
    # wait Until page contains element    xpath://x-row[contains(text(),"Welcome to Ubuntu")]
    ##check FGT monitor info using FGT GUI
    ${browser_index}=    connection check    ${SSLVPN_GUI_USERNAME}    SSH    ${host}
    #switch to previous broswer which is used to operate SSLVPN GUI
    switch browser    ${browser_index-1}
    #close SSH connection window
    close window
    #switch back to SSLVPN GUI window
    Select window    ${older_window}
    wait Until page contains element    ${PORTAL_NEW_BOOKMARK_BUTTON}

open and cli check ssh bookmark
    [Arguments]    ${bookmark_name}    ${host}    ${username}    ${password}    ${if_predefined}=${False}
    ${locator_replaced_with_real_value}=    Run keyword if    ${if_predefined}    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${PORTAL_VAR_PREDEFINED_BOOKMARK_BUTTON}    ${bookmark_name}
    ...    ELSE        REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${PORTAL_VAR_BOOKMARK_BUTTON}    ${bookmark_name}
    wait Until page contains element    ${locator_replaced_with_real_value}
    #record opened windows
    ${exclude}=    Get window handles
    click button    ${locator_replaced_with_real_value}
    ${older_window}=    Select window    ${exclude}
    Wait Until element is Visible    ${QUICK_SSH_HEAD}
    input text    ${QUICK_SSH_USERNAME_TEXT}    ${username}
    input text    ${QUICK_SSH_PASSWORD_PASSWORD}    ${password}
    click button    ${QUICK_SSH_LOGIN_BUTTON}
    Wait Until Element Is Visible    ${QUICK_SSH_IFRAME}
    select frame    ${QUICK_SSH_IFRAME}
    Wait Until keyword Succeeds    5x    ${SELENIUM_TIMEOUT}    Current Frame Should Contain    Welcome to Ubuntu
    # wait Until page contains element    xpath://x-row[contains(text(),"Welcome to Ubuntu")]
    #check FGT monitor info using CLI
    check result from CLI    SSH    sslvpn_monitor_cli.txt
    #close ssh connection window
    close window
    [teardown]    switch back to ssl vpn portal    ${older_window}

create bookmark telnet
    [Arguments]    ${bookmark_name}    ${host}    ${description}
    [Documentation]    format of arguments:
    ...    ${sso_credentials}-->False, sslvpn, alternative
    ...    ${matching_text}--> text that should be matched in http/https page
    delete bookmark by name if it exists    ${bookmark_name}
    click button    ${PORTAL_NEW_BOOKMARK_BUTTON}
    click element    ${QUICK_TELNET_LABEL}
    input text    ${BOOKMARK_NAME_TEXT}    ${bookmark_name}
    input text    ${QUICK_TELNET_HOST_TEXT}    ${host}
    input text    ${BOOKMARK_DESCRIPTION_TEXT}    ${description}
    click button    ${BOOKMARK_SAVE_BUTTON}
    wait Until page contains element    ${PORTAL_NEW_BOOKMARK_BUTTON}
    ${locator_replaced_with_real_value}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${PORTAL_VAR_BOOKMARK_BUTTON}    ${bookmark_name}
    wait Until page contains element    ${locator_replaced_with_real_value}

open and check telnet bookmark
    [Arguments]    ${bookmark_name}    ${host}    ${username}    ${password}    ${if_login}=False    ${if_predefined}=${False}
    ${locator_replaced_with_real_value}=    Run keyword if    ${if_predefined}    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${PORTAL_VAR_PREDEFINED_BOOKMARK_BUTTON}    ${bookmark_name}
    ...    ELSE        REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${PORTAL_VAR_BOOKMARK_BUTTON}    ${bookmark_name}
    wait Until page contains element    ${locator_replaced_with_real_value}
    #record opened windows
    ${exclude}=    Get window handles
    click button    ${locator_replaced_with_real_value}
    ${older_window}=    Select window    ${exclude}
    Wait Until Element Is Visible    ${QUICK_TELNET_IFRAME}
    select frame    ${QUICK_TELNET_IFRAME}
    Wait Until keyword Succeeds    5x    ${SELENIUM_TIMEOUT}    Current Frame Should Contain    Ubuntu
    # wait Until page contains element    xpath://x-row[contains(text(),"Ubuntu")]    30
    run keyword if    "${if_login}"=="True"    telnet login    ${username}    ${password}
    ##check FGT monitor info using FGT GUI
    ${browser_index}=    connection check    ${SSLVPN_GUI_USERNAME}    Telnet    ${host}
    #switch to previous broswer which is used to operate SSLVPN GUI
    switch browser    ${browser_index-1}
    #close TELNET connection window
    close window
    #switch back to SSLVPN GUI window
    Select window    ${older_window}
    wait Until page contains element    ${PORTAL_NEW_BOOKMARK_BUTTON}

open and cli check telnet bookmark
    [Arguments]    ${bookmark_name}    ${host}    ${username}    ${password}    ${if_login}=False    ${if_predefined}=${False}
    ${locator_replaced_with_real_value}=    Run keyword if    ${if_predefined}    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${PORTAL_VAR_PREDEFINED_BOOKMARK_BUTTON}    ${bookmark_name}
    ...    ELSE        REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${PORTAL_VAR_BOOKMARK_BUTTON}    ${bookmark_name}
    wait Until page contains element    ${locator_replaced_with_real_value}
    #record opened windows
    ${exclude}=    Get window handles
    click button    ${locator_replaced_with_real_value}
    ${older_window}=    Select window    ${exclude}
    Wait Until Element Is Visible    ${QUICK_TELNET_IFRAME}
    select frame    ${QUICK_TELNET_IFRAME}
    Wait Until keyword Succeeds    5x    ${SELENIUM_TIMEOUT}    Current Frame Should Contain    Ubuntu
    # wait Until page contains element    xpath://x-row[contains(text(),"Ubuntu")]    30
    run keyword if    "${if_login}"=="True"    telnet login    ${username}    ${password}
    ##check FGT monitor info using CLI
    check result from CLI    TELNET    sslvpn_monitor_cli.txt
    #close TELNET connection window
    close window
    [teardown]    switch back to ssl vpn portal    ${older_window}

delete bookmark by name
    [Arguments]    ${bookmark_name}
    #Login SSLVPN Portal
    #${if_main_page}=    Run Keyword And Return Status    Wait Until Page Contains Element    ${PORTAL_QUICK_CONNECTION_BUTTON}
    #run keyword if     "${if_main_page}"!="True"    click button    ${BOOKMARK_DELETE_CANCEL_BUTTON}
    ${locator_replaced_with_real_value}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${PORTAL_VAR_BOOKMARK_BUTTON}    ${bookmark_name}
    ${locator_replaced_with_real_value2}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${PORTAL_VAR_BOOKMARK_DELETE_BUTTON}    ${bookmark_name}
    wait Until page contains element    ${locator_replaced_with_real_value}
    Mouse Over    ${locator_replaced_with_real_value}
    wait Until element is visible    ${locator_replaced_with_real_value2}
    click element    ${locator_replaced_with_real_value2}
    wait Until page contains element    ${BOOKMARK_DELETE_OK_BUTTON}
    wait Until element is visible    ${BOOKMARK_DELETE_OK_BUTTON}
    click button    ${BOOKMARK_DELETE_OK_BUTTON}
    wait Until page does not contain element    ${locator_replaced_with_real_value}
    #Logout SSLVPN Portal
    #[teardown]    close window

delete bookmark by name if it exists
    [Arguments]    ${bookmark_name}
    ${locator_replaced_with_real_value}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${PORTAL_VAR_BOOKMARK_BUTTON}    ${bookmark_name}
    ${if_exists}=    run keyword and return status    Wait Until Page Contains Element    ${locator_replaced_with_real_value}
    run keyword if    "${if_exists}"=="True"    delete bookmark by name    ${bookmark_name}

connection check
    [Arguments]    ${username}    ${connection_type}    ${host}
    ${browser_index}=    Run Keyword And Continue On Failure    Login FortiGate
    Run Keyword And Continue On Failure    Check SSL VPN monitor    ${username}    ${connection_type}    ${host}
    Run Keyword And Continue On Failure    Logout FortiGate
    Return From Keyword    ${browser_index}
    [teardown]    close browser

check result from CLI
    [Arguments]    ${check_point}    ${cli_file}
    @{responses}=   Run Keyword And Continue On Failure    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${cli_file}
    ${response}=    set variable    @{responses}[-1]
    should match regexp    ${response}    ${check_point}

close browser and return browser index
    [Arguments]    ${browser_index}
    close browser
    Return From Keyword    ${browser_index}

RDP screen checking
    [arguments]    ${image_dir}
    #Make sure this is a file "sslvpn" in desktop of remote PC
    #and this file contains text "This is SSL VPN automation testing"
    Set Library Search Order    SikuliLibrary    pyautogui
    Add Image Path    ${image_dir}
    wait Until Screen Contain    textpad.png    60
    double click    textpad.png
    wait Until Screen Contain    textpad_header.png    5
    exists    sentence_in_opened_textpad.png    5
    click in    left_top_notepad.png    close_notepad.png
    wait Until Screen not Contain    textpad_header.png    5
    [teardown]    stop remote server and close current window

VNC screen checking
    [arguments]    ${image_dir}
    #Make sure this is a file "sslvpn_automation" in desktop of remote PC
    #and this file contains text "This is SSL VPN automation testing"
    Add Image Path    ${image_dir}
    wait Until Screen Contain    file_icon.png    20
    Get Match Score    file_icon.png
    # double click    file_icon.png
    # # wait Until Screen Contain    file_tab.png    10
    # Get Match Score    sentence_in_opened_notepad.png
    # wait Until Screen Contain    sentence_in_opened_notepad.png    10
    # click in    left_top_notepad.png    close_notepad.png
    # wait Until Screen not Contain    file_tab.png    5
    # #below action is to release the focus on to-be recognized file
    # Click    computer.png
    # wait Until Screen Contain    file_icon.png    5
    [teardown]    stop remote server and close current window

stop remote server and close current window
    Stop Remote Server
    #close RDP or VNC connection window
    close window

connect to ftp
    [Arguments]    ${folder}    ${sso_credentials}=False    ${username}=${EMPTY}    ${password}=${EMPTY}
    [Documentation]    format of arguments:
    ...    ${sso_credentials}-->False, sslvpn, alternative
    ...    ${matching_text}--> text that should be matched in http/https page
    click button    ${PORTAL_QUICK_CONNECTION_BUTTON}
    click element    ${QUICK_FTP_LABEL}
    input text    ${QUICK_FTP_FOLDER_TEXT}    ${folder}
    ###need to implement SSO credentials and SSO form data
    ${selected_status}=    run keyword and return status    Checkbox Should Be Selected    ${QUICK_FTP_SSO_CHECKBOX}
    run keyword if    "${selected_status}"!="True" and "${sso_credentials}"!="False"    click element    ${QUICK_FTP_SSO_CHECKBOX_LABEL}
    run keyword if    "${sso_credentials}"=="sslvpn"    click element    ${QUICK_FTP_SSO_SSLVPN_LABEL}
    run keyword if    "${sso_credentials}"=="alternative"    click element    ${QUICK_FTP_SSO_ALTERNATIVE_LABEL}
    run keyword if    "${sso_credentials}"=="alternative"    input text    ${QUICK_FTP_SSO_USERNAME_TEXT}    ${username}
    run keyword if    "${sso_credentials}"=="alternative"    input text    ${QUICK_FTP_SSO_PASSWORD_TEXT}    ${password}
    #record opened windows
    ${exclude}=    Get window handles
    #launch ftp
    click button    ${QUICK_LAUNCH_BUTTON}
    ${older_window}=    Select window    ${exclude}
    run keyword if    "${sso_credentials}"=="False"    wait until element is visible    ${QUICK_FTP_USERNAME_TEXT}
    run keyword if    "${sso_credentials}"=="False"    input text        ${QUICK_FTP_USERNAME_TEXT}    ${username}
    run keyword if    "${sso_credentials}"=="False"    wait until element is visible    ${QUICK_FTP_PASSWORD_TEXT}
    run keyword if    "${sso_credentials}"=="False"    input text        ${QUICK_FTP_PASSWORD_TEXT}    ${password}
    run keyword if    "${sso_credentials}"=="False"    wait until element is visible    ${QUICK_FTP_LOGIN_BUTTON}
    run keyword if    "${sso_credentials}"=="False"    click button    ${QUICK_FTP_LOGIN_BUTTON}
    wait Until page contains element    ${FTP_HEAD}

connect to sftp
    [Arguments]    ${folder}    ${sso_credentials}=False    ${username}=${EMPTY}    ${password}=${EMPTY}
    [Documentation]    format of arguments:
    ...    ${sso_credentials}-->False, sslvpn, alternative
    ...    ${matching_text}--> text that should be matched in http/https page
    click button    ${PORTAL_QUICK_CONNECTION_BUTTON}
    click element    ${QUICK_SFTP_LABEL}
    input text    ${QUICK_SFTP_FOLDER_TEXT}    ${folder}
    ###need to implement SSO credentials and SSO form data
    ${selected_status}=    run keyword and return status    Checkbox Should Be Selected    ${QUICK_SFTP_SSO_CHECKBOX}
    run keyword if    "${selected_status}"!="True" and "${sso_credentials}"!="False"    click element    ${QUICK_SFTP_SSO_CHECKBOX_LABEL}
    run keyword if    "${sso_credentials}"=="sslvpn"    click element    ${QUICK_SFTP_SSO_SSLVPN_LABEL}
    run keyword if    "${sso_credentials}"=="alternative"    click element    ${QUICK_SFTP_SSO_ALTERNATIVE_LABEL}
    run keyword if    "${sso_credentials}"=="alternative"    input text    ${QUICK_SFTP_SSO_USERNAME_TEXT}    ${username}
    run keyword if    "${sso_credentials}"=="alternative"    input text    ${QUICK_SFTP_SSO_PASSWORD_TEXT}    ${password}
    #record opened windows
    ${exclude}=    Get window handles
    #launch sftp
    click button    ${QUICK_LAUNCH_BUTTON}
    ${older_window}=    Select window    ${exclude}
    run keyword if    "${sso_credentials}"=="False"    wait until element is visible    ${QUICK_SFTP_USERNAME_TEXT}
    run keyword if    "${sso_credentials}"=="False"    input text        ${QUICK_SFTP_USERNAME_TEXT}    ${username}
    run keyword if    "${sso_credentials}"=="False"    wait until element is visible    ${QUICK_SFTP_PASSWORD_TEXT}
    run keyword if    "${sso_credentials}"=="False"    input text        ${QUICK_SFTP_PASSWORD_TEXT}    ${password}
    run keyword if    "${sso_credentials}"=="False"    wait until element is visible    ${QUICK_SFTP_LOGIN_BUTTON}
    run keyword if    "${sso_credentials}"=="False"    click button    ${QUICK_SFTP_LOGIN_BUTTON}
    wait Until page contains element    ${SFTP_HEAD}

connect to smb
    [Arguments]    ${folder}    ${sso_credentials}=False    ${username}=${EMPTY}    ${password}=${EMPTY}
    [Documentation]    format of arguments:
    ...    ${sso_credentials}-->False, sslvpn, alternative
    ...    ${matching_text}--> text that should be matched in http/https page
    click button    ${PORTAL_QUICK_CONNECTION_BUTTON}
    click element    ${QUICK_SMB_CIFS_LABEL}
    input text    ${QUICK_SMB_FOLDER_TEXT}    ${folder}
    #need to implement SSO credentials and SSO form data
    ${selected_status}=    run keyword and return status    Checkbox Should Be Selected    ${QUICK_SMB_SSO_CHECKBOX}
    run keyword if    "${selected_status}"!="True" and "${sso_credentials}"!="False"    click element    ${QUICK_SMB_SSO_CHECKBOX_LABEL}
    run keyword if    "${sso_credentials}"=="sslvpn"    click element    ${QUICK_SMB_SSO_SSLVPN_LABEL}
    run keyword if    "${sso_credentials}"=="alternative"    click element    ${QUICK_SMB_SSO_ALTERNATIVE_LABEL}
    run keyword if    "${sso_credentials}"=="alternative"    input text    ${QUICK_SMB_SSO_USERNAME_TEXT}    ${username}
    run keyword if    "${sso_credentials}"=="alternative"    input text    ${QUICK_SMB_SSO_PASSWORD_TEXT}    ${password}
    #record opened windows
    ${exclude}=    Get window handles
    #launch bookmark
    click button    ${QUICK_LAUNCH_BUTTON}
    ${older_window}=    Select window    ${exclude}
    run keyword if    "${sso_credentials}"=="False"    wait until element is visible    ${QUICK_SMB_USERNAME_TEXT}
    run keyword if    "${sso_credentials}"=="False"    input text        ${QUICK_SMB_USERNAME_TEXT}    ${username}
    run keyword if    "${sso_credentials}"=="False"    wait until element is visible    ${QUICK_SMB_PASSWORD_TEXT}
    run keyword if    "${sso_credentials}"=="False"    input text        ${QUICK_SMB_PASSWORD_TEXT}    ${password}
    run keyword if    "${sso_credentials}"=="False"    wait until element is visible    ${QUICK_SMB_LOGIN_BUTTON}
    run keyword if    "${sso_credentials}"=="False"    click button    ${QUICK_SMB_LOGIN_BUTTON}
    wait Until page contains element    ${SMB_HEAD}

telnet login
    [Arguments]    ${username}    ${password}
    Click Element    xpath://x-row[contains(text(),"login:")]
    # press key    xpath://x-row[contains(text(),"login:")]    ${username}
    typewrite    ${username}\n
    wait Until page contains element    xpath://x-row[contains(text(),"Password:")]
    Click Element    xpath://x-row[contains(text(),"Password:")]
    # press key    xpath://x-row[contains(text(),"Password:")]    ${password}\\13
    typewrite    ${password}\n
    wait Until page contains element    xpath://x-row[contains(text(),"Welcome to Ubuntu")]

number of history records
    wait Until page contains element    ${HISTORY_TABLE}
    ${num_history}=    Get Element Count    ${HISTORY_LINES}
    # Capture Page Screenshot
    [return]    ${num_history}

get detail of history records as list
    [Arguments]    ${line}=${1}
    ${if_show_all_label_exists}=    run keyword and return status    Wait Until Page Contains Element    ${HISTORY_SHOW_ALL_LABEL}
    # run keyword if    "${if_show_all_label_exists}"=="True"    click element    ${HISTORY_SHOW_ALL_LABEL}
    run keyword and ignore error    click element    ${HISTORY_SHOW_ALL_LABEL}
    Capture Page Screenshot
    ${time}=    Get Text    ${HISTORY_LINES}\[${line}]/td[1]
    ${remote_ip}=    Get Text    ${HISTORY_LINES}\[${line}]/td[2]
    ${duration}=    Get Text    ${HISTORY_LINES}\[${line}]/td[3]
    ${data_statistics}=    Get Text    ${HISTORY_LINES}\[${line}]/td[4]
    [return]    ${time}    ${remote_ip}    ${duration}    ${data_statistics}

file download should be done
    [Arguments]    ${file_full_path}
    OperatingSystem.File Should Exist    ${file_full_path}