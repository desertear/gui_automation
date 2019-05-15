*** Settings ***
Documentation    Verify option "use-management-vdom" works for GUI Radius test page ( #286533)
Resource    ../user_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${radius_name}    ${USER_RADIUS1_NAME}
${radius_server}    ${USER_RADIUS1_SERVER}
${radius_secret}    ${USER_RADIUS1_SECRET}
@{arg}    ${USER_RADIUS1_USER1}    ${USER_RADIUS1_PASSWORD1}    Successful
*** Test Cases ***
800952
    [Tags]    v6.2    chrome    800952    high
    [setup]    Run Cli commands in File on Terminal Server    ${USER_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login FortiGate
    Go to VDOM    ${FGT_VDOM_NAME_1}    Global
    Edit Radius Server    ${radius_name}    Test Connectivity    Successful
    Edit Radius Server    ${radius_name}    Test User Credentials    ${arg}
    Logout FortiGate
    Close Browser
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Run Cli commands in File on Terminal Server    ${USER_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}