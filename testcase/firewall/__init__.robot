*** Settings ***
Documentation    GUI automation for Firewall feature
Resource    ./fw_resource.robot
#Suite Setup    Setup Firewall Testing Environment
#Suite teardown    Clean Firewall Testing Environment
Test Timeout    ${FGT_MAX_RUNNING_TIME}
Force Tags    firewall

*** Variables ***

*** Keywords ***
Terminate Test When Run CLI Commands Fail
    [Arguments]    ${response} 
    ${length}=    Get Length    ${response}
    :FOR    ${index}    IN RANGE    ${length}
    \    ${return}=    Set variable    @{response}[${index}]
    \    Should Not Contain    ${return}    Command fail

Setup Firewall Testing Environment
    Align FortiGates
    @{response}=    Create List
    ${response}=     Run Cli commands in File on Terminal Server    ${FW_CLI_FILE_DIR}${/}fw_setup_access.txt
    #Terminate Test When Run CLI Commands Fail    ${response} 
    sleep    10   

    ${response}=     Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}fw_setup_cli.txt
    #Terminate Test When Run CLI Commands Fail    ${response}    

Clean Firewall Testing Environment
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}fw_teardown_cli.txt
    Run Cli commands in File on Terminal Server    ${FW_CLI_FILE_DIR}${/}fw_teardown_access.txt
