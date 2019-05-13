*** Settings ***
Documentation     This file contains FortiGate GUI Policy and Objects operation

*** Keywords ***
###Useful functions###
Wait and Select frame
    [Arguments]    ${frame}
    Wait Until Element Is Visible    ${frame}
    select frame    ${frame}

Right Click Element
    [Arguments]    ${element}
    Wait Until Element Is Visible    ${element}
    Open Context Menu    ${element}

###Intrusion Prevention###    
##Security Profile -> Intrusion Prevention##
Create New IPS Custom Signatures
    [Arguments]   ${custom_signature_name}    ${custom_signature_signature}
    [Documentation]    create new custom signature with input name/signature

    fgt_gui_securityprofile_app.Go to Security Profile
    Go to Custom Signatures
    click element    ${CUSTOM_SIGNATURES_CREATE_NEW_BUTTON}
    wait and click    ${CUSTOM_SIGNATURES_CREATE_NEW_BUTTON_IPS}
    Wait Until Element Is Visible    ${CUSTOM_SIGNATURE_EDIT_NAME}
    input text    ${CUSTOM_SIGNATURE_EDIT_NAME}    ${custom_signature_name}
    input text    ${CUSTOM_SIGNATURE_EDIT_SIGNATURE}    ${custom_signature_signature}
    click element    ${CUSTOM_SIGNATURE_EDIT_OK_BUTTON}
    Wait Until Element Is Visible    ${CUSTOM_SIGNATURE_EDIT_VERIFY}

Edit IPS Custom Signatures
    fgt_gui_securityprofile_app.Go to Security Profile
    Go to Custom Signatures
    Wait Until Element is Visible    ${CUSTOM_SIGNATURE_EDIT_VERIFY}
    double click element    ${CUSTOM_SIGNATURE_EDIT_VERIFY}    

Edit IPS Custom Signatures Signature 
    [Documentation]    Run after Edit IPS Custom Signatures
    [Arguments]    ${custom_signature_new_sig}
    Edit IPS Custom Signatures
    input text    ${CUSTOM_SIGNATURE_EDIT_SIGNATURE}    ${custom_signature_new_sig}
    click element    ${CUSTOM_SIGNATURE_EDIT_OK_BUTTON}
    Wait Until Element Is Visible    ${CUSTOM_SIGNATURE_EDIT_VERIFY}


Go to IPS profile
    [Arguments]    ${frame}=${IPS_FRAME}  
    fgt_gui_securityprofile_app.Go to Security Profile
    wait and click    ${IPS_ENTRY}
    wait and select frame    ${frame}
    Wait Until Element Is Visible    ${CREATE_IPS_SENSOR}

Create New IPS sensor
    [Arguments]    ${ips_sensor_name}    ${frame}=${IPS_FRAME}  
    [Documentation]    Goes to "New IPS Sensor" page and fills a name
    Go to IPS profile 
    wait and click    ${CREATE_IPS_SENSOR}
    Wait Until Element Is Visible    ${EDIT_IPS_SENSOR_NAME}
    input text    ${EDIT_IPS_SENSOR_NAME}    ${ips_sensor_name}

Delete IPS sensor
    [Arguments]    ${ips_sensor_name}    ${frame}=${IPS_FRAME}
    unselect frame
    Go to IPS profile  
    wait and click    xpath://td[contains(text(),"${ips_sensor_name}")]
    click element    ${DELETE_IPS_SENSOR}
    unselect frame
    wait and click    ${DELETE_IPS_SENSOR_CONFIRM}
    wait and select frame    ${frame}
    Wait Until Element is Not Visible    xpath://td[contains(text(),"${ips_sensor_name}")]
    unselect frame

Add IPS Signature
    [Arguments]    ${ips_signature_name}    ${frame}=${IPS_FRAME}
    [Documentation]    Ran on "New IPS Sensor" page. Adds signature based on name search
    click element    ${IPS_SENSOR_ADD_SIGNATURE}
    unselect frame
    Wait Until Element Is Visible    ${IPS_SENSOR_ADD_SIGNATURE_LOAD_CHECK}
    click element    ${IPS_SENSOR_ADD_SIGNATURE_ADD_FILTER}
    wait and click    ${IPS_SENSOR_ADD_SIGNATURE_FILTER_NAME}
    Wait Until Element Is Visible    ${IPS_SENSOR_ADD_SIGNATURE_FILTER_NAME_FIELD}
    input text    ${IPS_SENSOR_ADD_SIGNATURE_FILTER_NAME_FIELD}    ${ips_signature_name}
    Press Key    ${IPS_SENSOR_ADD_SIGNATURE_FILTER_NAME_FIELD}     \\13
    sleep    2
    wait and click    ${IPS_SENSOR_ADD_SIGNATURE_ENTRY}
    click element    ${IPS_SENSOR_USE_SELECTED_SIGNATURE}
    wait and select frame    ${frame}
    Wait Until Element Is Visible    xpath://span[contains(text(),"${ips_signature_name}")]
    click element    ${IPS_SENSOR_OK_BUTTON}
    unselect frame

Add IPS Filter
    [Arguments]    ${ips_filter_category}    ${ips_filter_subcategory}    ${frame}=${IPS_FRAME}    
    [Documentation]    Ran on "New/Edit IPS Sensor" page. Fills in sensor name and adds an IPS filter based on category and value
    ...                ${ips_filter_category}   Category of Filter (ex. Application, OS, Protocol, Severity)
    ...                ${ips_filter_value}      After selecting category to filter, select category value (ex. OS -> Linux)
    ...                Example:
    ...                Add IPS Filter    OS    Linux
    ...                Add IPS Filter    Application    Adobe
    click element   ${IPS_SENSOR_ADD_FILTER}
    unselect frame
    Wait Until Element Is Visible    ${IPS_SENSOR_ADD_FILTER_LOAD_CHECK}
    click element    ${IPS_SENSOR_ADD_FILTER_ADD_FILTER}

    ${locator_of_category}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${IPS_SENSOR_ADD_FILTER_PLACEHOLDER}    ${ips_filter_category}
    
    #Wait and click category
    wait and click    ${locator_of_category}

    #After clicking category type in subcategory
    Wait Until Element is Visible    ${IPS_SENSOR_ADD_FILTER_FILTER_FIELD}
    input text    ${IPS_SENSOR_ADD_FILTER_FILTER_FIELD}    ${ips_filter_subcategory}
    Press Key    ${IPS_SENSOR_ADD_FILTER_FILTER_FIELD}     \\13

    #Press Enter and click Use Filters to save
    wait and click    ${IPS_SENSOR_ADD_FILTER_USE_FILTERS}

    #Verify filter is added
    wait and select frame    ${frame}
    Wait Until Element Is Visible    xpath://td[@class="filter_details" and text() = "${ips_filter_category}: ${ips_filter_subcategory}"]

Mouse Over IPS Context Popup and Click 
    [Arguments]    ${ips_signature_popup}    ${button}
    Mouse Over    ${ips_signature_popup}
    wait and click    ${button}
    



    






