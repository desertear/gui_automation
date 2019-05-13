*** Settings ***
Documentation    Verify personal SSO HTTP bookmark can be access with "alternative" sso credential.
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${http_url}    ${sso_http}
${sslvpn_username}    ${SSLVPN_GUI_USERNAME}
${sslvpn_password}    ${SSLVPN_GUI_PASSWORD}
${sslvpn_user_group}    ${FGT_USER_GROUP_NAME}
${username}    ${sso_username}
${password}    ${sso_password}
${bookmark_name}   http_sso_861852
${bookmark_description}    automation test for bookmark ${bookmark_name}
${matching_text}    ${FAC_HEAD}
*** Test Cases ***
861852
    [Tags]    v6.0    chrome    firefox    edge    safari    861852    high    win10,64bit 
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login SSLVPN Portal    username=${sslvpn_username}    password=${sslvpn_password}
    open and check http bookmark    ${bookmark_name}    ${matching_text}
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}