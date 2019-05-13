*** Settings ***
Documentation   Verify GUI display Virtual Wire Pair Policy separately(IPV4/IPV6)
Resource    ../../../system_resource.robot

*** Variables ***


*** Test Cases ***
807207
    [Documentation]    
    [Tags]    v6.0    chrome   807207    High    win10,64bit    runable
    [setup]    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    login FortiGate
    Go to network
    Go to network_Interfaces
    sleep    2
    Capture Page Screenshot 
    sleep    2
    Go to system
    go to system_feature visibility
    enable_FGT_feature_noRC  IPv6
    Reload Page
    Go To Vdom     ${SYSTEM_TEST_VDOM_NAME_1}
    Go to policy and objects
    Wait Until Element Is Visible   ${NETWORK_POLICY_IPV4_VWP}
    Wait Until Element Is Visible   ${NETWORK_POLICY_IPV6_VWP}
    sleep   2
    [teardown]    case teardown
 
*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file   ${CURDIR}
