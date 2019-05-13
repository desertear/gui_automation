*** Settings ***
Documentation    Verify sslvpn web mode SSH connection would NOT idle timeout (458964)
...    Action:
...     1. Log into SSL VPN portal
...     2. Connect SSH bookmark
...     3. wait for 5 minutes
...    Expect:
...    SSH connection is not timeout
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${ssh_host}    ${SSLVPN_SSH_HOST}
${ssh_username}    ${SSLVPN_SSH_USERNAME}
${ssh_password}    ${SSLVPN_SSH_PASSWORD}
${waiting_time}    5 minutes 10 seconds
*** Test Cases ***
877937
    [Tags]    v6.0    chrome    firefox    edge    safari    877937    medium    win10,64bit
    [Timeout]    10 minutes
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}sslvpn_idle_timeout_setup_cli.txt
    Login SSLVPN Portal
    click button    ${PORTAL_QUICK_CONNECTION_BUTTON}
    click element    ${QUICK_SSH_LABEL}
    input text    ${QUICK_SSH_HOST_TEXT}    ${ssh_host}
    #record opened windows
    ${exclude}=    Get window handles
    click button    ${QUICK_LAUNCH_BUTTON}
    ${older_window}=    Select window    ${exclude}
    Wait Until element is Visible    ${QUICK_SSH_HEAD}
    input text    ${QUICK_SSH_USERNAME_TEXT}    ${ssh_username}
    input text    ${QUICK_SSH_PASSWORD_PASSWORD}    ${ssh_password}
    click button    ${QUICK_SSH_LOGIN_BUTTON}
    select frame    ${QUICK_SSH_IFRAME}
    Wait Until keyword Succeeds    5x    ${SELENIUM_TIMEOUT}    Current Frame Should Contain    Welcome to Ubuntu
    # wait Until page contains element    xpath://x-row[contains(text(),"Welcome to Ubuntu")]
    ##check FGT monitor info using FGT GUI
    ${browser_index}=    connection check    ${SSLVPN_GUI_USERNAME}    SSH    ${ssh_host}
    #switch to previous broswer which is used to operate SSLVPN GUI
    switch browser    ${browser_index-1}
    #sleep more than 5 minutes
    sleep     ${waiting_time}
    ##check FGT monitor info using FGT GUI again
    ${browser_index}=    connection check    ${SSLVPN_GUI_USERNAME}    SSH    ${ssh_host}
    #switch to previous broswer which is used to operate SSLVPN GUI
    switch browser    ${browser_index-2}
    #close SSH connection window
    close window
    [Teardown]    case Teardown    ${older_window}

*** Keywords ***
case Teardown
    [Arguments]    ${older_window}
    run keyword and ignore error    switch back to ssl vpn portal    ${older_window}
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}sslvpn_idle_timeout_teardown_cli.txt
    write test result to file    ${CURDIR}