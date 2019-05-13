*** Settings ***
Documentation    Verify personal SSO SMB bookmark can be access with "alternative" sso credential.
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
737590
    [Tags]    v6.0    firefox    chrome    edge    safari    737590    high    win10,64bit
    Login SSLVPN Portal
    create bookmark smb or cifs    ${bookmark_name}    ${folder}    ${bookmark_description}    alternative    ${username}    ${password}
    open and check smb or cifs bookmark    ${bookmark_name}    ${matching_text}    ${username}    ${password}    sso_credentials=alternative
    [Teardown]    case Teardown    ${bookmark_name}

*** Keywords ***
case Teardown
    [Arguments]    ${name}
    run keyword and ignore error    delete bookmark by name    ${name}
    write test result to file    ${CURDIR}