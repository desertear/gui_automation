*** Settings ***
Documentation    Verify that FTP connect to unreachable site will get "destination unreachable" error
...   Action:
...    1. login web portal, connect to ftp sever.
...    2. choose a file and click on download
...   Expect:
...   the file has been downloaded successfully
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
#this case can only be run on Chrome(v56+) and Edge
${ftp_host}    173.17.201.56
${username}    ${SSLVPN_FTP_USERNAME}
${password}    ${SSLVPN_FTP_PASSWORD}
${FTP_ERROR}   Destination unreachable
*** Test Cases ***
182900
    [Tags]    v6.0    chrome    ff    edge    182900    high
    Login SSLVPN Portal
    click button    ${PORTAL_QUICK_CONNECTION_BUTTON}
    click element    ${QUICK_FTP_LABEL}
    input text    ${QUICK_FTP_FOLDER_TEXT}    ${ftp_host}
    ${exclude}=    Get window handles
    #launch ftp
    click button    ${QUICK_LAUNCH_BUTTON}
    ${older_window}=    Select window    ${exclude}
    input text        ${QUICK_FTP_USERNAME_TEXT}    ${username}
    input text        ${QUICK_FTP_PASSWORD_TEXT}    ${password}
    click button    ${QUICK_FTP_LOGIN_BUTTON}
    wait Until page contains    ${FTP_ERROR}
    close window
    select window    MAIN
    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***