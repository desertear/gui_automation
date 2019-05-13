*** Settings ***
Documentation    GUI automation for FIPSCC feature
Resource    ./fipscc_resource.robot
Suite Setup    Setup FIPSCC Testing Environment
Suite teardown    clear FIPSCC test data
Test Timeout    10 min
Force Tags    fipscc

*** Variables ***
${old_gui_password}    ${FGT_GUI_PASSWORD}
${old_cli_password}    ${FGT_CLI_PASSWORD}

*** Keywords ***
Setup FIPSCC testing environment
    ##enable FIPSCC Mode
    Run Cli commands in File on Terminal Server    ${FIPSCC_CLI_FILE_DIR}${/}fipscc_pre_setup_cli.txt
    #set password to new password
    set global variable    ${FGT_GUI_PASSWORD}    ${FGT_FIPS_CC_PASSWORD}
    set global variable    ${FGT_CLI_PASSWORD}    ${FGT_FIPS_CC_PASSWORD}
    Run Cli commands in File on Terminal Server    ${FIPSCC_CLI_FILE_DIR}${/}fipscc_setup_cli.txt

clear FIPSCC test data
    Run Cli commands in File on Terminal Server    ${FIPSCC_CLI_FILE_DIR}${/}fipscc_teardown_cli.txt
    #set password back to original one
    set global variable    ${FGT_GUI_PASSWORD}    ${old_gui_password}
    set global variable    ${FGT_CLI_PASSWORD}    ${old_cli_password}


