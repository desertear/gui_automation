*** Settings ***
Documentation    Verify GUI radius server pages test button work well (bug #128289)
Resource    ../user_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${radius_name}    ${USER_RADIUS1_NAME}
${radius_server}    ${USER_RADIUS1_SERVER}
${radius_secret}    ${USER_RADIUS1_SECRET}
@{arg}    ${USER_RADIUS1_USER1}    ${USER_RADIUS1_PASSWORD1}    Successful
*** Test Cases ***
730226
    [Tags]    v6.2    chrome    730226    high
    Login FortiGate
    Create New RADIUS Server    ${radius_name}    Default    ${EMPTY}    ${False}    ${radius_server}    ${radius_secret}
    Edit Radius Server    ${radius_name}    Test Connectivity    Successful
    Edit Radius Server    ${radius_name}    Test User Credentials    ${arg}
    Delete RADIUS Server  ${radius_name}
    Logout FortiGate
    Close Browser
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    write test result to file    ${CURDIR}