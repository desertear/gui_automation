*** Settings ***
Documentation    Verify logtraffic-start option will still be displayed on policy editing page when it is enabled even if logtraffic is disabled (M434862)
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***

*** Test Cases ***
874419
    [Documentation]    
    [Tags]    chrome    874419    medium

    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown
        
    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects    

#Step 1: Verify logtraffic-start option will still be displayed when it is enabled
    Log    ==================== Step 1: Verify logtraffic-start option will still be displayed when it is enabled ====================
    Go to IPv4 policy    
    View By Sequence
    Edit Policy By ID on Policy list    ${FW_TEST_V4_POLICY_ID_1}
    Wait Until Element Is Visible    ${POLICY_V4V6_LOG_SESSION_START_TEXT}
    Checkbox Should Be Selected    ${POLICY_V4V6_LOG_SESSION_START_INPUT}

#Step 2: Verify logtraffic-start option is not shown when it is disabled
    Log    ==================== Step 2: Verify logtraffic-start option is not shown when it is disabled ====================    
    Unselect Checkbox by JS on Policy Editor    Generate Logs when Session Starts    ${POLICY_V4V6_LOG_SESSION_START_ID}    ${POLICY_V4V6_LOG_SESSION_START_INPUT}    NO
    Click Ok Button on Policy Editor
    Edit Policy By ID on Policy list    ${FW_TEST_V4_POLICY_ID_1}
    Wait Until Element Is Not Visible    ${POLICY_V4V6_LOG_SESSION_START_TEXT}
    Click Cancel Button on Policy Editor

    Logout FortiGate

*** Keywords ***

case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}