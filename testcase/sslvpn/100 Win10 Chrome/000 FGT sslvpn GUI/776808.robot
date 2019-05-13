*** Settings ***
Documentation    Verify the first IPV4 sslvpn policy can be created by the link in sslvpn setting page.
Resource    ../../sslvpn_resource.robot

*** Variables ***

*** Test Cases ***
776808
    [Documentation]    The result of this is based on SSLVPN setup,
    ...    and the setup will set the result of checking via global variable.
    [Tags]    v6.0    chrome    firefox    edge    776808    medium    win10,64bit
    ##only judge if SSLVPN configuration has been set by GUI, if it does, current case must pass.
    Run keyword if    "${POLICY_WARNING}"!="True"    Fail    Warning cannot be seen
    [Teardown]    write test result to file    ${CURDIR}
*** Keywords ***