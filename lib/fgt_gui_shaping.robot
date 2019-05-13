*** Settings ***
Documentation     This file contains FortiGate Traffic Shaper, Shaping Policy and Shaping Profile function

*** Keywords ***
##Policy & Objects ->Traffic Shaping Policy##

# Click FOS GUI menu and navigate to Shaping Policy list page
Go to Shaping policy
    Wait Until Element Is Visible    ${MENU_POLICY_SHAPING_POLICY}
    click element    ${MENU_POLICY_SHAPING_POLICY}
    Wait Until Element Is Visible    ${POLICY_SHAPING_TABLE_NAME}

# Expand IPv4 and IPv6 Session to see all policies on Shaping list page
Open Shaping Policy Section
    Open Shaping Policy Section By IP Version    IPv4
    Open Shaping Policy Section By IP Version    IPv6

Open Shaping Policy Section By IP Version
    [Arguments]   ${ip_version}=IPv4
    #ipv4 section
    ${section_toggle_button}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_SHAPING_TOGGLE_BUTTON}    ${ip_version}
    ${toggle_open}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_SHAPING_TOGGLE_OPEN}    ${ip_version}
    #click the toggle only when it exists
    ${toggle_exist}    ${result}=    Run Keyword And Ignore Error    Wait Until Page Contains Element    ${section_toggle_button}
    Run Keyword If    "${toggle_exist}" == "PASS"  click toggle when it exists   ${toggle_open}    ${section_toggle_button}

click toggle when it exists
    [Arguments]   ${toggle_open}    ${section_toggle_button}
    ${toggle_status}    ${result}=    Run Keyword And Ignore Error    Wait Until Page Does Not Contain Element    ${toggle_open}
    Run Keyword if    "${toggle_status}" == "PASS"    Click Element    ${section_toggle_button}
    Wait Until Element Is Visible    ${toggle_open}

Right Click Traffic Shaping Policy by ID
    [Arguments]   ${policy_id}
    ${policy_in_table}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_SHAPING_ID_IN_TABLE}    ${policy_id}
    Open Context Menu    ${policy_in_table}
    Wait Until Element Is Visible    ${POLICY_SHAPING_CONTEXT_MENU}

# Select a policy by its ID and Click Edit
Edit Shaping Policy By ID
    [Arguments]   ${policy_id}
    Open Shaping Policy Section
    ${policy_in_table}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_SHAPING_ID_IN_TABLE}    ${policy_id}
    Wait Until Element Is Visible    ${policy_in_table}
    Click Element    ${policy_in_table}
    Wait Until Element Is Visible    xpath://div[contains(@class,"selected")]//div[@column-id="id"]
    Wait Until Element Is Visible    ${POLICY_SHAPING_POLICY_EDIT_BUTTON}
    Click Button    ${POLICY_SHAPING_POLICY_EDIT_BUTTON}
    Wait Until Element Is Visible    ${POLICY_SHAPING_NAME_TEXT}

# Change to IPv6 mode on Shaping Policy Editor
Switch to IPv6 Mode
    Click Element    ${POLICY_SHAPING_IPV6}
    Wait Until Page Contains Element    ${POLICY_SHAPING_IPV6_SELECT}    

Click Create New Button on Shaping Policy List
    Click Button    ${GENERAL_LIST_CREATE_NEW_BUTTON}
    Wait Until Element Is Visible    ${POLICY_SHAPING_POLICY_H1}
    Wait Until Element Is Visible    ${POLICY_SHAPING_NAME_TEXT}    


##Policy & Objects ->Traffic Shaper##

Go to Traffic Shaper
    Wait Until Element Is Visible    ${MENU_POLICY_TRAFFIC_SHAPER}
    click element    ${MENU_POLICY_TRAFFIC_SHAPER}
    Select Frame    ${POLICY_OBJECT_FRAME}
    Wait Until Element Is Visible    ${POLICY_SHAPER_TABLE_NAME}  
    Unselect Frame   

Right Click Traffic Shaper on Shaper list
    [Arguments]   ${name}
    ${shaper_in_table}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_SHAPING_NAME_COLUMN}    ${name}
    Select Frame    ${POLICY_OBJECT_FRAME}
    Wait Until Element Is Visible    ${shaper_in_table}
    Open Context Menu    ${shaper_in_table}
    Wait Until Element Is Visible    ${POLICY_CONTEXT_MENU_BUTTON_EDIT_IN_CLI}
    Unselect Frame