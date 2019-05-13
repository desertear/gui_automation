*** Settings ***
Documentation    Verify user filter works from GUI
Resource    ../user_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${username1}    user123
${username2}    123456
${username3}    `~!@$%^&*-_=+,./;:
${search_keyword1}       123
${search_keyword2}       se
${search_keyword3}       %^
${search_keyword4}       abc
*** Test Cases ***
747225
    [Tags]    v6.2    chrome    747225    high
    [Setup]    Run Cli commands in File on Terminal Server    ${USER_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login FortiGate
    Search User with keyword    ${search_keyword1}    ${username1}    ${username2}
    Search User with keyword    ${search_keyword2}    ${username1}   
    Search User with keyword    ${search_keyword3}    ${username3}
    Search User with keyword    ${search_keyword4}
    Logout FortiGate
    close browser
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Run Cli commands in File on Terminal Server    ${USER_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}