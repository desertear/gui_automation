*** Settings ***
Documentation    Verify fortinet bar doesn't support at sslvpn ipv6 (0304104)
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${url_ipv6}    ${SSLVPN_URL_V6}
${matched_element}    pc5
${http_pc5_ipv6}    http://[2000:172:16:200::55]
*** Test Cases ***
818399
    [Tags]    v6.0    chrome    firefox    edge    safari    818399    medium    win10,64bit
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}fortinet_bar_ipv6_setup_cli.txt
    Login SSLVPN Portal    url=${url_ipv6}
    click button    ${PORTAL_QUICK_CONNECTION_BUTTON}
    click element    ${QUICK_HTTP_HTTPS_LABEL}
    input text    ${QUICK_HTTP_URL_TEXT}    ${http_pc5_ipv6}
    #record opened windows
    ${exclude}=    Get window handles
    click button    ${QUICK_LAUNCH_BUTTON}
    ${main_window}=    Select window    ${exclude}
    Wait Until Page Contains regardless of iframe    ${matched_element}
    Current Frame Should Not Contain    ${FORTINET_BAR_IFRAME}
    ##close http window
    close window
    #switch back to SSLVPN GUI window
    Select window    ${main_window}
    wait Until page contains element    ${PORTAL_QUICK_CONNECTION_BUTTON}
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}fortinet_bar_ipv6_teardown_cli.txt
    write test result to file    ${CURDIR}