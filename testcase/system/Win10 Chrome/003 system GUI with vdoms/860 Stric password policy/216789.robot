*** Settings ***
Documentation   GUI configuration match to CLI command
Resource    ../../../system_resource.robot

*** Variables ***
${pass_scope}   Admin
${new_passwd}    Abc1234!@#$
@{char_list}    min-upper    min-lower    min-number    min-special
${length_input}    min-length
@{cmd_list}     config global    config system password-policy    show
${test_tegx_1}    set minimum-length 10
${test_tegx_2}    set min-lower-case-letter 2
${test_tegx_3}    set min-upper-case-letter 1
${test_tegx_4}    set min-non-alphanumeric 4
${test_tegx_5}    set min-number 3
${username}        216789
${password}        123
@{vdom}      ${SYSTEM_TEST_VDOM_NAME_1}
*** Test Cases ***
216789
    [Documentation]    
    [Tags]    v6.0    chrome   216789    High    win10,64bit    runable    
    ######
    Login FortiGate   
    Go to Global
    Go to system
    go to System_administrators
    Create Administrator   ${username}    ${password}    vdom=${vdom}
    ##############
    Go to system
    Go to system_Settings
    wait until Element Is Visible   ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION}
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION_SCOPE_LABEL}    ${pass_scope}
    ${new_locator}=    CATENATE     SEPARATOR=     ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION}    ${new_locator}
    wait and click   ${new_locator}
    ${status}=    run keyword and return status    checkbox should be selected    ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION_CHAR_REQ_CHKBOX}
    run keyword if    "${status}"=="False"    wait and click    ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION_CHAR_REQ_LABEL}
    ${i}=   set variable    1
    ${j}=   set variable    0
    :FOR  ${element}   IN   @{char_list}
         \  ${j}=    evaluate   ${i}+${j}
         \  ${new_locator}=     REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION_CHAR_REQ}    ${element}
         \  clear element text  ${new_locator}
         \  input text  ${new_locator}    ${i}
         \  ${i}=       evaluate   ${i}+1
    ${new_locator}=     REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION_CHAR_REQ}    ${length_input}
    clear element text  ${new_locator}
    input text    ${new_locator}    ${j}
    wait and click   ${SUBMIT_APPLY_SPAN}
    sleep   2
    Go to system_Settings
    Go to system
    go to System_administrators
    EDIT ADMINISTRATOR    ${username}
    Change Admin Password    old_password=${password}     new_password=${new_passwd} 
    ###  test if GUI config is same with CLI  ####
    :FOR   ${i}  IN RANGE   1   6
        \  TEST FROM CLI AND CHECK REGXP  ${cmd_list}   ${test_tegx${i}}   username=${username}  password=${new_passwd}
          
    sleep   2
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Close All Browsers
    Run Cli commands in File on Terminal Server  ${SYSTEM_CLI_FILE_DIR}${/}reset_passwdpolicy_cli.txt   username=${SUPER_ADMIN_NAME}  password=${SUPER_ADMIN_PASSWD}  
    Run Cli commands in File on Terminal Server  ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt 
    write test result to file    ${CURDIR}

