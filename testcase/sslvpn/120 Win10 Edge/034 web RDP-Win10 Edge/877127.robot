*** Settings ***
Documentation    Verify SSL VPN RDP bookmark requires user name for RDP security method NLA, but password can be empty
Library    SikuliLibrary    mode=NEW
Resource    ../../sslvpn_resource.robot
Suite Setup    begin 877127 test
Suite Teardown    clear up

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${browser}    ${SSLVPN_BROWSER}
${host}    ${SSLVPN_RDP_HOST}
${port}    ${SSLVPN_RDP_PORT}
${username}    ${SSLVPN_RDP_USERNAME}
${password}    ${SSLVPN_RDP_PASSWORD}
${bookmark_name}    rdp_automation
${bookmark_description}    automation test for bookmark ${bookmark_name}
${image_dir}    ${SIKULI_IMAGE_DIR}${/}rdp
*** Test Cases ***
877127
    [Tags]    no_grid     v6.0    firefox   chrome    edge    safari    877127    high    win10,64bit
    Login SSLVPN Portal    browser=${browser}
    create bookmark for rdp    ${bookmark_name}    ${host}    ${port}    ${bookmark_description}
    ...    username=${username}    security=network
    open and check rdp bookmark    ${bookmark_name}    ${host}    ${image_dir}    password=${password}
    [Teardown]    case Teardown    ${bookmark_name}

*** Keywords ***
begin 877127 test
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