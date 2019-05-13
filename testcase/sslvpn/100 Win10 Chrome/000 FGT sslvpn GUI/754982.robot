*** Settings ***
Documentation    Verify sslvpn setting page can show port conflict warning in GUI if sslvpn port conflicts with system https access.
Resource    ../../sslvpn_resource.robot

*** Variables ***

*** Test Cases ***
754982
    [Documentation]    The result of this is based on SSLVPN setup,
    ...    and the setup will set the result of checking via global variable.
    [Tags]    v6.0    chrome    firefox    edge    754982    medium    win10,64bit
    ##only judge if SSLVPN configuration has been set by GUI, if it does, current case must pass.
    Run keyword if    "${PORT_CONFLICT}"!="True"    Fail    Warning cannot be seen
    [Teardown]    write test result to file    ${CURDIR}
*** Keywords ***
