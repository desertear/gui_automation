*** Settings ***
Documentation    GUI automation for IPS feature
Resource    ./ips_resource.robot
#Suite Setup    Setup IPS Testing Environment
Suite teardown    Clean IPS Testing Environment
Test Timeout    5 min
Force Tags    IPS

*** Variables ***

*** Keywords ***
Setup IPS Testing Environment
    #${browser_fgt_lower}=    Convert To Lowercase    ${FGT_BROWSER}
    #Run Cli commands in File on Terminal Server    ${IPS_CLI_FILE_DIR}${/}ips_setup_cli.txt

Clean IPS Testing Environment
    Run Cli commands in File on Terminal Server    ${IPS_CLI_FILE_DIR}${/}ips_teardown_cli.txt
