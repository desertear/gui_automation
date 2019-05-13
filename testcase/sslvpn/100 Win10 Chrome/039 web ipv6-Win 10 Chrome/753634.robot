*** Settings ***
Documentation    Verify local/remote user can login ipv6 sslvpn web portal in chrome
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
${url_ipv6}    ${SSLVPN_URL_V6}
${local_user}    ${SSLVPN_GUI_USERNAME}
${local_password}    ${SSLVPN_GUI_PASSWORD}
${radius_user}    ${FGT_RADIUS_USERNAME}
${radius_password}    ${FGT_RADIUS_PASSWORD}
*** Test Cases ***
753634
    [Tags]    v6.0    chrome    firefox    edge    safari    753634    high    win10,64bit
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login SSLVPN Portal    url=${url_ipv6}    username=${local_user}    password=${local_password}
    Logout SSLVPN Portal
    close browser
    Login SSLVPN Portal    url=${url_ipv6}    username=${radius_user}    password=${radius_password}
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}