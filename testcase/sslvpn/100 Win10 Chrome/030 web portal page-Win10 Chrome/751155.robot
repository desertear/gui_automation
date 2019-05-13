*** Settings ***
Documentation    Verify login history entry can be shown normally if logs are stored in fortianalyzer.
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot

*** Test Cases ***
751155
    [Tags]    v6.0    firefox    chrome    edge    safari    751155    high    win10,64bit    bug

    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    ##wait until the connection with FAZ is established.
    Wait Until Fortianalyzer is connected
    Login SSLVPN Portal
    ${num_his_old}=    number of history records
    sleep    5s
    Logout SSLVPN Portal
    sleep    30s
    Login SSLVPN Portal
    ${num_his_newer}=    number of history records
    should be equal as integers    ${num_his_old+1}    ${num_his_newer}
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}

