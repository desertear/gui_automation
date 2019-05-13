*** Settings ***
Documentation    Verify personal bookmark can be shown and delete.
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${http_url}    http://${SSLVPN_HTTP_IP}
${bookmark_name}    personal_bookmark
${bookmark_description}    automation test for bookmark ${bookmark_name}
@{cmds}    show vpn ssl web user-bookmark
*** Test Cases ***
735370
    [Tags]    v6.0    firefox    chrome    edge    safari    735370    critical    win10,64bit
    Login SSLVPN Portal
    create bookmark for http or https    ${bookmark_name}    ${http_url}    ${bookmark_description}
    ${cli_response}=    Execute CLI commands on FortiGate Via Direct Telnet    ${cmds}
    should contain    @{cli_response}[-1]    edit "${bookmark_name}"
    [Teardown]   case Teardown    ${bookmark_name}

*** Keywords ***
case Teardown
    [Arguments]    ${name}
    delete bookmark by name    ${name}
    write test result to file    ${CURDIR}