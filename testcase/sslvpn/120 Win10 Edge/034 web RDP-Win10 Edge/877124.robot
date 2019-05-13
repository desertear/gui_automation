*** Settings ***
Documentation    Verify that RDP bookmark can be created and RDP over SSL works in Web App mode with different RDP quality.
...    Action:
...    1. VPNSSLBookmarkcreate new,create RDP bookmark to RDP server and added it to bookmark group
...    2. useruser groupbookmarks, choose group.
...    3. login ssl portal
...    Expect: the newly created RDP bookmark is there. Click on it, a RDP GUI displayed.
Library    SikuliLibrary    mode=NEW
Resource    ../../sslvpn_resource.robot
Suite Setup    begin 877124 test
Suite Teardown    clear up

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${host}    ${SSLVPN_RDP_HOST}
${port}    ${SSLVPN_RDP_PORT}
${username}    ${SSLVPN_RDP_USERNAME}
${password}    ${SSLVPN_RDP_PASSWORD}
${bookmark_name}    rdp_automation
${bookmark_description}    automation test for bookmark ${bookmark_name}
${image_dir}    ${SIKULI_IMAGE_DIR}${/}rdp
*** Test Cases ***
877124
    [Tags]    no_grid    v6.0    chrome    firefox    edge    safari    877124    critical    win10,64bit
    Login SSLVPN Portal
    create bookmark for rdp    ${bookmark_name}    ${host}    ${port}    ${bookmark_description}
    ...    username=${username}    password=${password}
    open and check rdp bookmark    ${bookmark_name}    ${host}    ${image_dir}
    [Teardown]    case Teardown    ${bookmark_name}

*** Keywords ***
begin 877124 test
    Start Sikuli Process
    Set Library Search Order    SeleniumLibrary    SikuliLibrary

clear up
    run keyword and ignore error    Logout SSLVPN Portal
    run keyword and ignore error    Delete All Cookies
    run keyword and ignore error    close browser
    run keyword and ignore error    Stop Remote Server

case Teardown
    [Arguments]    ${name}
    run keyword and ignore error    delete bookmark by name    ${name}
    write test result to file    ${CURDIR}