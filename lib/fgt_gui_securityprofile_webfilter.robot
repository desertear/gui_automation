*** Settings ***
Documentation     This file contains FortiGate GUI Policy and Objects operation

*** Keywords ***
###Data Leak Prevention###    
##Security Profile -> Data Leak Prevention##


Go to Webfilter profile
    wait and click    ${WEBFILTER_ENTRY}
    Wait Until Element Is Visible    ${WEBFILTER_NEW_BUTTON}

Go into a Webfilter profile
    [Arguments]   ${webfilter_profile_name}
    Go to Security Profiles
    Go to Webfilter profile
    Wait Until Element Is Visible    xpath://span[text()="${webfilter_profile_name}"]
    #Wait Until Element Is Visible    ${Webfilter_Profile_Name_Webfilter} 
    Double Click Element    xpath://span[text()="${webfilter_profile_name}"]
    #Click Element    ${EDIT_WEBFILTER_BUTTON}
    Wait Until Element Is Visible    ${webfilter_page}
    
Filter a Category
    [Arguments]   ${category_name}
    Mouse Over     ${Webfilter_Fortiguard_Table_Header_Name}
    wait and click    ${Webfilter_Fortiguard_Table_Header_Name_Filter}
    click element    ${regex_button_of_ftgd_filter}
    input text    ${Webfilter_Fortiguard_Name_Filter}    ^${category_name}$
    ${locator_of_category}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${Webfilter_Fortiguard_Category_name}    ${category_name}
    Wait Until Element Is Visible    ${locator_of_category}
    click element    ${Webfilter_Fortiguard_Name_Filter_Apply}
    ${if_it_is_expanded_or_not}=    run keyword and return status    Wait Until Page Contains Element    ${locator_of_category}
    run keyword if    "${if_it_is_expanded_or_not}"=="False"        click element    ${Webfilter_Fortiguard_Big_Category_expand_button}
    Wait Until Element Is Visible    ${locator_of_category}

Set Action As Warning
    [Arguments]   ${time}   
    click element    xpath://f-mutable-menu-transclude[@class="ng-scope ng-isolate-scope"]//span[@class="ng-binding ng-scope"][contains(text(),"Warning")] 
    @{split_time_value}=    Split String    ${time}    :    2
    Wait Until Element Is Visible    ${Webfilter_Fortiguard_warning_action_pop_out_page}
    input text    ${Webfilter_Fortiguard_warning_action_time_hours}    1
    #input text    ${Webfilter_Fortiguard_warning_action_time_hours}    @{split_time_value}[0]
    #input text    ${Webfilter_Fortiguard_warning_action_time_minutes}    @{split_time_value}[1]
    #input text    ${Webfilter_Fortiguard_warning_action_time_seconds}    @{split_time_value}[2]


Change the action
    [Arguments]   ${category_name}    ${action}    ${time}
    ${locator_of_category}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${Webfilter_Fortiguard_Category_name}    ${category_name}
    Open Context Menu    ${locator_of_category}
    ${locator_of_action}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${Webfilter_Fortiguard_action_button}    ${action}
    run keyword if    "${action}"=="Allow" or "${action}"=="Block" or "${action}"=="Monitor"        click element    ${locator_of_action}
    ...    ELSE IF    "${action}"=="Warning"      Set Action As Warning    ${time}











Change the action of fortiguard filter
    [Arguments]   ${action}    ${category}



# Create New DLP Profile
#     [Arguments]   ${dlp_sensor_name}
#     [Documentation]    possible item of appctrl profile name: testgui/default profile (add and then delete specific signature)

#     fgt_gui_securityprofile_dlp.Go to Security Profile
#     Go to DLP profile
#     Wait Until Element Is Visible    ${DLP_NEW_BUTTON}
#     click button    ${DLP_NEW_BUTTON}
#     Wait Until Element Is Visible    ${EDIT_DLP_SENSOR_NAME}
#     input text    ${EDIT_DLP_SENSOR_NAME}    ${dlp_sensor_name}

#     #add filter
#     click element    ${ADD_DLP_FILTER}
#     Wait Until Element Is Visible    ${FILTER_TYPE_FILE}
#     click element    ${FILTER_TYPE_FILE}
#     Wait Until Element is Visible    ${SELECT_FILETYPE}
#     click element    ${SELECT_FILETYPE}

#     #select filetype
#     Wait Until Element is Visible ${ADD_FILETYPE}
#     click element ${ADD_FILETYPE}
#     Wait Until Element Is Visible ${FILETYPE_SELECTION_PANE}
#     click element ${FILETYPE_BZIP}
    
#     #specify action
#     click element ${FILTER_ACTION}
#     Wait Until Element is Visible ${FILTER_ACTION_BLOCK}
#     click element ${FILTER_ACTION_BLOCK}

#     #save sensor
#     click element ${SAVE_FILTER}


# Create New App List
#     [Arguments]   ${app_sensor_name}
#     [Documentation]    possible item of appctrl list name: testgui/default profile

#     Go to Security Profile
#     Go to Application Control

#     #create default list
#     click button    ${APP_SENSOR_LIST_BUTTON}
#     Wait Until Element Is Visible    embedded-iframe
#     select frame    embedded-iframe
#     Wait Until Element Is Visible    ${VIEW_LIST_CREATE_NEW_BUTTON}
#     click element    ${VIEW_LIST_CREATE_NEW_BUTTON}
#     unselect frame
#     Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_SIGNATURES_BUTTON}
#     input text    ${EDIT_APP_SENSOR_NAME}    ${app_sensor_name}
#     Wait Until Element Is Visible    ${EDIT_APP_SENSOR_OK}
#     click element    ${EDIT_APP_SENSOR_OK}


# Delete New App Sensor in List

#     Go to Security Profile
#     Go to Application Control
#     click button    ${APP_SENSOR_LIST_BUTTON}
#     Wait Until Element Is Visible    embedded-iframe
#     select frame    embedded-iframe
#     Wait Until Element Is Visible    ${VIEW_LIST_11}
#     click element    ${VIEW_LIST_11}
#     Wait Until Element Is Visible    ${VIEW_LIST_DELETE_BUTTON}
#     click button    ${VIEW_LIST_DELETE_BUTTON}
#     unselect frame
#     Wait Until Element Is Visible    ${VIEW_LIST_DELETE_OK_BUTTON}
#     click button    ${VIEW_LIST_DELETE_OK_BUTTON}
#     Wait Until Element Is Not Visible    ${VIEW_LIST_11}

# Create New App Profile with Specific Signature

#     [Arguments]   ${app_sensor_name}    ${app_filter_name_input}    
#     ...    ${app_filter_name_input_verify}    ${app_filter_name_display}
#     [Documentation]    define specific app signature under application overrides in new app profile
#     ...    ${app_filter_name_input}-----filter by name:input
#     ...    ${app_filter_name_input_verify}-------dropdown menu after input name
#     ...    ${app_filter_name_display}----------available app entry display in list after filter

#     Go to Security Profile
#     Go to Application Control
#     click button    ${APP_SENSOR_NEW_BUTTON}
#     Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_SIGNATURES_BUTTON}
#     input text    ${EDIT_APP_SENSOR_NAME}    ${app_sensor_name}
#     click element    ${EDIT_APP_SENSOR_ADD_SIGNATURES_BUTTON}

#     #filter "XXXXX" by searching name and then click OK

#     Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_SIGNATURES_ADD_FILTER}
#     click element    ${EDIT_APP_SENSOR_ADD_SIGNATURES_ADD_FILTER}
#     Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_SIGNATURES_NAME}
#     click element    ${EDIT_APP_SENSOR_ADD_SIGNATURES_NAME}
#     Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_SIGNATURES_NAME_INPUT}
#     input text    ${EDIT_APP_SENSOR_ADD_SIGNATURES_NAME_INPUT}    ${app_filter_name_input}
#     #click button    ${app_filter_name_input_verify}
#     lib.ExtendedSeleniumLibrary.Mouse Down    ${app_filter_name_input_verify}
#     lib.ExtendedSeleniumLibrary.Mouse Up    ${app_filter_name_input_verify}
#     Wait Until Element Is Visible    ${app_filter_name_display}
#     lib.ExtendedSeleniumLibrary.Mouse Down    ${app_filter_name_display}
#     lib.ExtendedSeleniumLibrary.Mouse Up    ${app_filter_name_display}
#     sleep    3
#     click element    ${app_filter_name_display}
#     Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_SIGNATURES_USE}
#     click button    ${EDIT_APP_SENSOR_ADD_SIGNATURES_USE}
#     Wait Until Element Is Visible    ${EDIT_APP_SENSOR_OK}
#     click element    ${EDIT_APP_SENSOR_OK}
#     sleep    10
#     Wait Until Element Is Visible    ${app_filter_name_display}

# # Drag the page to the bottom
# Press Down Key
#     [Arguments]    ${max}=10 
#     :FOR    ${i}    IN RANGE    ${max}
#     \    Exit For Loop If	${i} == 9	
#     \    Press Key    tag=body    \\57365

# Apply App Profile in Firewall Policy

#     [Arguments]   ${app_sensor_name}
#     [Documentation]    possible item of appctrl list name: testgui/default profile
#     Go to policy and objects
#     Go to IPv4 policy
#     sleep    5
#     Wait Until Element Is Visible    ${VIEW_LIST_PLUS_DETAIL_BUTTON}
#     click button    ${VIEW_LIST_PLUS_DETAIL_BUTTON}
#     Wait Until Element Is Visible     ${IPv4_POLICY_LIST_ENTRY}
#     Wait Until Element Is Not Visible     ${IPv4_POLICY_LIST_APP_PROFILE}
#     click element    ${IPv4_POLICY_LIST_ENTRY} 
#     Wait Until Element Is Visible    ${IPv4_POLICY_EDIT}
#     click element    ${IPv4_POLICY_EDIT}
#     Wait Until Element Is Visible    ${IPv4_POLICY_EDIT_NAME}
#     click element    ${IPv4_POLICY_EDIT_NAME}
#     Press Down Key
#     Wait Until Element Is Visible    ${IPv4_POLICY_APP_PROFILE_ENABLE}
#     click element    ${IPv4_POLICY_APP_PROFILE_ENABLE} 
#     Wait Until Element Is Visible     ${IPv4_POLICY_APP_PROFILE_ADD}
#     click element     ${IPv4_POLICY_APP_PROFILE_ADD}
#     Wait Until Element Is Visible     ${IPv4_POLICY_APP_PROFILE_ADD_NAME}
#     click element   ${IPv4_POLICY_APP_PROFILE_ADD_NAME}
#     Wait Until Element Is Visible     ${IPv4_POLICY_OK}
#     click button    ${IPv4_POLICY_OK}
#     Wait Until Element Is Visible     ${IPv4_POLICY_LIST_CREATE_NEW_BUTTON}
#     Wait Until Element Is Visible     ${IPv4_POLICY_LIST_APP_PROFILE}
#     Wait Until Element Is Visible     ${IPv4_POLICY_LIST_APP_PROFILE_INCLUDED}


# Delete App Profile in Firewall Policy

#     [Arguments]   ${app_sensor_name}
#     [Documentation]    possible item of appctrl list name: testgui/default profile
#     Go to policy and objects
#     Go to IPv4 policy
#     Wait Until Element Is Visible    ${IPv4_POLICY_LIST_CREATE_NEW_BUTTON}
#     Wait Until Element Is Visible     ${IPv4_POLICY_LIST_APP_PROFILE_INCLUDED}
#     click element    ${IPv4_POLICY_LIST_APP_PROFILE} 
#     Wait Until Element Is Visible    ${IPv4_POLICY_EDIT}
#     click element    ${IPv4_POLICY_EDIT}
#     Wait Until Element Is Visible    ${IPv4_POLICY_APP_PROFILE_ENABLE}
#     click element    ${IPv4_POLICY_APP_PROFILE_ENABLE} 
#     Wait Until Element Is Not Visible     ${IPv4_POLICY_APP_PROFILE_ADD}
#     Wait Until Element Is Visible     ${IPv4_POLICY_OK}
#     click button    ${IPv4_POLICY_OK}
    
#     Wait Until Element Is Visible     ${IPv4_POLICY_LIST_CREATE_NEW_BUTTON}
#     Wait Until Element Is Not Visible     ${IPv4_POLICY_LIST_APP_PROFILE_INCLUDED}


# Delete New App Sensor in List when in use in firewall policy

#     Go to Security Profile
#     Go to Application Control
#     click button    ${APP_SENSOR_LIST_BUTTON}
#     Wait Until Element Is Visible    embedded-iframe
#     select frame    embedded-iframe
#     Wait Until Element Is Visible    ${VIEW_LIST_11}
#     click element    ${VIEW_LIST_11}
#     Click button if unclickable    ${VIEW_LIST_DELETE_BUTTON}
#     unselect frame
#     Wait Until Element Is Not Visible    ${VIEW_LIST_DELETE_OK_BUTTON}

#Click button if unclickable    
# create a keyword to see if button is clickable
#    [Arguments]    ${button_locator}
#    Wait Until Element Is Visible    ${button_locator}
#    Wait Until Element Is Visible    ${button_locator}[@disabled="disabled"] 


#Go to Custom Signatures
#    Wait Until Element Is Visible    ${CUSTOM_SIGNATURES_ENTRY}
#    click element    ${CUSTOM_SIGNATURES_ENTRY}
#    Wait Until Element Is Visible    ${CUSTOM_SIGNATURES_CREATE_NEW_BUTTON}

#Create New Custom Signatures
#    [Arguments]   ${custom_signature_name}    ${custom_signature_signature}
#    [Documentation]    create new custom signature with input name/signature
#
#    Go to Security Profile
#    Go to Custom Signatures
#    click element    ${CUSTOM_SIGNATURES_CREATE_NEW_BUTTON}
#    Wait Until Element Is Visible    ${CUSTOM_SIGNATURES_CREATE_NEW_BUTTON_APP}
#    click element    ${CUSTOM_SIGNATURES_CREATE_NEW_BUTTON_APP}
#    Wait Until Element Is Visible    ${CUSTOM_SIGNATURE_EDIT_NAME}
#    input text    ${CUSTOM_SIGNATURE_EDIT_NAME}    ${custom_signature_name}
#    input text    ${CUSTOM_SIGNATURE_EDIT_SIGNATURE}    ${custom_signature_signature}
#    click element    ${CUSTOM_SIGNATURE_EDIT_OK_BUTTON}
#    Wait Until Element Is Visible    ${CUSTOM_SIGNATURE_EDIT_VERIFY}

#Delete New Custom Signatures
#    Go to Security Profile
#    Go to Custom Signatures
#    Wait Until Element Is Visible    ${CUSTOM_SIGNATURE_EDIT_VERIFY}
#    click element    ${CUSTOM_SIGNATURE_EDIT_VERIFY}
#    Wait Until Element Is Visible    ${CUSTOM_SIGNATURES_DELETE_BUTTON}
#    click element    ${CUSTOM_SIGNATURES_DELETE_BUTTON}
#    Wait Until Element Is Visible    ${CUSTOM_SIGNATURES_DELETE_BUTTON_OK}
#    click button    ${CUSTOM_SIGNATURES_DELETE_BUTTON_OK}
#    sleep    10
#    Wait Until Element Is Not Visible    ${CUSTOM_SIGNATURE_EDIT_VERIFY}


# Create New App Sensor with Category and Overrides
#     [Arguments]   ${app_sensor_name}
#     [Documentation]    possible item of appctrl profile name: testgui; category:Gerneral interest/Block; Filter override: Technology/Browser-Based; APP override:1kxun

#     Go to Security Profile
#     Go to Application Control
#     click button    ${APP_SENSOR_NEW_BUTTON}
#     Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_SIGNATURES_BUTTON}
#     input text    ${EDIT_APP_SENSOR_NAME}    ${app_sensor_name}
    
#     #add category override
#     Wait Until Element Is Visible    ${EDIT_APP_SENSOR_CATEGORY_GENERAL_INTEREST}
#     click element    ${EDIT_APP_SENSOR_CATEGORY_GENERAL_INTEREST}
#     Wait Until Element Is Visible    ${EDIT_APP_SENSOR_CATEGORY_GENERAL_INTEREST_BLOCK}
#     sleep    3
#     click element    ${EDIT_APP_SENSOR_CATEGORY_GENERAL_INTEREST_BLOCK}

#     #add app override
#     click element    ${EDIT_APP_SENSOR_ADD_SIGNATURES_BUTTON}
#     Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_SIGNATURES_1}
#     click element    ${EDIT_APP_SENSOR_ADD_SIGNATURES_1}
#     Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_SIGNATURES_USE}
#     click button    ${EDIT_APP_SENSOR_ADD_SIGNATURES_USE}
    
#     #add filter override
#     Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_FILTER_BUTTON}
#     click element    ${EDIT_APP_SENSOR_ADD_FILTER_BUTTON}
#     Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_FILTER_ADD_FILTER}
#     click element    ${EDIT_APP_SENSOR_ADD_FILTER_ADD_FILTER}
#     Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_FILTER_ADD_FILTER_TECHNOLOGY}
#     click button    ${EDIT_APP_SENSOR_ADD_FILTER_ADD_FILTER_TECHNOLOGY}
#     Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_FILTER_ADD_FILTER_TECHNOLOGY_BROWSER_BASED}
#     click element    ${EDIT_APP_SENSOR_ADD_FILTER_ADD_FILTER_TECHNOLOGY_BROWSER_BASED}
#     Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_FILTER_ADD_FILTER_USE}
#     lib.ExtendedSeleniumLibrary.Mouse Down    ${EDIT_APP_SENSOR_ADD_FILTER_ADD_FILTER_USE}
#     lib.ExtendedSeleniumLibrary.Mouse Up    ${EDIT_APP_SENSOR_ADD_FILTER_ADD_FILTER_USE}
#     click element    ${EDIT_APP_SENSOR_ADD_FILTER_ADD_FILTER_USE}

#     Wait Until Element Is Visible    ${EDIT_APP_SENSOR_OK}
#     click element    ${EDIT_APP_SENSOR_OK}
#     sleep    10
#     Wait Until Element Is Visible    ${EDIT_APP_SENSOR_CATEGORY_GENERAL_INTEREST}[@class="fa-denied"]
#     Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_ENTRY_EXIST}
#     Wait Until Element Is Visible    ${EDIT_APP_SENSOR_FILTER_ENTRY_EXIST}

