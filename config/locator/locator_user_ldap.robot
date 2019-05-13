*** Settings ***
Documentation     This file contains all locator variables on FortiGate LDAP Server

*** Variables ***
${USER_LDAP_SERVERS_ENTRY}    xpath://span[text()="LDAP Servers"]
${USER_LDAP_SERVERS_CREATE_NEW}    xpath://button[div/span="Create New"]
${USER_LDAP_SERVERS_EDIT_BUTTON}    xpath://button[div/span="Edit"]
${USER_LDAP_SERVERS_DELETE_BUTTON}    xpath://button[div/span="Delete" and not(@disabled)]
${VAR_LDAP_SERVERS_IN_TABLE}    xpath://td[@class="name" and text()="\${PLACEHOLDER}"]
#Edit LDAP Server
${USER_LDAP_SERVERS_EDIT_H1}    xpath://h1[text()="Edit LDAP Server"]
${USER_LDAP_SERVERS_NAME_INPUT}    xpath://label[text()="Name"]/following-sibling::div/input
${USER_LDAP_SERVERS_IP_INPUT}    xpath://label[text()="Server IP/Name"]/following-sibling::div/input
${USER_LDAP_SERVERS_PORT_INPUT}    xpath://label[text()="Server Port"]/following-sibling::div/input
${USER_LDAP_SERVERS_CN_INPUT}    xpath://label[text()="Common Name Identifier"]/following-sibling::div/input
${USER_LDAP_SERVERS_DN_INPUT}    xpath://label[text()="Distinguished Name"]/following-sibling::div/input
${VAR_USER_LDAP_SERVERS_BIND_TYPE}    xpath://label[span="\${PLACEHOLDER}"]
${USER_LDAP_SERVERS_USERNAME_INPUT}    xpath://label[text()="Username"]/following-sibling::div/input
${USER_LDAP_SERVERS_PASSWORD}    xpath://label[text()="Password"]/following-sibling::div//input[@type="password"]
${USER_LDAP_SERVERS_PASSWORD_CHANGE_BUTTON}    xpath://button[text()="Change"]
${USER_LDAP_SERVERS_SECURE_LABEL}    xpath://span[text()="Secure Connection"]/following-sibling::label
${USER_LDAP_SERVERS_SECURE_CHECKBOX}    xpath://span[text()="Secure Connection"]/following-sibling::input
${VAR_USER_LDAP_SERVERS_PROTOCOL}    xpath://label[span="\${PLACEHOLDER}"]
${USER_LDAP_SERVERS_CERTIFICATE_DIV}    xpath://label[text()="Certificate"]/following-sibling::div
${VAR_USER_LDAP_SERVERS_CERTIFICATE_DIV_IN_DROPDOWN}    xpath://div[@class="selection-dropdown"]//div[span/span="\${PLACEHOLDER}"]
${VAR_USER_LDAP_SERVERS_CERTIFICATE_DIV_SELECTED}    xpath://label[text()="Certificate"]/following-sibling::div//span[text()="\${PLACEHOLDER}"]
${USER_LDAP_SERVERS_TEST_CONNECTIVITY_BUTTON}    xpath://button[span="Test Connectivity"]
${USER_LDAP_SERVERS_CONNECTION_STATUS}    xpath://label[field-label="Connection status"]/following-sibling::div//span[f-icon]
${USER_LDAP_SERVERS_TEST_CREDENTIALS_BUTTON}    xpath://button[span="Test User Credentials"]
${USER_LDAP_SERVERS_TEST_CREDENTIALS_HEAD}    xpath://h1[text()="Test User Credentials"]
${USER_LDAP_SERVERS_TEST_CREDENTIALS_USERNAME_INPUT}    xpath://label[field-label="Username"]/following-sibling::div//input
${USER_LDAP_SERVERS_TEST_CREDENTIALS_PASSWORD_INPUT}    xpath://label[field-label="Password"]/following-sibling::div//input
${USER_LDAP_SERVERS_TEST_CREDENTIALS_PASSWORD_EMPTY_WARNING}    xpath://label[normalize-space(.)="This field is required."]
${USER_LDAP_SERVERS_TEST_CREDENTIALS_TEST_BUTTON}    xpath://button[span="Test"]
${USER_LDAP_SERVERS_TEST_CREDENTIALS_CLOSE_BUTTON}    xpath://button[span="Test"]/following-sibling::button[text()="Close"]
${USER_LDAP_SERVERS_CREDENTIALS_STATUS}    xpath://label[field-label="User credentials"]/following-sibling::div//span[f-icon]
${USER_LDAP_SERVERS_USER_OK}    id:submit_ok
#Browse Distinguished Name Subpage
${USER_LDAP_SERVERS_DN_BROWSE}    xpath://button[span="Browse"]
${USER_LDAP_SERVERS_DN_BROWSE_INVALID_WARNING}    xpath://div[text()="Invalid LDAP server"]
${VAR_USER_LDAP_SERVERS_DN_BROWSE_TREE_NODE}    xpath://f-tree-view/ul/li[normalize-space(.//label)="\${PLACEHOLDER}"]
${USER_LDAP_SERVERS_DN_BROWSE_OK}    xpath://button[text()="OK"]
${USER_LDAP_SERVERS_DN_BROWSE_CANCEL}    xpath://button[text()="Cancel"]
#Delete Sub Page
${USER_LDAP_SERVERS_DELETE_CONFIRM_HEAD}    xpath://h1[@title="Confirm" and text()="Confirm"]
${USER_LDAP_SERVERS_DELETE_CONFIRM_OK_BUTTON}    xpath://button[text()="OK"]
${USER_LDAP_SERVERS_DELETE_CONFIRM_CANCEL_BUTTON}    xpath://button[text()="Cancel"]
