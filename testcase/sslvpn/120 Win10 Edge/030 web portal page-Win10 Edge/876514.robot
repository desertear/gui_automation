*** Settings ***
Documentation    Verify that valid LDAP user can  login sslvpn web portal
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
${ldap_user}    ${FGT_LDAP_USERNAME}
${ldap_password}    ${FGT_LDAP_PASSWORD}
*** Test Cases ***
876514
    [Tags]    v6.0    firefox    chrome    edge    safari    876514    critical    win10,64bit
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login SSLVPN Portal    username=${ldap_user}    password=${ldap_password}
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}