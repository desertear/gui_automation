*** Settings ***
Documentation    Verify personal SSO FTP bookmark can be access with "ssl vpn login" sso credential.
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${folder}    ${SSLVPN_FTP_HOST}
${username}    ${SSLVPN_FTP_USERNAME}
${password}    ${SSLVPN_FTP_PASSWORD}
${bookmark_name}    ftp_automation
${bookmark_description}    automation test for bookmark ${bookmark_name}
${matching_text}    ${SSLVPN_FTP_TEST_DIR}
${tmp_group_name}    737587group
&{cli_dic}    username=${username}    password=${password}    group_name=${tmp_group_name}
*** Test Cases ***
737587
    [Tags]    v6.0    chrome    firefox    edge    safari    737587    high    win10,64bit
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt    &{cli_dic}
    Login SSLVPN Portal    username=${username}    password=${password}
    create bookmark ftp    ${bookmark_name}    ${folder}    ${bookmark_description}    sslvpn
    open and check ftp bookmark    ${bookmark_name}    ${matching_text}    ${username}    ${password}    sso_credentials=sslvpn
    [Teardown]    case Teardown    ${bookmark_name}

*** Keywords ***
case Teardown
    [Arguments]    ${name}
    run keyword and ignore error    delete bookmark by name    ${name}
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt    &{cli_dic}
    write test result to file    ${CURDIR}