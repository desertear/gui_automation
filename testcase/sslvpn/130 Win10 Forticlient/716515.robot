*** Settings ***
Documentation    Verify rdp service ok
Library    SikuliLibrary    mode=NEW
Resource    ../sslvpn_resource.robot

*** Variables ***
${RDP_IMAGE}    ${SIKULI_IMAGE_DIR}${/}rdp
${username}    ${SSLVPN_GUI_USERNAME}
${password}    ${SSLVPN_GUI_PASSWORD}
${rdp_username}    w2k12\\fosqa
${rdp_password}    123456
${profile}    sslvpn_automation_user
${rdp_server}     ${SSLVPN_RDP_HOST}


*** Test Cases ***
716515
    [Tags]    win10    v6.0    v6.2    716515    screen_alive    forticlient_6.0.3.0155
    #Config SSLVPN ON FGT
    open forticlient and select profile    ${profile}
    fill in username and password    ${username}    ${password}
    connect sslvpn on forticlient
    open rdp on local pc    ${rdp_server}    ${RDP_IMAGE}
    check rdp on local pc     ${RDP_IMAGE}

    [Teardown]    case Teardown

*** Keywords ***

case Teardown
    [Arguments]
    run keyword and ignore error    logout sslvpn on forticlient
    run keyword and ignore error    close rdp connection for local pc
    write test result to file    ${CURDIR}