*** Settings ***
Documentation    Verify that Telnet bookmark can be created and Telnet over SSL works in Web App mode
...    Action:
...    1. VPNSSLBookmarkcreate new,create telnet bookmark to windows telnet server and added it to bookmark group
...    2. useruser groupbookmarks, choose group.
...    3. login ssl portal
...    Expect:  the newly created telnet bookmark is there. Click on it, a telnet GUI displayed.
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${folder}    ${SSLVPN_TELNET_HOST}
${username}    ${SSLVPN_TELNET_USERNAME}
${password}    ${SSLVPN_TELNET_PASSWORD}
${bookmark_name}    telnet_automation
${bookmark_description}    automation test for bookmark ${bookmark_name}
*** Test Cases ***
877942
    [Tags]    no_grid    v6.0    chrome    firefox    edge    safari    877942    critical    win10,64bit
    Login SSLVPN Portal
    create bookmark telnet    ${bookmark_name}    ${folder}    ${bookmark_description}
    open and cli check telnet bookmark    ${bookmark_name}    ${folder}    ${username}    ${password}
    [Teardown]    case Teardown    ${bookmark_name}

*** Keywords ***
case Teardown
    [Arguments]    ${name}
    run keyword and ignore error    delete bookmark by name    ${name}
    write test result to file    ${CURDIR}