*** Settings ***
Documentation    Verify enforce minimum word for admin user GUI
Resource    ../fipscc_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***

*** Test Cases ***
730933
    [Documentation]    
    [Tags]    chrome    730933    critical
    [Teardown]    case Teardown
    Login FortiGate
    Go to system
    ${vdom1}=    create list   ${FIPSCC_TEST_VDOM_NAME_1}
    ${vdom2}=    create list   ${FIPSCC_TEST_VDOM_NAME_2}
    ${vdom3}=    create list   ${FIPSCC_TEST_VDOM_NAME_TP}
    #use all digits as password
    Go to System_administrators
    ${status}=    Run keyword and return status    Create Administrator    admin1    12345678    vdom=${vdom1}
    Should be True    not ${status}
    #use all letters as password
    Go to System_administrators
    ${status}=    Run keyword and return status    Create Administrator    admin2    abcdefgh    vdom=${vdom2}
    Should be True    not ${status}
    #no special chars
    Go to System_administrators
    ${status}=    Run keyword and return status    Create Administrator    admin3    1234efgh    vdom=${vdom3}
    Should be True    not ${status}
    #shorter than 8 chars
    Go to System_administrators
    ${status}=    Run keyword and return status    Create Administrator    admin4    Zj#1234    vdom=${vdom1}
    Should be True    not ${status} 
    #no Upper case letters
    Go to System_administrators
    ${status}=    Run keyword and return status    Create Administrator    admin5    zj#12345    vdom=${vdom2}
    Should be True    not ${status}
    #no Lower case letters
    Go to System_administrators
    ${status}=    Run keyword and return status    Create Administrator    admin6    ZJ#12345    vdom=${vdom3}
    Should be True    not ${status}
    #use correct password    
    Go to System_administrators
    ${status}=    Run keyword and return status    Create Administrator    admin7    Zj#12345    vdom=${vdom1}
    Should be True    ${status}
    Logout FortiGate
    Close Browser
    Login FortiGate    username=admin7    password=Zj#12345
    Logout FortiGate    admin7
    
*** Keywords ***
case Teardown
    Run Cli commands in File on Terminal Server    ${FIPSCC_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}