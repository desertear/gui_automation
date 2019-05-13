*** Settings ***
Documentation    Verify FAC web gui can be displayed through ssl vpn web mode.
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${url}    https://${FAC_IP}
${tmp_username}    admin
${tmp_password}    ${EMPTY}
*** Test Cases ***
757059
    [Tags]    v6.0    chrome    firefox    edge    safari    757059    high    win10,64bit
    Login SSLVPN Portal
    click button    ${PORTAL_QUICK_CONNECTION_BUTTON}
    click element    ${QUICK_HTTP_HTTPS_LABEL}
    input text    ${QUICK_HTTP_URL_TEXT}    ${url}
    #record opened windows
    ${exclude}=    Get window handles
    click button    ${QUICK_LAUNCH_BUTTON}
    ${older_window}=    Select window    ${exclude}
    ${if_warning}=    run keyword and return status    wait Until element is visible    ${FAC_WARNING_CONTENT}
    run keyword if    "${if_warning}"=="${True}"    click element    ${FAC_WARNING_ACCEPT}
    input text    ${FAC_LOGIN_USERNAME}    ${tmp_username}
    input text    ${FAC_LOGIN_PASSWORD}    ${tmp_password}
    click button    ${FAC_LOGIN_LOGIN}
    wait Until element is visible    ${FAC_HEAD}
    close window
    #switch back to SSLVPN GUI window
    Select window    ${older_window}
    wait Until page contains element    ${PORTAL_QUICK_CONNECTION_BUTTON}
    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***