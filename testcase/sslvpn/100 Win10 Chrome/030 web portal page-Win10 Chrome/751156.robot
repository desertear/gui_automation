*** Settings ***
Documentation    Verify login history entry can be shown normally if logs are stored in forticloud.
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
@{cli_cmd}    execute log delete-all

*** Test Cases ***
751156
    [Tags]    v6.0    firefox    chrome    edge    safari    751156    high    win10,64bit
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    ##wait until the connection with FGD is established.
    Wait Until FortiGuard is connected
    sleep    60s
    #clean previous logs
    Execute CLI commands on FortiGate Via Direct Telnet    commands=${cli_cmd}
    Login SSLVPN Portal
    ${num_his_old}=    number of history records
    Logout SSLVPN Portal
    sleep    120s
    Login SSLVPN Portal
    ${num_his_newer}=    number of history records
    #should be equal as integers    ${num_his_old+1}    ${num_his_newer}
    #since it is not be able to delete logs from forticloud, it will be true if sslvpn history is not zero
    should be true    ${num_his_newer}
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}

