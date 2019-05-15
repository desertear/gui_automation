*** Settings ***
Documentation     This file contains all locator variables on FortiGate Radius Server

*** Variables ***
${USER_RADIUS_SERVERS_ENTRY}    xpath://span[text()="RADIUS Servers"]
${USER_RADIUS_SERVERS_CREATE_NEW}    xpath://button[div/span="Create New"]
${USER_RADIUS_SERVERS_EDIT_BUTTON}    xpath://button[div/span="Edit"]
${USER_RADIUS_SERVERS_DELETE_BUTTON}    xpath://button[div/span="Delete" and not(@disabled)]
${VAR_RADIUS_SERVERS_IN_TABLE}    xpath://div[@column-id="name" and //div="\${PLACEHOLDER}"]
${USER_RADIUS_SERVERS_NEW_H1}    xpath://h1[text()="New RADIUS Server"]
${USER_RADIUS_SERVERS_EDIT_H1}    xpath://h1[text()="Edit RADIUS Server"]
${USER_RADIUS_SERVERS_NAME_INPUT}    xpath://label[field-label="Name"]/following-sibling::div//input
${VAR_USER_RADIUS_SERVERS_AUTH_METHOD_TAB}    xpath://label[span="\${PLACEHOLDER}"]
${USER_RADIUS_SERVERS_AUTH_METHOD_DROPDOWN_DIV}    xpath://div[@class="add-placeholder"]
${VAR_USER_RADIUS_SERVERS_AUTH_METHOD_IN_DROPDOWN}    xpath://div[@class="selection-dropdown"]/div/div[span/span="\${PLACEHOLDER}"]
${VAR_USER_RADIUS_SERVERS_AUTH_METHOD_IN_DIV}    xpath://div[@class="selected-entries"]/div[span/span="\${PLACEHOLDER}"]
${USER_RADIUS_SERVERS_NAS_IP_INPUT}    xpath://label[field-label="NAS IP"]/following-sibling::div//input
${USER_RADIUS_SERVERS_USER_GROUP_CHECKBOX}    xpath://span[text()="Include in every user group"]/following-sibling::input
${USER_RADIUS_SERVERS_USER_GROUP_LABEL}    xpath://span[text()="Include in every user group"]/following-sibling::label
${USER_RADIUS_SERVERS_PRIMARY_IP_INPUT}    xpath://div[h2="Primary Server"]//following-sibling::f-field//label[field-label="IP/Name"]/following-sibling::div//input
${USER_RADIUS_SERVERS_PRIMARY_SECRET_INPUT}    xpath://div[h2="Primary Server"]//following-sibling::f-field//label[field-label="Secret"]/following-sibling::div//input
${USER_RADIUS_SERVERS_SECONDARY_IP_INPUT}    xpath://div[h2="Secondary Server"]//following-sibling::f-field//label[field-label="IP/Name"]/following-sibling::div//input
${USER_RADIUS_SERVERS_SECONDARY_SECRET_INPUT}    xpath://div[h2="Secondary Server"]//following-sibling::f-field//label[field-label="Secret"]/following-sibling::div//input
${USER_RADIUS_SERVERS_USER_OK}    id:submit_ok
#Test Buttons
${USER_RADIUS_SERVERS_PRIMARY_TEST_CONNECTIVITY_BUTTON}    xpath://div[h2="Primary Server"]//following-sibling::f-field//button[text()="Test Connectivity"]
${USER_RADIUS_SERVERS_PRIMARY_TEST_CREDENTIALS_BUTTON}    xpath://div[h2="Primary Server"]//following-sibling::f-field//button[text()="Test User Credentials"]
${USER_RADIUS_SERVERS_PRIMARY_CONNECTION_STATUS}    xpath://div[h2="Primary Server"]//following-sibling::f-connection-status//span
${USER_RADIUS_SERVERS_SECONDARY_TEST_CONNECTIVITY_BUTTON}    xpath://div[h2="Secondary Server"]//following-sibling::f-field//button[text()="Test Connectivity"]
${USER_RADIUS_SERVERS_SECONDARY_TEST_CREDENTIALS_BUTTON}    xpath://div[h2="Secondary Server"]//following-sibling::f-field//button[text()="Test User Credentials"]
${USER_RADIUS_SERVERS_SECONDARY_CONNECTION_STATUS}    xpath://div[h2="Secondary Server"]//following-sibling::f-connection-status//span
#Test Sub page
${USER_RADIUS_SERVERS_TEST_CREDENTIALS_HEAD}    xpath://h1[text()="Test User Credentials"]
${USER_RADIUS_SERVERS_TEST_CREDENTIALS_USERNAME_INPUT}    xpath://label[field-label="Username"]/following-sibling::div//input
${USER_RADIUS_SERVERS_TEST_CREDENTIALS_PASSWORD_INPUT}    xpath://label[field-label="Password"]/following-sibling::div//input
${USER_RADIUS_SERVERS_TEST_CREDENTIALS_PASSWORD_EMPTY_WARNING}    xpath://label[normalize-space(.)="This field is required."]
${USER_RADIUS_SERVERS_TEST_CREDENTIALS_TEST_BUTTON}    xpath://button[span="Test"]
${USER_RADIUS_SERVERS_TEST_CREDENTIALS_CLOSE_BUTTON}    xpath://button[span="Test"]/following-sibling::button[text()="Close"]
${USER_RADIUS_SERVERS_CREDENTIALS_STATUS}    xpath://label[field-label="User credentials"]/following-sibling::div//span[f-icon]
${USER_RADIUS_SERVERS_SERVER_MESSAGE}    xpath://div[@class="message-content" and pre]
#Delete Sub Page
${USER_RADIUS_SERVERS_DELETE_CONFIRM_HEAD}    xpath://h1[@title="Confirm" and text()="Confirm"]
${USER_RADIUS_SERVERS_DELETE_CONFIRM_OK_BUTTON}    xpath://button[text()="OK"]
${USER_RADIUS_SERVERS_DELETE_CONFIRM_CANCEL_BUTTON}    xpath://button[text()="Cancel"]