*** Settings ***
Documentation    Verify the default status in FIPS mode
Resource    ../fipscc_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
@{cmds}    config global
...    get system fips-cc
*** Test Cases ***
751387
    [Documentation]    
    [Tags]    chrome    751387    critical
    ${response}=    Execute CLI commands on FortiGate Via Terminal Server    ${cmds}
    ${if_entropy_required}=    If entropy is required
    Run keyword if    ${if_entropy_required}    Should Match Regexp    @{response}[-1]    entropy-token\\s*: enable
    ...    ELSE    Fail    entropy is not required
    [Teardown]    Run keyword if    ${if_entropy_required}    case Teardown
    
*** Keywords ***
case Teardown
    write test result to file    ${CURDIR}