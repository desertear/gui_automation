*** Settings ***
Documentation    Verify that option "Fetch DN" in LDAP user GUI works correctly with LDAPS/STARTTLS
Resource    ../user_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${ldap_name}    ${USER_LDAP1_NAME}
${ldap_address}    ${USER_LDAP1_SERVER_ADDR}
${ldap_port}    ${USER_LDAP1_SERVER_LDAPS_PORT}
${ldap_cn}    ${USER_LDAP1_CNID}
${ldap_dn}    ${USER_LDAP1_DN}
${ldap_bind_type}    Regular
${ldap_username}    ${USER_LDAP1_USERNAME}
${ldap_password}    ${USER_LDAP1_PASSWORD}
#Warning: LDAP server should use the certificate located in user/config/certificate/ad_server.p12
*** Test Cases ***
776621
    [Tags]    v6.2    chrome    776621    medium
    [setup]    Run Cli commands in File on Terminal Server    ${USER_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login FortiGate
    Go to User and Device
    Go to User Definition
    Wait Until Element Is Visible    ${USER_FRAME}
    select frame    ${USER_FRAME}
    click button    ${USER_DEFINITION_ENTRY_CREATE_NEW}
    unselect frame
    choose user type in step one    Remote LDAP User
    edit and add ldap server in step two    ${ldap_name}    Browse    ${EMPTY}
    Logout FortiGate
    Close Browser
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Run Cli commands in File on Terminal Server    ${USER_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}