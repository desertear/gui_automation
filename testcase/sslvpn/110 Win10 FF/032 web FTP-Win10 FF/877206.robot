*** Settings ***
Documentation    Verify personal SSO FTP bookmark can be access with "alternative" sso credential.
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${folder}    ${SSLVPN_FTP_HOST}
${username}    ${SSLVPN_FTP_USERNAME}
${password}    ${SSLVPN_FTP_PASSWORD}
${bookmark_name}    ftp_automation
${bookmark_description}    automation test for bookmark ${bookmark_name}
${matching_text}    ${SSLVPN_FTP_TEST_DIR}
*** Test Cases ***
877206
    [Tags]    v6.0    chrome    firefox    edge    safari    877206    high    win10,64bit
    Login SSLVPN Portal
    create bookmark ftp    ${bookmark_name}    ${folder}    ${bookmark_description}    alternative    ${username}    ${password}
    open and check ftp bookmark    ${bookmark_name}    ${matching_text}    ${username}    ${password}    sso_credentials=alternative
    [Teardown]    case Teardown    ${bookmark_name}

*** Keywords ***
case Teardown
    [Arguments]    ${name}
    run keyword and ignore error    delete bookmark by name    ${name}
    write test result to file    ${CURDIR}