*** Settings ***
Documentation    Verify sslvpn web mode quick connection works when disable user-bookmark
...   Action:
...   1. cli disable user-bookmark
...   2. sslvpn web portal
...   3. new bookmark button does not appear, quick connection button woeks
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${http_url}    ${SSLVPN_HTTP_IP}
${matched_text}    ${SSLVPN_HTTP_PAGE_KEYWORD}
${portal_name}    testportal
&{variables_dic_cli_file}    PORTAL_NAME=${portal_name}

*** Test Cases ***
878358
    [Tags]    v6.0    chrome    firefox    edge    safari    878358    high    win10,64bit
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}sslvpn_disable_user_bookmark_setup_cli.txt    &{variables_dic_cli_file}

    Login SSLVPN Portal
    Wait Until Page Contains element    ${PORTAL_QUICK_CONNECTION_BUTTON}
    Wait Until Page does NOT contain element    ${PORTAL_NEW_BOOKMARK_BUTTON}    timeout=10
    quick connection of http or https    ${http_url}    ${matched_text}

    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}sslvpn_disable_user_bookmark_teardown_cli.txt     &{variables_dic_cli_file}
    write test result to file    ${CURDIR}