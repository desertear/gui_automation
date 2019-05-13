*** Settings ***
Documentation    Verify duration and traffic statistics can be shown normally for SSLVPN web mode
...    Action:
...    1. Create sslvpn related portal, user group and firewall policy.
...    2. Login sslvpn web mode. Then access the servers by using applications such as TELNET and RDP.
...    Expect:
...    In CLI, session statistics for TELNET and RDP can be shown in sslvpn monitor. 
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${ssh_host}    ${SSLVPN_SSH_HOST}
${telnet_host}    ${SSLVPN_TELNET_HOST}
${vnc_host}    ${SSLVPN_VNC_HOST}
${vnc_port}    ${SSLVPN_VNC_PORT}
${vnc_connection_password}    ${SSLVPN_VNC_PASSWORD}
${rdp_host}    ${SSLVPN_RDP_HOST}
${rdp_port}    ${SSLVPN_RDP_PORT}
${rdp_username}    ${SSLVPN_RDP_USERNAME}
${rdp_password}    ${SSLVPN_RDP_PASSWORD}
@{cli_cmds}    get vpn ssl monitor
*** Test Cases ***
754653
    [Tags]    v6.0    chrome    firefox    edge    safari    754653    medium    win10,64bit
    Login SSLVPN Portal
    ##connect to ssh
    click button    ${PORTAL_QUICK_CONNECTION_BUTTON}
    click element    ${QUICK_SSH_LABEL}
    input text    ${QUICK_SSH_HOST_TEXT}    ${ssh_host}
    #record opened windows
    ${exclude}=    Get window handles
    click button    ${QUICK_LAUNCH_BUTTON}
    ${main_window}=    Select window    ${exclude}
    Wait Until element is Visible    ${QUICK_SSH_HEAD}
    ##connect to telnet
    select window    ${main_window}
    click button    ${PORTAL_QUICK_CONNECTION_BUTTON}
    click element    ${QUICK_TELNET_LABEL}
    input text    ${QUICK_TELNET_HOST_TEXT}    ${telnet_host}
    #record opened windows
    ${exclude}=    Get window handles
    click button    ${QUICK_LAUNCH_BUTTON}
    ${ssh_window}=    Select window    ${exclude}
    Wait Until element is Visible    ${QUICK_TELNET_IFRAME}
    select frame    ${QUICK_TELNET_IFRAME}
    Wait Until keyword Succeeds    5x    ${SELENIUM_TIMEOUT}    Current Frame Should Contain    Ubuntu
    # wait Until page contains element    xpath://x-row[contains(text(),"Ubuntu")]    30
    ##connect to VNC
    select window    ${main_window}
    click button    ${PORTAL_QUICK_CONNECTION_BUTTON}
    click element    ${QUICK_VNC_LABEL}
    input text    ${QUICK_VNC_HOST_TEXT}    ${vnc_host}
    input text    ${QUICK_VNC_PORT_TEXT}    ${vnc_port}
    input text    ${QUICK_VNC_PASSWORD_PASSWORD}    ${vnc_connection_password}
    #record opened windows
    ${exclude}=    Get window handles
    click button    ${QUICK_LAUNCH_BUTTON}
    ${telnet_window}=    Select window    ${exclude}
    ##connect to RDP
    select window    ${main_window}
    click button    ${PORTAL_QUICK_CONNECTION_BUTTON}
    click element    ${QUICK_RDP_LABEL}
    input text    ${QUICK_RDP_HOST_TEXT}    ${rdp_host}
    input text    ${QUICK_RDP_PORT_TEXT}    ${rdp_port}
    input text    ${QUICK_RDP_USERNAME_TEXT}    ${rdp_username}
    input text    ${QUICK_RDP_PASSWORD_PASSWORD}    ${rdp_password}
    Select From List By Label    ${QUICK_RDP_SECURITY_SELECT}    Network Level Authentication.
    #record opened windows
    ${exclude}=    Get window handles
    click button    ${QUICK_LAUNCH_BUTTON}
    ${vnc_window}=    Select window    ${exclude}
    sleep    10
    ##check session on CLI
    @{responses}=    Execute CLI commands on FortiGate Via Direct Telnet    commands=${cli_cmds}
    ${response}=    set variable    @{responses}[-1]  
    Should Match Regexp    ${response}    SSH\\s${ssh_host}
    Should Match Regexp    ${response}    TELNET\\s${telnet_host}
    Should Match Regexp    ${response}    VNC\\s${vnc_host}
    Should Match Regexp    ${response}    RDP\\s${rdp_host}
    # ##close newly opened windows one by one   
    select window    MAIN
    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***


