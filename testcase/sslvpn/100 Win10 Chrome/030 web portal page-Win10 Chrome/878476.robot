*** Settings ***
Documentation    Verify sslvpn web mode will not show quick connection button when display-connection-tools disable
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
${bookmark_name}    878476_http
${portal_name}    testportal
${bookmark_description}    http bookmark
*** Test Cases ***
878476
    [Tags]    v6.0    chrome    firefox    edge    safari    878476    high    win10,64bit
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt

    Login SSLVPN Portal

    Wait Until Page contains element    ${PORTAL_NEW_BOOKMARK_BUTTON}
    wait Until page does NOT contain element    ${PORTAL_QUICK_CONNECTION_BUTTON}    timeout=10

    create bookmark for http or https    ${bookmark_name}    ${http_url}    ${bookmark_description}
    open and check http bookmark    ${bookmark_name}    ${matching_text}
    [Teardown]   case Teardown    ${bookmark_name}

*** Keywords ***
case Teardown
    [Arguments]    ${name}
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    delete bookmark by name    ${name}
    write test result to file    ${CURDIR}