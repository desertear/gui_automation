*** Settings ***
Documentation    Verify quick connection the VNC tool works properly
...    Action:
...    1. Log into SSL VPN portal
...    2. choose vnc tool, input target server ip. Click \'go\'
...    Expect:
...    Target server\'s desktop displays
Library    SikuliLibrary    mode=NEW
Resource    ../../sslvpn_resource.robot
Suite Setup    begin 874179 test
Suite Teardown    clear up

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${browser}    ${SSLVPN_BROWSER}
${vnc_host}    ${SSLVPN_VNC_HOST}
${vnc_port}    ${SSLVPN_VNC_PORT}
${vnc_connection_password}    ${SSLVPN_VNC_PASSWORD}
${bookmark_name}    vnc_automation
${bookmark_description}    automation test for bookmark ${bookmark_name}
${image_dir}    ${SIKULI_IMAGE_DIR}${/}vnc
${msg1}    SSL web application activated
${msg2}    SSL web application closed
&{cli_dic1}    message=${msg1}
&{cli_dic2}    message=${msg2}

*** Test Cases ***
874179
    [Tags]    v6.0    chrome    firefox    Edge    safari    874179    Medium    win10,64bit
        # clean previous logs
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}sslvpn_log_delete_cli.txt
    Login SSLVPN Portal    browser=${browser}
    create bookmark for vnc    ${bookmark_name}    ${vnc_host}    ${vnc_port}    ${bookmark_description}    ${vnc_connection_password}
    open vnc bookmark    ${bookmark_name}    ${vnc_host}    ${image_dir}
    run keyword and ignore error   close window
    run keyword and ignore error    Select window    MAIN
    delete bookmark by name if it exists    ${bookmark_name}
    run keyword and ignore error    Logout SSLVPN Portal
    sleep    30s
    # check application activated log
    @{responses1}=   Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}sslvpn_log_event_check_cli.txt    &{cli_dic1}
    ${response1}=    set variable    @{responses1}[-1]
    should match regexp    ${response1}    reason="vnc"
    # check application closed log
    @{responses2}=   Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}sslvpn_log_event_check_cli.txt    &{cli_dic2}
    ${response2}=    set variable    @{responses2}[-1]
    should match regexp    ${response2}    reason="vnc"
    [Teardown]    case Teardown

*** Keywords ***
begin 874179 test
    Start Sikuli Process
    Set Library Search Order    SeleniumLibrary    SikuliLibrary

clear up
    run keyword and ignore error    Logout SSLVPN Portal
    run keyword and ignore error    Delete All Cookies
    run keyword and ignore error    close browser
    run keyword and ignore error    Stop Remote Server

case Teardown
    write test result to file    ${CURDIR}