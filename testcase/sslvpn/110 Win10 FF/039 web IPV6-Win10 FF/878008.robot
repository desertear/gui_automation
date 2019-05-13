*** Settings ***
Documentation    Verify ssl vpn ipv6 policy can be created from GUI
Resource    ../../sslvpn_resource.robot

*** Variables ***

*** Test Cases ***
878008
    [Documentation]    The result of this is based on SSLVPN setup,
    ...    because checkpoints have been verifeid on SSLVPN setp already.
    [Tags]    v6.0    chrome    firefox    edge    safari    878008    high    win10,64bit
    ##only judge if SSLVPN configuration has been set by GUI, if it does, current case must pass.
    Run keyword if    "${IF_CONFIG_SSLVPN_ON_FGT_FIRSTLY}"!="GUI"    Fail    GUI setup hasn't been run
    [Teardown]    write test result to file    ${CURDIR}
*** Keywords ***