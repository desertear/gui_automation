*** Settings ***
Documentation      To verify virtual domain could not be deleted if it is binding to an interface or management Vdom.
Resource    ../../../system_resource.robot

*** Variables ***
${test_vdom_name}    181534
${vdom_fw_mode}      Policy-based
${vdom_comments}     this is a test vdom
@{ssh_cmd_fgt}    config vdom   delete ${test_vdom_name}    end
*** Test Cases ***
181534
    [Tags]    v6.0    chrome   181534    Medium    win10,64bit    browsers    runable   
    Login FortiGate   
    Go to system
    sleep  2
    ###    create a new vdom   ####
    Go to system_VDOM
    sleep  2
    select frame    ${NETWORK_FRAME}
    wait and click    ${SYSTEM_VDOM_CREATE NEW_BUTTON}
    sleep  2
    wait and click      ${SYSTEM_VDOM_NEW_VDOM_NAME}
    clear element text  ${SYSTEM_VDOM_NEW_VDOM_NAME}
    input text          ${SYSTEM_VDOM_NEW_VDOM_NAME}    ${test_vdom_name}
    ${new_locator}=     REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_VDOM_NEW_VDOM_NGFW_MODE}    ${vdom_fw_mode}
    wait and click      ${new_locator}
    wait and click      ${SYSTEM_VDOM_NEW_VDOM_COMMENTS}
    clear element text  ${SYSTEM_VDOM_NEW_VDOM_COMMENTS}
    input text          ${SYSTEM_VDOM_NEW_VDOM_COMMENTS}    ${vdom_comments}
    wait and click      ${SUBMIT_OK_SPAN}
    sleep   2
    ## try to delete management vdom ###
    select frame    ${NETWORK_FRAME}
    ${status}=    run keyword and return status   DELETE VDOM   ${SYSTEM_TEST_VDOM_NAME_1}
    should be equal    "${status}"    "False"
    sleep   1
    ## try to delete a vdom with interfaces ##
    ${status}=    run keyword and return status   DELETE VDOM   ${SYSTEM_TEST_VDOM_NAME_2}
    should be equal    "${status}"    "False"
    ## try to delete a vdom without interface and not management vdom ###
    DELETE VDOM   ${test_vdom_name}
    unselect frame
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Close All Browsers
    Execute CLI commands on FortiGate Via Direct Telnet   ${ssh_cmd_fgt}
    write test result to file    ${CURDIR}
