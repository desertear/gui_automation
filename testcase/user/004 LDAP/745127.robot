*** Settings ***
Documentation    Verify GUI LDAP test button work (bug #128289)
Resource    ../user_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${ldap_name}    ${USER_LDAP1_NAME}
${ldap_address}    ${USER_LDAP1_SERVER_ADDR}
${ldap_port}    ${USER_LDAP1_SERVER_PORT}
${ldap_cn}    ${USER_LDAP1_CNID}
${ldap_dn}    ${USER_LDAP1_DN}
${ldap_bind_type}    Regular
${ldap_username}    ${USER_LDAP1_USERNAME}
${ldap_password}    ${USER_LDAP1_PASSWORD}
*** Test Cases ***
745127
    [Tags]    v6.2    chrome    745127    high
    Login FortiGate
    Create New LDAP Server    ${ldap_name}    ${ldap_address}    ${ldap_port}    ${ldap_cn}
    ...    ${ldap_dn}    ${ldap_bind_type}    ${ldap_username}    ${ldap_password}
    Edit LDAP Server    ${ldap_name}    Test Connectivity    Successful
    Delete LDAP Server    ${ldap_name}
    Logout FortiGate
    Close Browser
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    write test result to file    ${CURDIR}