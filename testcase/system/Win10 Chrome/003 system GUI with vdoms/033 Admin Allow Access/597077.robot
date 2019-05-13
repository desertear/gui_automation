*** Settings ***
Documentation    Verify 10 trusted host can be added in GUI and work properly
...              FailCase with bug #0511311
Resource    ../../../system_resource.robot

*** Variables ***
${username}     597077
${passwd}       123
${column_id}    trusthostsIpv4
${num_hosts}    10
@{vdom}         ${SYSTEM_TEST_VDOM_NAME_1}
*** Test Cases ***
597077
    [Documentation]    
    [Tags]    FailCase!Bug#0511311   v6.0    chrome   597077    low    win10,64bit   runable   env2fail
    Login FortiGate  
    sleep  2
    Go to system
    go to System_administrators
    Create Administrator  username=${username}   password=${passwd}   vdom=${vdom}
    EDIT ADMINISTRATOR    ${username}
    ${status}=          Run Keyword and Return Status    Checkbox Should Be Selected    ${system_administrators_edit_admin_trust host_input}
    run keyword if     "${status}"=="False"    wait and click    ${system_administrators_edit_admin_trust host_label} 
    :FOR    ${i}    IN RANGE   1   ${num_hosts}+1
    \    ${host_input}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_TRUST HOST_IPV4}   ${i}
    \    wait and click      ${host_input}
    \    clear element text  ${host_input}
    \    input text          ${host_input}    ${i}.${i}.${i}.${i}/32
    \    run keyword if      ${i}<10    wait and click      ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_TRUST HOST_IPV4_ADD_BUTTON}
    ${status}=    run keyword and return status     wait and click      ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_TRUST HOST_IPV4_ADD_BUTTON}
    should be equal    "${status}"    "False"
    wait and click      ${system_administrators_edit_admin_OK_button}
    ${admin_entry}=     REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_ADMINISTRATORS_EDIT_ENTRY}           ${username}
    ${column_entry}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_ADMINISTRATORS_EDIT_ENTRY_COLUMN}    ${column_id}
    ${entry_span}=      CATENATE  SEPARATOR=    ${admin_entry}    ${column_entry}
    :FOR    ${i}    IN RANGE   1    ${num_hosts}+1
        \   ${column_entry_span}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_ADMINISTRATORS_EDIT_ENTRY_COLUMN_SPAN}    ${i}
        \   ${new_entry_span}=    CATENATE  SEPARATOR=    ${entry_span}    ${column_entry_span}
        \   ${status}=    run keyword and return status   wait until element is visible    ${new_entry_span}
        \   ${text}=      run keyword if    "${status}"=="True"    get text    ${new_entry_span}
        \   run keyword if     "${status}"=="True"    should be equal    "${text}"    "${i}.${i}.${i}.${i}/32"
        \   EXIT FOR LOOP IF   "${status}"=="False"
    ${entry_span}=      CATENATE  SEPARATOR=    ${entry_span}    ${SYSTEM_ADMINISTRATORS_EDIT_ENTRY_COLUMN_BUBBLE}
    ${text}=    get text    ${entry_span}
    ${rest}=    evaluate    ${num_hosts}-${i}+1
    should be equal    "${text}"    "+${rest}"
    [Teardown]   case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate   
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file   ${CURDIR}

