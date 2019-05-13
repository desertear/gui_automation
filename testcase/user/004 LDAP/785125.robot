*** Settings ***
Documentation    Verify internal LDAP browser supports UTF character sets
Resource    ../user_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${ldap_name}    aB!@$%^&*_-+=:;,./?~`0
${ldap_address}    ${USER_LDAP2_SERVER_ADDR}
${ldap_port}    ${USER_LDAP2_SERVER_PORT}
${ldap_cn}    ${USER_LDAP2_CNID}
${ldap_dn}    ${USER_LDAP2_DN}
${ldap_username}    ${USER_LDAP2_USERNAME}
${ldap_password}    ${USER_LDAP2_PASSWORD}
@{expected_users}    ${USER_LDAP2_USER4_UTF}
@{unexpected_users}    test1    test11    test2    test3    test31    test4
&{data_dic}    ldap_server=${ldap_name}

*** Test Cases ***
785125
    [Tags]    v6.2    chrome    785125    high
    [setup]    Run Cli commands in File on Terminal Server    ${USER_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login FortiGate
    Go to User and Device
    Go to User Definition
    Wait Until Element Is Visible    ${USER_FRAME}
    select frame    ${USER_FRAME}
    click button    ${USER_DEFINITION_ENTRY_CREATE_NEW}
    unselect frame
    choose user type in step one    Remote LDAP User
    config user in step two    Remote LDAP User    &{data_dic}
    Wait Until Element is Visible    ${USER_USER_LDAP_SERVER_BROWSER}
    Search user in ldap browser    Users    ${EMPTY}    ${USER_LDAP2_USER4_UTF}    ${True}    @{expected_users}
    Search user in ldap browser    Users    ${EMPTY}    ${USER_LDAP2_USER4_UTF}    ${False}    @{unexpected_users}
    Logout FortiGate
    Close Browser
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Run Cli commands in File on Terminal Server    ${USER_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}