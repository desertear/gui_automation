*** Settings ***
Documentation    Verified User-group-bookmark RDP works correctly
Library    SikuliLibrary    mode=NEW
Resource    ../../sslvpn_resource.robot
Suite Teardown    clear up
Suite Setup    begin 877130 test
*** Variables ***
${group_bookmark_name}    group_bookmark_RDP
${rdp_host}    ${SSLVPN_RDP_HOST}
${rdp_port}    ${SSLVPN_RDP_PORT}
${rdp_username}    ${SSLVPN_RDP_USERNAME}
${rdp_password}    ${SSLVPN_RDP_PASSWORD}
${rdp_image_dir}    ${SIKULI_IMAGE_DIR}${/}rdp
&{cli_var_dic}    bookmark_name=${group_bookmark_name}    host=${rdp_host}    port=${rdp_port}    username=${rdp_username}    password=${rdp_password}
*** Test Cases ***
877130
    [Tags]     no_grid    v6.0    firefox    chrome    edge    safari    877130    high    win10,64bit
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt    &{cli_var_dic}
    Login SSLVPN Portal
    open and check rdp bookmark    ${group_bookmark_name}    ${rdp_host}    ${rdp_image_dir}    ${rdp_username}    ${rdp_password}    if_predefined=${True}
    [Teardown]    case Teardown

*** Keywords ***
begin 877130 test
    Start Sikuli Process
    Set Library Search Order    SeleniumLibrary    SikuliLibrary
clear up
    run keyword and ignore error    Logout SSLVPN Portal
    run keyword and ignore error    Delete All Cookies
    run keyword and ignore error    close browser
    run keyword and ignore error    Stop Remote Server

case Teardown
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt    &{cli_var_dic}
    write test result to file    ${CURDIR}