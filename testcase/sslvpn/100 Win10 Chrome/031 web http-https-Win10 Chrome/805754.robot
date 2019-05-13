*** Settings ***
Documentation    Verified User-group-bookmark works correctly on supported protocols.
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
${group_bookmark_name}    group_bookmark_http
${tmp_url}    ${SSLVPN_HTTP_IP}
&{cli_var_dic}    bookmark_name=${group_bookmark_name}    bookmark_url=${tmp_url}
${matched_text}    ${SSLVPN_HTTP_PAGE_KEYWORD}
*** Test Cases ***
805754
    [Tags]    v6.0    firefox    chrome    edge    safari    805754    high    win10,64bit
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt    &{cli_var_dic}
    Login SSLVPN Portal
    open and check http bookmark    ${group_bookmark_name}    ${matched_text}    ${True}
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt    &{cli_var_dic}
    write test result to file    ${CURDIR}