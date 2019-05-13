*** Settings ***
Documentation    Verify ssl vpn user would not logout until timeout after closing browser without normal logout. (174894)
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
@{cli_ssl_monitor}    get vpn ssl monitor
*** Test Cases ***
737177
    [Tags]    v6.0    firefox    chrome    edge    safari    737177    medium    win10,64bit
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login SSLVPN Portal
    close browser
    #close browser
    sleep    10S
    @{responses}=    Execute CLI commands on FortiGate Via Direct Telnet    commands=${cli_ssl_monitor}
    ${response}=    set variable    @{responses}[-1]
    should match regexp    ${response}    ${SSLVPN_GUI_USERNAME}

    # wait for 60S for sslvpn login idle timeout
    sleep    60S
    @{responses}=    Execute CLI commands on FortiGate Via Direct Telnet    commands=${cli_ssl_monitor}
    ${response}=    set variable    @{responses}[-1]
    should not match regexp    ${response}    ${SSLVPN_GUI_USERNAME}

    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}