*** Settings ***
Documentation    Verify sslvpn firewall policy RDP/VNC service options works properly with different groups in sslvpn firewall policy for web mode
Resource    ../../sslvpn_resource.robot
Library    SikuliLibrary    mode=NEW
Suite Setup    begin 871409 test
Suite Teardown    clear up

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
${rdp_host}    ${SSLVPN_RDP_HOST}
${rdp_port}    ${SSLVPN_RDP_PORT}
${rdp_username}    ${SSLVPN_RDP_USERNAME}
${rdp_password}    ${SSLVPN_RDP_PASSWORD}
${rdp_image_dir}    ${SIKULI_IMAGE_DIR}${/}rdp
${vnc_host}    ${SSLVPN_VNC_HOST}
${vnc_port}    ${SSLVPN_VNC_PORT}
${vnc_connection_password}    ${SSLVPN_VNC_PASSWORD}
${vnc_password}    ${SSLVPN_VNC_PASSWORD}
${vnc_image_dir}    ${SIKULI_IMAGE_DIR}${/}vnc
*** Test Cases ***
871409
    [Timeout]    10 min
    [Tags]    v6.0    firefox    chrome    edge    safari    871409    high    win10,64bit
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login SSLVPN Portal    username=${user1}    password=${password1}
    ${status}=    run keyword and return status    quick connection of rdp   ${rdp_host}    ${rdp_port}    ${rdp_image_dir}    username=${rdp_username}    password=${rdp_password}
    should be true    ${status}
    run keyword and ignore error    Logout SSLVPN Portal
    close all browsers
    Login SSLVPN Portal    username=${user1}    password=${password1}
    ${status}=    run keyword and return status    quick connection of vnc   ${vnc_host}    ${vnc_port}    ${vnc_image_dir}    connection_password=${vnc_connection_password}    password=${vnc_password}
    should not be true    ${status}    
    run keyword and ignore error    Logout SSLVPN Portal
    close all browsers
    Login SSLVPN Portal    username=${user2}    password=${password2}
    ${status}=    run keyword and return status    quick connection of vnc   ${vnc_host}    ${vnc_port}    ${vnc_image_dir}    connection_password=${vnc_connection_password}    password=${vnc_password}
    should be true    ${status}
    run keyword and ignore error    Logout SSLVPN Portal
    close all browsers
    Login SSLVPN Portal    username=${user2}    password=${password2}
    ${status}=    run keyword and return status    quick connection of rdp   ${rdp_host}    ${rdp_port}    ${rdp_image_dir}    username=${rdp_username}    password=${rdp_password}
    should not be true    ${status}
    [Teardown]    case Teardown

*** Keywords ***
begin 871409 test
    Start Sikuli Process
    Set Library Search Order    SeleniumLibrary    SikuliLibrary

clear up
    run keyword and ignore error    Logout SSLVPN Portal
    run keyword and ignore error    Delete All Cookies
    run keyword and ignore error    close all browsers

case Teardown
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}