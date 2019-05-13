*** Settings ***
Documentation    Verify that valid local user can login sslvpn web portal
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
${msg1}    SSL tunnel established
${url}    ${SSLVPN_URL}
${browser}    ${SSLVPN_BROWSER}
${LOGIN_SSLVPN_REPLACE_MESSAGE}    sslvpn replace message testing
*** Test Cases ***
182879
    [Tags]    v6.0    firefox    chrome    edge    safari    182879    medium    win10,64bit
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt

    [Documentation]    This keyword is used to login ssl vpn portal
    Open Browser    ${url}    ${browser}
    Run Keyword And Continue On Failure    Maximize Browser Window
    Run Keyword And Continue On Failure    get all selenium config
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${LOGIN_SSLVPN_REPLACE_MESSAGE}

    sleep    20s

    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    Close All Browsers
    write test result to file    ${CURDIR}