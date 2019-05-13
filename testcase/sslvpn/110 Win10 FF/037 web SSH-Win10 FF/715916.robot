*** Settings ***
Documentation    Verify that SSH bookmark can be created and SSH over SSL works in Web App mode.
...    Action:
...    1. Log into SSL VPN portal
...    2. create ssh bookmark
...    Expect:  A GUI ssh window appeared with connect enabled.
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${folder}    ${SSLVPN_SSH_HOST}
${username}    ${SSLVPN_SSH_USERNAME}
${password}    ${SSLVPN_SSH_PASSWORD}
${bookmark_name}    ssh_automation
${bookmark_description}    automation test for bookmark ${bookmark_name}
*** Test Cases ***
715916
    [Tags]    v6.0    chrome    firefox    edge    safari    715916    critical    win10,64bit
    Login SSLVPN Portal
    create bookmark ssh    ${bookmark_name}    ${folder}    ${bookmark_description}
    open and cli check ssh bookmark    ${bookmark_name}    ${folder}    ${username}    ${password}
    [Teardown]    case Teardown    ${bookmark_name}

*** Keywords ***
case Teardown
    [Arguments]    ${name}
    run keyword and ignore error    delete bookmark by name    ${name}
    write test result to file    ${CURDIR}