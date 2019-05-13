*** Settings ***
Documentation    Verify sslvpn firewall policy HTTPS/SMB service options works properly with different groups in sslvpn firewall policy for web mode
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${group1}    tmp_grp1
${group2}    tmp_grp2
${user1}    tmp_user1
${user2}    tmp_user2
${password1}    123456
${password2}    123456
${policy_id_1}    1001
${policy_id_2}    1002
${https_url}    https://${SSLVPN_HTTP_IP}
${https_page_keyword}    ${SSLVPN_HTTP_PAGE_KEYWORD}
${smb_folder}    ${SSLVPN_SMB_HOST}
${smb_username}    ${SSLVPN_SMB_USERNAME}
${smb_password}    ${SSLVPN_SMB_PASSWORD}
${matched_text}    ${SSLVPN_SMB_MOST_UPPER_DIR}
*** Test Cases ***
871415
    [Tags]    v6.0    firefox    chrome    edge    safari    871415    high    win10,64bit
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login SSLVPN Portal    username=${user1}    password=${password1}
    ${status}=    run keyword and return status    quick connection of http or https    ${https_url}    ${https_page_keyword}
    should be true    ${status}
    run keyword and ignore error    Logout SSLVPN Portal
    close all browsers
    Login SSLVPN Portal    username=${user1}    password=${password1}
    ${status}=    run keyword and return status    quick connection of smb or cifs    ${smb_folder}    ${matched_text}    username=${smb_username}    password=${smb_password}
    should not be true    ${status}    
    run keyword and ignore error    Logout SSLVPN Portal
    close all browsers
    Login SSLVPN Portal    username=${user2}    password=${password2}
    ${status}=    run keyword and return status    quick connection of smb or cifs    ${smb_folder}    ${matched_text}    username=${smb_username}    password=${smb_password}
    should be true    ${status}
    run keyword and ignore error    Logout SSLVPN Portal
    close all browsers
    Login SSLVPN Portal    username=${user2}    password=${password2}
    ${status}=    run keyword and return status    quick connection of http or https    ${https_url}    ${https_page_keyword}
    should not be true    ${status}
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}