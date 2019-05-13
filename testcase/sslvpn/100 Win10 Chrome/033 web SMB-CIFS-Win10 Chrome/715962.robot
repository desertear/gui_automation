*** Settings ***
Documentation    Verify that SMB bookmark can be created and the bookmark works
...    Action:
...    1. VPNSSLBookmarkcreate new,create SMB bookmark to SMB server and added it to bookmark group
...    2. useruser groupbookmarks, choose group.
...    3. login ssl portal
...    Expect:  the newly created SMB bookmark is there. Click on it, a SMB GUI displayed.
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${folder}    ${SSLVPN_SMB_HOST}
${username}    ${SSLVPN_SMB_USERNAME}
${password}    ${SSLVPN_SMB_PASSWORD}
${bookmark_name}    smb_automation
${bookmark_description}    automation test for bookmark ${bookmark_name}
${matching_text}    ${SSLVPN_SMB_MOST_UPPER_DIR}
*** Test Cases ***
715962
    [Tags]    v6.0    chrome    firefox    edge    safari    715962    critical    win10,64bit
    Login SSLVPN Portal
    create bookmark smb or cifs    ${bookmark_name}    ${folder}    ${bookmark_description}
    open and check smb or cifs bookmark    ${bookmark_name}    ${matching_text}    ${username}    ${password}
    [Teardown]    case Teardown    ${bookmark_name}

*** Keywords ***
case Teardown
    [Arguments]    ${name}
    run keyword and ignore error    delete bookmark by name    ${name}
    write test result to file    ${CURDIR}