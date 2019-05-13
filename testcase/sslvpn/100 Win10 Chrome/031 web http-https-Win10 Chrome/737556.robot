*** Settings ***
Documentation    Verify fortinet bar can be shown when the fortinet-bar-port is set to other than default value(8011).
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${url}    ${SSLVPN_HTTP_IP}
${matched_element}    ${SSLVPN_HTTP_PAGE_KEYWORD}
${fortinet_bar_port}    8888
*** Test Cases ***
737556
    [Tags]    v6.0    chrome    firefox    edge    safari    737556    medium    win10,64bit
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}fortinet_bar_setup_cli.txt
    Login SSLVPN Portal
    click button    ${PORTAL_QUICK_CONNECTION_BUTTON}
    click element    ${QUICK_HTTP_HTTPS_LABEL}
    input text    ${QUICK_HTTP_URL_TEXT}    ${url}
    #record opened windows
    ${exclude}=    Get window handles
    click button    ${QUICK_LAUNCH_BUTTON}
    ${older_window}=    Select window    ${exclude}
    Wait Until Page Contains regardless of iframe    ${matched_element}
    wait until page contains element    ${FORTINET_BAR_IFRAME}
    close window
    #switch back to SSLVPN GUI window
    Select window    ${older_window}
    wait Until page contains element    ${PORTAL_QUICK_CONNECTION_BUTTON}
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}fortinet_bar_teardown_cli.txt
    write test result to file    ${CURDIR}