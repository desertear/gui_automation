*** Settings ***
Documentation     This file contains keywords for USER only

*** Keywords ***
Get FTM Activation Code
    [Arguments]    @{commands}
    ${response}=    Execute CLI commands on FortiGate Via Terminal Server    @{commands}
    ${activation_code}=    Get Regexp matches    @{response}[-1]   activation-code "(\\w{16})"    1
    [Return]    ${activation_code}

Login FortiGate Using Token
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
    Run Keyword And Continue On Failure    process authentication for admin Using Token    ${username}    ${password}    ${auth_type}    ${pki_auth}    &{others}
    #Now admin should pass authentication, need to wait until "Login Disclaimer" prompt
    Run Keyword And Continue On Failure    handle disclaimer    ${if_need_post_banner}
    #handle different warnings
    Run Keyword And Continue On Failure    handle different warnings
    #check if admin login successfully
    Run Keyword And Continue On Failure    check if admin login successfully    ${username}
    [return]    ${browser_index}

Process authentication for admin Using Token
    [Documentation]    Process authentication according to authentication type. 
    ...    The authentication type ${auth_type} can be "password", "token", "email", "sms", "pki" and "sso".
    [Arguments]    ${username}    ${password}    ${auth_type}    ${pki_auth}    &{others}
    run keyword if    "${auth_type}"=="sso"    redirect to idp authentication page    ${pki_auth}
    run keyword if    not ${pki_auth}    process password authentication Using Token    ${username}    ${password}    &{others}
    #when authentication has finished, browser jump back to source page.
    run keyword if    "${auth_type}"=="sso"    redirect back to source page
    #todo: implement other types when it's necessary.

process password authentication Using Token
    [Arguments]    ${username}    ${password}    &{others}
    #input username and password
    process regular password authentication    ${username}    ${password}
    ${change_password_status}=    Run keyword and return status    Dictionary Should Contain Key    ${others}    change_password
    Run keyword if    ${change_password_status}    change password and then login    ${username}    ${password}    &{others}
    ${mobile_token_status}=    Run keyword and return status    Dictionary Should Contain Key    ${others}    fortitoken_mobile
    Run keyword if    ${mobile_token_status}    get fortitoken mobile and then login    &{others}


get fortitoken mobile and then login
    [Arguments]    &{others}
    Dictionary Should Contain Key    ${others}    fortitoken_mobile
    ${token}=    Get token from FotiTokenMobile
    #input username and password
    Wait Until Element Is Visible    ${LOGIN_FORTITOKEN_HEAD}
    input password    ${LOGIN_FORTITOKEN_TEXT}    ${token}
    click button    ${LOGIN_LOGIN_BUTTON}