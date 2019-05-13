*** Settings ***
Documentation    Verify api-user must have at least one trusthost entry 
Resource    ../../../system_resource.robot

*** Variables ***
${admin_rest_username}  837012_REST
${admin_profile}        837012_REST
${trust_host}           10.10.10.10/32
@{vdom}        ${SYSTEM_TEST_VDOM_NAME_1} 
*** Test Cases ***
837012
    [Documentation]    
    [Tags]    v6.0    chrome   837012    High    win10,64bit   runable  
    Login FortiGate  
    sleep  2
    Go to system
    go to system_admin_profiles
    Create Admin Profile  ${admin_profile} 
    Go to system
    Go to System_administrators
    wait and click    ${system_administrators_create new}
    ${admin_menu_bar}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_ADMINISTRATORS_CREATE_ADMINISTRATOR}    REST API Admin
    ##pop_up sometimes is not shown, and clicking "Create New" will go to edit page directly.
    ${if_pop_up}=    Run keyword and return status    Wait Until Element Is Visible     ${admin_menu_bar}
    Run keyword if    ${if_pop_up}    wait and click    ${admin_menu_bar}
    wait and click    ${SYSTEM_ADMINISTRATORS_EDIT_REST_USERNAME}
    clear element text   ${SYSTEM_ADMINISTRATORS_EDIT_REST_USERNAME}
    input text        ${SYSTEM_ADMINISTRATORS_EDIT_REST_USERNAME}   ${admin_rest_username}
    wait and click    ${SYSTEM_ADMINISTRATORS_EDIT_REST_ADMIN_PROFILE}
    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${system_administrators_edit_admin_admin_profile_select}    ${admin_profile}
    wait and click    ${new_locator}    
    wait and click    ${SYSTEM_ADMINISTRATORS_EDIT_REST_API_VDOM_ADD_BUTTON}
    wait and click    ${SYSTEM_ADMINISTRATORS_EDIT_REST_API_FIRSTVDOM_REMOVE_BUTTON}
    :FOR   ${ELEMENT}    IN      @{vdom}
           \   ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SELECTION_SPAN_MENU_BAR}   ${ELEMENT}
           \   wait and click   ${new_locator}
    ${staus}=    run keyword and return status     checkbox should be selected   ${SYSTEM_ADMINISTRATORS_EDIT_REST_API_PKI_CHECKBOX}
    run keyword if   "${staus}"=="True"    wait and click    ${SYSTEM_ADMINISTRATORS_EDIT_REST_API_PKI_LABEL}
    wait and click    ${SUBMIT_OK_BUTTON}
    ## double check if the admin user has been created, it should not be created without trusted host ##
    ${name_entry}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_ADMINISTRATORS_TABLE_NAME_ENTRY}   ${admin_rest_username}
    ${status}=   run keyword and return status    Wait Until Element Is Visible   ${name_entry}
    should be equal    "${status}"    "False"
    Wait Until Element Is Visible  ${SYSTEM_ADMINISTRATORS_EDIT_REST_API_TRUSTED_WARN_MSG}
    wait and click        ${SYSTEM_ADMINISTRATORS_EDIT_REST_API_TRUSTED_HOST}
    clear element text    ${SYSTEM_ADMINISTRATORS_EDIT_REST_API_TRUSTED_HOST}
    input text            ${SYSTEM_ADMINISTRATORS_EDIT_REST_API_TRUSTED_HOST}     ${trust_host}
    wait and click        ${SUBMIT_OK_BUTTON}
    wait and click        ${SYSTEM_ADMINISTRATORS_EDIT_REST_APIK_CLOSE_BUTTON}
    ## double check if the admin user has been created ##
    sleep  2
    Open Toggle Button     REST API Administrator
    ${name_entry}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_ADMINISTRATORS_TABLE_NAME_ENTRY}   ${admin_rest_username}
    Wait Until Element Is Visible    ${name_entry}
    Close Toggle Button     REST API Administrator

    [Teardown]   case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate   
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file   ${CURDIR}

