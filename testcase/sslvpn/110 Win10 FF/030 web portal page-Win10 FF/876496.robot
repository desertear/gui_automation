*** Settings ***
Documentation    Verify able to exclude certain services (i.e., telnet) from being created personal bookmark
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${ping_url}    ${SSLVPN_PING_HOST}
*** Test Cases ***
876496
    [Tags]    v6.0    firefox    chrome    edge    safari    876496    high    win10,64bit
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login SSLVPN Portal
    #the tab "Ping" dispears becuase it's disabled via CLI.
    ${status}=    run keyword and return status    quick connection of ping    ${ping_url}
    Should Be True    "${status}"=="False"
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}