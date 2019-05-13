*** Settings ***
Documentation    Verify windows Forticlient can custom login ssl vpn tunnel mode.
Library    SikuliLibrary    mode=NEW
Resource    ../sslvpn_resource.robot

*** Variables ***
${profile}    sslvpn_automation_user

*** Test Cases ***
702592
    [Tags]    win10    v6.0    v6.2    702592    screen_alive    forticlient_6.0.3.0155
    Set Library Search Order    SeleniumLibrary    SikuliLibrary
    open forticlient and select profile    ${profile}
    reset forticlient profile
    [Teardown]    case Teardown

*** Keywords ***

case Teardown
    [Arguments]
    run keyword and ignore error    close forticlient
    write test result to file    ${CURDIR}