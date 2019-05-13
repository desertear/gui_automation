*** Settings ***
Documentation    Verify FGT sslvpn portals page predefined SMB bookmark could set "ssl-vpn login" SSO and work
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${folder}    ${SSLVPN_SMB_HOST}
${username}    ${SSLVPN_SMB_USERNAME}
${password}    ${SSLVPN_SMB_PASSWORD}
${bookmark_name}    smb_automation_sso_sslvpn
${bookmark_description}    automation test for bookmark ${bookmark_name}
${matching_text}    ${SSLVPN_SMB_MOST_UPPER_DIR}
${tmp_group_name}    877283group
&{cli_dic}    username=${username}    password=${password}    group_name=${tmp_group_name}
*** Test Cases ***
877283
    [Tags]    v6.0    firefox    chrome    edge    safari    877283    high    win10,64bit
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt    &{cli_dic}
    Login SSLVPN Portal    username=${username}    password=${password}
    open and check smb or cifs bookmark    ${bookmark_name}    ${matching_text}    ${username}    ${password}    if_predefined=True    sso_credentials=sslvpn
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt    &{cli_dic}
    write test result to file    ${CURDIR}