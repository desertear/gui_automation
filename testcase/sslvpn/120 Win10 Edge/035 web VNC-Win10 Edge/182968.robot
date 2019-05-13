*** Settings ***
Documentation    Verify that the VNC tool works properly
...    Action:
...    1. create VNC bookmark in portal
...    2.  choose vnc tool, input target server ip. Click \'go\'
...    Expect: Target server\'s desktop displays
Library    SikuliLibrary    mode=NEW
Resource    ../../sslvpn_resource.robot
Suite Setup    begin 182968 test
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
182968
    [Tags]    v6.0    no_grid    chrome    edge    firefox    safari    182968    medium    win10,64bit
    Login SSLVPN Portal    browser=${browser}
    create bookmark for vnc    ${bookmark_name}    ${vnc_host}    ${vnc_port}    ${bookmark_description}    ${vnc_connection_password}
    open and check vnc bookmark    ${bookmark_name}    ${vnc_host}    ${image_dir}
    [Teardown]    case Teardown    ${bookmark_name}

*** Keywords ***
begin 182968 test
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