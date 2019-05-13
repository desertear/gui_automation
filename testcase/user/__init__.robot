*** Settings ***
Documentation    GUI automation for User feature
Resource    ./user_resource.robot
Suite Setup    Setup User Testing Environment
Suite teardown    clear User test data
Test Timeout    ${USER_MAX_RUNNING_TIME}
Force Tags    user

*** Variables ***

*** Keywords ***
Setup User testing environment
    Run Cli commands in File on Terminal Server    ${USER_CLI_FILE_DIR}${/}user_setup_cli.txt

clear User test data
    Run Cli commands in File on Terminal Server    ${USER_CLI_FILE_DIR}${/}user_teardown_cli.txt
