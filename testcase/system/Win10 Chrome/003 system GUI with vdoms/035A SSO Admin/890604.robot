*** Settings ***
Documentation      Verify GUI show pre/post disclaimer after sso-admin login when enable pre/post banner(0546920)
Resource    ../../../system_resource.robot

*** Variables ***
${admin_name}   SSO_890604
${password}    123
${admin_profile}    prof_admin
@{vdom}      ${FGTB_VDOM_NAME_1}
${idp_ip}    172.16.200.2
${cert}    Fortinet_Factory
${sp_name}    FGT_A
${sp_ip}    172.16.200.1
${default_login}   Normal
${profile}    prof_admin
*** Test Cases ***
890604
    [Tags]    v6.0    chrome   890604    Medium    win10,64bit    browsers    runable
    Login FortiGate  url=https://10.1.100.2
    Go to system
    Go to System_administrators
    Create Administrator  username=${admin_name}  password=${password}   vdom=${vdom}  admin_profile=${admin_profile} 
    Go to User and Device
    Go to User SAML SSO
    Set SAML Idp    ${idp_ip}    ${cert}
    ${prefix}=    Create SP On Idp and Return Prefix   ${sp_name}    ${sp_ip}
    Logout FortiGate
    
    Login FortiGate
    Go to User and Device
    Go to User SAML SSO
    Set SAML SP   ${sp_ip}   ${default_login}  ${profile}
    Set SP Idp Info of Type Fortinet   Fortinet Product  ${prefix}  ${idp_ip}  ${cert} 
    Logout FortiGate

    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}setup_banner_cli.txt 
    ##  go to login page, pre_ban and post_ban should be shown 
    Open Browser    ${FGT_URL}    ${FGT_BROWSER}
    Set Window Size    ${SCREEN_SIZE_WIDTH}    ${SCREEN_SIZE_HEIGTH}
    Wait Until Element Is Visible  ${NETWORK_INTERFACES_CAPTIVE_PTL_LGIN_PRE_BAN}
    wait and click    ${NETWORK_INTERFACES_CAPTIVE_PTL_LGIN_ACPT}
    wait and click    ${SYSTEM_SAML_HREF_ON_LOGIN_PAGE}
    Wait Until Element Is Visible    ${LOGIN_USERNAME_TEXT}
    input text    ${LOGIN_USERNAME_TEXT}    ${admin_name}
    input password    ${LOGIN_PASSWORD_TEXT}    ${password}
    Run Keyword And Continue On Failure    click button    ${LOGIN_LOGIN_BUTTON}
    sleep  2
    ${continue}=    run keyword and return status    Wait Until Element Is Visible    ${SYSTEM_SAML_CONTINUE_BUTTON_LOGIN_PAGE}
    run keyword if    "${continue}"=="True"    click button    ${SYSTEM_SAML_CONTINUE_BUTTON_LOGIN_PAGE}
    Wait Until Element Is Visible  ${NETWORK_INTERFACES_CAPTIVE_PTL_LGIN_POST_BAN}
    wait and click    ${NETWORK_INTERFACES_CAPTIVE_PTL_LGIN_ACPT}
    ##### login to foritgate ####
    run keyword if    "${FGT_FIPS_CC_MODE}"=="True"    Run Keyword And Continue On Failure    Wait Until Page Contains Element    ${FIPS_DISCLAIMER_HEAD}
    run keyword if    "${FGT_FIPS_CC_MODE}"=="True"    Run Keyword And Continue On Failure    click button    ${FIPS_ACCEPT_BUTTON}
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
    Run Keyword And Continue On Failure    Wait Until Keyword Succeeds    3x    2s    Element Text Should Be    ${PLTF_TYPE_DIV}    ${FGT_HW_TYPE}
    Remove file   ${SYSTEM_FILE_DOWNLOAD_DIR_PATH}${/}${cert}.cer
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate  username=${admin_name}  if_need_pre_banner=True
    Close All Browsers
    Run Cli commands in File on Terminal Server  ${SYSTEM_CLI_FILE_DIR}${/}clean_banner_cli.txt
    Run Cli commands in File on Terminal Server  ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    Run Cli commands in File on Terminal Server  ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_fgtb_teardown_cli.txt   telnet_port=2002
    write test result to file    ${CURDIR}