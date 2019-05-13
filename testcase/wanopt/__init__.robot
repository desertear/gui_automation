*** Settings ***
Documentation    GUI automation for WANOPT feature
Resource    ./wanopt_resource.robot
Suite Setup    Setup WANOPT Testing Environment
Suite teardown    Clean WANOPT Testing Environment
Test Timeout    5 min
Force Tags    WANOPT

*** Variables ***

*** Keywords ***
Setup WANOPT Testing Environment
    #${browser_fgt_lower}=    Convert To Lowercase    ${FGT_BROWSER}
    Run Cli commands in File on Terminal Server    ${WANOPT_CLI_FILE_DIR}${/}wanopt_setup_cli.txt

Clean WANOPT Testing Environment
    Run Cli commands in File on Terminal Server    ${WANOPT_CLI_FILE_DIR}${/}wanopt_teardown_cli.txt
