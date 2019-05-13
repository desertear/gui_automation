*** Settings ***
Documentation    Verify sslvpn web mode will not show predefined bookmarks when display-bookmark disable
...   Action:
...   1. establish vpn connection,portal appears.
...   2. prededined bookmarks show and work'
...   Expect:
...   The target website\'s page displayed.
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${http_url}    ${SSLVPN_HTTP_IP}
${matching_text}    ${SSLVPN_HTTP_PAGE_KEYWORD}
${portal_name}    testportal
${http_url}    http://${SSLVPN_HTTP_IP}
${http_page_keyword}    ${SSLVPN_HTTP_PAGE_KEYWORD}
${bookmark_name}    878477_bookmark
${bookmark_description}    automation test for bookmark ${bookmark_name}

*** Test Cases ***
878477
    [Tags]    v6.0    chrome    firefox    edge    safari    878477    high    win10,64bit
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt

    Login SSLVPN Portal
    wait Until page contains element    ${PORTAL_QUICK_CONNECTION_BUTTON}
    Wait Until Page contains element    ${PORTAL_NEW_BOOKMARK_BUTTON}

    ${locator_replaced_with_real_value}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${PORTAL_VAR_PREDEFINED_BOOKMARK_BUTTON}    ${bookmark_name}
    wait Until page does NOT contain element    ${locator_replaced_with_real_value}        timeout=10

    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}