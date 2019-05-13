*** Settings ***
Documentation    Verify GUI can highlight new feature and collect user feedback
...              no this feature in B822
Resource    ../../../system_resource.robot

*** Variables ***

*** Test Cases ***
875115
    [Documentation]    
    [Tags]    v6.0    chrome   875115    high    win10,64bit    browsers  norun
    ##only judge if the embeded console can be connected by different browser, if it does, current case must pass.
    Login FortiGate     
    Unselect Frame
    [teardown]    case teardown

*** Keywords ***
