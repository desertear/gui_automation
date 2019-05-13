*** Settings ***
Documentation    GUI automation for LENC feature
Resource    ./LENC_resource.robot
Suite Setup    Setup LENC Testing Environment
Suite teardown    clear LENC test data
Test Timeout    5 min
Force Tags    lenc    norun

*** Variables ***

*** Keywords ***
Setup LENC testing environment
    #check if FGT is using LENC license
    @{cmds_check_license}=    create list    get system status | grep "License Status"
    @{responses}=    Execute CLI commands on FortiGate Via Terminal Server    ${cmds_check_license}
    ${responses_str}=    Convert List to String  ${responses}
    ${if_lenc_license}=    Run keyword and return status    should contain    ${responses_str}    Low-Encryption(LENC)
    #if FGT is not using LENC license, apply LENC license to it.
    @{cmds_change_license}=    create list    execute factory-license ${FGT_LENC_LICENSE}
    Run keyword if    not ${if_lenc_license}    Execute CLI commands on FortiGate Via Terminal Server    ${cmds_change_license} 
    Run keyword if    not ${if_lenc_license}    Align FortiGates  
    Run Cli commands in File on Terminal Server    ${LENC_CLI_FILE_DIR}${/}LENC_setup_cli.txt

clear LENC test data
    #check if FGT is using LENC license
    @{cmds_check_license}=    create list    get system status | grep "License Status"
    @{responses}=    Execute CLI commands on FortiGate Via Terminal Server    ${cmds_check_license}
    ${responses_str}=    Convert List to String  ${responses}
    ${if_lenc_license}=    Run keyword and return status    should contain    ${responses_str}    Low-Encryption(LENC)
    #if FGT is using LENC license, apply Factory license to it.
    @{cmds_change_license}=    create list    execute factory-license ${FGT_FACTORY_LICENSE}
    Run keyword if    ${if_lenc_license}    Execute CLI commands on FortiGate Via Terminal Server    ${cmds_change_license}    