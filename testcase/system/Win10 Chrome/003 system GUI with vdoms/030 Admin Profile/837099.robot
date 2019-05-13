*** Settings ***
Documentation    Verify the invalid value in the override time ou is not acceptable on GUI and CLI
...              time range shoud be (0-480)
Resource    ../../../system_resource.robot

*** Variables ***


*** Test Cases ***
837099
    [Documentation]    
    [Tags]    v6.0    chrome   837099    Medium    win10,64bit    runable
    login FortiGate
    Go to Global
    Go to system
    go to system_admin_profiles
    ${status}=   run keyword and return status    Create Admin Profile  837099    time_out=0
    should be equal   "${status}"   "False"
    wait until Element Is Visible    ${SYSTEM_ADMIN_PROFILES_OVERRIDE_IDEL_MIN_WARN}
    
    Go to system
    go to system_admin_profiles
    ${status}=   run keyword and return status    Create Admin Profile  837099    time_out=500
    should be equal   "${status}"   "False"
    wait until Element Is Visible    ${SYSTEM_ADMIN_PROFILES_OVERRIDE_IDEL_MAX_WARN}
    
    [Teardown]   case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate  
    Close All Browsers
    write test result to file    ${CURDIR}

   
