*** Settings ***
Documentation    Verify that RDP bookmark can be created and RDP over SSL works in Web App mode with different RDP quality.
...    Action:
...    1. VPNSSLBookmarkcreate new,create RDP bookmark to RDP server and added it to bookmark group
...    2. useruser groupbookmarks, choose group.
...    3. login ssl portal
...    Expect: the newly created RDP bookmark is there. Click on it, a RDP GUI displayed.
Library    SikuliLibrary    mode=NEW
Resource    ../../sslvpn_resource.robot
Suite Setup    begin 816831 test
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
${msg1}    SSL web application activated
${msg2}    SSL web application closed
&{cli_dic1}    message=${msg1}
&{cli_dic2}    message=${msg2}

*** Test Cases ***
816831
    [Tags]    no_grid    v6.0    chrome    firefox    edge    safari    816831    Medium    win10,64bit
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}sslvpn_log_delete_cli.txt
    Login SSLVPN Portal
    create bookmark for rdp    ${bookmark_name}    ${host}    ${port}    ${bookmark_description}
    ...    username=${username}    password=${password}
    open and check rdp bookmark    ${bookmark_name}    ${host}    ${image_dir}
    sleep    30s
    # check application activated log
    @{responses1}=   Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}sslvpn_log_event_check_cli.txt    &{cli_dic1}
    ${response1}=    set variable    @{responses1}[-1]
    should match regexp    ${response1}    rdp
    # check application closed log
    @{responses2}=   Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}sslvpn_log_event_check_cli.txt    &{cli_dic2}
    ${response2}=    set variable    @{responses2}[-1]
    should match regexp    ${response2}    rdp

    [Teardown]    case Teardown    ${bookmark_name}

*** Keywords ***
begin 816831 test
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