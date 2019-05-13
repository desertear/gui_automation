*** Settings ***
Documentation    Verify RDP bookmark works when user and password not set for auth type 'Allow the server to choose'
Library    SikuliLibrary    mode=NEW
Resource    ../../sslvpn_resource.robot
Suite Teardown    clear up
Suite Setup    begin 861898 test
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
861898
    [Tags]    no_grid    v6.0    firefox    chrome    edge    safari    861898    high   rdp    win10,64bit
    Login SSLVPN Portal    browser=${browser}
    create bookmark for rdp    ${bookmark_name}    ${host}    ${port}    ${bookmark_description}
    ...    security=server
    open and check rdp bookmark    ${bookmark_name}    ${host}    ${image_dir}    username=${username}    password=${password}
    [Teardown]    case Teardown    ${bookmark_name}

*** Keywords ***
begin 861898 test
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