*** Settings ***
Documentation     This file contains all locator variables on FortiGate Login Page

*** Variables ***
#Format Definition: ${LOCATION_FRAME-NAME_FRAME-TYPE}###
#below is the common frame defined generally
${FGT_FRAME}    name:embedded-iframe
####LOGIN Page####
${LOGIN_USERNAME_TEXT}    id:username
${LOGIN_PASSWORD_TEXT}    id:secretkey
${LOGIN_LOGIN_BUTTON}    name:login_button

####Authentication failure####
${LOGIN_AUTH_FAILURE}    xpath://div[text()="Authentication failure"]
${LOGIN_LOCKOUT_WARNING}    xpath://div[text()="Too many login failures. Please try again in a few minutes..."]

####Login Disclaimer in FIPS Mode####
${FIPS_DISCLAIMER_HEAD}    xpath://h1[text()="Login Disclaimer"]
${FIPS_ACCEPT_BUTTON}    xpath://button[text()="Accept"]
${FIPS_DECLINE_BUTTON}    xpath://button[text()="Decline"]

####Warning: File System Check Recommended####
${LOGIN_FILE_CHECK_HEAD}    xpath://h1[text()="File System Check Recommended"]
${LOGIN_FILE_CHECK_REBOOT}    xpath://button[normalize-space(.)="Reboot and scan disk now"]
${LOGIN_FILE_CHECK_LATER}    xpath://button[normalize-space(.)="Remind me later"]

####Warning: Password Change####
${PWD_CHANGE_HEAD}    xpath://h1[text()="Password Change"]
${PWD_CHANGE_CHANGE_BUTTON}    xpath://button[normalize-space(.)="Change Password"]
${PWD_CHANGE_LATER_BUTTON}    xpath://button[normalize-space(.)="Later"]

####Warning: Managed by FortiManager####
${FMG_LOGIN_HEAD}    xpath://h1[text()="This FortiGate is currently managed by a FortiManager device"]
${FMG_LOGIN_LOGOUT_BUTTON}    xpath://button[normalize-space(.)="Log Out"]
${FMG_LOGIN_READ_ONLY_BUTTON}    xpath://button[normalize-space(.)="Login Read-Only"]
${FMG_LOGIN_READ_WRITE_BUTTON}    xpath://button[normalize-space(.)="Login Read-Write"]

####Warning: out-of-sync on the FortiManager.####
${OUT_OF_SYNC_FMG_TEXT}    xpath://div[contains(.,"Changing this device will cause it to become out-of-sync on the FortiManager")]
${OUT_OF_SYNC_FMG_CANCEL_BUTTON}    xpath://button[normalize-space(.)="Cancel"]
${OUT_OF_SYNC_FMG_YES_BUTTON}    xpath://button[normalize-space(.)="Yes"]

####Warning: FortiCare Registration Required####
${FORTICARE_REQUIRED_BUTTON}    xpath://button[text()="Later"]

####Change Password when it's expired####
${LOGIN_CHANGE_PASSWORD_HEAD}    xpath://h1[text()="Change Password"]
${LOGIN_CHANGE_PASSWORD_OLD_PASSWORD}    id:old_pwd
${LOGIN_CHANGE_PASSWORD_NEW_PASSWORD}    id:pwd1
${LOGIN_CHANGE_PASSWORD_CONFIRM_PASSWORD}    id:pwd2
${LOGIN_CHANGE_PASSWORD_OK_BUTTON}    id:change-button
${LOGIN_CHANGE_PASSWORD_LOGOUT_BUTTON}    id:logout-button
###logout
${LOGOUT_PKI_WARNING}    xpath://h3[text()="You have logged out. It is recommended to close the window for security reasons."]
${LOGOUT_SAML_NO_PERMIT_WARNING}    xpath://div[normalize-space(.)="This account is using a restricted access profile with limited permissions. Additional permission must be granted by the device administrator."]
${LOGOUT_SAML_LOGOUT}    xpath://button[span="Logout"]
###FortiToken 
${LOGIN_FORTITOKEN_HEAD}    xpath://div[text()="Please input your token code."]
${LOGIN_FORTITOKEN_TEXT}    name:token_code