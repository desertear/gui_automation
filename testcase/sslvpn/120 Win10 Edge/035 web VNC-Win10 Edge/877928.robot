*** Settings ***
Documentation    Verify quick connection the VNC tool works properly
...    Action:
...    1. Log into SSL VPN portal
...    2. choose vnc tool, input target server ip. Click \'go\'
...    Expect:
...    Target server\'s desktop displays
Library    SikuliLibrary    mode=NEW
Resource    ../../sslvpn_resource.robot
Suite Setup    begin 877928 test
Suite Teardown    clear up

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${vnc_host}    ${SSLVPN_VNC_HOST}
${vnc_port}    ${SSLVPN_VNC_PORT}
${vnc_connection_password}    ${SSLVPN_VNC_PASSWORD}
${vnc_password}    ${SSLVPN_VNC_PASSWORD}
${image_dir}    ${SIKULI_IMAGE_DIR}${/}vnc

*** Test Cases ***
877928
    [Tags]    v6.0    chrome    firefox    edge    safari    877928    high    win10,64bit
    Login SSLVPN Portal
    quick connection of vnc   ${vnc_host}    ${vnc_port}    ${image_dir}
    ...    connection_password=${vnc_connection_password}    password=${vnc_password}
    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***
begin 877928 test
    Start Sikuli Process
    Set Library Search Order    SeleniumLibrary    SikuliLibrary

clear up
    run keyword and ignore error    Logout SSLVPN Portal
    run keyword and ignore error    Delete All Cookies
    run keyword and ignore error    close browser
    run keyword and ignore error    Stop Remote Server
