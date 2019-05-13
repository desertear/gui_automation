*** Settings ***
Documentation    Verified User-group-bookmark could be defined for certain group and works when firewall policy uses the group to authenticate.
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
${group_bookmark_name}    test_group_bookmark
${tmp_url}    ${SSLVPN_HTTP_IP}
&{cli_var_dic}    bookmark_name=${group_bookmark_name}    bookmark_url=${tmp_url}
*** Test Cases ***
805606
    [Tags]    v6.0    firefox    chrome    edge    safari    805606    high    win10,64bit
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt    &{cli_var_dic}
    Login SSLVPN Portal
    ${locator_replaced_with_real_value}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${PORTAL_VAR_PREDEFINED_BOOKMARK_BUTTON}    ${group_bookmark_name}
    wait Until page contains element    ${locator_replaced_with_real_value}
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt    &{cli_var_dic}
    write test result to file    ${CURDIR}