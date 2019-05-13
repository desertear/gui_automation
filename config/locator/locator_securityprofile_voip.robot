*** Settings ***
Documentation     This file contains all locator variables on FortiGate for VoIP

*** Variables ***
##Go to VDOM move to  Security Porfile
###   VoIP   ####
${VOIP_ENTRY}                       xpath:(//span[contains(text(),"VoIP")])[1]
${CREATE_NEW_VOIP_PROFILE}          xpath://button[div/span="Create New"]
${VOIP_PROFILE_ENTRY_DEFAULT}       xpath://*[@id="content"]/div[2]/table/tbody/tr[1]/td[1]
${VOIP_PROFILE_ENTRY_STRICT}        xpath://*[@id="content"]/div[2]/table/tbody/tr[2]/td[1]
${EDIT_VOIP_PROFILE_NAME}           xpath://input[@id="name"]
${EDIT_VOIP_PROFILE_SIP_REGISTER_RATE}           xpath://input[@id="sip-register-rate"]
${EDIT_VOIP_PROFILE_SIP_INVITE_RATE}           xpath://input[@id="sip-invite-rate"]
${EDIT_VOIP_PROFILE_SCCP_MAX_CALLS}           xpath://input[@id="sccp-max-calls"]
${ADD_VOIP_PROFILE_OK}              xpath://button[@id="submit_ok"]
${EDIT_VOIP_PROFILE_APPLY}          xpath://button[@id="submit_apply"]
${VOIP_PROFILE_LIST_ENTRY3}         xpath://*[@id="content"]/div[2]/table/tbody/tr[3]/td[1]
${VOIP_PROFILE_LIST_EDIT_BUTTON}    xpath:(//button[div/span="Edit"])[1]
${VOIP_PROFILE_LIST_DELETE_BUTTON}              xpath:(//button[div/span="Delete"])[1]
${VOIP_PROFILE_LIST_DELETE_CONFIRM_BUTTON}      xpath://button[contains(text(),"OK")]
