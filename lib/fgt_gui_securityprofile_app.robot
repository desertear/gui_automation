*** Settings ***
Documentation     This file contains FortiGate GUI Policy and Objects operation

*** Keywords ***
###Application Control###    
##Security Profile ->Application Control##
Go to Security Profile
    Wait Until Element Is Visible    ${SECURITY_PROFILE_ENTRY}
    ${nav_bar_is_not_expanded}=    run keyword and return status    Wait Until Page Contains Element    ${SECURITY_PROFILE_ENTRY}//following-sibling::f-icon[@class="fa-angle-right rotate-0"]
    run keyword if    "${nav_bar_is_not_expanded}"=="True"        click element    ${SECURITY_PROFILE_ENTRY}

Go to Application Control
    Wait Until Element Is Visible    ${APPLICATION_CONTROL_ENTRY}
    click element    ${APPLICATION_CONTROL_ENTRY}
    Wait Until Element Is Visible    ${APP_SENSOR_NEW_BUTTON}

Create New App Sensor
    [Arguments]   ${app_sensor_name}
    [Documentation]    possible item of appctrl profile name: testgui/default profile (add and then delete specific signature)

    Go to Security Profile
    Go to Application Control
    click button    ${APP_SENSOR_NEW_BUTTON}
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_SIGNATURES_BUTTON}
    input text    ${EDIT_APP_SENSOR_NAME}    ${app_sensor_name}

    #add specific app
    click element    ${EDIT_APP_SENSOR_ADD_SIGNATURES_BUTTON}
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_SIGNATURES_1}
    click element    ${EDIT_APP_SENSOR_ADD_SIGNATURES_1}
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_SIGNATURES_USE}
    click button    ${EDIT_APP_SENSOR_ADD_SIGNATURES_USE}
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_OK}
    click element    ${EDIT_APP_SENSOR_OK}
    sleep    10
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_ENTRY_EXIST}
    
    #del specific app
    click element    ${EDIT_APP_SENSOR_ADD_ENTRY_EXIST}
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_DELETE_SIGNATURES_BUTTON}
    click element    ${EDIT_APP_SENSOR_DELETE_SIGNATURES_BUTTON}
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_APPLY}
    click element    ${EDIT_APP_SENSOR_APPLY}
    sleep    10
    Wait Until Element Is Not Visible    ${EDIT_APP_SENSOR_ADD_ENTRY_EXIST}

Create New App List
    [Arguments]   ${app_sensor_name}
    [Documentation]    possible item of appctrl list name: testgui/default profile

    Go to Security Profile
    Go to Application Control

    #create default list
    click button    ${APP_SENSOR_LIST_BUTTON}
    Wait Until Element Is Visible    embedded-iframe
    select frame    embedded-iframe
    Wait Until Element Is Visible    ${VIEW_LIST_CREATE_NEW_BUTTON}
    click element    ${VIEW_LIST_CREATE_NEW_BUTTON}
    unselect frame
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_SIGNATURES_BUTTON}
    input text    ${EDIT_APP_SENSOR_NAME}    ${app_sensor_name}
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_OK}
    click element    ${EDIT_APP_SENSOR_OK}


Delete New App Sensor in List

    Go to Security Profile
    Go to Application Control
    click button    ${APP_SENSOR_LIST_BUTTON}
    Wait Until Element Is Visible    embedded-iframe
    select frame    embedded-iframe
    Wait Until Element Is Visible    ${VIEW_LIST_11}
    click element    ${VIEW_LIST_11}
    Wait Until Element Is Visible    ${VIEW_LIST_DELETE_BUTTON}
    click button    ${VIEW_LIST_DELETE_BUTTON}
    unselect frame
    Wait Until Element Is Visible    ${VIEW_LIST_DELETE_OK_BUTTON}
    click button    ${VIEW_LIST_DELETE_OK_BUTTON}
    Wait Until Element Is Not Visible    ${VIEW_LIST_11}

Create New App Profile with Specific Signature

    [Arguments]   ${app_sensor_name}    ${app_filter_name_input}    
    ...    ${app_filter_name_input_verify}    ${app_filter_name_display}
    [Documentation]    define specific app signature under application overrides in new app profile
    ...    ${app_filter_name_input}-----filter by name:input
    ...    ${app_filter_name_input_verify}-------dropdown menu after input name
    ...    ${app_filter_name_display}----------available app entry display in list after filter

    Go to Security Profile
    Go to Application Control
    click button    ${APP_SENSOR_NEW_BUTTON}
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_SIGNATURES_BUTTON}
    input text    ${EDIT_APP_SENSOR_NAME}    ${app_sensor_name}
    click element    ${EDIT_APP_SENSOR_ADD_SIGNATURES_BUTTON}

    #filter "XXXXX" by searching name and then click OK

    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_SIGNATURES_ADD_FILTER}
    click element    ${EDIT_APP_SENSOR_ADD_SIGNATURES_ADD_FILTER}
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_SIGNATURES_NAME}
    click element    ${EDIT_APP_SENSOR_ADD_SIGNATURES_NAME}
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_SIGNATURES_NAME_INPUT}
    input text    ${EDIT_APP_SENSOR_ADD_SIGNATURES_NAME_INPUT}    ${app_filter_name_input}
    #click button    ${app_filter_name_input_verify}
    lib.ExtendedSeleniumLibrary.Mouse Down    ${app_filter_name_input_verify}
    lib.ExtendedSeleniumLibrary.Mouse Up    ${app_filter_name_input_verify}
    Wait Until Element Is Visible    ${app_filter_name_display}
    lib.ExtendedSeleniumLibrary.Mouse Down    ${app_filter_name_display}
    lib.ExtendedSeleniumLibrary.Mouse Up    ${app_filter_name_display}
    sleep    3
    click element    ${app_filter_name_display}
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_SIGNATURES_USE}
    click button    ${EDIT_APP_SENSOR_ADD_SIGNATURES_USE}
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_OK}
    click element    ${EDIT_APP_SENSOR_OK}
    sleep    10
    Wait Until Element Is Visible    ${app_filter_name_display}

# Drag the page to the bottom
Press Down Key
    [Arguments]    ${max}=10 
    :FOR    ${i}    IN RANGE    ${max}
    \    Exit For Loop If	${i} == 9	
    \    Press Key    tag=body    \\57365

Apply App Profile in Firewall Policy

    [Arguments]   ${app_sensor_name}
    [Documentation]    possible item of appctrl list name: testgui/default profile
    Go to policy and objects
    Go to IPv4 policy
    sleep    5
    Wait Until Element Is Visible    ${VIEW_LIST_PLUS_DETAIL_BUTTON}
    click button    ${VIEW_LIST_PLUS_DETAIL_BUTTON}
    Wait Until Element Is Visible     ${IPv4_POLICY_LIST_ENTRY}
    Wait Until Element Is Not Visible     ${IPv4_POLICY_LIST_APP_PROFILE}
    click element    ${IPv4_POLICY_LIST_ENTRY} 
    Wait Until Element Is Visible    ${IPv4_POLICY_EDIT}
    click element    ${IPv4_POLICY_EDIT}
    Wait Until Element Is Visible    ${IPv4_POLICY_EDIT_NAME}
    click element    ${IPv4_POLICY_EDIT_NAME}
    Press Down Key
    Wait Until Element Is Visible    ${IPv4_POLICY_APP_PROFILE_ENABLE}
    click element    ${IPv4_POLICY_APP_PROFILE_ENABLE} 
    Wait Until Element Is Visible     ${IPv4_POLICY_APP_PROFILE_ADD}
    click element     ${IPv4_POLICY_APP_PROFILE_ADD}
    Wait Until Element Is Visible     ${IPv4_POLICY_APP_PROFILE_ADD_NAME}
    click element   ${IPv4_POLICY_APP_PROFILE_ADD_NAME}
    Wait Until Element Is Visible     ${IPv4_POLICY_OK}
    click button    ${IPv4_POLICY_OK}
    Wait Until Element Is Visible     ${IPv4_POLICY_LIST_CREATE_NEW_BUTTON}
    Wait Until Element Is Visible     ${IPv4_POLICY_LIST_APP_PROFILE}
    Wait Until Element Is Visible     ${IPv4_POLICY_LIST_APP_PROFILE_INCLUDED}


Delete App Profile in Firewall Policy

    [Arguments]   ${app_sensor_name}
    [Documentation]    possible item of appctrl list name: testgui/default profile
    Go to policy and objects
    Go to IPv4 policy
    Wait Until Element Is Visible    ${IPv4_POLICY_LIST_CREATE_NEW_BUTTON}
    Wait Until Element Is Visible     ${IPv4_POLICY_LIST_APP_PROFILE_INCLUDED}
    click element    ${IPv4_POLICY_LIST_APP_PROFILE} 
    Wait Until Element Is Visible    ${IPv4_POLICY_EDIT}
    click element    ${IPv4_POLICY_EDIT}
    Wait Until Element Is Visible    ${IPv4_POLICY_APP_PROFILE_ENABLE}
    click element    ${IPv4_POLICY_APP_PROFILE_ENABLE} 
    Wait Until Element Is Not Visible     ${IPv4_POLICY_APP_PROFILE_ADD}
    Wait Until Element Is Visible     ${IPv4_POLICY_OK}
    click button    ${IPv4_POLICY_OK}
    
    Wait Until Element Is Visible     ${IPv4_POLICY_LIST_CREATE_NEW_BUTTON}
    Wait Until Element Is Not Visible     ${IPv4_POLICY_LIST_APP_PROFILE_INCLUDED}


Delete New App Sensor in List when in use in firewall policy

    Go to Security Profile
    Go to Application Control
    click button    ${APP_SENSOR_LIST_BUTTON}
    Wait Until Element Is Visible    embedded-iframe
    select frame    embedded-iframe
    Wait Until Element Is Visible    ${VIEW_LIST_11}
    click element    ${VIEW_LIST_11}
    Click button if unclickable    ${VIEW_LIST_DELETE_BUTTON}
    unselect frame
    Wait Until Element Is Not Visible    ${VIEW_LIST_DELETE_OK_BUTTON}

Click button if unclickable    
# create a keyword to see if button is clickable
    [Arguments]    ${button_locator}
    Wait Until Element Is Visible    ${button_locator}
    Wait Until Element Is Visible    ${button_locator}[@disabled="disabled"] 


Go to Custom Signatures
    Wait Until Element Is Visible    ${CUSTOM_SIGNATURES_ENTRY}
    click element    ${CUSTOM_SIGNATURES_ENTRY}
    Wait Until Element Is Visible    ${CUSTOM_SIGNATURES_CREATE_NEW_BUTTON}

Create New Custom Signatures
    [Arguments]   ${custom_signature_name}    ${custom_signature_signature}
    [Documentation]    create new custom signature with input name/signature

    Go to Security Profile
    Go to Custom Signatures
    click element    ${CUSTOM_SIGNATURES_CREATE_NEW_BUTTON}
    Wait Until Element Is Visible    ${CUSTOM_SIGNATURES_CREATE_NEW_BUTTON_APP}
    click element    ${CUSTOM_SIGNATURES_CREATE_NEW_BUTTON_APP}
    Wait Until Element Is Visible    ${CUSTOM_SIGNATURE_EDIT_NAME}
    input text    ${CUSTOM_SIGNATURE_EDIT_NAME}    ${custom_signature_name}
    input text    ${CUSTOM_SIGNATURE_EDIT_SIGNATURE}    ${custom_signature_signature}
    click element    ${CUSTOM_SIGNATURE_EDIT_OK_BUTTON}
    Wait Until Element Is Visible    ${CUSTOM_SIGNATURE_EDIT_VERIFY}

Delete New Custom Signatures
    Go to Security Profile
    Go to Custom Signatures
    Wait Until Element Is Visible    ${CUSTOM_SIGNATURE_EDIT_VERIFY}
    click element    ${CUSTOM_SIGNATURE_EDIT_VERIFY}
    Wait Until Element Is Visible    ${CUSTOM_SIGNATURES_DELETE_BUTTON}
    click element    ${CUSTOM_SIGNATURES_DELETE_BUTTON}
    Wait Until Element Is Visible    ${CUSTOM_SIGNATURES_DELETE_BUTTON_OK}
    click button    ${CUSTOM_SIGNATURES_DELETE_BUTTON_OK}
    sleep    10
    Wait Until Element Is Not Visible    ${CUSTOM_SIGNATURE_EDIT_VERIFY}


Create New App Sensor with Category and Overrides
    [Arguments]   ${app_sensor_name}
    [Documentation]    possible item of appctrl profile name: testgui; category:Gerneral interest/Block; Filter override: Technology/Browser-Based; APP override:1kxun

    Go to Security Profile
    Go to Application Control
    click button    ${APP_SENSOR_NEW_BUTTON}
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_SIGNATURES_BUTTON}
    input text    ${EDIT_APP_SENSOR_NAME}    ${app_sensor_name}
    
    #add category override
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_CATEGORY_GENERAL_INTEREST}
    click element    ${EDIT_APP_SENSOR_CATEGORY_GENERAL_INTEREST}
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_CATEGORY_GENERAL_INTEREST_BLOCK}
    sleep    3
    click element    ${EDIT_APP_SENSOR_CATEGORY_GENERAL_INTEREST_BLOCK}

    #add app override
    click element    ${EDIT_APP_SENSOR_ADD_SIGNATURES_BUTTON}
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_SIGNATURES_1}
    click element    ${EDIT_APP_SENSOR_ADD_SIGNATURES_1}
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_SIGNATURES_USE}
    click button    ${EDIT_APP_SENSOR_ADD_SIGNATURES_USE}
    
    #add filter override
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_FILTER_BUTTON}
    click element    ${EDIT_APP_SENSOR_ADD_FILTER_BUTTON}
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_FILTER_ADD_FILTER}
    click element    ${EDIT_APP_SENSOR_ADD_FILTER_ADD_FILTER}
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_FILTER_ADD_FILTER_TECHNOLOGY}
    click button    ${EDIT_APP_SENSOR_ADD_FILTER_ADD_FILTER_TECHNOLOGY}
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_FILTER_ADD_FILTER_TECHNOLOGY_BROWSER_BASED}
    click element    ${EDIT_APP_SENSOR_ADD_FILTER_ADD_FILTER_TECHNOLOGY_BROWSER_BASED}
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_FILTER_ADD_FILTER_USE}
    lib.ExtendedSeleniumLibrary.Mouse Down    ${EDIT_APP_SENSOR_ADD_FILTER_ADD_FILTER_USE}
    lib.ExtendedSeleniumLibrary.Mouse Up    ${EDIT_APP_SENSOR_ADD_FILTER_ADD_FILTER_USE}
    click element    ${EDIT_APP_SENSOR_ADD_FILTER_ADD_FILTER_USE}

    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_OK}
    click element    ${EDIT_APP_SENSOR_OK}
    sleep    10
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_CATEGORY_GENERAL_INTEREST}[@class="fa-denied"]
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_ENTRY_EXIST}
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_FILTER_ENTRY_EXIST}

