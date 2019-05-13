*** Settings ***
Documentation    Verify voip profile can be created, edited and deleted from GUI
Resource    ../voip_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${voip_profile_name}     voip_profile_test
${voip_profile_name_2}     voip_profile_test_2

*** Test Cases ***
751742
    [Documentation]    
    [Tags]    6.2.0    voip    chrome    751742    critical    win10    runable

    Login FortiGate    browser=chrome

    Create New VoIP Profile   ${voip_profile_name}
    Edit New VoIP Profile     ${voip_profile_name_2}
    Delete New VoIP Profile

    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    write test result to file    ${CURDIR}