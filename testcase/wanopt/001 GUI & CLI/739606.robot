*** Settings ***
Documentation    Verify wanopt profile can be created and edited from GUI
Resource    ../wanopt_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${wanopt_profile_name}    test1
${wanopt_profile_name_2}    test2
    
*** Test Cases ***
739606
    [Documentation]    
    [Tags]    6.2.0    wanopt    chrome    739606    high    win10    runable

    Login FortiGate    browser=chrome

    Create New Wanopt Profile   ${wanopt_profile_name}
    Edit New Wanopt Profile     ${wanopt_profile_name_2}

    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    write test result to file    ${CURDIR}