*** Settings ***
Documentation    Verify that valid local user can login sslvpn web portal
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
${local_user}    ${SSLVPN_GUI_USERNAME}
${local_password}    ${SSLVPN_GUI_PASSWORD}
*** Test Cases ***
876483
    [Tags]    v6.0    firefox    chrome    edge    safari    876483    medium    win10,64bit
    Login SSLVPN Portal    username=${local_user}    password=${local_password}
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    write test result to file    ${CURDIR}