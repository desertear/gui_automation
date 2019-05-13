*** Settings ***
Documentation    Verify the change password function for default 'admin' through CLI
Resource    ../fipscc_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${new_password}    Qa@12345
*** Test Cases ***
780289
    [Documentation]    
    [Tags]    chrome    780289    high
    [Setup]    Run Cli commands in File on Terminal Server    ${FIPSCC_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown
    Login FortiGate    password=${new_password}
    Logout FortiGate
    
*** Keywords ***
case Teardown
    Run Cli commands in File on Terminal Server    ${FIPSCC_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt    password=${new_password}
    write test result to file    ${CURDIR}