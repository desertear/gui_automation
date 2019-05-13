*** Settings ***
Documentation    Verify policy with multiple service/service group can be edited and service/service group can be added or removed. (separated from case 599492)
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
#for step 1 test
@{column_list}    Service
${original_srv}    ${FW_TEST_SERVICE_1}${FW_TEST_SERVICE_GROUP_1}
@{add_srv}    ${FW_TEST_SERVICE_5}    ${FW_TEST_SERVICE_GROUP_3}
${new_srv}    ${FW_TEST_SERVICE_1}${FW_TEST_SERVICE_GROUP_1}${FW_TEST_SERVICE_5}${FW_TEST_SERVICE_GROUP_3}

${original_srv6}    ${FW_TEST_SERVICE_1}${FW_TEST_SERVICE_GROUP_1}
@{add_srv6}    ${FW_TEST_SERVICE_4}    ${FW_TEST_SERVICE_GROUP_3}
${new_srv6}    ${FW_TEST_SERVICE_1}${FW_TEST_SERVICE_GROUP_1}${FW_TEST_SERVICE_4}${FW_TEST_SERVICE_GROUP_3}

#for step 2 test
@{del_srv}    ${FW_TEST_SERVICE_1}    ${FW_TEST_SERVICE_GROUP_3}
${2new_srv}    ${FW_TEST_SERVICE_GROUP_1}${FW_TEST_SERVICE_5}

@{del_srv6}    ${FW_TEST_SERVICE_GROUP_1}    ${FW_TEST_SERVICE_4}    ${FW_TEST_SERVICE_GROUP_3}
${2new_srv6}    ${FW_TEST_SERVICE_1}

*** Test Cases ***
877910
    [Documentation]
    [Tags]    chrome    877910    critical
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects

# Step 1: service and service group can be added to policy
    Log    ==================== Step 1: service and service group can be added to policy ====================
    Go to IPv4 policy
    View By Sequence
    ${display}=    Get Policy Config by Column Name and Policy ID    ${column_list}    ${FW_TEST_V4_POLICY_ID_1}
    Should Be Equal    ${display[1]}    ${original_srv}
    Edit Policy By ID on Policy list    ${FW_TEST_V4_POLICY_ID_1}
    Select Service on Policy Editor    ${add_srv}    
    Click Ok Button on Policy Editor
    ${display}=    Get Policy Config by Column Name and Policy ID    ${column_list}    ${FW_TEST_V4_POLICY_ID_1}
    Should Be Equal    ${display[1]}    ${new_srv}

    Go to IPv6 policy
    View By Sequence
    ${display}=    Get Policy Config by Column Name and Policy ID    ${column_list}    ${FW_TEST_V6_POLICY_ID_1}
    Should Be Equal    ${display[1]}    ${original_srv6}
    Edit Policy By ID on Policy list    ${FW_TEST_V6_POLICY_ID_1}
    Select Service on Policy Editor    ${add_srv6}   
    Click Ok Button on Policy Editor
    ${display}=    Get Policy Config by Column Name and Policy ID    ${column_list}    ${FW_TEST_V6_POLICY_ID_1}
    Should Be Equal    ${display[1]}    ${new_srv6}  
 

# Step 2: service and service group can be removed from policy
    Log    ==================== Step 2: service and service group can be removed from policy ==================== 
    Go to IPv4 policy
    View By Sequence
    Edit Policy By ID on Policy list    ${FW_TEST_V4_POLICY_ID_1}
    Unselect Service on Policy Editor    ${del_srv}  
    Click Ok Button on Policy Editor
    ${display}=    Get Policy Config by Column Name and Policy ID    ${column_list}    ${FW_TEST_V4_POLICY_ID_1}
    Should Be Equal    ${display[1]}    ${2new_srv}

    Go to IPv6 policy
    View By Sequence
    Edit Policy By ID on Policy list    ${FW_TEST_V6_POLICY_ID_1}
    Unselect Service on Policy Editor    ${del_srv6}  
    Click Ok Button on Policy Editor
    ${display}=    Get Policy Config by Column Name and Policy ID    ${column_list}    ${FW_TEST_V6_POLICY_ID_1}
    Should Be Equal    ${display[1]}    ${2new_srv6}

    Logout FortiGate

*** Keywords ***
case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
