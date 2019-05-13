*** Settings ***
Documentation    Verify http service ok
Library    SikuliLibrary    mode=NEW
Resource    ../sslvpn_resource.robot

*** Variables ***
${username}    ${SSLVPN_GUI_USERNAME}
${password}    ${SSLVPN_GUI_PASSWORD}
${profile}    sslvpn_automation_user
${url}     http://${SSLVPN_HTTP_IP}
${keyword}    ${SSLVPN_HTTP_PAGE_KEYWORD}

*** Test Cases ***
716511
    [Tags]    win10    v6.0    v6.2    716511    screen_alive    forticlient_6.0.3.0155
    #Config SSLVPN ON FGT
    open forticlient and select profile    ${profile}
    fill in username and password    ${username}    ${password}
    connect sslvpn on forticlient
    check http on local pc    ${url}    ${keyword}

    [Teardown]    case Teardown

*** Keywords ***

case Teardown
    [Arguments]
    run keyword and ignore error    logout sslvpn on forticlient
    run keyword and ignore error    Delete All Cookies
    run keyword and ignore error    close browser
    write test result to file    ${CURDIR}