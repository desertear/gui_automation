*** Settings ***
Documentation    Verified User-group-bookmark TELNET works correctly
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
${group_bookmark_name}    group_bookmark_TELNET
${telnet_host}    ${SSLVPN_TELNET_HOST}
${telnet_username}    ${SSLVPN_TELNET_USERNAME}
${telnet_password}    ${SSLVPN_TELNET_PASSWORD}
&{cli_var_dic}    bookmark_name=${group_bookmark_name}    host=${telnet_host}
*** Test Cases ***
871407
    [Tags]    v6.0    firefox    chrome    edge    safari    871407    high    win10,64bit
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}sslvpn_group_bookmark_setup_cli.txt    &{cli_var_dic}
    Login SSLVPN Portal
    ${locator_replaced_with_real_value}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${PORTAL_VAR_PREDEFINED_BOOKMARK_BUTTON}    ${group_bookmark_name}
    wait Until page contains element    ${locator_replaced_with_real_value}
    #record opened windows
    ${exclude}=    Get window handles
    click button    ${locator_replaced_with_real_value}
    ${older_window}=    Select window    ${exclude}
    wait until element is visible    ${QUICK_TELNET_IFRAME}
    select frame    ${QUICK_TELNET_IFRAME}
    Wait Until keyword Succeeds    5x    ${SELENIUM_TIMEOUT}    Current Frame Should Contain    Ubuntu
    # wait Until page contains element    xpath://x-row[contains(text(),"Ubuntu")]    30
    #close TELNET connection window
    close window
    #switch back to SSLVPN GUI window
    Select window    ${older_window}
    wait Until page contains element    ${PORTAL_NEW_BOOKMARK_BUTTON}
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}sslvpn_group_bookmark_teardown_cli.txt    &{cli_var_dic}
    write test result to file    ${CURDIR}