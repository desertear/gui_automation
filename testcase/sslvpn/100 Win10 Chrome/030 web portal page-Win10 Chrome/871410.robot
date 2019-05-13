*** Settings ***
Documentation    Verify sslvpn firewall policy SSH/Telnet service options works properly with different groups in sslvpn firewall policy for web mode
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${group1}    tmp_grp1
${group2}    tmp_grp2
${user1}    tmp_user1
${user2}    tmp_user2
${password1}    123456
${password2}    123456
${policy_id_1}    1001
${policy_id_2}    1002
${ssh_host}    ${SSLVPN_SSH_HOST}
${ssh_username}    ${SSLVPN_SSH_USERNAME}
${ssh_password}    ${SSLVPN_SSH_PASSWORD}
${telnet_host}    ${SSLVPN_TELNET_HOST}
${telnet_username}    ${SSLVPN_TELNET_USERNAME}
${telnet_password}    ${SSLVPN_TELNET_PASSWORD}
*** Test Cases ***
871410
    [Tags]    v6.0    firefox    chrome    edge    safari    871410    high    win10,64bit
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login SSLVPN Portal    username=${user1}    password=${password1}
    ${status}=    run keyword and return status    quick connection of ssh    ${ssh_host}    ${ssh_username}    ${ssh_password}
    should be true    ${status}
    run keyword and ignore error    Logout SSLVPN Portal
    close all browsers
    Login SSLVPN Portal    username=${user1}    password=${password1}
    ${status}=    run keyword and return status    quick connection of telnet    ${telnet_host}    ${telnet_username}    ${telnet_password}
    should not be true    ${status}    
    run keyword and ignore error    Logout SSLVPN Portal
    close all browsers
    Login SSLVPN Portal    username=${user2}    password=${password2}
    ${status}=    run keyword and return status    quick connection of telnet    ${telnet_host}    ${telnet_username}    ${telnet_password}
    should be true    ${status}
    run keyword and ignore error    Logout SSLVPN Portal
    close all browsers
    Login SSLVPN Portal    username=${user2}    password=${password2}
    ${status}=    run keyword and return status    quick connection of ssh    ${ssh_host}    ${ssh_username}    ${ssh_password}
    should not be true    ${status}
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}