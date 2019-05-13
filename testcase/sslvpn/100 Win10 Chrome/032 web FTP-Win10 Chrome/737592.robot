*** Settings ***
Documentation    Verify predefined SSO FTP bookmark can be access with "alternative" sso credential.
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${folder}    ${SSLVPN_FTP_HOST}
${username}    ${SSLVPN_FTP_USERNAME}
${password}    ${SSLVPN_FTP_PASSWORD}
${bookmark_name}    bookmark_ftp_sso_alternative
${bookmark_description}    automation test for bookmark ${bookmark_name}
${matching_text}    ${SSLVPN_FTP_TEST_DIR}
*** Test Cases ***
737592
    [Tags]    v6.0    chrome    firefox    edge    safari    737592    high    win10,64bit
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login SSLVPN Portal
    open and check ftp bookmark    ${bookmark_name}    ${matching_text}    ${username}    ${password}    if_predefined=${True}    sso_credentials=sslvpn
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    [Arguments]
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}