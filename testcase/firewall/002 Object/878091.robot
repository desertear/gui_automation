*** Settings ***
Documentation    Verify "show in list (visibility)" work for firewall service on policy and service group editor (Separated from case 757155)
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
#only service has visibility command. service group does not.
@{service_list}    ${FW_TEST_SERVICE_1}    ${FW_TEST_SERVICE_2}    ${FW_TEST_SERVICE_3}    ${FW_TEST_SERVICE_4}    ${FW_TEST_SERVICE_5}

*** Test Cases ***
878091
    [Documentation]    Service that has visibiltiy disabled are still listed in Service group member list
    [Tags]    chrome    878091    high
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects

# Step 1: test service is shown on policy editor
    Log    ==================== Step 1: test service is shown on policy editor ====================
    Go to IPv4 policy
    Click Create New Button on Policy List
    Verify Service Visibility in Policy Editor    ${service_list}
    Click Cancel Button on Policy Editor   

    Go to IPv6 policy
    Click Create New Button on Policy List
    Verify Service Visibility in Policy Editor    ${service_list}
    Click Cancel Button on Policy Editor   

# Step 2: test service is shown on service group editor
    Log    ==================== Step 2: test service is shown on service group editor ====================
    Go to Services 
    Click Create New on Services List    Service Group
    Verify Service Visibility in Service Group Editor    ${service_list}
    Click Cancel Button on Service Editor


# Step 3: test service is not shown on policy editor
    Log    ==================== Step 3: test service is not shown on policy editor ====================
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_cli_1.txt
    Go to IPv4 policy
    Click Create New Button on Policy List
    Verify Service Visibility in Policy Editor    ${service_list}    NO 
    Click Cancel Button on Policy Editor   

    Go to IPv6 policy
    Click Create New Button on Policy List
    Verify Service Visibility in Policy Editor    ${service_list}    NO
    Click Cancel Button on Policy Editor

# Step 4: test service is still shown on service group editor
    Log    ==================== Step 4: test service is not shown on service group editor ====================
    Go to Services 
    Click Create New on Services List    Service Group
    Verify Service Visibility in Service Group Editor    ${service_list}
    Click Cancel Button on Service Editor


# Step 5: test service is visible on policy editor
    Log    ==================== Step 5: test service is visible on policy editor ====================
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_cli_2.txt
    Go to IPv4 policy
    Click Create New Button on Policy List
    Verify Service Visibility in Policy Editor    ${service_list}
    Click Cancel Button on Policy Editor   

    Go to IPv6 policy
    Click Create New Button on Policy List
    Verify Service Visibility in Policy Editor    ${service_list} 
    Click Cancel Button on Policy Editor

# Step 6: test service is shown on service group editor
    Log    ==================== Step 6: test service is shown on service group editor ====================
    Go to Services 
    Click Create New on Services List    Service Group
    Verify Service Visibility in Service Group Editor     ${service_list}
    Click Cancel Button on Service Editor

    Logout FortiGate

*** Keywords ***
Check Service Display in Slide in Window
    [Arguments]    ${test_list}    ${visible}=YES
    Wait Until Element Is Visible    ${POLICY_V4V6_SERVICE_ENTRY_LIST}
    Wait Until Element Is Visible    ${POLICY_V4V6_SERVICE_ALL_IN_SELECT_ENTRY}    
    :FOR    ${item}    IN    @{test_list}
    \    ${item_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_SERVICE_ENTRY_IN_LIST}    ${item}
    \    run keyword if    "${visible}"=="YES"    Element Should be Visible    ${item_locator}
    \    ...    ELSE IF    "${visible}"=="NO"    Element Should Not be Visible    ${item_locator}
    click button    ${POLICY_V4V6_ENTRY_CLOSE_BUTTON}

Verify Service Visibility in Policy Editor
    [Arguments]    ${test_list}    ${visible}=YES
    Click Element    ${POLICY_V4V6_SERVICE_DIV}
    Check Service Display in Slide in Window    ${test_list}    ${visible}     

Verify Service Visibility in Service Group Editor
    [Arguments]    ${test_list}    ${visible}=YES
    Click Element    ${POLICY_SERVICE_SERVICE_GROUP_MEMBER_DIV}
    Check Service Display in Slide in Window    ${test_list}    ${visible}  

case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
