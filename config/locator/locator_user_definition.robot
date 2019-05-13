*** Settings ***
Documentation     This file contains all locator variables on FortiGate User&Device->User definition page

*** Variables ***
####User & Device####
${USER_FRAME}    name:embedded-iframe
${USER_DEVICE_ENTRY}     xpath://span[text()="User & Device"]
${USER_DEVICE_SAML_SSO_ENTRY}     xpath://span[text()="SAML SSO"]
###User Definition###
${USER_DEFINITION_ENTRY}    xpath://span[text()="User Definition"]
${USER_DEFINITION_ENTRY_CREATE_NEW}    xpath://button[div/span="Create New"]
${VAR_USER_DEFINITION_USE_IN_TABLE}    xpath://td[@class="name" and text()="\${PLACEHOLDER}"]
${USER_EDIT_USER}    xpath://button[div/span="Edit User"]
${USER_CLONE}    xpath://button[div/span="Clone"]
${USER_WIZARD_H1}    xpath://h1[text()="Users/Groups Creation Wizard"]
${USER_TYPE_LOCAL}     xpath://label/span[text()="Local User"]
${USER_TYPE_RADIUS}     xpath://label/span[text()="Remote RADIUS User"]
${USER_TYPE_TACACS}     xpath://label/span[text()="Remote TACACS+ User"]
${USER_TYPE_LDAP}     xpath://label/span[text()="Remote LDAP User"]
${USER_TYPE_FSSO}     xpath://label/span[text()="FSSO"]
${VAR_USER_TYPE}     xpath://label/span[text()="\${PLACEHOLDER}"]
${USER_NEXT_BUTTON}    xpath://button[contains(span,"Next")]
${USER_LOCAL_USERNAME}    xpath://label[text()="Username"]/following-sibling::div/input
${USER_LOCAL_PASSWORD}    xpath://label[text()="Password"]/following-sibling::div/input
${USER_LOCAL_CONFIRM_PASSWORD}    xpath://label[text()="Confirm password"]/following-sibling::div/input
${USER_LOCAL_CONFIRM_PASSWORD_EMPTY_WARNING_LABEL}    xpath://label[text()="This field is required."]
${USER_LOCAL_CONFIRM_PASSWORD_MISMATCH_WARNING_LABEL}    xpath://label[text()="Doesn't Match"]
${USER_LOCAL_PASSWORD_WARNING_LABEL}    xpath://label[text()="Please enter at least 8 characters."]
${USER_LOCAL_EMAIL}    xpath://input[@type="email"]
${USER_LOCAL_GROUP_LABEL}    xpath://label[span/span="User Group"]
${USER_LOCAL_GROUP_DIV}    xpath://label[span/span="User Group"]/following-sibling::div/div/div[@class="add-placeholder"]
${USER_LOCAL_GROUP_ENTRY_H1}    xpath://div[h1="Select Entries"]
${VAR_USER_LOCAL_GROUP_ENTRY_IN_LIST}    xpath://div[span/span="\${PLACEHOLDER}"]
${VAR_USER_LOCAL_GROUP_IN_DIV}    xpath://label[span/span="User Group"]/following-sibling::div[//span="\${PLACEHOLDER}"]
${USER_LOCAL_GROUP_CLOSE_BUTTON}    xpath://div[h1="Select Entries"]/following-sibling::div/button[text()="Close"]
${USER_BACK_BUTTON}    xpath://button[normalize-space(.)="< Back"]
${USER_SUBMIT_BUTTON}    xpath://button[normalize-space(.)="Submit"]
${USER_DELETE_USER_BUTTON}    xpath://button[div/span="Delete" and not(@disabled)]
${USER_DELETE_CONFIRM_HEAD}    xpath://h1[@title="Confirm" and text()="Confirm"]
${USER_DELETE_CONFIRM_OK_BUTTON}    xpath://button[text()="OK"]
${USER_DELETE_CONFIRM_CANCEL_BUTTON}    xpath://button[text()="Cancel"]
${USER_LIST_COLUMN}    xpath://td[@class="name"]
###USER edit
${USER_EDIT_USER_HEAD}    xpath://h1[text()="Edit User"]
${USER_EDIT_USER_USERNAME_INPUT}    xpath://label[text()="Username"]/following-sibling::div/input
${USER_EDIT_USER_STATUS_ENABLED}    xpath://label[span="Enabled"]
${USER_EDIT_USER_STATUS_DISABLED}    xpath://label[span="Disabled"]
${USER_EDIT_USER_PASSWORD_INPUT}    xpath://label[text()="Password"]/following-sibling::div/input
${USER_EDIT_USER_EMAIL_INPUT}    xpath://label[span="Email Address"]/following-sibling::div/input
${USER_EDIT_USER_OK}    id:submit_ok
###USER search
${USER_SEARCH_INPUT}    xpath://div[div/div/button//span="Create New"]/following-sibling::div/div/div/input
${USER_SEARCH_BUTTON}    xpath://div[div/div/button//span="Create New"]/following-sibling::div/div/button[@class="do-search"]
${USER_SEARCH_NO_MATCH_TD}    xpath://td[@class and text()="No matching entries found"]
${VAR_USER_SEARCH_USER_IN_TABLE}    xpath://tr[@mkey="\${PLACEHOLDER}"]
###LDAP BROWSER
${USER_USER_LDAP_SERVER_LABEL}    xpath://label[text()="LDAP Server"]
${USER_USER_LDAP_SERVER_DROPDOWN_DIV}    xpath://div[@class="add-placeholder"]
${VAR_USER_USER_LDAP_SERVER_IN_DROPDOWN}    xpath://div[span/span="\${PLACEHOLDER}"]
${VAR_USER_USER_LDAP_SERVER_SELECTED}    xpath://label[text()="LDAP Server"]/following-sibling::div[//span="\${PLACEHOLDER}"]
${USER_USER_LDAP_SERVER_BROWSER}    xpath://f-ldap-browser
${VAR_USER_USER_LDAP_SERVER_USERS_IN_LIST}    xpath://td[span="\${PLACEHOLDER}"]
${USER_USER_LDAP_SERVER_ADD_BUTTON}    xpath://button[div/span="Add Selected"]
${USER_USER_LDAP_SERVER_REMOVE_BUTTON}    xpath://button[div/span="Remove Selected"]
${USER_USER_LDAP_SERVER_SEARCH_INPUT}    xpath://div[contains(@class,"search-container")]/input
${USER_USER_LDAP_SERVER_SEARCH_BUTTON}    xpath://div[contains(@class,"search-container")]/following-sibling::button
${USER_USER_LDAP_SERVER_ADD_BUTTON_IN_DROPDOWN}    xpath://button[span="Create"]
${USER_USER_LDAP_SERVER_ADD_LDAP_IFRAME}    xpath://iframe[@class="slide-iframe"]
${VAR_USER_USER_LDAP_SERVER_EDIT_IN_DROPDOWN}    xpath://span[span="\${PLACEHOLDER}"]/following-sibling::f-icon
${VAR_USER_USER_LDAP_SERVER_FILTER_TYPE_LABEL}    xpath://button[span="\${PLACEHOLDER}"]
${USER_USER_LDAP_SERVER_FILTER_INPUT}    xpath://label[text()="Custom LDAP Filter"]/following-sibling::div/input
${USER_USER_LDAP_SERVER_FILTER_BUTTON}    xpath://button[span="Apply"]
