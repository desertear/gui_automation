*** Settings ***
Documentation    Verify that VNC bookmark can be created and VNC over SSL works in Web App mode.
...    Action:
...    1. create VNC bookmark in portal
...    2. useruser groupbookmarks, choose group.
...    3. login ssl portal
...    Expect: vnc application works normally
Library    SikuliLibrary    mode=NEW
Resource    ../../sslvpn_resource.robot
Suite Setup    begin 593254 test
Suite Teardown    clear up

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${browser}    firefox
${vnc_host}    ${SSLVPN_VNC_HOST}
${vnc_port}    ${SSLVPN_VNC_PORT}
${vnc_connection_password}    ${SSLVPN_VNC_PASSWORD}
${vnc_password}    ${SSLVPN_VNC_PASSWORD}
${bookmark_name}    vnc_automation
${bookmark_description}    automation test for bookmark ${bookmark_name}
${image_dir}    ${SIKULI_IMAGE_DIR}${/}vnc
*** Test Cases ***
593254
    [Tags]   no_grid    v6.0    firefox    593254    medium    win10,64bit
    Login SSLVPN Portal    browser=${browser}
    create bookmark for vnc    ${bookmark_name}    ${vnc_host}    ${vnc_port}    ${bookmark_description}    ${vnc_connection_password}
    open and check vnc bookmark    ${bookmark_name}    ${vnc_host}    ${image_dir}
    [Teardown]    case Teardown    ${bookmark_name}

*** Keywords ***
begin 593254 test
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