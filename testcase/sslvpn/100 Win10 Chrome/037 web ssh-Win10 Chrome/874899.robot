*** Settings ***
Documentation    Verify two users connect to sslvpn web portal, could SSH to same SSH server simultaneously
...    Action:
...    1. create SSH bookmark in portal
...    2.  choose ssh tool, input target server ip. Click \'go\'
...    Expect: Target server\'s desktop displays
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${username}    ${SSLVPN_GUI_USERNAME}
${password}    ${SSLVPN_GUI_PASSWORD}
${username2}    ${SSLVPN_GUI_USERNAME2}
${password2}    ${SSLVPN_GUI_PASSWORD2}

${ssh_host}    ${SSLVPN_SSH_HOST}
${ssh_username}    ${SSLVPN_SSH_USERNAME}
${ssh_password}    ${SSLVPN_SSH_PASSWORD}
${bookmark_name}    ssh_automation
${bookmark_description}    automation test for bookmark ${bookmark_name}

${ssh_host2}    ${SSLVPN_LINUX_SERVER2}
${ssh_username2}    ${SSLVPN_SSH_USERNAME}
${ssh_password2}    ${SSLVPN_SSH_PASSWORD}
${bookmark_name2}    ssh_automation2
${bookmark_description2}    automation test for bookmark ${bookmark_name2}

*** Test Cases ***
874899
    [Tags]   v6.0    no_grid    chrome    firefox    874899    high    win10,64bit
    ${old_browser}=    Login SSLVPN Portal    username=${username}    password=${password}
    # create ssh bookmark
    create bookmark ssh    ${bookmark_name}    ${ssh_host}    ${bookmark_description}
    # open ssh bookmark and keep it
    open and cli check ssh bookmark    ${bookmark_name}    ${ssh_host}    ${ssh_username}    ${ssh_password}

    # login sslvpn portal with user2, quick connect to same web url
    Login SSLVPN Portal    username=${username2}    password=${password2}
    create bookmark ssh    ${bookmark_name2}    ${ssh_host2}   ${bookmark_description2}
    # open ssh bookmark and keep it
    open and cli check ssh bookmark    ${bookmark_name2}    ${ssh_host2}    ${ssh_username2}    ${ssh_password2}
    run keyword and ignore error   close window
    run keyword and ignore error    Select window    MAIN
    delete bookmark by name if it exists    ${bookmark_name2}
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