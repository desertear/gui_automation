*** Settings ***
Documentation     This file contains all locator variables on FortiGate TACACS Server

*** Variables ***
${USER_TACACS_SERVERS_ENTRY}    xpath://span[text()="TACACS+ Servers"]
${USER_TACACS_SERVERS_CREATE_NEW}    xpath://button[div/span="Create New"]
${USER_TACACS_SERVERS_EDIT_BUTTON}    xpath://button[div/span="Edit"]
${USER_TACACS_SERVERS_DELETE_BUTTON}    xpath://button[div/span="Delete" and not(@disabled)]
${VAR_TACACS_SERVERS_IN_TABLE}    xpath://div[@column-id="name" and //div="\${PLACEHOLDER}"]
${USER_TACACS_SERVERS_NEW_H1}    xpath://h1[text()="New TACACS+ Server"]
${USER_TACACS_SERVERS_EDIT_H1}    xpath://h1[text()="Edit TACACS+ Server"]
${USER_TACACS_SERVERS_NAME_INPUT}    xpath://label[field-label="Name"]/following-sibling::div//input
${VAR_USER_TACACS_SERVERS_AUTH_METHOD_TAB}    xpath://label[span="\${PLACEHOLDER}"]
${USER_TACACS_SERVERS_AUTH_METHOD_DROPDOWN_DIV}    xpath://div[@class="add-placeholder"]
${VAR_USER_TACACS_SERVERS_AUTH_METHOD_IN_DROPDOWN}    xpath://div[@class="selection-dropdown"]/div/div[span/span="\${PLACEHOLDER}"]
${VAR_USER_TACACS_SERVERS_AUTH_METHOD_IN_DIV}    xpath://div[@class="selected-entries"]/div[span/span="\${PLACEHOLDER}"]
${USER_TACACS_SERVERS_PRIMARY_IP_INPUT}    xpath://div[h2="Primary Server"]//following-sibling::f-field//label[field-label="Server IP/Name"]/following-sibling::div//input
${USER_TACACS_SERVERS_PRIMARY_SECRET_INPUT}    xpath://div[h2="Primary Server"]//following-sibling::f-field//label[field-label="Server Secret"]/following-sibling::div//input
${USER_TACACS_SERVERS_SECONDARY_IP_INPUT}    xpath://div[h2="Secondary Server"]//following-sibling::f-field//label[field-label="Server IP/Name"]/following-sibling::div//input
${USER_TACACS_SERVERS_SECONDARY_SECRET_INPUT}    xpath://div[h2="Secondary Server"]//following-sibling::f-field//label[field-label="Server Secret"]/following-sibling::div//input
${USER_TACACS_SERVERS_TERTIARY_IP_INPUT}    xpath://div[h2="Tertiary Server"]//following-sibling::f-field//label[field-label="Server IP/Name"]/following-sibling::div//input
${USER_TACACS_SERVERS_TERTIARY_SECRET_INPUT}    xpath://div[h2="Tertiary Server"]//following-sibling::f-field//label[field-label="Server Secret"]/following-sibling::div//input
${USER_TACACS_SERVERS_USER_OK}    id:submit_ok
#Test Buttons
${USER_TACACS_SERVERS_PRIMARY_TEST_CONNECTIVITY_BUTTON}    xpath://div[h2="Primary Server"]//following-sibling::button[text()="Test"]
${USER_TACACS_SERVERS_PRIMARY_CONNECTION_STATUS}    xpath://div[h2="Primary Server"]//following-sibling::f-connection-status//span
${USER_TACACS_SERVERS_SECONDARY_TEST_CONNECTIVITY_BUTTON}    xpath://div[h2="Secondary Server"]//following-sibling::button[text()="Test"]
${USER_TACACS_SERVERS_SECONDARY_CONNECTION_STATUS}    xpath://div[h2="Secondary Server"]//following-sibling::f-connection-status//span
${USER_TACACS_SERVERS_TERTIARY_TEST_CONNECTIVITY_BUTTON}    xpath://div[h2="Tertiary Server"]//following-sibling::button[text()="Test"]
${USER_TACACS_SERVERS_TERTIMARY_CONNECTION_STATUS}    xpath://div[h2="Tertiary Server"]//following-sibling::f-connection-status//span
#Delete Sub Page
${USER_TACACS_SERVERS_DELETE_CONFIRM_HEAD}    xpath://h1[@title="Confirm" and text()="Confirm"]
${USER_TACACS_SERVERS_DELETE_CONFIRM_OK_BUTTON}    xpath://button[text()="OK"]
${USER_TACACS_SERVERS_DELETE_CONFIRM_CANCEL_BUTTON}    xpath://button[text()="Cancel"]