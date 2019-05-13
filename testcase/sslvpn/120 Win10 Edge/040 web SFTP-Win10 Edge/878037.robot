*** Settings ***
Documentation    sslvpn web mode HTTP application will generate event logs.
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot

${folder}    ${SSLVPN_SFTP_HOST}
${username}    ${SSLVPN_SFTP_USERNAME}
${password}    ${SSLVPN_SFTP_PASSWORD}
${bookmark_name}    sftp_automation
${bookmark_description}    automation test for bookmark ${bookmark_name}
${matching_text}    ${SSLVPN_SFTP_TEST_FILE}
*** Test Cases ***
878037
    [Tags]    v6.0    chrome    firefox    edge    safari    878037    critical    win10,64bit
    Login SSLVPN Portal
    create bookmark sftp    ${bookmark_name}    ${folder}    ${bookmark_description}
    open and check sftp bookmark    ${bookmark_name}    ${matching_text}    ${username}    ${password}
    [Teardown]    case Teardown    ${bookmark_name}

*** Keywords ***
case Teardown
    [Arguments]    ${name}
    run keyword and ignore error    delete bookmark by name    ${name}
    write test result to file    ${CURDIR}