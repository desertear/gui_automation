*** Settings ***
Documentation    Verify GUI TACACS+ server pages test button work well (bug #128289)
Resource    ../user_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${tacacs_name}    ${USER_TACPLUS_NAME}
${tacacs_server}    ${USER_TACPLUS_SERVER}
${tacacs_secret}    ${USER_TACPLUS_KEY}
*** Test Cases ***
744804
    [Tags]    v6.2    chrome    744804    high
    [setup]    Run Cli commands in File on Terminal Server    ${USER_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login FortiGate
    Create New TACACS Server    ${tacacs_name}    Auto
    ...    ${tacacs_server}    ${tacacs_secret}
    Edit Tacacs Server    ${tacacs_name}    Test    OK
    Delete TACACS Server  ${tacacs_name}
    Logout FortiGate
    Close Browser
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Run Cli commands in File on Terminal Server    ${USER_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}