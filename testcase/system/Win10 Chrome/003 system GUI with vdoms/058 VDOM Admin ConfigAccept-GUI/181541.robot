*** Settings ***
Documentation      To verify that an administrator could be created for each vdom
Resource    ../../../system_resource.robot

*** Variables ***
${test_vdom_name}    181541
@{vdom_list_1}    ${SYSTEM_TEST_VDOM_NAME_1}
@{vdom_list_2}    ${SYSTEM_TEST_VDOM_NAME_2}
${vdom_fw_mode}      Policy-based
${vdom_comments}     this is a test vdom
@{ssh_cmd_fgt}    get system status | grep "Max number of virtual domains"
*** Test Cases ***
181541
##
    [Tags]    v6.0    chrome   181541    high    win10,64bit    browsers    runable  
    @{responses_ssh}=    Execute CLI commands on FortiGate Via Terminal Server   ${ssh_cmd_fgt}
    ${response}=    set variable       @{responses_ssh}[-1]
    ${vdom_num}=    Fetch From Right   ${response}    domains:
    ${vdom_num}=    Fetch From Left    ${vdom_num}    \r
    ${vdom_num}=    Strip String       ${vdom_num} 
    ${fgt_vdom_num_max}=    Set Variable    ${vdom_num}
    ${fgt_vdom_num_max}=    Evaluate    ${fgt_vdom_num_max}-1
    Login FortiGate   
    Go to system
    sleep  2
    ###    create a new vdom   ####
    Go to system_VDOM
    sleep  2
    ${new_locator}=     REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_VDOM_NEW_VDOM_NGFW_MODE}    ${vdom_fw_mode}
    :FOR  ${i}   IN RANGE   1   ${fgt_vdom_num_max}
        \    select frame       ${NETWORK_FRAME}
        \    wait and click     ${SYSTEM_VDOM_CREATE NEW_BUTTON}
        \    sleep  2
        \    wait and click      ${SYSTEM_VDOM_NEW_VDOM_NAME}
        \    clear element text  ${SYSTEM_VDOM_NEW_VDOM_NAME}
        \    input text          ${SYSTEM_VDOM_NEW_VDOM_NAME}       ${test_vdom_name}${i}
        \    wait and click      ${new_locator}
        \    wait and click      ${SYSTEM_VDOM_NEW_VDOM_COMMENTS}
        \    clear element text  ${SYSTEM_VDOM_NEW_VDOM_COMMENTS}
        \    input text          ${SYSTEM_VDOM_NEW_VDOM_COMMENTS}    ${vdom_comments}${i}
        \    wait and click      ${SUBMIT_OK_SPAN}
        \    sleep   2
    Wait Until Element Is Visible    ${SYSTEM_VDOM_MAX_NUM_WARN_MSG}
    wait and click    ${CONFIRM_CANCEL_BUTTON}
    sleep   2
    ${fgt_vdom_num_max}=    Evaluate    ${fgt_vdom_num_max}-1
    select frame       ${NETWORK_FRAME}
    :FOR  ${i}   IN RANGE   1   ${fgt_vdom_num_max}
        \    DELETE VDOM  ${test_vdom_name}${i}
        \    sleep   2
    unselect frame
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Close All Browsers
    write test result to file   ${CURDIR}
