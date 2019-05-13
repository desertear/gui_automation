*** Settings ***
Documentation    Verify that a new LDAP user configuration can be created in step 2 when mapping remote LDAP users to local users ( #219002 ) 
Resource    ../user_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${ldap_name}    ${USER_LDAP2_NAME}
${ldap_address}    ${USER_LDAP2_SERVER_ADDR}
${ldap_port}    ${USER_LDAP2_SERVER_PORT}
${ldap_cn}    ${USER_LDAP2_CNID}
${ldap_dn}    ${USER_LDAP2_DN}
${ldap_bind_type}    Regular
${ldap_username}    ${USER_LDAP2_USERNAME}
${ldap_password}    ${USER_LDAP2_PASSWORD}
${username1}    ${USER_LDAP2_USER1}
@{ldap_users}    ${username1}
@{cmd_correct_pwd}    diagnose test authserver local '' ${USER_LDAP2_USER1} ${USER_LDAP2_PASSWORD1}
&{data_dic}    ldap_server=${ldap_name}    ldap_remote_users=${ldap_users}

*** Test Cases ***
754599
    [Tags]    v6.2    chrome    754599    high
    Login FortiGate
    Go to User and Device
    Go to User Definition
    Wait Until Element Is Visible    ${USER_FRAME}
    select frame    ${USER_FRAME}
    click button    ${USER_DEFINITION_ENTRY_CREATE_NEW}
    unselect frame
    choose user type in step one    Remote LDAP User
    add and select new ldap server in step two    ${ldap_name}    ${ldap_address}    ${ldap_port}    ${ldap_cn}
    ...    ${ldap_dn}    ${ldap_bind_type}    ${ldap_username}    ${ldap_password}
    config remote user in step three    &{data_dic}
    Logout FortiGate
    Close Browser
    #user debug command to verify the user authentication
    ${response_list}=    Execute CLI commands on FortiGate Via Terminal Server    commands=${cmd_correct_pwd}
    Should Contain     @{response_list}[-1]    succeeded
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Run Cli commands in File on Terminal Server    ${USER_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}