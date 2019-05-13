*** Settings ***
Documentation   Verify GUI hidden accprofile: admin_no_access and super_admin_readonly profile (0547413)	
Resource    ../../../system_resource.robot

*** Variables ***

*** Test Cases ***
890582
    [Tags]      v6.0    chrome   890582    low    win10,64bit    browsers    runable   test12
    Login FortiGate
    Go to system
    go to system_admin_profiles
    ${name_entry}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_ADMIN_PROFILE_TABLE_NAME_ENTRY}    admin_no_access
    ${exist}=    run keyword and return status    Wait Until Element Is Visible    ${name_entry}
    should be equal    "${exist}"    "False"
    ${name_entry}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_ADMIN_PROFILE_TABLE_NAME_ENTRY}    super_admin_readonly
    ${exist}=    run keyword and return status    Wait Until Element Is Visible    ${name_entry}
    should be equal    "${exist}"    "False"
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate    
    Close All Browsers
    write test result to file    ${CURDIR}
