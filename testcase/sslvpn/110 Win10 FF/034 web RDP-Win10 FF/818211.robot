*** Settings ***
Documentation    Verify RDP/VNC session will not be disconnected after the 'idle-timeout' is reached
Library    SikuliLibrary    mode=NEW
Resource    ../../sslvpn_resource.robot
Suite Setup    begin 818211 test
Suite Teardown    clear up

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${host}    ${SSLVPN_RDP_HOST}
${port}    ${SSLVPN_RDP_PORT}
${security_type}    tls
${sslvpn_user}    ${SSLVPN_GUI_USERNAME}
${sslvpn_user_group}    ${FGT_USER_GROUP_NAME}
${username}    ${SSLVPN_RDP_USERNAME}
${password}    ${SSLVPN_RDP_PASSWORD}
${bookmark_name}    rdp_automation
${bookmark_description}    automation test for bookmark ${bookmark_name}
${image_dir}    ${SIKULI_IMAGE_DIR}${/}rdp
${waiting_time}    70 seconds
${timeout}    60
*** Test Cases ***
818211
    [Tags]    no_grid    v6.0    firefox    chrome    edge    safari    818211    critical    win10,64bit
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login SSLVPN Portal
    click button    ${PORTAL_QUICK_CONNECTION_BUTTON}
    click element    ${QUICK_RDP_LABEL}
    input text    ${QUICK_RDP_HOST_TEXT}    ${host}
    input text    ${QUICK_RDP_PORT_TEXT}    ${port}
    input text    ${QUICK_RDP_USERNAME_TEXT}    ${username}
    input text    ${QUICK_RDP_PASSWORD_PASSWORD}    ${password}
    Select From List By Label    ${QUICK_RDP_SECURITY_SELECT}    Network Level Authentication.
    #record opened windows
    ${exclude}=    Get window handles
    click button    ${QUICK_LAUNCH_BUTTON}
    ${older_window}=    Select window    ${exclude}
    ##check FGT monitor info using FGT GUI
    check result from CLI    RDP    ${SSLVPN_CLI_FILE_DIR}${/}sslvpn_monitor_cli.txt
    sleep    ${waiting_time}
    check result from CLI    RDP    ${SSLVPN_CLI_FILE_DIR}${/}sslvpn_monitor_cli.txt
    #close RDP connection page
    close window
    [Teardown]    case Teardown    ${older_window}

*** Keywords ***
begin 818211 test
    Start Sikuli Process
    Set Library Search Order    SeleniumLibrary    SikuliLibrary

clear up
    run keyword and ignore error    Logout SSLVPN Portal
    run keyword and ignore error    Delete All Cookies
    run keyword and ignore error    close browser
    run keyword and ignore error    Stop Remote Server

case Teardown
    [Arguments]    ${older_window}
    run keyword and ignore error    switch back to ssl vpn portal    ${older_window}
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST_NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}