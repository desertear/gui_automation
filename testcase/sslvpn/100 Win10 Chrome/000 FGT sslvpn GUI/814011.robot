*** Settings ***
Documentation    Verify interface alias "SSL-VPN Interface" is added for virtual interface ssl.root in firewall policy and route.
Resource    ../../sslvpn_resource.robot

*** Variables ***

*** Test Cases ***
814011
    [Documentation]    The result of this is based on SSLVPN setup,
    ...    because checkpoints have been verifeid on SSLVPN setp already.
    [Tags]    v6.0    chrome    firefox    edge    736281    medium    win10,64bit
    ##only judge if SSLVPN configuration has been set by GUI, if it does, current case must pass.
    Run keyword if    "${IF_CONFIG_SSLVPN_ON_FGT_FIRSTLY}"!="GUI"    Fail    GUI setup hasn't been run
    [Teardown]    write test result to file    ${CURDIR}
*** Keywords ***
