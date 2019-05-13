*** Settings ***
Documentation    Verify the SSL-VPN portal could download forticlient if web-mode disable and tunnel-mode enable
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${portal_name}    testportal
&{variables_dic_cli_file}    PORTAL_NAME=${portal_name}
*** Test Cases ***
838556
    [Tags]    v6.0    firefox    chrome    edge    safari    838556    high    win10,64bit
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt    &{variables_dic_cli_file}
    Login SSLVPN Portal
    #click "Download fortiClient" button
    Wait Until Page Contains Element    ${PORTAL_DOWNLOAD_FORTICLIENT_BUTTON}
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    [Arguments]
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt    &{variables_dic_cli_file}
    write test result to file    ${CURDIR}