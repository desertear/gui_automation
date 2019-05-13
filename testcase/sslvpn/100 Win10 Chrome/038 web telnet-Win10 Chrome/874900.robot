*** Settings ***
Documentation    Verify two users connect to sslvpn web portal, could TELNET to same TELNET server simultaneously
...    Action:
...    1. create TELNET bookmark in portal
...    2.  choose telnet tool, input target server ip. Click \'go\'
...    Expect: Target server\'s desktop displays
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${username}    ${SSLVPN_GUI_USERNAME}
${password}    ${SSLVPN_GUI_PASSWORD}
${username2}    ${SSLVPN_GUI_USERNAME2}
${password2}    ${SSLVPN_GUI_PASSWORD2}

${telnet_host}    ${SSLVPN_TELNET_HOST}
${telnet_username}    ${SSLVPN_TELNET_USERNAME}
${telnet_password}    ${SSLVPN_TELNET_PASSWORD}
${bookmark_name}    telnet_automation
${bookmark_description}    automation test for bookmark ${bookmark_name}
${image_dir}    ${SIKULI_IMAGE_DIR}${/}telnet
*** Test Cases ***
874900
    [Tags]   v6.0    no_grid    chrome    firefox    874900    high    win10,64bit
    ${old_browser}=    Login SSLVPN Portal    username=${username}    password=${password}
    # create telnet bookmark
    create bookmark telnet    ${bookmark_name}    ${telnet_host}    ${bookmark_description}
    # open telnet bookmark and keep it
    open and cli check telnet bookmark    ${bookmark_name}    ${telnet_host}    ${telnet_username}    ${telnet_password}

    # login sslvpn portal with user2, quick connect to same web url
    Login SSLVPN Portal    username=${username2}    password=${password2}
    create bookmark telnet    ${bookmark_name}    ${telnet_host}   ${bookmark_description}
    # open telnet bookmark and keep it
    open and cli check telnet bookmark    ${bookmark_name}    ${telnet_host}    ${telnet_username}    ${telnet_password}
    run keyword and ignore error   close window
    run keyword and ignore error    Select window    MAIN
    delete bookmark by name if it exists    ${bookmark_name}
    run keyword and ignore error    Logout SSLVPN Portal
    # switch back to first login
    run keyword and ignore error    switch browser    ${old_browser}
    run keyword and ignore error    close window
    run keyword and ignore error    Select window    MAIN
    delete bookmark by name if it exists    ${bookmark_name}

    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    write test result to file    ${CURDIR}