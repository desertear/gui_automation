*** Settings ***
Documentation    Verify vdom admin can create sso-admin from GUI (0547935)
Resource    ../../../system_resource.robot

*** Variables ***
${admin_name}   SSO_890819
${password}   123
${admin_profile}    prof_admin
@{vdom}      ${FGTB_VDOM_NAME_1}
${idp_ip}    172.16.200.2
${cert}    Fortinet_Factory
${sp_name}    FGT_A
${sp_ip}    172.16.200.1
${default_login}   Normal
${profile}    prof_admin
*** Test Cases ***
890819
    [Tags]    v6.0    chrome   890819    High   win10,64bit   runable
    ###  create SSO_admin on FGTB, set IDP
    Login FortiGate  url=https://10.1.100.2
    Go to system
    Go to System_administrators
    Create Administrator  username=${admin_name}  password=${password}   vdom=${vdom}  admin_profile=${admin_profile} 
    Go to User and Device
    Go to User SAML SSO
    Set SAML Idp    ${idp_ip}    ${cert}
    ${prefix}=    Create SP On Idp and Return Prefix   ${sp_name}    ${sp_ip}
    Logout FortiGate
    
    ###  login FGTA, set SP
    Login FortiGate
    Go to User and Device
    Go to User SAML SSO
    Set SAML SP   ${sp_ip}   ${default_login}  ${profile}
    Set SP Idp Info of Type Fortinet   Fortinet Product  ${prefix}  ${idp_ip}  ${cert} 
    Logout FortiGate

    ## login with SSO_ADMIN and test backup restore
    login SSO_ADMIN   username=${admin_name}    password=${password}
    ${backup_vdom}=    SET VARIABLE   @{vdom}[0]
    ${filename}=    BACKUP CONFIGURATION  username=${admin_name}  backup_vdom=${backup_vdom}   
    RESTORE CONFIGURATION  username=${admin_name}  restore_vdom=${backup_vdom}   file_name=${filename}
    [Teardown]   case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    Run Cli commands in File on Terminal Server  ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_fgtb_teardown_cli.txt   telnet_port=2002