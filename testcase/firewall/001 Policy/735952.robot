*** Settings ***
Documentation    Verify GUI checkbox for log traffic start option in each policy only support on 2U FGT (167323, 199765)
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${log_session_start_text}    xpath://span[text()="Generate Logs when Session Starts"]

*** Test Cases ***
735952
    [Documentation]    
    [Tags]    chrome    735952    high
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown
        
    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects    

#Step 1: "Generate Logs when Session Starts" should only be availabe on 2U and above
    Log    ==================== Step 1: "Generate Logs when Session Starts" should only be availabe on 2U and above ====================
    Go to IPv4 policy    
    View By Sequence
    Click Create New Button on Policy List
    Wait Until Element Is Visible    ${POLICY_V4V6_POLICY_LOG_H2}
    Run Keyword If    "${FGT_HW_SIZE}"=="2U" or "${FGT_HW_SIZE}"=="VM"     Wait Until Element Is Visible    ${log_session_start_text}
    ...    ELSE    Wait Until Element Is Not Visible    ${log_session_start_text}
    Click Cancel Button on Policy Editor


#Step 2: "Generate Logs when Session Starts" Can be enabled and disabled
    Log    ==================== Step 2: "Generate Logs when Session Starts" Can be enabled and disabled ====================
    Go to IPv4 policy    
    View By Sequence
    Edit Policy By ID on Policy list    ${FW_TEST_V4_POLICY_ID_1}
    Wait Until Element Is Visible    ${POLICY_V4V6_POLICY_LOG_H2}
    Run Keyword If    "${FGT_HW_SIZE}"=="2U" or "${FGT_HW_SIZE}"=="VM"    Select Log Session Start And Check Result
    Run Keyword If    "${FGT_HW_SIZE}"=="2U" or "${FGT_HW_SIZE}"=="VM"    Unselect Log Session Start And Check Result
    Logout FortiGate

*** Keywords ***
Select Log Session Start And Check Result
    Select Checkbox by JS on Policy Editor    Generate Logs when Session Starts    ${POLICY_V4V6_LOG_SESSION_START_ID}    ${POLICY_V4V6_LOG_SESSION_START_INPUT}    NO
    Click Ok Button on Policy Editor
    Edit Policy By ID on Policy list    ${FW_TEST_V4_POLICY_ID_1}
    Checkbox Should Be Selected    ${POLICY_V4V6_LOG_SESSION_START_INPUT}

Unselect Log Session Start And Check Result
    Unselect Checkbox by JS on Policy Editor    Generate Logs when Session Starts    ${POLICY_V4V6_LOG_SESSION_START_ID}    ${POLICY_V4V6_LOG_SESSION_START_INPUT}    NO
    Click Ok Button on Policy Editor
    Edit Policy By ID on Policy list    ${FW_TEST_V4_POLICY_ID_1}
    Checkbox Should Not Be Selected    ${POLICY_V4V6_LOG_SESSION_START_INPUT}

case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}