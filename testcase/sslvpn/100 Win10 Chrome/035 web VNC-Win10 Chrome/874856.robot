*** Settings ***
Documentation    Verify two users connect to sslvpn web portal, could VNC to different VNC servers
...    Action:
...    1. create VNC bookmark in portal
...    2.  choose vnc tool, input target server ip. Click \'go\', keep the vnc connection
...    3. login sslvpn using another user
...    4. connect to defferent vnc server
...    Expect: Target server\'s desktop displays
Library    SikuliLibrary    mode=NEW
Resource    ../../sslvpn_resource.robot
Suite Setup    begin 874856 test
Suite Teardown    clear up

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${username}    ${SSLVPN_GUI_USERNAME}
${password}    ${SSLVPN_GUI_PASSWORD}
${username2}    ${SSLVPN_GUI_USERNAME2}
${password2}    ${SSLVPN_GUI_PASSWORD2}

${vnc_host}    ${SSLVPN_VNC_HOST}
${vnc_port}    ${SSLVPN_VNC_PORT}
${vnc_connection_password}    ${SSLVPN_VNC_PASSWORD}
${bookmark_name}    vnc_automation
${bookmark_description}    automation test for bookmark ${bookmark_name}
${image_dir}    ${SIKULI_IMAGE_DIR}${/}vnc
${vnc_host2}    ${SSLVPN_LINUX_SERVER2}

*** Test Cases ***
874856
    [Tags]    v6.0    no_grid    chrome   firefox     874856    high    win10,64bit
    ${old_browser}=    Login SSLVPN Portal    username=${username}    password=${password}
    # create vnc bookmark
    create bookmark for vnc    ${bookmark_name}    ${vnc_host}    ${vnc_port}    ${bookmark_description}    ${vnc_connection_password}
    # open vnc bookmark and keep it
    open vnc bookmark    ${bookmark_name}    ${vnc_host}    ${image_dir}

    # login sslvpn portal with user2, quick connect to same web url
    Login SSLVPN Portal    username=${username2}    password=${password2}
    create bookmark for vnc    ${bookmark_name}    ${vnc_host2}    ${vnc_port}    ${bookmark_description}    ${vnc_connection_password}
    # open vnc bookmark and keep it
    open vnc bookmark    ${bookmark_name}    ${vnc_host2}    ${image_dir}
    run keyword and ignore error   close window
    run keyword and ignore error    Select window    MAIN
    delete bookmark by name if it exists    ${bookmark_name}
    run keyword and ignore error    Logout SSLVPN Portal
    # switch back to first login
    run keyword and ignore error    switch browser    ${old_browser}
    run keyword and ignore error    close window
    run keyword and ignore error    Select window    MAIN
    delete bookmark by name if it exists    ${bookmark_name}
    run keyword and ignore error    Logout SSLVPN Portal
    [Teardown]    case Teardown    ${bookmark_name}

*** Keywords ***
begin 874856 test
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