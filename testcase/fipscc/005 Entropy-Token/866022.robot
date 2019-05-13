*** Settings ***
Documentation    Verify Entropy-Token related CLI cmds should be invisible in FIPS mode when SoC3 or CP9 is available as the entropy source(0474006)
Resource    ../fipscc_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
@{cmds}    config global
...    sh full-configuration system fips-cc
*** Test Cases ***
866022
    [Documentation]    
    [Tags]    chrome    866022    critical
    ${response}=    Execute CLI commands on FortiGate Via Terminal Server    ${cmds}
    ${if_entropy_required}=    If entropy is required
    Run keyword if   not ${if_entropy_required}    Should Not Match Regexp    @{response}[-1]    entropy-token
    ...    ELSE    Fail    Entropy token should be visible for running FGT.
    [Teardown]    Run keyword if   not ${if_entropy_required}    case Teardown
    
*** Keywords ***
case Teardown
    write test result to file    ${CURDIR}