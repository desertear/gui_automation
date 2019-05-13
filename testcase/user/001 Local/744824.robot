*** Settings ***
Documentation    Verify user can be created/edited/renamed/delete from GUI
Resource    ../user_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${user_group}    ldapgrp
${username}    user1
${password}    123456
${email}    fosqa@fortinet.com
&{data_dic}    username=${username}    password=${password}    email=${email}
*** Test Cases ***
744824
    [Tags]    v6.2    chrome    744824    high
    Login FortiGate
    Create new user    Local User    &{data_dic}
    Edit User    ${username}    Username    user2
    Edit User    user2    Password    654321
    Edit User    user2    Email Address    fosqa1@fortinet.com
    Edit User    user2    User Account Status    Disabled
    Delete user    user2
    Logout FortiGate
    close browser
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    write test result to file    ${CURDIR}