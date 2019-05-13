*** Settings ***
Documentation   Verify VoIP Feature could be enabled from Feature Visibility on GUI
Resource    ../voip_resource.robot

#*** Variables ***
*** Test Cases ***
751744
    [Documentation]    
    [Tags]    6.2.0    voip    chrome    751744    high    win10    runable
    login FortiGate

    Go to system
    go to system_feature visibility
    Disable_FGT_Feature_Additional   VoIP
    sleep      3
    Check VoIP Entry Is Not In Security Profiles

    Go to system
    go to system_feature visibility
    Enable_FGT_Feature_Additional   VoIP
    sleep      3
    Check VoIP Entry Is In Security Profiles

 
    [Teardown]    Case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    write test result to file    ${CURDIR}
