*** Settings ***
Documentation    Verify that SAML SSO remote admins can be used with admin_no_access profile on SP FGT
Resource    ../user_resource.robot
Library    AppiumLibrary
Suite Setup    Set Library Search Order    SeleniumLibrary    AppiumLibrary
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${admin_group}    admingrp
${token_admin}    tokenadmin
${token_admin_password}    1
${token_admin_profile}    super_admin
${sso_admin_profile_fgtb}    admin_no_access
${sso_admin_fgtb}    ${token_admin}
@{cmd}    show user fortitoken ${USER_FORTITOKEN_SN1}
@{cmd_change_profile}    config system sso-admin    edit ${sso_admin_fgtb}    set accprofile super_admin    end
&{options_dic}    fortitoken_mobile=${True}

*** Test Cases ***
890905
    [Tags]    v6.2    chrome    890905    high    mobile_token
    [setup]    run cli commands in files on terminal server for two FGTs
    ${activation_code}=    Get FTM Activation Code    ${cmd}
    Add key to FotiTokenMobile    test    ${activation_code}
    sleep    5s
    Login FortiGate and expect Access Limit Failure    ${FGTB_URL}    username=${token_admin}    password=${token_admin_password}    auth_type=sso    pki_auth=${False}    &{options_dic}
    Logout FortiGate on Access Limit Failure page
    close browser
    #assign a profile super_admin to the user on SP FGT.
    Execute CLI commands on FortiGate Via Terminal Server    ${cmd_change_profile}
    ...    ${TERMINAL_SERVER_IP_B}    ${FGTB_TELNET_PORT_ON_TERMINAL_SERVER}    ${FGTB_CLI_PROMPT}
    ...    ${FGTB_CLI_USERNAME}    ${FGTB_CLI_PASSWORD}    ${FGTB_CLI_TELNET_CONNECTION_TIMEOUT}    ${FGTB_CLI_NEWLINE}    
    #and login SP FGT again.
    Login FortiGate Using Token    ${FGTB_URL}    username=${token_admin}    password=${token_admin_password}    auth_type=sso    pki_auth=${False}    &{options_dic}
    #when logging out, below keywords will check the username.
    Logout FortiGate    ${token_admin}
    close browser
    [Teardown]    case Teardown

*** Keywords ***
run cli commands in files on terminal server for two FGTs
    Run Cli commands in File on Terminal Server    ${USER_CLI_FILE_DIR}${/}${TEST NAME}_fgta_setup_cli.txt

case Teardown
    Run Cli commands in File on Terminal Server    ${USER_CLI_FILE_DIR}${/}${TEST NAME}_fgtb_teardown_cli.txt
    ...    ${TERMINAL_SERVER_IP_B}    ${FGTB_TELNET_PORT_ON_TERMINAL_SERVER}    ${FGTB_CLI_PROMPT}
    ...    ${FGTB_CLI_USERNAME}    ${FGTB_CLI_PASSWORD}    ${FGTB_CLI_TELNET_CONNECTION_TIMEOUT}    ${FGTB_CLI_NEWLINE}    
    Run Cli commands in File on Terminal Server    ${USER_CLI_FILE_DIR}${/}${TEST NAME}_fgta_teardown_cli.txt
    write test result to file    ${CURDIR}


Login FortiGate and expect Access Limit Failure
    [Arguments]    ${url}=${FGT_URL}    ${browser}=${FGT_BROWSER}    ${alias}=None    ${username}=${FGT_GUI_USERNAME}    ${password}=${FGT_GUI_PASSWORD}
    ...    ${remote_url}=${FGT_REMOTE_URL}    ${desired_capabilities}=${FGT_DESIRED_CAPABILITIES}    ${ff_profile_dir}=${FGT_FF_PROFILE_DIR}
    ...    ${if_need_pre_banner}=${False}    ${if_need_post_banner}=${False}    ${auth_type}=password    ${pki_auth}=${False}    &{others}
    #open browser
    ${browser_index}=    open browser    ${url}    browser=${browser}    alias=${alias}
    ...    remote_url=${remote_url}    desired_capabilities=${desired_capabilities}    ff_profile_dir=${ff_profile_dir}
    #configure browser
    Run Keyword And Continue On Failure    configure browser
    #process authentication according to authentication type
    Run Keyword And Continue On Failure    process authentication for admin Using Token    ${username}    ${password}    ${auth_type}    ${pki_auth}    &{others}
    #Now admin should pass authentication, need to wait until "Login Disclaimer" prompt
    #check if the no permit warning page is shown
    Wait Until element is visible    ${LOGOUT_SAML_NO_PERMIT_WARNING}
    [return]    ${browser_index}

Logout FortiGate on Access Limit Failure page
    Wait Until element is visible    ${LOGOUT_SAML_LOGOUT}
    Click Button    ${LOGOUT_SAML_LOGOUT}
    Wait Until Element is visible    ${SYSTEM_SAML_HREF_ON_LOGIN_PAGE}
