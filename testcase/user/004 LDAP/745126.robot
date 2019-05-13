*** Settings ***
Documentation    Verify LDAP query from GUI work when "bind type"=regular/simple/Anonymous (bug 0192630)
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
*** Test Cases ***
745126
    [Tags]    v6.2    chrome    745126    high
    Login FortiGate
    Create New LDAP Server    ${ldap_name}    ${ldap_address}    ${ldap_port}    ${ldap_cn}
    ...    ${ldap_dn}    ${ldap_bind_type}    ${ldap_username}    ${ldap_password}
    #query DN in regular type
    Edit LDAP Server    ${ldap_name}    Browse    ${EMPTY}
    Edit LDAP Server    ${ldap_name}    Bind Type    Simple
    #query DN in simple type
    Edit LDAP Server    ${ldap_name}    Browse    ${EMPTY}
    #query DN in anonymous type doesn't work due to bug #0505066
    Delete LDAP Server    ${ldap_name}
    Logout FortiGate
    Close Browser
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    write test result to file    ${CURDIR}