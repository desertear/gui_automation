*** Settings ***
Documentation    Verify ssl vpn user personal bookmark can be shown and accessed in fortinet bar.
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${url}    ${SSLVPN_HTTP_IP}
${matched_element}    ${SSLVPN_HTTP_PAGE_KEYWORD}
${http_bookmark_name}    bookmark_http
${http_bookmark_url}    www.google.ca
*** Test Cases ***
737555
    [Tags]    v6.0    chrome    firefox    edge    safari    737555    high    win10,64bit
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}fortinet_bar_setup_cli.txt
    Login SSLVPN Portal
    click button    ${PORTAL_QUICK_CONNECTION_BUTTON}
    click element    ${QUICK_HTTP_HTTPS_LABEL}
    input text    ${QUICK_HTTP_URL_TEXT}    ${url}
    #record opened windows
    ${exclude}=    Get window handles
    click button    ${QUICK_LAUNCH_BUTTON}
    ${main_window}=    Select window    ${exclude}
    Wait Until Page Contains regardless of iframe    ${matched_element}
    wait until page contains element    ${FORTINET_BAR_IFRAME}
    ##click bookmark
    select frame    ${FORTINET_BAR_IFRAME}
    click element    ${FORTINET_BAR_BOOKMARK_DIV}
    unselect frame
    select frame    ${FORTINET_BAR_MENU_IFRAME}
    ${bookmark_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_FORTINET_BAR_BOOKMARK_LINK}    ${http_bookmark_name}
    #record opened windows
    ${exclude}=    Get window handles
    click element    ${bookmark_locator}
    unselect frame
    ${http_window}=    select window    ${exclude}
    Location Should Contain    ${http_bookmark_url}
    select window    ${http_window}
    ##close http window
    close window
    #switch back to SSLVPN GUI window
    Select window    ${main_window}
    wait Until page contains element    ${PORTAL_QUICK_CONNECTION_BUTTON}
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}fortinet_bar_teardown_cli.txt
    write test result to file    ${CURDIR}