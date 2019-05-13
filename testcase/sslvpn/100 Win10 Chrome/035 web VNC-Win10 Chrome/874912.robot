*** Settings ***
Documentation    Verify quick connection the VNC tool works properly
...    Action:
...    1. Log into SSL VPN portal
...    2. choose vnc tool, input target server ip. Click \'go\'
...    Expect:
...    Target server\'s desktop displays
Library    SikuliLibrary    mode=NEW
Resource    ../../sslvpn_resource.robot
Suite Setup    begin 874912 test
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

*** Test Cases ***
874912
    [Tags]    v6.0    chrome     firefox    874912    Medium    win10,64bit
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
    # check traffic log
    @{responses1}=   Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}sslvpn_log_traffic_check_cli.txt
    ${response1}=    set variable    @{responses1}[-1]
    should match regexp    ${response1}    service="tcp/${SSLVPN_VNC_PORT}"

    [Teardown]    case Teardown    ${bookmark_name}

*** Keywords ***
begin 874912 test
    Start Sikuli Process
    Set Library Search Order    SeleniumLibrary    SikuliLibrary

clear up
    run keyword and ignore error    Logout SSLVPN Portal
    run keyword and ignore error    Delete All Cookies
    run keyword and ignore error    close browser
    run keyword and ignore error    Stop Remote Server

case Teardown
    [Arguments]    ${name}
    run keyword and ignore error    delete bookmark by name    ${name}
    write test result to file    ${CURDIR}