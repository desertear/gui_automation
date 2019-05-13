*** Settings ***
Documentation    Verify history widget is hidden when user-anonymize is enabled in log setting.
...    Go vpn>ssl>portal page, create new sslvpn portal.
...    Disable log disk/fortianalyzer/forticloud setting. Enable log memory setting.
...    Enable user anonymous in vdom1 log setting.
...    config log setting
...        set local-in-deny disable
...        set user-anonymize enable <<<<<---------
...    end
...    Login sslvpn web mode. Access servers through http/https etc. Then logout web mode. Login sslvpn web mode again.
...    Expect result:
...    History widget is hidden in personal web portal.
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${http_url}    http://${SSLVPN_HTTP_IP}
${http_page_keyword}    ${SSLVPN_HTTP_PAGE_KEYWORD}
${bookmark_name}    personal_bookmark
${bookmark_description}    automation test for bookmark ${bookmark_name}
@{cmds}    show vpn ssl web user-bookmark
*** Test Cases ***
876497
    [Tags]    v6.0    firefox    chrome    edge    safari    876497    high    win10,64bit
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login SSLVPN Portal
    # ${time_login}=    Get Time    epoch
    ${num_his_old}=    number of history records
    sleep    5s
    Logout SSLVPN Portal
    Login SSLVPN Portal
    ${num_his_newer}=    number of history records
    should be equal as integers    ${num_his_old}    ${num_his_newer}
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}