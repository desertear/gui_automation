*** Settings ***
Documentation    verify user can visit fortinet web site
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
*** Test Cases ***
796047
    [Tags]    v6.0    chrome    firefox    edge    safari    796047    medium    win10,64bit
    Login SSLVPN Portal
    quick connection of http or https    ${url_fortinet}    ${FORTINET_MAINPAGE}
    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***

