*** Settings ***
Documentation    Verify policy list of interface-pair view is sorted by interfaces name or alias name. (M462078)
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${intf_alias_1}    ~abcc cccc
${intf_alias_2}    abcde eeee
${intf_alias_3}    z12345

${POLICY_ID_5}    5000
${POLICY_ID_6}    6000

${section_label}    xpath:(//label[@class="section-label"])
#each section label contains (source interface)→(Destination interface)(Number of policy in this section)
@{section_list}    ${intf_alias_1} (${FW_TEST_INTF_1}) →${intf_alias_2} (${FW_TEST_INTF_2})1
...    ${intf_alias_2} (${FW_TEST_INTF_2}) →${intf_alias_1} (${FW_TEST_INTF_1})1
...    ${intf_alias_2} (${FW_TEST_INTF_2}) →${FW_TEST_INTF_4}1
...    ${intf_alias_2} (${FW_TEST_INTF_2}) →${intf_alias_3} (${FW_TEST_INTF_3})1
...    ${FW_TEST_INTF_4} →${intf_alias_1} (${FW_TEST_INTF_1})1
...    ${intf_alias_3} (${FW_TEST_INTF_3}) →${intf_alias_1} (${FW_TEST_INTF_1})1

*** Test Cases ***
853944
    [Documentation]    
    [Tags]    chrome    853944    high
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown
        
    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects    

#Step 1: Alias displayed correctly in firewall policy list 
    Log    ==================== Step 1: Alias displayed correctly in firewall policy list ====================
    Go to IPv4 policy   
    View By Interface Pair View
    Verify Section Lebal Order
 
    Go to IPv6 policy   
    View By Interface Pair View
    Verify Section Lebal Order

    Logout FortiGate

*** Keywords ***
Verify Section Lebal Order
    ${index}=    Set Variable    0
    :FOR    ${section}    IN    @{section_list}
    \    ${index}=    Evaluate    ${index} + 1
    \    ${section_with_index}=    Add Index to XPATH    ${section_label}    ${index}
    \    ${return}=   Get Text    ${section_with_index}
    \    ${return_text}=    Remove Extra Character in Text    ${return}
    \    Should Be True    "${return_text}"=="${section}"

case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}