*** Settings ***
Documentation    Verify that file can be downloaded properly by clicking on the filename
...   Action:
...    1. login web portal, connect to ftp sever.
...    2. choose a file and click on download
...   Expect:
...   the file has been downloaded successfully
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
#this case can only be run on Chrome(v56+)
${browser}    chrome
${file_path}    ${SSLVPN_FILE_UPLOAD_DIR_PATH}
${file_name}    10M.dat
${ftp_host}    ${SSLVPN_FTP_HOST}
${ftp_username}    ${SSLVPN_FTP_USERNAME}
${ftp_password}    ${SSLVPN_FTP_PASSWORD}
${download_directory}    ${SSLVPN_FILE_DOWNLOAD_DIR_PATH}
*** Test Cases ***
182900
    [Tags]    v6.0    no_grid   firefox    182900    high
    Login SSLVPN Portal    browser=${browser}
    connect to ftp    ${ftp_host}    username=${ftp_username}    password=${ftp_password}
    go to ftp directory    ${SSLVPN_FTP_TEST_DIR}
    upload file to ftp    ${file_path}    ${file_name}
    download ftp file by clicking filename    ${file_name}    ${download_directory}
    close window
    select window    MAIN
    [Teardown]    write test result to file    ${CURDIR}

demo
    [Tags]    v6.0    norun    high
    ${ff_profile}=    Evaluate    sys.modules['selenium.webdriver'].FirefoxProfile()    sys,selenium.webdriver
    # ${prefs}=    create dictionary    download.default_directory=${download_directory}    download.prompt_for_download=${false}    profile.default_content_setting_values.automatic_downloads=${1}
    Call method    ${ff_profile}    set_preference    browser.helperApps.neverAsk.saveToDisk    application/dat
    create webdriver    firefox    firefox_profile=${ff_profile}
    go to    ${SSLVPN_URL}
    Maximize Browser Window
    input text    ${LOGIN_SSLVPN_USERNAME_TEXT}    ${SSLVPN_GUI_USERNAME}
    input password    ${LOGIN_SSLVPN_PASSWORD_TEXT}    ${SSLVPN_GUI_PASSWORD}
    click button    ${LOGIN_SSLVPN_LOGIN_BUTTON}
    #verify if log in SSLVPN portal successfully
    wait Until page contains element    ${PORTAL_QUICK_CONNECTION_BUTTON}
    connect to ftp    ${ftp_host}    username=${ftp_username}    password=${ftp_password}
    go to ftp directory    ${SSLVPN_FTP_TEST_DIR}
    upload file to ftp    ${file_path}    ${file_name}
    download ftp file by clicking filename    ${file_name}    ${download_directory}
    close window
    select window    MAIN
    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***