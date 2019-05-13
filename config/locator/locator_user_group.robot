
*** Settings ***
Documentation     This file contains all locator variables on FortiGate User&Device->User Groups page

*** Variables ***
###User Groups###
${USER_GROUP_ENTRY}    xpath://span[text()="User Groups"]
${USER_GROUP_FRAME}    name:embedded-iframe
${GROUP_LIST_COLUMN}    xpath://div[@class="table-container"]
${GROUP_CREATE_NEW_BUTTON}    xpath://button[div/span="Create New"]
${VAR_GROUP_GROUP_IN_TABLE}    xpath://div[@class="table-container"]//div[text()="\${PLACEHOLDER}"]

${GROUP_WIZARD_H1}    xpath://h1[text()="New User Group"]
${GROUP_NAME_TEXT}     xpath://div/label[text()="Name"]/following-sibling::div/input
${VAR_GROUP_TYPE_FIREWALL_LABEL}    xpath://label[span="\${PLACEHOLDER}"]
${GROUP_TYPE_FIREWALL_LABEL}    xpath://label[span="Firewall"]
${GROUP_TYPE_FSSO_LABEL}    xpath://label[span="Fortinet Single Sign-On (FSSO)"]
${GROUP_TYPE_RSSO_LABEL}    xpath://label[span="RADIUS Single Sign-On (RSSO)"]
${GROUP_TYPE_GUEST_LABEL}    xpath://label[span="Guest"]
${GROUP_MEMBERS_DIV}    xpath://div/label[text()="Members"]/following-sibling::div/div/div[@class="add-placeholder"]
${GROUP_SELECT_ENTRY_H1}    xpath://div[h1="Select Entries"]
${GROUP_SELECT_ENTRY_CLOSE_BUTTON}    xpath://div[h1="Select Entries"]/following-sibling::div/button[text()="Close"]
${GROUP_SELECT_ENTRY_LIST}    xpath://div[h1="Select Entries"]/following-sibling::div[@class="virtual-results"]
${VAR_GROUP_SELECT_ENTRY_USE_IN_LIST}    xpath://div[span/span="\${PLACEHOLDER}"]
${VAR_GROUP_SELECT_ENTRY_USE_IN_DIV}    xpath://div/label[text()="Members"]/following-sibling::div//span[text()="\${PLACEHOLDER}"]
${GROUP_OK_BUTTON}    xpath://button[@id="submit_ok"]
${GROUP_CANCEL_BUTTON}    xpath://button[@id="submit_cancel"]
${GROUP_DELETE_GROUP_BUTTON}    xpath://button[div/span="Delete" and not(@disabled)]
${GROUP_DELETE_CONFIRM_HEAD}    xpath://h1[@title="Confirm" and text()="Confirm"]
${GROUP_DELETE_CONFIRM_OK_BUTTON}    xpath://button[text()="OK"]
${GROUP_DELETE_CONFIRM_CANCEL_BUTTON}    xpath://button[text()="Cancel"]
##Remote Groups
${GROUP_REMOTE_GROUPS_ADD_BUTTON}    xpath://button[div/span="Add"]
${GROUP_REMOTE_GROUPS_EDIT_BUTTON}    xpath://button[div/span="Edit"]
${GROUP_REMOTE_GROUPS_DELETE_BUTTON}    xpath://button[div/span="Delete"]
${VAR_GROUP_REMOTE_GROUPS_ENTRY_IN_TABLE}    xpath://div[h2="Remote Groups"]/following-sibling::div//table//td[span="\${PLACEHOLDER}"]
#Remote Groups Add/Edit Side Frame
${GROUP_REMOTE_GROUPS_HEAD}    xpath://h1[text()="Add Group Match"]
${GROUP_REMOTE_GROUPS_DROPDOWN_DIV}    xpath://label[text()="Remote Server"]/following-sibling::div//div[@class="add-placeholder"]
${VAR_GROUP_REMOTE_GROUPS_GROUP_IN_DROPDOWN}    xpath://div[span/span="\${PLACEHOLDER}"]
${VAR_GROUP_REMOTE_GROUPS_GROUP_SELECTED}    xpath://label/following-sibling::div[.//span="\${PLACEHOLDER}"]
${GROUP_REMOTE_GROUPS_GROUP_LABEL_ANY}    xpath://label[span="any"]
${GROUP_REMOTE_GROUPS_GROUP_LABEL_SPECIFY}    xpath://label[span="Specify"]
${GROUP_REMOTE_GROUPS_GROUP_SPECIFY_INPUT}    xpath://f-field[label/field-label="Groups"]/following-sibling::f-field//input
##LDAP server browser
${GROUP_REMOTE_GROUPS_SERVER_BROWSER}    xpath://f-ldap-browser
${VAR_GROUP_REMOTE_GROUPS_SERVER_IN_LIST}    xpath://td[span="\${PLACEHOLDER}"]
${GROUP_REMOTE_GROUPS_SERVER_ADD_BUTTON}    xpath://button[div/span="Add Selected"]
${GROUP_REMOTE_GROUPS_SERVER_REMOVE_BUTTON}    xpath://button[div/span="Remove Selected"]
${GROUP_REMOTE_GROUPS_SERVER_BROWSER_OK_BUTTON}    xpath://button[text()="OK"]
#Delete Servers confirm frame
${GROUP_REMOTE_GROUPS_SERVER_DELETE_HEAD}    xpath://h1[text()="Confirm"]
${GROUP_REMOTE_GROUPS_SERVER_DELETE_OK_BUTTON}    xpath://button[text()="OK"]