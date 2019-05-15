*** Settings ***
Documentation    Verify that ldap-browser ( query button)  in LDAP user config GUI works if LDAP server is configured as LDAPS ( #217684 )
Resource    ../user_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${ldap_name}    ${USER_LDAP1_NAME}
${ldap_address}    ${USER_LDAP1_SERVER_ADDR}
${ldap_port}    ${USER_LDAP1_SERVER_LDAPS_PORT}
${ldap_cn}    ${USER_LDAP1_CNID}
${ldap_dn}    ${USER_LDAP1_DN}
${ldap_username}    ${USER_LDAP1_USERNAME}
${ldap_password}    ${USER_LDAP1_PASSWORD}
@{ldap_users}    ${USER_LDAP1_USER1}    ${USER_LDAP1_USER2}
&{dic2}    ldap_server=${ldap_name}    ldap_remote_users=${ldap_users}
@{cmd_correct_pwd}    diagnose test authserver local '' ${USER_LDAP1_USER1} ${USER_LDAP1_PASSWORD1}
@{cmd_wrong_pwd}    diagnose test authserver local '' ${USER_LDAP1_USER2} 654321

*** Test Cases ***
754603
    [Tags]    v6.2    chrome    754603    high
    [setup]    Run Cli commands in File on Terminal Server    ${USER_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login FortiGate
    Create new user    Remote LDAP User    &{dic2}    
    Logout FortiGate
    Close Browser
    #user debug command to verify the user authentication
    ${response_list}=    Execute CLI commands on FortiGate Via Terminal Server    commands=${cmd_correct_pwd}
    Should Contain     @{response_list}[-1]    succeeded
    ${response_list}=    Execute CLI commands on FortiGate Via Terminal Server    commands=${cmd_wrong_pwd}
    Should Contain     @{response_list}[-1]    failed
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Run Cli commands in File on Terminal Server    ${USER_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}