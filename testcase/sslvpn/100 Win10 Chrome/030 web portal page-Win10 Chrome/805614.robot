*** Settings ***
Documentation    Verified User-group-bookmark defined for certain group won't get load when firewall policy does not use the group to authenticate.
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
${tmp_bookmark_name}    tmp_group_bookmark
${tmp_group_name}    tmp_usergrp
${tmp_url}    ${SSLVPN_HTTP_IP}
${username}    ${SSLVPN_GUI_USERNAME}
${password}    ${SSLVPN_GUI_PASSWORD}
&{cli_var_dic}    group_name=${tmp_group_name}    bookmark_name=${tmp_bookmark_name}    bookmark_url=${tmp_url}
*** Test Cases ***
805614
    [Tags]    v6.0    firefox    chrome    edge    safari    805614    high    win10,64bit
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt    &{cli_var_dic}
    Login SSLVPN Portal    username=${username}    password=${password}
    ${locator_replaced_with_real_value}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${PORTAL_VAR_PREDEFINED_BOOKMARK_BUTTON}    ${tmp_bookmark_name}
    ${if_bookmark_exists}=    run keyword and return status    wait Until page contains element    ${locator_replaced_with_real_value}
    should not be true    ${if_bookmark_exists}
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt    &{cli_var_dic}
    write test result to file    ${CURDIR}