*** Settings ***
Documentation     This file contains FortiGate GUI VoIP Profile operation

*** Keywords ***
### Security Profiles ###    
### VoIP Profile ###


###        VoIP        ##############################################################################
Go To VoIP
    Go to Security Profiles
    Wait Until Element Is Visible    ${VOIP_ENTRY}
    click element    ${VOIP_ENTRY}
    select frame    embedded-iframe
    Wait Until Element Is Visible    ${CREATE_NEW_VOIP_PROFILE}
    Wait Until Element Is Visible    ${VOIP_PROFILE_ENTRY_DEFAULT}
    Wait Until Element Is Visible    ${VOIP_PROFILE_ENTRY_STRICT}
    unselect frame

Create New VoIP Profile
    [Arguments]    ${voip_profile_name}
    [Documentation]    after the new profile is created and saved, the editing page is still shown but the Apply button is displayed.
    Go To VoIP
    Wait Until Element Is Visible    ${VOIP_ENTRY}
    click element    ${VOIP_ENTRY}
    select frame    embedded-iframe
    Wait Until Element Is Visible    ${CREATE_NEW_VOIP_PROFILE}
    click element    ${CREATE_NEW_VOIP_PROFILE}
    Wait Until Element Is Visible    ${EDIT_VOIP_PROFILE_NAME}
    input text    ${EDIT_VOIP_PROFILE_NAME}    ${voip_profile_name}
    input text    ${EDIT_VOIP_PROFILE_SIP_REGISTER_RATE}    "30000"
    input text    ${EDIT_VOIP_PROFILE_SIP_INVITE_RATE}      "20000"
    input text    ${EDIT_VOIP_PROFILE_SCCP_MAX_CALLS}       "10000"
    click element    ${ADD_VOIP_PROFILE_OK}
    Wait Until Element Is Visible    ${EDIT_VOIP_PROFILE_APPLY}
    unselect frame

Edit New VoIP Profile
    [Arguments]    ${voip_profile_name_2}
    Go To VoIP
    select frame    embedded-iframe
    Wait Until Element Is Visible    ${VOIP_PROFILE_LIST_ENTRY3}
    click element    ${VOIP_PROFILE_LIST_ENTRY3}
    Wait Until Element Is Visible    ${VOIP_PROFILE_LIST_EDIT_BUTTON}
    click button    ${VOIP_PROFILE_LIST_EDIT_BUTTON}
    Wait Until Element Is Visible    ${EDIT_VOIP_PROFILE_NAME}
    input text    ${EDIT_VOIP_PROFILE_NAME}    ${voip_profile_name_2}
    input text    ${EDIT_VOIP_PROFILE_SIP_REGISTER_RATE}    "0"
    input text    ${EDIT_VOIP_PROFILE_SIP_INVITE_RATE}      "0"
    input text    ${EDIT_VOIP_PROFILE_SCCP_MAX_CALLS}       "0"
    click element    ${EDIT_VOIP_PROFILE_APPLY}
    Wait Until Element Is Visible    ${EDIT_VOIP_PROFILE_APPLY}
    unselect frame

Delete New VoIP Profile
    Go To VoIP
    select frame    embedded-iframe
    Wait Until Element Is Visible    ${VOIP_PROFILE_LIST_ENTRY3}
    click element    ${VOIP_PROFILE_LIST_ENTRY3}
    Wait Until Element Is Visible    ${VOIP_PROFILE_LIST_DELETE_BUTTON}
    click button    ${VOIP_PROFILE_LIST_DELETE_BUTTON}
    unselect frame
    Wait Until Element Is Visible    ${VOIP_PROFILE_LIST_DELETE_CONFIRM_BUTTON}
    click button    ${VOIP_PROFILE_LIST_DELETE_CONFIRM_BUTTON}
    select frame    embedded-iframe
    Wait Until Element Is Visible    ${VOIP_PROFILE_ENTRY_DEFAULT}
    Wait Until Element Is Not Visible    ${VOIP_PROFILE_LIST_ENTRY3}
    unselect frame

Check VoIP Entry Is Not In Security Profiles
   Go to Security Profiles
    Wait Until Element Is Not Visible    ${VOIP_ENTRY}

Check VoIP Entry Is In Security Profiles
    Go to Security Profiles
    Wait Until Element Is Visible    ${VOIP_ENTRY}