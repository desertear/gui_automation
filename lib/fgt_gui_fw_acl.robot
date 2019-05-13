*** Settings ***
Documentation     This file contains FortiGate ACL function

*** Keywords ***

Go to Ipv4 ACL
    Wait Until Element Is Visible    ${MENU_POLICY_IPV4_ACL}
    click element    ${MENU_POLICY_IPV4_ACL}
    Wait Until Element Is Visible    ${POLICY_V4V6_TABLE}

Go to Ipv6 ACL
    Wait Until Element Is Visible    ${MENU_POLICY_IPV6_ACL}
    click element    ${MENU_POLICY_IPV6_ACL}
    Wait Until Element Is Visible    ${POLICY_V4V6_TABLE}

Go to Ipv4 DoS Policy
    Wait Until Element Is Visible    ${MENU_POLICY_IPV4_DOS_POLYCY}
    click element    ${MENU_POLICY_IPV4_DOS_POLYCY}
    Wait Until Element Is Visible    ${POLICY_V4V6_TABLE}

Go to Ipv6 DoS Policy
    Wait Until Element Is Visible    ${MENU_POLICY_IPV6_DOS_POLYCY}
    click element    ${MENU_POLICY_IPV6_DOS_POLYCY}
    Wait Until Element Is Visible    ${POLICY_V4V6_TABLE}

Edit Other Policy By ID on Policy list
    [Arguments]   ${policy_id}    ${policy_type}=ACL
    Click Policy By ID on ACL Policy List    ${policy_id}
    wait and click    ${POLICY_V4V6_EDIT_BUTTON_E}
    run keyword if     "${policy_type}"=="ACL" or "${policy_type}"=="DoS"    Select Frame    ${POLICY_OBJECT_FRAME}

Click Policy By ID on ACL Policy List
    [Arguments]   ${policy_id}
    ${policy_in_table}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_NAME_BY_ID_COLUMN}    ${policy_id}
    Click Element    ${policy_in_table}
    Wait Until Element Is Visible    xpath://div[contains(@class,"selected")]//div[@column-id="policyid"]
    Mouse Out    ${policy_in_table}    #this is to avoid tooltips making the edit button not visible
