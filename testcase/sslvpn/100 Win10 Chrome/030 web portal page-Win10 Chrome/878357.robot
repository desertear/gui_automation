*** Settings ***
Documentation    Verify sslvpn web mode predefined bookmark works when disable user-bookmark
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
${bookmark_name}    878357_bookmark
${bookmark_description}    automation test for bookmark ${bookmark_name}

*** Test Cases ***
878357
    [Tags]    v6.0    chrome    firefox    edge    safari    878357    high    win10,64bit
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt

    Login SSLVPN Portal
    wait Until page contains element    ${PORTAL_QUICK_CONNECTION_BUTTON}
    Wait Until Page does NOT contain element    ${PORTAL_NEW_BOOKMARK_BUTTON}    timeout=10

    open and check http bookmark    ${bookmark_name}    ${matching_text}    if_predefined=${True}


    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}