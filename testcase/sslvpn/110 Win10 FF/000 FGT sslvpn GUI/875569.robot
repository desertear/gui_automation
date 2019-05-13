*** Settings ***
Documentation    Verify GUI sslvpn portal reference is correct
Resource    ../../sslvpn_resource.robot

*** Variables ***

*** Test Cases ***
875569
    [Documentation]    The result of this is based on SSLVPN setup,
    ...    and the setup will set the result of checking via global variable.
    [Tags]    v6.0    chrome    firefox    edge    875569    low    win10,64bit     norun
    ##only judge if SSLVPN configuration has been set by GUI, if it does, current case must pass.
    Run keyword if    "${LINK_CORRECT}"!="True"    Fail    Warning cannot be seen
    [Teardown]    write test result to file    ${CURDIR}
*** Keywords ***
