*** Settings ***
Documentation    Verify winscp transfer big file over 2G has no problem through sslvpn tunnel
Library    SikuliLibrary    mode=NEW
Resource    ../sslvpn_resource.robot

*** Variables ***
${username}    ${SSLVPN_GUI_USERNAME}
${password}    ${SSLVPN_GUI_PASSWORD}
${profile}    sslvpn_automation_user
${download_path}    ${SSLVPN_FILE_DOWNLOAD_DIR_PATH}

*** Test Cases ***
871843
    [Timeout]    20 min
    [Tags]    win10    v6.0    v6.2    871843    screen_alive    forticlient_6.0.3.0155    time_consuming
    #Config SSLVPN ON FGT
    open forticlient and select profile    ${profile}
    fill in username and password    ${username}    ${password}
    connect sslvpn on forticlient
    # need 30 minutes to download 2GB file
    winscp download file    winscp_2GBfile.png
    logout sslvpn on forticlient
    [Teardown]    case Teardown

*** Keywords ***

case Teardown
    [Arguments]
    run keyword and ignore error    Delete All Cookies
    run keyword and ignore error    close browser
    write test result to file    ${CURDIR}