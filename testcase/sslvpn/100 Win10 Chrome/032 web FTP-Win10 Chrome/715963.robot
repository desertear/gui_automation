*** Settings ***
Documentation    Verify that FTP bookmark can be created and the bookmark works
...    Action:
...    1. VPNSSLBookmarkcreate new,create FTP bookmark to FTP server and added it to bookmark group
...    2. useruser groupbookmarks, choose group.
...    3. login ssl portal
...    Expect:  the newly created FTP bookmark is there. Click on it, a FTP GUI displayed.
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${folder}    ${SSLVPN_FTP_HOST}
${username}    ${SSLVPN_FTP_USERNAME}
${password}    ${SSLVPN_FTP_PASSWORD}
${bookmark_name}    ftp_automation
${bookmark_description}    automation test for bookmark ${bookmark_name}
${matching_text}    ${SSLVPN_FTP_TEST_FILE}
*** Test Cases ***
715963
    [Tags]    v6.0    chrome    firefox    edge    safari    715963    critical    win10,64bit
    Login SSLVPN Portal
    create bookmark ftp    ${bookmark_name}    ${folder}    ${bookmark_description}
    open and check ftp bookmark    ${bookmark_name}    ${matching_text}    ${username}    ${password}
    [Teardown]    case Teardown    ${bookmark_name}

*** Keywords ***
case Teardown
    [Arguments]    ${name}
    run keyword and ignore error    delete bookmark by name    ${name}
    write test result to file    ${CURDIR}