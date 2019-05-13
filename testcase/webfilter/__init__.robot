*** Settings ***
Documentation    GUI automation for DLP feature
Resource    ./webfilter_resource.robot
#Suite Setup    Setup DLP Testing Environment
##Suite teardown    Clean DLP Testing Environment
Test Timeout    5 min
Force Tags    WEBFILTER

*** Variables ***

*** Keywords ***
#Setup DLP Testing Environment
    #${browser_fgt_lower}=    Convert To Lowercase    ${FGT_BROWSER}
#    Run Cli commands in File on Terminal Server    ${DLP_CLI_FILE_DIR}${/}dlp_setup_cli.txt

#Clean DLP Testing Environment
#    Run Cli commands in File on Terminal Server    ${DLP_CLI_FILE_DIR}${/}dlp_teardown_cli.txt
