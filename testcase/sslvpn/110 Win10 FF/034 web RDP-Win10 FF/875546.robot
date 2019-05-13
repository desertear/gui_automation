*** Settings ***
Documentation    Verify sslvpn RDP bookmark can connect to windows 10 when do the special config (366484)
Library    SikuliLibrary    mode=NEW
Resource    ../../sslvpn_resource.robot
Suite Setup    begin 875546 test
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
*** Test Cases ***
875546
    [Tags]    no_grid    v6.0    firefox    chrome    edge    safari    875546    high    win10,64bit
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}sslvpn_rdp_bookmark_setup_cli.txt
    Login SSLVPN Portal
    open and check rdp bookmark    ${bookmark_name}    ${host}    ${image_dir}
    [Teardown]    case Teardown

*** Keywords ***
begin 875546 test
    Start Sikuli Process
    Set Library Search Order    SeleniumLibrary    SikuliLibrary

clear up
    run keyword and ignore error    Logout SSLVPN Portal
    run keyword and ignore error    Delete All Cookies
    run keyword and ignore error    close browser
    run keyword and ignore error    Stop Remote Server

case Teardown
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}sslvpn_rdp_bookmark_teardown_cli.txt
    write test result to file    ${CURDIR}