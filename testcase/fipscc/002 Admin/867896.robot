*** Settings ***
Documentation    Verify the change should be logged when a admin user change his own password in CLI(0487733)
Resource    ../fipscc_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
@{cmds}    config vdom
...    edit ${FIPSCC_TEST_VDOM_NAME_1}
...    execute log filter category 1
...    execute log filter field logid 0100044547
...    execute log display
${new_password}    Qa@12345
*** Test Cases ***
867896
    [Documentation]    
    [Tags]    chrome    867896    high
    [Setup]    Run Cli commands in File on Terminal Server    ${FIPSCC_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    ${response}=    Execute CLI commands on FortiGate Via Terminal Server    ${cmds}    password=${new_password}
    Should Match Regexp    @{response}[-1]    cfgattr="password\\[\\*\\].*msg="Edit system\\.admin admin"
    [Teardown]    case Teardown
 
    
*** Keywords ***
case Teardown
    Run Cli commands in File on Terminal Server    ${FIPSCC_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt    password=${new_password}
    write test result to file    ${CURDIR}