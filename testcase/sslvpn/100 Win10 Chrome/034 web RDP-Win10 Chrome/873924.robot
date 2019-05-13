*** Settings ***
Documentation    Verify two users connect to sslvpn web portal, could RDP to different RDP servers
...    Action:
...    1. user1 login sslvpn web portal
...    2. connect to RDP win2012 and keep open the web
...    3. user2 login sslvpn web portal
...    4. conect to different RDP win2012
...    5. logout
Library    SikuliLibrary    mode=NEW
Resource    ../../sslvpn_resource.robot
Suite Setup    begin 873924 test
Suite Teardown    clear up

*** Variables ***
${username}    ${SSLVPN_GUI_USERNAME}
${password}    ${SSLVPN_GUI_PASSWORD}
${username2}    ${SSLVPN_GUI_USERNAME2}
${password2}    ${SSLVPN_GUI_PASSWORD2}
${host}    ${SSLVPN_RDP_HOST}
${port}    ${SSLVPN_RDP_PORT}
${rdp_username}    ${SSLVPN_RDP_USERNAME}
${rdp_password}    ${SSLVPN_RDP_PASSWORD}
${bookmark_name}    rdp_automation
${bookmark_description}    automation test for bookmark ${bookmark_name}
${image_dir}    ${SIKULI_IMAGE_DIR}${/}rdp
${rdp_host2}    ${SSLVPN_WIN_SERVER2}
##Please only put case level variables here, while global variables should be set in env.robot
*** Test Cases ***
873924
    [Tags]    v6.0    chrome    firefox    873924    critical    win10,64bit
    # login sslvpn portal with user, quick connect to web url
    ${old_browser}=    Login SSLVPN Portal    username=${username}    password=${password}
    # create RDP bookmark
    create bookmark for rdp    ${bookmark_name}    ${host}    ${port}    ${bookmark_description}
    ...    username=${rdp_username}    password=${rdp_password}
    # open RDP bookmark and keep it
    open rdp bookmark    ${bookmark_name}    ${host}    ${image_dir}

    # login sslvpn portal with user2, quick connect to same web url
    Login SSLVPN Portal    username=${username2}    password=${password2}
    create bookmark for rdp    ${bookmark_name}    ${rdp_host2}    ${port}    ${bookmark_description}
    ...    username=${rdp_username}    password=${rdp_password}
    open rdp bookmark    ${bookmark_name}    ${rdp_host2}    ${image_dir}
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
    #close all windows
    close all browsers

    [Teardown]    case Teardown    ${bookmark_name}

*** Keywords ***
begin 873924 test
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