*** Settings ***
Documentation    Rdp service works normally in sslvpn ipv6 web mode.
Library    SikuliLibrary    mode=NEW
Resource    ../../sslvpn_resource.robot
Suite Setup    begin 731864 test
Suite Teardown    clear up

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${url_ipv6}    ${SSLVPN_URL_V6}
${rdp_host}    [${SSLVPN_RDP_HOST_V6}]
${rdp_port}    ${SSLVPN_RDP_PORT}
${rdp_username}    ${SSLVPN_RDP_USERNAME}
${rdp_password}    ${SSLVPN_RDP_PASSWORD}
${image_dir}    ${SIKULI_IMAGE_DIR}${/}rdp

*** Test Cases ***
731864
    [Tags]    v6.0    chrome    firefox    edge    safari    731864    high    win10,64bit    special_env
    Login SSLVPN Portal    url=${url_ipv6}
    quick connection of rdp   ${rdp_host}    ${rdp_port}    ${image_dir}
    ...    username=${rdp_username}    password=${rdp_password}
    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***
begin 731864 test
    Start Sikuli Process
    Set Library Search Order    SeleniumLibrary    SikuliLibrary

clear up
    run keyword and ignore error    Logout SSLVPN Portal
    run keyword and ignore error    Delete All Cookies
    run keyword and ignore error    close browser
    run keyword and ignore error    Stop Remote Server
