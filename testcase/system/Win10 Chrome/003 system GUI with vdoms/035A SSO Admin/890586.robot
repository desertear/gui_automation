*** Settings ***
Documentation    Verify GUI can login to SP FGT with SSO-Admin after add it to IDP FGT (0546295/0542088)
Resource    ../../../system_resource.robot

*** Variables ***
${admin_name}   SSO_890586
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
890586
    [Tags]    v6.0    chrome   890586    Critical   win10,64bit   runable
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
    [Teardown]   case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    Run Cli commands in File on Terminal Server  ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_fgtb_teardown_cli.txt   telnet_port=2002