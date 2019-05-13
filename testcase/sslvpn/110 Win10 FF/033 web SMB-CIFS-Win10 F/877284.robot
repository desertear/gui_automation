*** Settings ***
Documentation    Verify FGT sslvpn portals page predefined SMB bookmark could set SSO alternative and work
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${folder}    ${SSLVPN_SMB_HOST}
${username}    ${SSLVPN_SMB_USERNAME}
${password}    ${SSLVPN_SMB_PASSWORD}
${bookmark_name}    smb_automation_sso_alternative
${bookmark_description}    automation test for bookmark ${bookmark_name}
${matching_text}    ${SSLVPN_SMB_MOST_UPPER_DIR}
${tmp_group_name}    877284group
*** Test Cases ***
877284
    [Tags]    v6.0    firefox    chrome    edge    safari    877284    high    win10,64bit
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login SSLVPN Portal
    open and check smb or cifs bookmark    ${bookmark_name}    ${matching_text}    ${username}    ${password}    if_predefined=True    sso_credentials=alternative
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}