*** Settings ***
Documentation    Verify expired schedule indicated in schedule list and policy (M259338)
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${expired_schedule}    Expired_Sch_796213
${expired_schedule_group}    Expired_Sch_Group_796213

${var_locator_expired_schedule_name}    xpath://tr[@mkey="\${PLACEHOLDER}"]//span
${var_locator_expired_schedule_icon}    xpath://tr[@mkey="\${PLACEHOLDER}"]//f-icon

${var_locator_expired_schedule_in_group_name}    xpath://tr[@mkey="${expired_schedule_group}"]/td[@class="details"]//span[contains(text(),"${expired_schedule}")]
${var_locator_expired_schedule_in_group_icon}    xpath://tr[@mkey="${expired_schedule_group}"]/td[@class="details"]//f-icon[following-sibling::span[contains(text(),"${expired_schedule}")]]

*** Test Cases ***
796213
    [Documentation]
    [Tags]    chrome    796213    high
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects

# Step 1: there is icon to indicate expired schedule on schedule page
    Log    ==================== Step 1: there is error icon to indicate expired schedule on schedule page ====================
    Go to Schedules
    Select Frame    ${POLICY_OBJECT_FRAME}
    ${locator_icon}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${var_locator_expired_schedule_icon}    ${expired_schedule}
    Verify Icon by Class    ${expired_schedule}    ftnt-expired-schedule    Other    ${locator_icon}        
    ${locator_name}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${var_locator_expired_schedule_name}    ${expired_schedule}
    Element Should Contain    ${locator_name}    (expired)

    ${locator_icon}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${var_locator_expired_schedule_icon}    ${FW_TEST_SCHEDULE_ONE_TIME_1}  
    Verify Icon by Class    ${FW_TEST_SCHEDULE_ONE_TIME_1}    ftnt-schedule${SPACE}    Other    ${locator_icon}  
    ${locator_name}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${var_locator_expired_schedule_name}    ${FW_TEST_SCHEDULE_ONE_TIME_1}
    Element Should Not Contain    ${locator_name}    (expired)


# Step 2: there is icon to indicate expired schedule when schedule is used in a schedule group
    Log    ==================== Step 2: there is icon to indicate expired schedule when schedule is used in a schedule group ====================
    ${locator_icon}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${var_locator_expired_schedule_icon}    ${expired_schedule}
    Verify Icon by Class    ${expired_schedule}    ftnt-expired-schedule    Other    ${locator_icon}        
    ${locator_name}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${var_locator_expired_schedule_name}    ${expired_schedule}
    Element Should Contain    ${locator_name}    (expired)
    Unselect Frame

# Step 3: there is error icon to indicate expired schedule on policy page
    Log    ==================== Step 3: there is error icon to indicate expired schedule on policy page====================
    Go to IPv4 policy  
    View By Sequence    
    Verify Icon by Class    ${expired_schedule}    ftnt-expired-schedule    Policy List

    Go to IPv6 policy  
    View By Sequence    
    Verify Icon by Class    ${expired_schedule}    ftnt-expired-schedule    Policy List

    Logout FortiGate

*** Keywords ***
case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
