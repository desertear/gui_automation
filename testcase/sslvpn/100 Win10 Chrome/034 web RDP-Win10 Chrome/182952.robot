*** Settings ***
Documentation    Verify quick connection the RDP tool works properly
...    Action:
...    1. Log into SSL VPN portal
...    2. choose file sharing tool, input target server ip. Click \'go\'
...    Expect:
...    A window display target server\'s shared directories.
Library    SikuliLibrary    mode=NEW
Resource    ../../sslvpn_resource.robot
Suite Setup    begin 182952 test
Suite Teardown    clear up

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${rdp_host}    ${SSLVPN_RDP_HOST}
${rdp_port}    ${SSLVPN_RDP_PORT}
${rdp_username}    ${SSLVPN_RDP_USERNAME}
${rdp_password}    ${SSLVPN_RDP_PASSWORD}
${image_dir}    ${SIKULI_IMAGE_DIR}${/}rdp

*** Test Cases ***
182952
    [Tags]    v6.0    chrome    firefox    edge    safari    182952    high    win10,64bit
    Login SSLVPN Portal
    quick connection of rdp   ${rdp_host}    ${rdp_port}    ${image_dir}
    ...    username=${rdp_username}    password=${rdp_password}
    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***
begin 182952 test
    Start Sikuli Process
    Set Library Search Order    SeleniumLibrary    SikuliLibrary

clear up
    run keyword and ignore error    Logout SSLVPN Portal
    run keyword and ignore error    Delete All Cookies
    run keyword and ignore error    close browser
    run keyword and ignore error    Stop Remote Server
