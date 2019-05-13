*** Settings ***
Documentation    GUI automation for Application feature
Resource    ./app_resource.robot
Suite Setup    Setup Application Testing Environment
Suite teardown    Clean Application Testing Environment
Test Timeout    5 min
Force Tags    Application

*** Variables ***

*** Keywords ***
Setup Application Testing Environment
    ${browser_fgt_lower}=    Convert To Lowercase    ${FGT_BROWSER}
    Run Cli commands in File on Terminal Server    ${APP_CLI_FILE_DIR}${/}app_setup_cli.txt

Clean Application Testing Environment
    Run Cli commands in File on Terminal Server    ${APP_CLI_FILE_DIR}${/}app_teardown_cli.txt
