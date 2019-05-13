*** Settings ***
Documentation     This file contains FortiGate GUI Policy operation

*** Keywords ***
Click Policy Object REF
    [Arguments]   ${test_object}    ${type}
    ${ref_type} =    Run Keyword If    "${type}" == "Address"    Set Variable    ${POLICY_ADDRESS_REF}
    ...    ELSE IF    "${type}" == "Wildcard_FQDN"    Set Variable    ${POLICY_ADDRESS_REF}
    ...    ELSE IF    "${type}" == "Service"    Set Variable    ${POLICY_ADDRESS_REF}
    ...    ELSE IF    "${type}" == "Schedule"    Set Variable    ${POLICY_SCHDULE_REF}
    ...    ELSE IF    "${type}" == "VIP"    Set Variable    ${POLICY_ADDRESS_REF}
    ...    ELSE IF    "${type}" == "IP_Pool"    Set Variable    ${POLICY_IP_POOL_REF}
    ...    ELSE    Fail    wrong type
    ${ref_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${ref_type}    ${test_object}
    Press Down Key Until an Element is Visible    ${ref_locator}
    Wait Until Element Is Visible    ${ref_locator}
    Click Link    ${ref_locator}
    Run Keyword If    "${type}" == "Schedule"    Unselect Frame
    Run Keyword If    "${type}" == "IP_Pool"    Unselect Frame
    Wait Until Element Is Visible    ${POLICY_V4V6_SLIDER_AREA}

Click Policy Object REF and Verify Display
    [Arguments]   ${test_object}    ${ref_title_prefix}    ${ref_result}    ${type}
    [Documentation]    ${type} could be "Address", "Wildcard_FQDN", "Service", "Schedule", "VIP", and "IP_Pool"
    Click Policy Object REF    ${test_object}    ${type}    
    #check ref title and entries
    ${ref_title}=    Get Text    ${POLICY_OBJECTS_REF_H1}
    Should Be Equal    ${ref_title}    ${ref_title_prefix} ${test_object}
    ${index}=    Set Variable    0
    :FOR    ${item}    IN    @{ref_result}
    \    ${index}=    Evaluate    ${index} + 1
    \    ${locator_with_index}=    Add Index to XPATH    ${POLICY_OBJECTS_REF_ENTRIES}    ${index}
    \    Wait Until Element Is Visible    ${locator_with_index}
    \    ${return}=   Get Text    ${locator_with_index}
    \    ${return_text}=    Remove Extra Character in Text    ${return}
    \    Should Be True    "${return_text}"=="${item}" 
    Click Button    ${POLICY_OBJECTS_REF_CLOSE}
    Wait Until Page Does Not Contain Element    ${POLICY_V4V6_SLIDER_AREA}  

click policy filter button
    [Arguments]    ${column_name}
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${POLICY_TABLE_FILTER_BUTTON}    ${column_name}
    wait and click   ${new_locator}
    Wait Until Element Is Visible   ${POLICY_TABLE_FILTER_SPAN}

click policy sort button
    [Arguments]    ${column_name}
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${POLICY_COLUMN_SORT_SPAN}    ${column_name}
    wait and click   ${new_locator}
    
##Policy & Objects ->Addresses##
Go to Addresses
    Wait Until Element Is Visible    ${MENU_POLICY_ADDRESS}
    click element    ${MENU_POLICY_ADDRESS}
    Wait Until Element Is Visible    ${POLICY_ADDRESSES_ADDRESS_TOGGLE_BUTTON}

create new addresses
    [Arguments]        ${category}    ${address_name}    ${type}    ${address_value}    ${interface}    ${address_value_mac_end}=00:00:00:00:00:00
    ###${type}->subnet
    ${input_label}=   Set Variable If    "${type}"=="Subnet"    IP/Netmask    ${type}
    ${input_label}=   Set Variable If    "${type}"=="Geography"    Country/Region    ${input_label}
    ${input_label}=   Set Variable If    "${type}"=="Fabric Connector Address"    SDN Connector    ${input_label}
    Go to policy and objects
    Go to Addresses
    ${status}=    if address exists    ${address_name}
    run keyword if    "${status}"=="True"     delete address    ${address_name}
    Wait Until Element Is Visible    ${GENERAL_LIST_CREATE_NEW_BUTTON}
    click button    ${GENERAL_LIST_CREATE_NEW_BUTTON}
    Wait Until Element Is Visible    ${POLICY_ADDRESSES_ADDRESS_BUTTON}
    click button    ${POLICY_ADDRESSES_ADDRESS_BUTTON}
    Wait Until Element Is Visible    ${POLICY_ADDRESSES_ADDRESS_H1}
    #if IPv6 is enabled, need to choose Category first.
    ${if_catergory_enabled}=    run keyword and return status    Wait Until Page Contains Element    ${POLICY_ADDRESSES_CATEGORY_ADDRESS}
    run keyword if    "${if_catergory_enabled}"=="True"    click element    ${POLICY_ADDRESSES_CATEGORY_ADDRESS}
    input text    ${POLICY_ADDRESSES_NAME_TEXT}    ${address_name}
    Select From List By Label    ${POLICY_ADDRESSES_TYPE_SELECT}    ${type}
    ${input}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${POLICY_ADDRESSES_INPUT_TEXT}    ${input_label}
    input text        ${input}    ${address_value}
    Run Keyword If   "${type}"=="MAC Address Range"    input text    ${POLICY_ADDRESSES_INPUT_TEXT_MAC_END}    ${address_value_mac_end}
    click element    ${POLICY_ADDRESSES_INTERFACE_DIV}
    ${interface_input}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${POLICY_ADDRESSES_INTERFACE_INPUT}    ${interface}
    click element    ${interface_input}
    click button     ${POLICY_ADDRESSES_OK_BUTTON}
    unselect frame
    ##verify if the address is created successfully
    Wait Until Element Is Visible    ${GENERAL_LIST_CREATE_NEW_BUTTON}
    Open Section Label on Address List    Address
    ${address_in_table}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_ADDRESSES_IN_TABLE}    ${address_name}
    Wait Until Page Contains Element    ${address_in_table}
    [teardown]    unselect frame

if address exists
    [Arguments]    ${address_name}   ${address_type}=Address
    Wait Until page contains Element    ${GENERAL_LIST_CREATE_NEW_BUTTON}
    Wait Until Element Is Visible    ${GENERAL_LIST_CREATE_NEW_BUTTON}
    Open Section Label on Address List    ${address_type}
    ${address_in_table}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_ADDRESSES_IN_TABLE}    ${address_name}
    ${status}=    run keyword and return status    Wait Until Element Is Visible    ${address_in_table}
    [return]    ${status}    

delete address
    [Arguments]    ${address_name}
    ${address_in_table}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_ADDRESSES_IN_TABLE}    ${address_name}
    click element    ${address_in_table}
    click button    ${POLICY_ADDRESSES_PORTAL_DELETE_BUTTON}
    Wait Until Element Is Visible    ${POLICY_ADDRESSES_DELETE_CONFIRM_HEAD}
    Wait Until Element Is Visible    ${POLICY_ADDRESSES_DELETE_CONFIRM_OK_BUTTON}
    Wait Until Element Is Visible    ${POLICY_ADDRESSES_DELETE_CONFIRM_OK_BUTTON}
    click button    ${POLICY_ADDRESSES_DELETE_CONFIRM_OK_BUTTON}
    #verify if the address is deleted successfully
    Wait Until Element Is Visible    ${POLICY_ADDRESSES_ADDRESS_TOGGLE_BUTTON}
    wait until page does not contain element    ${address_in_table}

Open Section Label on Address List
    [Arguments]    ${address_type}
    [Documentation]    ${address_type} can be "Address", "Address Group", "IPv6 Address", "IPv6 Address Group", "IPv6 Address Template" and "Multicast Address"
    ${toggle_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_ADDRESSES_TOGGLE_BUTTON}    ${address_type}
    Click Toggle if Closed    ${toggle_locator}

Close Section Label on Address List
    [Arguments]    ${address_type}
    [Documentation]    ${address_type} can be "Address", "Address Group", "IPv6 Address", "IPv6 Address Group", "IPv6 Address Template" and "Multicast Address"
    ${toggle_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_ADDRESSES_TOGGLE_BUTTON}    ${address_type}
    Click Toggle if Opened    ${toggle_locator}    

Get Address Config by Column Name and Address Name     
    [Arguments]   ${column_list}    ${address_type}    ${address_name}         
    [Documentation]    This keyword return the displayed text in request columns 
    ...    ${column_list}: a list of column names;    ${address_name}: the address name  
    ...    ${config_list}: a list of text displayed in the requested columns
    Open Section Label on Address List    ${address_type}
    ${config_list}=    Get Config by Column Name and Key    ${column_list}    ${address_name}    ${D_ADDRESS_DISPLAY_NAME_TO_COLUMN_ID}    ${VAR_ADDRESS_COLUMN_GENERAL_SETTING}            
    [return]    ${config_list}


Click Create New on Addresses List
    [Arguments]    ${option}=Address
    [Documentation]    ${option} can be "Address", "Address Group", and "IPv6 Address Template"
    Wait Until Element Is Visible    ${GENERAL_LIST_CREATE_NEW_BUTTON}
    Click Button    ${GENERAL_LIST_CREATE_NEW_BUTTON}
    ${sub_menu}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_ADDRESSES_CREATE_BUTTON_SUB_MENU}    ${option}
    Wait Until Element Is Visible    ${sub_menu}
    Click Button    ${sub_menu}
    #"Address Editor" is not in POLICY_OBJECT_FRAME but the other two are.
    Run Keyword If	"${option}"!="Address"    Wait Until Element Is Visible    ${POLICY_OBJECT_FRAME}
    Run Keyword If	"${option}"!="Address"    Select Frame    ${POLICY_OBJECT_FRAME}
    Run Keyword If	"${option}"=="Address"    Wait Until Element Is Visible    ${POLICY_ADDRESSES_ADDRESS_H1}		
    ...    ELSE IF  "${option}"=="Address Group"    Wait Until Element Is Visible    ${POLICY_ADDRESSES_ADDRESS_GROUP_H1}
    ...    ELSE IF  "${option}"=="IPv6 Address Template"    Wait Until Element Is Visible    ${POLICY_ADDRESSES_IPV6_TEMPLATE_H1}

Click Address By Name on Address List
    [Arguments]   ${type}    ${name}
    Open Section Label on Address List    ${type}
    ${address_in_table}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_ADDRESSES_NAME_COLUMN}    ${name}
    Press Down Key Until an Element is Visible    ${address_in_table}
    Click Element    ${address_in_table}
    Wait Until Element Is Visible    xpath://div[contains(@class,"selected")]//div[@column-id="name"]

Click Edit Button on Address List
    [Arguments]   ${type}=Address
    Wait Until Element Is Visible    ${POLICY_V4V6_EDIT_BUTTON_E}
    Click Button    ${POLICY_V4V6_EDIT_BUTTON_E}
    #"Address Editor" is not in POLICY_OBJECT_FRAME but the other two are.
    Run Keyword If	"${type}"!="Address" and "${type}"!="IPv6 Address"    Select Frame    ${POLICY_OBJECT_FRAME}
    ${result}    ${message}=    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${POLICY_ADDRESSES_ADDRESS_H1_EDIT}
    Run Keyword If    '${result}' == 'FAIL'	    Wait Until Element Is Visible    ${POLICY_ADDRESSES_ADDRESS_GROUP_H1_EDIT}

Edit Address By Name on Address List
    [Arguments]   ${type}    ${name}
    Click Address By Name on Address List    ${type}    ${name}
    Click Edit Button on Address List    ${type}

Right Click Address on Address List
    [Arguments]   ${address_name}
    ${address_in_table}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_ADDRESSES_NAME_COLUMN}    ${address_name}
    Wait Until Element Is Visible    ${address_in_table} 
    Open Context Menu    ${address_in_table}
    Wait Until Element Is Visible    ${POLICY_CONTEXT_MENU_BUTTON_EDIT_IN_CLI}    

Select Verfion on Address Editor
    [Arguments]   ${version}
    [Documentation]    ${version} can be "v4" and "v6"
    Run Keyword If	"${version}"=="v4"    Wait Until Element Is Visible    ${POLICY_ADDRESSES_ADDRESS_IPV4_LABEL}		
    ...    ELSE IF  "${version}"=="v6"    Wait Until Element Is Visible    ${POLICY_ADDRESSES_ADDRESS_IPV6_LABEL}
    Run Keyword If	"${version}"=="v4"    Click Element    ${POLICY_ADDRESSES_ADDRESS_IPV4_LABEL}		
    ...    ELSE IF  "${version}"=="v6"    Click Element    ${POLICY_ADDRESSES_ADDRESS_IPV6_LABEL}
    Run Keyword If	"${version}"=="v4"    Element Attribute Value Should Be    ${POLICY_ADDRESSES_ADDRESS_IPV4}    checked    true
    ...    ELSE IF  "${version}"=="v6"    Element Attribute Value Should Be    ${POLICY_ADDRESSES_ADDRESS_IPV6}    checked    true 

Select Verfion on Address Group Editor
    [Arguments]   ${version}
    [Documentation]    ${version} can be "v4" and "v6"
    Run Keyword If	"${version}"=="v4"    Wait Until Element Is Visible    ${POLICY_ADDRESSES_ADDRESS_GROUP_IPV4_LABEL}		
    ...    ELSE IF  "${version}"=="v6"    Wait Until Element Is Visible    ${POLICY_ADDRESSES_ADDRESS_GROUP_IPV6_LABEL}
    Run Keyword If	"${version}"=="v4"    Click Element    ${POLICY_ADDRESSES_ADDRESS_GROUP_IPV4_LABEL}		
    ...    ELSE IF  "${version}"=="v6"    Click Element    ${POLICY_ADDRESSES_ADDRESS_GROUP_IPV6_LABEL}
    Run Keyword If	"${version}"=="v4"    Element Attribute Value Should Be    ${POLICY_ADDRESSES_ADDRESS_GROUP_IPV4}    checked    true
    ...    ELSE IF  "${version}"=="v6"    Element Attribute Value Should Be    ${POLICY_ADDRESSES_ADDRESS_GROUP_IPV6}    checked    true   

Click Cancel Button on Address Editor
    Click Button    ${GENERAL_EDITOR_CANCEL_BUTTON}
    Unselect Frame
    Wait Until Element Is Visible    ${POLICY_ADDRESSES_ADDRESS_TOGGLE_BUTTON}  

Click Ok Button on Address Editor
    Click Button    ${GENERAL_EDITOR_OK_BUTTON}
    Unselect Frame
    Wait Until Element Is Visible    ${POLICY_ADDRESSES_ADDRESS_TOGGLE_BUTTON}      

##Policy & Objects ->Services##
Go to Services
    Wait Until Element Is Visible    ${MENU_POLICY_SERVICE}
    click element    ${MENU_POLICY_SERVICE}
    Wait Until Element Is Visible    ${POLICY_SERVICE_TABLE_SHOW}

Open Section Label on Service List
    [Arguments]   ${service_type}
    [Documentation]    ${service_type} can be "General", "Web Access", "File Access", etc
    ${toggle_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_SERVICE_TOGGLE_BUTTON}    ${service_type}
    Click Toggle if Closed    ${toggle_locator}

Close Section Label on Service List
    [Arguments]   ${service_type}
    [Documentation]    ${service_type} can be "General", "Web Access", "File Access", etc
    ${toggle_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_SERVICE_TOGGLE_BUTTON}    ${service_type}
    Click Toggle if Opened    ${toggle_locator}    

Right Click Service on Service List
    [Arguments]   ${name}
    ${service_in_table}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_SERVICE_NAME_COLUMN}    ${name}
    Wait Until Element Is Visible    ${service_in_table} 
    Open Context Menu    ${service_in_table}
    Wait Until Element Is Visible    ${POLICY_CONTEXT_MENU_BUTTON_EDIT_IN_CLI}   

Click Create New on Services List
    [Arguments]    ${option}=Service
    [Documentation]    ${option} can be "Service", "Service Group", and "Category"
    Wait Until Element Is Visible    ${GENERAL_LIST_CREATE_NEW_BUTTON}
    Click Button    ${GENERAL_LIST_CREATE_NEW_BUTTON}
    ${sub_menu}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_SERVICE_CREATE_BUTTON_SUB_MENU}    ${option}
    Wait Until Element Is Visible    ${sub_menu}
    Click Element    ${sub_menu}
    Wait Until Element Is Visible    ${POLICY_OBJECT_FRAME}
    Select Frame    ${POLICY_OBJECT_FRAME}
    Run Keyword If	"${option}"=="Service"    Wait Until Element Is Visible    ${POLICY_SERVICE_SERVICE_H1}		
    ...    ELSE IF  "${option}"=="Service Group"    Wait Until Element Is Visible    ${POLICY_SERVICE_SERVICE_GROUP_H1}
    ...    ELSE IF  "${option}"=="Category"    Wait Until Element Is Visible    ${POLICY_SERVICE_CATEGORY_H1}  

Click Cancel Button on Service Editor          
    Click Button    ${GENERAL_EDITOR_CANCEL_BUTTON}
    Wait Until Element Is Visible    ${POLICY_SERVICE_TABLE_SHOW}


##Policy & Objects ->Schedules##
Go to Schedules
    Wait Until Element Is Visible    ${MENU_POLICY_SCHEDULE}
    click element    ${MENU_POLICY_SCHEDULE}
    Select Frame    ${POLICY_OBJECT_FRAME}
    Wait Until Element Is Visible    ${POLICY_SCHEDULE_TABLE_MEMBER}  
    Unselect Frame

Right Click Schedule on Schedule List
    [Arguments]   ${name}
    Select Frame    ${POLICY_OBJECT_FRAME}
    ${schedule_in_table}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_SCHEDULE_NAME_COLUMN}    ${name}
    Wait Until Element Is Visible    ${schedule_in_table} 
    Open Context Menu    ${schedule_in_table}
    Wait Until Element Is Visible    ${POLICY_CONTEXT_MENU_BUTTON_EDIT_IN_CLI} 
    Unselect Frame   

##Policy & Objects ->Virtual IP##
Go to Virtual IP
    Wait Until Element Is Visible    ${MENU_POLICY_VIRTUAL_IP}
    click element    ${MENU_POLICY_VIRTUAL_IP}
    Wait Until Element Is Visible    ${POLICY_VIRTUAL_IP_TABLE_INTF}

Open Section Label on VIP List
    [Arguments]   ${vip_type}
    [Documentation]    ${vip_type} can be "NAT46 Virtual IP", "Virtual IP", etc
    Open Section Label on Service List    ${vip_type}    

Wait Until VIP Group Header Is Visible
    Wait Until Element Is Visible    ${POLICY_OBJECT_FRAME}
    Select Frame    ${POLICY_OBJECT_FRAME}
    Wait Until Element Is Visible    ${POLICY_VIRTUAL_IP_VIP_GROUP_H1}

Click Create New on Virtual IP List
    [Arguments]    ${option}=Virtual IP
    [Documentation]    ${option} can be "Virtual IP","Virtual IP Group"
    Wait Until Element Is Visible    ${GENERAL_LIST_CREATE_NEW_BUTTON}
    Click Button    ${GENERAL_LIST_CREATE_NEW_BUTTON}
    ${sub_menu}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_VIRTUAL_IP_CREATE_BUTTON_SUB_MENU}    ${option}
    Wait Until Element Is Visible    ${sub_menu}
    Click Button    ${sub_menu}
    Run Keyword If	"${option}"=="Virtual IP"    Wait Until Element Is Visible    ${POLICY_VIRTUAL_IP_VIP_H1}		
    ...    ELSE IF  "${option}"=="Virtual IP Group"    Wait Until VIP Group Header Is Visible

###############################
Click VIP By Name on VIP List
    [Arguments]   ${type}    ${name}
    Open Section Label on VIP List    ${type}
    ${address_in_table}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_VIP_NAME_COLUMN}    ${name}
    Press Down Key Until an Element is Visible    ${address_in_table}
    Click Element    ${address_in_table}
    Wait Until Element Is Visible    xpath://div[contains(@class,"selected")]//div[@column-id="name"]

Click Edit Button on VIP List
    [Arguments]   ${type}=Virtual IP
    Wait Until Element Is Visible   ${POLICY_V4V6_EDIT_BUTTON}
    Click Button     ${POLICY_V4V6_EDIT_BUTTON}
    Select Frame    ${POLICY_OBJECT_FRAME}
    ${result}    ${message}=    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${POLICY_VIRTUAL_IP_VIP_H1_EDIT}
    Run Keyword If    '${result}' == 'FAIL'	    Wait Until Element Is Visible    ${POLICY_VIRTUAL_IP_VIP_GROUP_H1_EDIT}

Edit VIP By Name on VIP List
    [Arguments]   ${type}    ${name}
    Click VIP By Name on VIP List    ${type}    ${name}
    Click Edit Button on VIP List    ${type}

check vip type info shown on VIP page
    [Arguments]    ${type}
    Wait Until Element Is Visible   ${POLICY_VIRTUAL_IP_VIP_TYPE}
    ${type_value}=    GET TEXT    ${POLICY_VIRTUAL_IP_VIP_TYPE}
    Should contain    "${type_value}"    ${type}

check ipmap info shown on VIP page
    [Arguments]    ${ip_ver}    ${name}    ${position}   ${expect}
    @{ipmap_list}=    Create List    ${name}    ${position}
    ${new_locator}=    REPLACE PLACEHOLDERS IN LOCATOR WITH VALUE    ${POLICY_VIRTUAL_IP_VIP_MAPIPV${ip_ver}}    ${ipmap_list}
    ${value}=    Get Element Attribute    ${new_locator}    value
    should be equal    ${value}    ${expect}

check portmap info shown on VIP page
    [Arguments]    ${name}    ${position}   ${expect}
    @{portmap_list}=    Create List    ${name}    ${position}
    ${new_locator}=    REPLACE PLACEHOLDERS IN LOCATOR WITH VALUE    ${POLICY_VIRTUAL_IP_VIP_MAPPORT}    ${portmap_list}
    ${value}=    Get Element Attribute    ${new_locator}    value
    should be equal    ${value}    ${expect}

check filter src addr info shown on VIP page
    [Arguments]    ${position}    ${expect}
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${POLICY_VIRTUAL_IP_VIP_FILTER_SRC}    ${position}
    ${value}=    Get Element Attribute    ${new_locator}    value
    should be equal    ${value}    ${expect}

check fqdn exip info shown on VIP page
    [Arguments]    ${expect}
    ${value}=    Get Element Attribute    ${POLICY_VIRTUAL_IP_VIP_FQDN_EXIP}    value
    should be equal    ${value}    ${expect}

check fqdn mapped addr info shown on VIP page
    [Arguments]    ${expect}
    ${value}=    Get Text    ${POLICY_VIRTUAL_IP_VIP_FQDN_MAP_ADDR}
    should be equal    ${value}    ${expect}

###############################

Click Cancel Button on Virtual IP Editor
    Click Button    ${GENERAL_EDITOR_CANCEL_BUTTON}
    #Unselect Frame
    Wait Until Element Is Visible    ${POLICY_VIRTUAL_IP_TABLE_INTF}  

##Policy & Objects ->IP Pools##
Go to IP Pool
    Wait Until Element Is Visible    ${MENU_POLICY_IP_POOL}
    click element    ${MENU_POLICY_IP_POOL}
    Select Frame    ${POLICY_OBJECT_FRAME}
    Wait Until Element Is Visible    ${POLICY_IP_POOL_TABLE_IP_RANGE}  
    Unselect Frame

Click Create New on IP Pool List
    Wait Until Element Is Visible    ${GENERAL_LIST_CREATE_NEW_BUTTON}
    Click Button    ${GENERAL_LIST_CREATE_NEW_BUTTON}
    Wait Until Element Is Visible    ${POLICY_OBJECT_FRAME}
    Wait Until Element Is Visible    ${POLICY_IP_POOL_H1}



##Policy & Objects ->Wildcard FQDN Addresses##
Go to Wildcard FQDN Address
    Wait Until Element Is Visible    ${MENU_POLICY_FQDN_ADDRESS}
    click element    ${MENU_POLICY_FQDN_ADDRESS}
    Wait Until Element Is Visible    ${POLICY_FQDN_ADDRESS_TOGGLE_BUTTON} 

Open Section Label on Wildcard FQDN Address List
    [Arguments]    ${address_type}
    [Documentation]    ${address_type} can be "Wildcard FQDN", "Wildcard FQDN Group"
    ${toggle_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_ADDRESSES_TOGGLE_BUTTON}    ${address_type}
    Click Toggle if Closed    ${toggle_locator}

Close Section Label on Wildcard FQDN Address List
    [Arguments]    ${address_type}
    [Documentation]    ${address_type} can be "Wildcard FQDN", "Wildcard FQDN Group"
    ${toggle_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_ADDRESSES_TOGGLE_BUTTON}    ${address_type}
    Click Toggle if Opened    ${toggle_locator}    

Click Toggle if Opened
    [Arguments]    ${toggle_locator}
    ${if_folded}=    if the label is folded    ${toggle_locator}
    run keyword if    "${if_folded}"=="False"    click button    ${toggle_locator}
    Wait Until Element Is Visible    ${toggle_locator}\[@class="compact-visual-toggle"]  

Click Toggle if Closed    
    [Arguments]    ${toggle_locator}
    ${if_folded}=    if the label is folded    ${toggle_locator}
    run keyword if    "${if_folded}"=="True"    click button    ${toggle_locator}
    Wait Until Element Is Visible    ${toggle_locator}\[@class="compact-visual-toggle active"]  

if the label is folded
    [Arguments]    ${toggle_locator}
    Wait Until Element Is Visible    ${toggle_locator}
    ${status}=    run keyword and return status    Wait Until Element Is Visible    ${toggle_locator}\[@class="compact-visual-toggle"]
    [return]    ${status}  

Verify Color by Class
    [Arguments]   ${name}    ${expect}    ${type}=Address
    Verify Icon by Class    ${name}    ${expect}    ${type}

Verify Icon by Class
    [Arguments]   ${name}    ${expect}    ${type}    ${special_locator}=NA
    [Documentation]    ${page} could be "Address", "Service", "Schedule", "Wildcard FQDN", "VIP", and Policy List

    ${icon_locator}=    Run Keyword If    "${type}" == "Address"    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_ADDRESS_ICON}    ${name}
    ...    ELSE IF    "${type}" == "Service"    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_ADDRESS_ICON}    ${name}
    ...    ELSE IF    "${type}" == "Wildcard FQDN"    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_ADDRESS_ICON}    ${name}
    ...    ELSE IF    "${type}" == "Schedule"    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_SCHEDULE_ICON}    ${name}
    ...    ELSE IF    "${type}" == "VIP"    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_ADDRESS_ICON}    ${name}
    ...    ELSE IF    "${type}" == "Policy List"    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_ADDRESS_ICON_POLICY_LIST}    ${name}
    ...    ELSE IF    "${type}" == "Other"    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${special_locator}    ${name}
    ...    ELSE    Fail    wrong type
    Press Down Key Until an Element is Visible    ${icon_locator}
    ${class_value}=    Get Element Attribute    ${icon_locator}    class
    Should Contain    ${class_value}    ${expect}   

##Policy & Objects ->Internet Service Database##
Go to Internet Service Database
    Wait Until Element Is Visible    ${MENU_POLICY_INTERNET_SERVICE_DATABASE}
    click element    ${MENU_POLICY_INTERNET_SERVICE_DATABASE}
    Wait Until Element Is Visible    ${POLICY_ISDB_TABLE_DIRECTION}  

Open Section Label on ISDB List
    [Arguments]    ${type}
    [Documentation]    ${type} can be "Custom Internet Service", "Internet Service Database"...
    ${toggle_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_ADDRESSES_TOGGLE_BUTTON}    ${type}
    Click Toggle if Closed    ${toggle_locator}   

Get ISDB Config by Column Name and Service Name     
    [Arguments]   ${column_list}    ${type}    ${name}         
    [Documentation]    This keyword return the displayed text in request columns 
    ...    ${column_list}: a list of column names;    ${type}: the section of internet service database;  
    ...    ${config_list}: a list of text displayed in the requested columns of the policy id
    Open Section Label on ISDB List    ${type}    
    ${config_list}=    Get Config by Column Name and Key    ${column_list}    ${name}    ${D_ISDB_DISPLAY_NAME_TO_COLUMN_ID}    ${VAR_POLICY_ISDB_COLUMN_GENERAL_SETTING}            
    [return]    ${config_list}

Click ISDB By Name on ISDB List
    [Arguments]   ${type}    ${name}
    Open Section Label on Address List    ${type}
    ${isdb_in_table}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_ISDB_NAME_COLUMN}    ${name}
    Press Down Key Until an Element is Visible    ${isdb_in_table}
    Click Element    ${isdb_in_table}
    Wait Until Element Is Visible    xpath://div[contains(@class,"selected")]//div[@column-id="name"]  

Right Click ISDB on ISDB List
    [Arguments]   ${name}
    ${isdb_in_table}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_ISDB_NAME_COLUMN}    ${name}
    Wait Until Element Is Visible    ${isdb_in_table} 
    Open Context Menu    ${isdb_in_table}
    Wait Until Element Is Visible    ${POLICY_CONTEXT_MENU_BUTTON_DELETE}     

#Close context menu by clicking the policy menu
Close Context Menu on Policy Object
    SeleniumLibrary.Mouse Down    ${MENU_POLICY_AND_OBJECT}    # this is just to get ride of the context menu
    SeleniumLibrary.Mouse Up    ${MENU_POLICY_AND_OBJECT}    # this is just to get ride of the context menu
    Wait Until Element Is not Visible    ${POLICY_CONTEXT_MENU_BUTTON_DELETE}   

Confirm and Delete Policy Object
    [Arguments]    ${item_locator}
    Wait Until Element Is Visible    ${POLICY_ADDRESSES_DELETE_CONFIRM_HEAD}
    Wait Until Element Is Visible    ${POLICY_ADDRESSES_DELETE_CONFIRM_OK_BUTTON}
    Click Button    ${POLICY_ADDRESSES_DELETE_CONFIRM_OK_BUTTON}
    #verify if the item is deleted successfully
    Wait Until Element Is Visible    ${POLICY_OBJECT_TABLE_COLUMN_NAME}     #not work for schedule and ip pool page. will work on it later
    Wait Until Page Does Not Contain Element    ${item_locator}

Delete Policy Object By Context Menu
    [Arguments]    ${type}    ${name}
    [Documentation]    This keyword is designed to delete Address, Service, Schedule, Custom ISDB, Virtual IP, and IP Pool. 
    ...    ${type} could be "ISDB", "Address"...    ${name} is the name of the deleted object    
    ${item_locator}=    Run Keyword If    "${type}"=="ISDB"    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_ISDB_NAME_COLUMN}    ${name}		
    ...    ELSE IF  "${type}"=="Address"    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_ADDRESSES_NAME_COLUMN}    ${name}
    ...    ELSE    Fail    wrong type
    Wait Until Element Is Visible    ${item_locator} 
    Open Context Menu    ${item_locator}
    Wait Until Element Is Visible    ${POLICY_CONTEXT_MENU_BUTTON_DELETE}  
    Click Button    ${POLICY_CONTEXT_MENU_BUTTON_DELETE}
    Confirm and Delete Policy Object    ${item_locator}    

Delete Policy Object By Top Menu
    [Arguments]    ${type}    ${name}
    [Documentation]    This keyword is designed to delete Address, Service, Schedule, Custom ISDB, Virtual IP, and IP Pool. 
    ...    ${type} could be "ISDB", "Address"...    ${name} is the name of the deleted object    
    ${item_locator}=    Run Keyword If    "${type}"=="ISDB"    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_ISDB_NAME_COLUMN}    ${name}		
    ...    ELSE IF  "${type}"=="Address"    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_ADDRESSES_NAME_COLUMN}    ${name}
    ...    ELSE    Fail    wrong type
    Click Element    ${item_locator}
    Wait Until Element Is Visible    ${POLICY_V4V6_DELETE_BUTTON_E}
    Click Button    ${POLICY_V4V6_DELETE_BUTTON_E}
    Confirm and Delete Policy Object    ${item_locator}

## wildcard fqdn ##
get entry from table base on line number
   [Documentation]   this keyword is to get an entry value in a table base on a given line number
   ...               table name and column name is that name shown on gui, dictionary is column name mapping to column-id in xpath
   [Arguments]    ${table_name}    ${column_name}    ${line_number}    ${dictionary}
   ${table_name}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${POLICY_ENTRY_TABLE_NAME}    ${table_name}
   ${line_number}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${POLICY_ENTRY_TABLE_LINE_NUMBER}   ${line_number}
   ${column_id}=    Get From Dictionary    ${dictionary}    ${column_name} 
   ${column}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${POLICY_ENTRY_TABLE_COLUMN}    ${column_id}
   ${new_locator}=   CATENATE   SEPARATOR=    ${table_name}    ${line_number}
   ${new_locator}=   CATENATE   SEPARATOR=    ${new_locator}   ${column}
   ${exist}=   Run Keyword and Return Status   Wait Until Element Is Visible    ${new_locator}
   ${text}=    Run Keyword If   ${exist}    GET TEXT    ${new_locator}   ELSE   Set Variable    no_exist
   [Return]   ${text}

get all entries of a colum in table
    [Arguments]    ${table_name}    ${column_name}     ${max_line_number}    ${dictionary}
    ${name_list}=  create list
    :FOR   ${i}  IN RANGE  1   ${max_line_number}
    \  ${name}=    get entry from table base on line number   ${table_name}    ${column_name}    ${i}    ${dictionary}
    \  EXIT FOR LOOP IF   "${name}"=="no_exist"
    \  APPEND TO LIST   ${name_list}    ${name}
    [Return]   ${name_list}