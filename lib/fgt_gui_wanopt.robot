*** Settings ***
Documentation     This file contains FortiGate GUI Policy and Objects operation

*** Keywords ***
###WAN Optimization###    
##WAN Opt. & Cache##
Go to Wanopt
    Wait Until Element Is Visible    ${WANOPT_ENTRY}
    ${nav_bar_is_not_expanded}=    run keyword and return status    Wait Until Page Contains Element    ${WANOPT_ENTRY}//following-sibling::f-icon[@class="fa-angle-right rotate-0"]
    run keyword if    "${nav_bar_is_not_expanded}"=="True"        click element    ${WANOPT_ENTRY}


###        Wanopt Profiles         ##############################################################################

Go To Wanopt Profile
    Go to Wanopt
    Wait Until Element Is Visible    ${WANOPT_PROFILES_ENTRY}
    click element    ${WANOPT_PROFILES_ENTRY}
    select frame    embedded-iframe
    Wait Until Element Is Visible    ${CREATE_NEW_WANOPT_PROFILE}
    unselect frame

Create New Wanopt Profile
    [Arguments]    ${wanopt_profile_name}
    [Documentation]    after the new profile is created and saved, the editing page is still shown but the Apply button is displayed.
    Go to Wanopt
    Wait Until Element Is Visible    ${WANOPT_PROFILES_ENTRY}
    click element    ${WANOPT_PROFILES_ENTRY}
    select frame    embedded-iframe
    Wait Until Element Is Visible    ${CREATE_NEW_WANOPT_PROFILE}
    click element    ${CREATE_NEW_WANOPT_PROFILE}
    Wait Until Element Is Visible    ${EDIT_WANOPT_PROFILE_NAME}
    input text    ${EDIT_WANOPT_PROFILE_NAME}    ${wanopt_profile_name}
    click element    ${ADD_WANOPT_PROFILE_OK}
    Wait Until Element Is Visible    ${EDIT_WANOPT_PROFILE_APPLY}
    unselect frame

Edit New Wanopt Profile
    [Arguments]    ${wanopt_profile_name_2}
    Go To Wanopt Profile
    select frame    embedded-iframe
    Wait Until Element Is Visible    ${WANOPT_PROFILE_LIST_ENTRY2}
    click element    ${WANOPT_PROFILE_LIST_ENTRY2}
    Wait Until Element Is Visible    ${WANOPT_PROFILE_LIST_EDIT_BUTTON}
    click button    ${WANOPT_PROFILE_LIST_EDIT_BUTTON}
    Wait Until Element Is Visible    ${EDIT_WANOPT_PROFILE_NAME}
    input text    ${EDIT_WANOPT_PROFILE_NAME}    ${wanopt_profile_name_2}
    click element    ${EDIT_WANOPT_PROFILE_APPLY}
    Wait Until Element Is Visible    ${EDIT_WANOPT_PROFILE_APPLY}
    unselect frame


# Delete Wanopt Profile
#     Go To Wanopt Profile
#     select frame    embedded-iframe
#     Wait Until Element Is Visible    ${WANOPT_PROFILE_LIST_ENTRY2}
#     click element    ${WANOPT_PROFILE_LIST_ENTRY2}
#     Wait Until Element Is Visible    ${WANOPT_PROFILE_LIST_DELETE_BUTTON}
#     click button    ${WANOPT_PROFILE_LIST_DELETE_BUTTON}
#     unselect frame
#     Wait Until Element Is Visible    ${WANOPT_PROFILE_LIST_DELETE_CONFIRM_BUTTON}
#     click button    ${WANOPT_PROFILE_LIST_DELETE_CONFIRM_BUTTON}
#     Wait Until Element Is Not Visible    ${WANOPT_PROFILE_LIST_ENTRY2}


###            Wanopt Peers           #############################################################################

Go To Wanopt Peers
    Go to Wanopt
    Wait Until Element Is Visible    ${WANOPT_PEERS_ENTRY}
    click element    ${WANOPT_PEERS_ENTRY}
    select frame    embedded-iframe
    Wait Until Element Is Visible    ${CREATE_NEW_WANOPT_PEER}
    unselect frame

Edit Wanopt Local Host ID
    [Arguments]     ${wanopt_local_host}
    Go To Wanopt Peers
    select frame    embedded-iframe
    Wait Until Element Is Visible    ${WANOPT_LOCAL_HOST_ID}
    
    # Configure a new local host id
    click element    ${WANOPT_LOCAL_HOST_ID}
    input text    ${WANOPT_LOCAL_HOST_ID_}    ${wanopt_local_host}
    Wait Until Element Is Visible   ${WANOPT_LOCAL_HOST_ID_APPLY}
    click element   ${WANOPT_LOCAL_HOST_ID_APPLY}
    Wait Until Element Is Not Visible    ${WANOPT_LOCAL_HOST_ID_APPLY}
    Wait Until Element Is Visible    ${WANOPT_LOCAL_HOST_ID}

    # Verify the local host id is the same value as expected
    ${wanopt_host_value}=    Get Element Attribute    ${WANOPT_LOCAL_HOST_ID}    value
    should be equal     ${wanopt_host_value}    ${wanopt_local_host}

    unselect frame

Create New Wanopt Peer
    [Arguments]    ${wanopt_peer_name}    ${wanopt_peer_ip}
    [Documentation]    after the new peer is created and saved, the peer list page will be displayed.
    Go To Wanopt Peers
    select frame    embedded-iframe
    Wait Until Element Is Visible    ${CREATE_NEW_WANOPT_PEER}
    click element    ${CREATE_NEW_WANOPT_PEER}
    Wait Until Element Is Visible    ${EDIT_WANOPT_PEER_NAME}
    input text    ${EDIT_WANOPT_PEER_NAME}    ${wanopt_peer_name}
    input text    ${EDIT_WANOPT_PEER_IP}    ${wanopt_peer_ip}
    click element    ${EDIT_WANOPT_PEER_OK}
    Wait Until Element Is Visible    ${WANOPT_PEER_LIST_ENTRY2}
    #Wait Until Element Is Visible    ${WANOPT_PEER_LIST_ENTRY2_IP}
    unselect frame

Edit New Wanopt Peer
    [Arguments]    ${wanopt_peer_name_2}    ${wanopt_peer_ip_2}
    Go To Wanopt Peers
    select frame    embedded-iframe
    Wait Until Element Is Visible    ${WANOPT_PEER_LIST_ENTRY2}
    click element    ${WANOPT_PEER_LIST_ENTRY2}
    # click element    ${WANOPT_PEER_LIST_ENTRY2}
    Wait Until Element Is Visible    ${WANOPT_PEER_LIST_EDIT_BUTTON}
    # sleep    1
    click button    ${WANOPT_PEER_LIST_EDIT_BUTTON}
    Wait Until Element Is Visible    ${EDIT_WANOPT_PEER_NAME}
    input text    ${EDIT_WANOPT_PEER_NAME}    ${wanopt_peer_name_2}
    input text    ${EDIT_WANOPT_PEER_IP}    ${wanopt_peer_ip_2}
    click element    ${EDIT_WANOPT_PEER_OK}
    Wait Until Element Is Visible    ${WANOPT_PEER_LIST_ENTRY2}
    # Wait Until Element Is Visible    ${WANOPT_PEER_LIST_ENTRY2_name_2}
    # Wait Until Element Is Visible    ${WANOPT_PEER_LIST_ENTRY2_IP_2}
    unselect frame


### Wanopt Authentication Groups         ##########################################################################

Go To Wanopt Auth Groups
    Go to Wanopt
    Wait Until Element Is Visible    ${WANOPT_AUTH_GROUPS_ENTRY}
    click element    ${WANOPT_AUTH_GROUPS_ENTRY}
    select frame    embedded-iframe
    Wait Until Element Is Visible    ${CREATE_NEW_WANOPT_AUTH_GROUP}
    unselect frame

Create New Wanopt Auth Group
    [Arguments]    ${wanopt_auth_group_name}
    [Documentation]    after the new auth group is created and saved, the auth group list page will be displayed.
    Go To Wanopt Auth Groups
    select frame    embedded-iframe
    Wait Until Element Is Visible    ${CREATE_NEW_WANOPT_AUTH_GROUP}
    click element    ${CREATE_NEW_WANOPT_AUTH_GROUP}
    Wait Until Element Is Visible    ${EDIT_WANOPT_AUTH_GROUP_NAME}
    input text    ${EDIT_WANOPT_AUTH_GROUP_NAME}    ${wanopt_auth_group_name}
    click element    ${WANOPT_AUTH_GROUP_METHOD_KEY}
    input text    ${EDIT_WANOPT_AUTH_GROUP_KEY}     "123456"
    click element    ${EDIT_WANOPT_AUTH_GROUP_OK}
    # Wait Until Element Is Visible    ${WANOPT_AUTH_GROUP_LIST_ENTRY2}
    Wait Until Element Is Visible    ${WANOPT_AUTH_GROUP_LIST_ENTRY2_NAME}
    unselect frame

Edit New Wanopt Auth Group
    [Arguments]    ${wanopt_auth_group_name_2}
    Go To Wanopt Auth Groups
    select frame    embedded-iframe
    Wait Until Element Is Visible    ${WANOPT_AUTH_GROUP_LIST_ENTRY2}
    click element    ${WANOPT_AUTH_GROUP_LIST_ENTRY2}
    Wait Until Element Is Visible    ${WANOPT_AUTH_GROUP_LIST_EDIT_BUTTON}
    click button    ${WANOPT_AUTH_GROUP_LIST_EDIT_BUTTON}
    Wait Until Element Is Visible    ${EDIT_WANOPT_AUTH_GROUP_NAME}
    input text    ${EDIT_WANOPT_AUTH_GROUP_NAME}    ${wanopt_auth_group_name_2}
    click element      ${WANOPT_AUTH_GROUP_METHOD_CERT}
    click element      ${WANOPT_AUTH_GROUP_CERT_SELECT}
    click element      ${WANOPT_AUTH_GROUP_CERT_FORTI_FACTORY}
    click element      ${WANOPT_AUTH_GROUP_ACCEPT_PEER_DEFINED}
    click element    ${EDIT_WANOPT_AUTH_GROUP_OK}
    # Wait Until Element Is Visible    ${WANOPT_AUTH_GROUP_LIST_ENTRY2}
    Wait Until Element Is Visible    ${WANOPT_AUTH_GROUP_LIST_ENTRY2_NAME_2}
    unselect frame

Delete New Wanopt Auth Group
    Go To Wanopt Auth Groups
    select frame    embedded-iframe
    Wait Until Element Is Visible    ${WANOPT_AUTH_GROUP_LIST_ENTRY2}
    click element    ${WANOPT_AUTH_GROUP_LIST_ENTRY2}
    Wait Until Element Is Visible    ${WANOPT_AUTH_GROUP_LIST_DELETE_BUTTON}
    click button    ${WANOPT_AUTH_GROUP_LIST_DELETE_BUTTON}
    unselect frame
    Wait Until Element Is Visible    ${WANOPT_AUTH_GROUP_LIST_DELETE_CONFIRM_BUTTON}
    click button    ${WANOPT_AUTH_GROUP_LIST_DELETE_CONFIRM_BUTTON}
    Wait Until Element Is Not Visible    ${WANOPT_PROFILE_LIST_ENTRY2}