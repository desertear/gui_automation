*** Settings ***
Documentation    GUI automation for SSLVPN feature
Library    SikuliLibrary    mode=NEW
Resource    ../sslvpn_resource.robot
Suite Setup    begin forticlient test
Suite teardown    clear up
Test Timeout    5 min
Force Tags    sslvpn

*** Variables ***
${IMAGE_DIR}      ${SIKULI_IMAGE_DIR}${/}forticlient

*** Keywords ***
begin forticlient test
    Run Cli commands in File     ${SSLVPN_CLI_FILE_DIR}${/}sslvpn_forticlient_setup_cli.txt
    Start Sikuli Process
    Set Library Search Order    SeleniumLibrary    SikuliLibrary
    Add Image Path    ${IMAGE_DIR}

clear up
    Run Cli commands in File     ${SSLVPN_CLI_FILE_DIR}${/}sslvpn_forticlient_teardown_cli.txt
    run keyword and ignore error    Stop Remote Server