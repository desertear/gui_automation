*** Settings ***
Documentation    Verify that sslvpn web mode SMB connection allow selecting and downloading multiple files at the same time
...    Verify:
...    1. check boxes are added beside each file, so any files can be selected/deselect
...    2. select all check box is added so all files can be selected
...    3. download or delete all buttons are added
...    4. multiple files can be selected, downloaded and deleted
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
#this case can only be run on Chrome(v56+)
${file_path}    ${SSLVPN_FILE_UPLOAD_DIR_PATH}
${file_name1}    1M.dat
${file_name2}    2M.dat
${smb_upper_most_dir_name}    ${SSLVPN_SMB_MOST_UPPER_DIR}
${smb_host}    ${SSLVPN_SMB_HOST}
${smb_username}    ${SSLVPN_SMB_USERNAME}
${smb_password}    ${SSLVPN_SMB_PASSWORD}
${download_directory}    ${SSLVPN_FILE_DOWNLOAD_DIR_PATH}
*** Test Cases ***
857459
    [Tags]    v6.0    chrome    857459    high    win10,64bit
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys,selenium.webdriver
    ${prefs}=    create dictionary    download.default_directory=${download_directory}    download.prompt_for_download=${false}    profile.default_content_setting_values.automatic_downloads=${1}
    Call method    ${chrome_options}    add_experimental_option    prefs    ${prefs}
    create webdriver    Chrome    chrome_options=${chrome_options}
    go to    ${SSLVPN_URL}
    Maximize Browser Window
    input text    ${LOGIN_SSLVPN_USERNAME_TEXT}    ${SSLVPN_GUI_USERNAME}
    input password    ${LOGIN_SSLVPN_PASSWORD_TEXT}    ${SSLVPN_GUI_PASSWORD}
    click button    ${LOGIN_SSLVPN_LOGIN_BUTTON}
    #verify if log in SSLVPN portal successfully
    wait Until page contains element    ${PORTAL_QUICK_CONNECTION_BUTTON}
    connect to smb    ${smb_host}    username=${smb_username}    password=${smb_password}
    go to smb upper most directory    ${smb_upper_most_dir_name}
    go to smb directory    ${SSLVPN_SMB_TEST_DIR}
    upload file to smb    ${file_path}    ${file_name1}
    upload file to smb    ${file_path}    ${file_name2}
    ${file_names}=    create list    ${file_name1}    ${file_name2}
    download mutiple smb files    ${file_names}    ${download_directory}
    close window
    select window    MAIN
    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***