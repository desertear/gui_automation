*** Settings ***
Documentation    Verify implicit policy cannot be deleted and only the logging option inside the policy may be changed(both id and non-id policy)
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${implicit_policy_id}    0

# xpath for the setting div of Incoming Interface, Outgoing Interface, Source, and Destination
# most of them are /lable/span[variable anme], but outgoing interface is only /label[variable name]
# also there are one extra space behind Destination, so in the xpath, contains is used not exact match
${var_attribute_disable}    xpath://label[span[contains(text(),"\${PLACEHOLDER}")] or contains(text(),"\${PLACEHOLDER}")]/following-sibling::div/div[contains(@class,"disabled")]



*** Test Cases ***
599534
    [Documentation]    
    [Tags]    chrome    599534    high
    [Teardown]    case Teardown
        
    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects    

#Step 1: implicit policy can not be deleted
    Log    ==================== Step 1: implicit policy can not be deleted ====================
    Go to IPv4 policy
    Delete Button Should be Disabled for Policy ID    ${implicit_policy_id}
    Go to IPv6 policy
    Delete Button Should be Disabled for Policy ID    ${implicit_policy_id}

#Step 2: Log can be enabled and disabled
    Log    ==================== Step 2: Log can be enabled and disabled ====================
    Go to IPv4 policy
    Log Can be Enabled and Disabled
    Go to IPv6 policy
    Log Can be Enabled and Disabled

#Step 3: Verify all fields are disabled and can not be edit
    Log    ==================== Step 3: Verify all fields are disabled and can not be edit ====================
    Go to IPv4 policy
    All Fields Are Disabled 
    Go to IPv6 policy
    All Fields Are Disabled    

#Step 4: Verify some fields are not applied to implicit policy and are hidden
    Log    ==================== Step 4: Verify some fields are not applied to implicit policy and are hidden ====================
    Go to IPv4 policy
    Attributes Not Applied And Should be Hidden
    Go to IPv6 policy
    Attributes Not Applied And Should be Hidden

    Logout FortiGate

*** Keywords ***
Log Can be Enabled and Disabled
    Edit Policy By ID on Policy List    ${implicit_policy_id} 
    Element Should Be Visible    ${POLICY_V4V6_POLICY_LOG_DENY_H2}
    Checkbox Should Not Be Selected    ${POLICY_V4V6_LOG_INPUT}
    Select Checkbox by JS on Policy Editor    NA    ${POLICY_V4V6_LOG_ID}    ${POLICY_V4V6_LOG_INPUT}    NO
    Click Ok Button on Policy Editor
    Edit Policy By ID on Policy list    ${implicit_policy_id}
    Checkbox Should Be Selected    ${POLICY_V4V6_LOG_INPUT}    
    Unselect Checkbox by JS on Policy Editor    NA    ${POLICY_V4V6_LOG_ID}    ${POLICY_V4V6_LOG_INPUT}    NO
    Click Ok Button on Policy Editor
    Edit Policy By ID on Policy list    ${implicit_policy_id}
    Checkbox Should Not Be Selected    ${POLICY_V4V6_LOG_INPUT}
    Click Cancel Button on Policy Editor

Field Should be Disabled 
    [Arguments]   ${name}
    ${locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${var_attribute_disable}    ${name}
    Element Should Be Visible    ${locator}

All Fields Are Disabled
    Edit Policy By ID on Policy List    ${implicit_policy_id}    
    Field Should be Disabled    Incoming Interface    
    Field Should be Disabled    Outgoing Interface
    Field Should be Disabled    Source
    Field Should be Disabled    Destination 
    Element Attribute Value Should Be    ${POLICY_V4V6_ACTION_ACCEPT_ID}    disabled    true
    Element Attribute Value Should Be    ${POLICY_V4V6_ACTION_DENY_ID}    disabled    true
    Click Cancel Button on Policy Editor

Attributes Not Applied And Should be Hidden
    Edit Policy By ID on Policy List    ${implicit_policy_id} 
    Element Should Not Be Visible    ${POLICY_V4V6_SERVICE_DIV}
    Element Should Not Be Visible    ${POLICY_V4V6_SCHEDULE_DIV}
    Element Should Not Be Visible    ${POLICY_V4V6_POLICY_NETWORK_H2}
    Element Should Not Be Visible    ${POLICY_V4V6_POLICY_UTM_H2}
    Element Should Not Be Visible    ${POLICY_V4V6_POLICY_TRAFFIC_SHAPING_H2}
    Element Should Not Be Visible    ${POLICY_V4V6_POLICY_LOG_H2} 
    Click Cancel Button on Policy Editor

case Teardown
    write test result to file    ${CURDIR}