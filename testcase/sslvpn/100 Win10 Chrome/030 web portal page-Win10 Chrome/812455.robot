*** Settings ***
Documentation    Verify sslvpn firewall policy HTTP/FTP service options works properly with different groups in sslvpn firewall policy for web mode
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
${http_url}    ${SSLVPN_HTTP_IP}
${http_page_keyword}    ${SSLVPN_HTTP_PAGE_KEYWORD}
${ftp_folder}    ${SSLVPN_FTP_HOST}
${ftp_username}    ${SSLVPN_FTP_USERNAME}
${ftp_password}    ${SSLVPN_FTP_PASSWORD}
${matched_text}    ${SSLVPN_FTP_TEST_DIR}
*** Test Cases ***
812455
    [Tags]    v6.0    firefox    chrome    edge    safari    812455    high    win10,64bit
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login SSLVPN Portal    username=${user1}    password=${password1}
    ${status}=    run keyword and return status    quick connection of http or https    ${http_url}    ${http_page_keyword}
    should be true    ${status}
    run keyword and ignore error    Logout SSLVPN Portal
    run keyword and ignore error    close browser
    Login SSLVPN Portal    username=${user1}    password=${password1}    
    ${status}=    run keyword and return status    quick connection of ftp    ${ftp_folder}    ${matched_text}    username=${ftp_username}    password=${ftp_password}
    should not be true    ${status}    
    run keyword and ignore error    Logout SSLVPN Portal
    close browser
    Login SSLVPN Portal    username=${user2}    password=${password2}
    ${status}=    run keyword and return status    quick connection of ftp    ${ftp_folder}    ${matched_text}    username=${ftp_username}    password=${ftp_password}
    should be true    ${status}
    run keyword and ignore error    Logout SSLVPN Portal
    run keyword and ignore error    close browser
    Login SSLVPN Portal    username=${user2}    password=${password2}    
    ${status}=    run keyword and return status    quick connection of http or https    ${http_url}    ${http_page_keyword}
    should not be true    ${status}
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}