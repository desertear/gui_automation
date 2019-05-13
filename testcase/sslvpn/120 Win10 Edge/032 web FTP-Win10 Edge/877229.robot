*** Settings ***
Documentation    Verified User-group-bookmark FTP works correctly
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
${group_bookmark_name}    group_bookmark_FTP
${ftp_host}    ${SSLVPN_FTP_HOST}
${ftp_username}    ${SSLVPN_FTP_USERNAME}
${ftp_password}    ${SSLVPN_FTP_PASSWORD}
${matched_text}    ${SSLVPN_FTP_TEST_DIR}
&{cli_var_dic}    bookmark_name=${group_bookmark_name}    folder=${ftp_host}
*** Test Cases ***
877229
    [Tags]    v6.0    firefox    chrome    edge    safari    877229    high    win10,64bit
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt    &{cli_var_dic}
    Login SSLVPN Portal
    open and check ftp bookmark    ${group_bookmark_name}    ${matched_text}    ${ftp_username}    ${ftp_password}    ${True}
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt    &{cli_var_dic}
    write test result to file    ${CURDIR}