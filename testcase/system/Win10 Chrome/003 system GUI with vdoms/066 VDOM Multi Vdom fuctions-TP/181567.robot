*** Settings ***
Documentation    To verify policies could be created and displayed per virtual domain in GUI.
Resource    ../../../system_resource.robot

*** Variables ***
${test_policy_name}   181567
${test_intf}     ${SYSTEM_TEST_INTF_3}
*** Test Cases ***
181567
    [Tags]    v6.0    chrome   181567   Critical     win10,64bit    browsers    runable   rest
    [setup]    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login FortiGate     
    Go To Vdom     ${SYSTEM_TEST_VDOM_NAME_tp}   
    Go to policy and objects
    Go to IPv4 policy
    system create ipv4 policy   ${test_policy_name}    ${test_intf}    ${test_intf}
    wait and click    ${SYSTEM_POLICY_IPV4_POLICY_EDITBY_SEQUENCE_BUTTON}
    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_POLICY_IPV4_POLICY_EDIT-ENTRY}    ${test_policy_name}
    Wait Until Element Is Visible     ${new_locator}
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    Close All Browsers
    write test result to file    ${CURDIR}

