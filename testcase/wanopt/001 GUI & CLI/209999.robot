*** Settings ***
Documentation    Verify wanopt peer can be created and edited from GUI
Resource    ../wanopt_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${wanopt_peer_name}     peer_test
${wanopt_peer_name_2}   peer_name_2
${wanopt_peer_ip}       111.111.111.111
${wanopt_peer_ip_2}     222.222.222.222

*** Test Cases ***
209999
    [Documentation]    
    [Tags]    6.2.0    wanopt    chrome    209999    high    win10    runable

    Login FortiGate    browser=chrome

    Create New Wanopt Peer   ${wanopt_peer_name}    ${wanopt_peer_ip}
    Edit New Wanopt Peer   ${wanopt_peer_name_2}    ${wanopt_peer_ip_2}

    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    write test result to file    ${CURDIR}