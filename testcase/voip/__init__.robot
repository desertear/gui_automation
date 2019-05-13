*** Settings ***
Documentation    GUI automation for VOIP feature
Resource    ./voip_resource.robot
Suite Setup    Setup VOIP Testing Environment
Suite teardown    Clean VOIP Testing Environment
Test Timeout    5 min
Force Tags    VOIP

*** Variables ***

*** Keywords ***
Setup VOIP Testing Environment
    #${browser_fgt_lower}=    Convert To Lowercase    ${FGT_BROWSER}
    Run Cli commands in File on Terminal Server    ${VOIP_CLI_FILE_DIR}${/}voip_setup_cli.txt

Clean VOIP Testing Environment
    Run Cli commands in File on Terminal Server    ${VOIP_CLI_FILE_DIR}${/}voip_teardown_cli.txt
