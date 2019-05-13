*** Settings ***
Documentation    Verify that group VNC bookmark works properly
...    Action:
...    1. create group VNC bookmark
...    2. useruser groupbookmarks, choose group.
...    3. login ssl portal
...    Expect: vnc application works normally
Library    SikuliLibrary    mode=NEW
Resource    ../../sslvpn_resource.robot
Suite Setup    begin 877930 test
Suite Teardown    clear up

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${bookmark_name}    bookmark_vnc
${vnc_host}    ${SSLVPN_VNC_HOST}
${vnc_port}    ${SSLVPN_VNC_PORT}
${vnc_connection_password}    ${SSLVPN_VNC_PASSWORD}
${vnc_password}    ${SSLVPN_VNC_PASSWORD}
${image_dir}    ${SIKULI_IMAGE_DIR}${/}vnc

*** Test Cases ***
877930
    [Tags]      no_grid    v6.0    chrome    firefox    edge    safari    877930    critical    win10,64bit    macos
    Login SSLVPN Portal
    open and check vnc bookmark    ${bookmark_name}    ${vnc_host}    ${image_dir}    if_predefined=${True}
    [Teardown]    case Teardown

*** Keywords ***
begin 877930 test
    Start Sikuli Process
    Set Library Search Order    SeleniumLibrary    SikuliLibrary

clear up
    run keyword and ignore error    Logout SSLVPN Portal
    run keyword and ignore error    Delete All Cookies
    run keyword and ignore error    close browser
    run keyword and ignore error    Stop Remote Server

case Teardown
    [Arguments]
    write test result to file    ${CURDIR}