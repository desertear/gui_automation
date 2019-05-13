*** Settings ***
Documentation    Verified User-group-bookmark SMB works correctly
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
${group_bookmark_name}    group_bookmark_SMB
${smb_host}    ${SSLVPN_SMB_HOST}
${smb_username}    ${SSLVPN_SMB_USERNAME}
${smb_password}    ${SSLVPN_SMB_PASSWORD}
${smb_matched_text}    ${SSLVPN_SMB_MOST_UPPER_DIR}
&{cli_var_dic}    bookmark_name=${group_bookmark_name}    folder=${smb_host}
*** Test Cases ***
871408
    [Tags]    v6.0    firefox    chrome    edge    safari    871408    high    win10,64bit
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt    &{cli_var_dic}
    Login SSLVPN Portal
    open and check smb or cifs bookmark    ${group_bookmark_name}    ${smb_matched_text}    ${smb_username}    ${smb_password}    ${True}
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt    &{cli_var_dic}
    write test result to file    ${CURDIR}