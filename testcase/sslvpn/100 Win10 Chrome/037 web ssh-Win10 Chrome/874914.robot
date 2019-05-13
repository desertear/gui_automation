*** Settings ***
Documentation    sslvpn web mode HTTP application will generate event logs.
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${ssh_host}    ${SSLVPN_SSH_HOST}
${ssh_username}    ${SSLVPN_SSH_USERNAME}
${ssh_password}    ${SSLVPN_SSH_PASSWORD}

*** Test Cases ***
874914
    [Tags]    v6.0    firefox    chrome    edge    safari    874914    Medium    win10,64bit

    # clean previous logs
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}sslvpn_log_delete_cli.txt
    #connection
    Login SSLVPN Portal
    quick connection of ssh    ${ssh_host}    ${ssh_username}    ${ssh_password}
    Logout SSLVPN Portal
    sleep    30s
    # check traffic log
    @{responses1}=   Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}sslvpn_log_traffic_check_cli.txt
    ${response1}=    set variable    @{responses1}[-1]
    should match regexp    ${response1}    service="SSH"

    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    write test result to file    ${CURDIR}