*** Settings ***
Documentation    Verify wanopt authentication group can be created, edited and deleted from GUI
Resource    ../wanopt_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${wanopt_auth_group_name}     auth_group_test
${wanopt_auth_group_name_2}     auth_group_test_2

*** Test Cases ***
210000
    [Documentation]    
    [Tags]    6.2.0    wanopt    chrome    210000    high    win10    runable

    Login FortiGate    browser=chrome

    Create New Wanopt Auth Group   ${wanopt_auth_group_name}
    Edit New Wanopt Auth Group     ${wanopt_auth_group_name_2}
    Delete New Wanopt Auth Group

    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    write test result to file    ${CURDIR}