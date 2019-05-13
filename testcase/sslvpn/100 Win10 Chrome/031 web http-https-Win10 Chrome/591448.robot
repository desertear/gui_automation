*** Settings ***
Documentation    Verify SSO HTTP form data works with automatic configuration from personal bookmark
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${https_url}    http://${FAC_IP}/login
${sslvpn_username}    ${SSLVPN_GUI_USERNAME}
${sslvpn_password}    ${SSLVPN_GUI_PASSWORD}
${sslvpn_user_group}    ${FGT_USER_GROUP_NAME}
${key1}    username
${value1}    ${FAC_USERNAME}
${key2}    password
${value2}    ${FAC_PASSWORD}
${bookmark_name}   http_sso_591448
${bookmark_description}    automation test for bookmark ${bookmark_name}
${matching_text}    ${FAC_HEAD}
*** Test Cases ***
591448
    [Tags]    v6.0    chrome    firefox    edge    safari    591448    medium    win10,64bit  
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login SSLVPN Portal
    open and check http bookmark    ${bookmark_name}    ${matching_text}
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}