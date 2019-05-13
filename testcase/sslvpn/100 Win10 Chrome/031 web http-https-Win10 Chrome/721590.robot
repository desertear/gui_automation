*** Settings ***
Documentation    Verify forticare.fortinet.com can be displayed through ssl vpn web mode and search works.
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${url}    ${url_fortcare_721590}
${matched_element}    ${FAC_LOGIN_HEAD}
${tmp_username}    fosqa
${tmp_password}    real password
*** Test Cases ***
721590
    [Tags]    v6.0    chrome    firefox    edge    safari    721590    critical    win10,64bit    special_env    norun
    Login SSLVPN Portal
    click button    ${PORTAL_QUICK_CONNECTION_BUTTON}
    click element    ${QUICK_HTTP_HTTPS_LABEL}
    input text    ${QUICK_HTTP_URL_TEXT}    ${url}
    #record opened windows
    ${exclude}=    Get window handles
    click button    ${QUICK_LAUNCH_BUTTON}
    ${older_window}=    Select window    ${exclude}
    wait Until element is visible    ${matched_element}
    input text    ${FAC_LOGIN_USERNAME}    ${tmp_username}
    input text    ${FAC_LOGIN_PASSWORD}    ${tmp_password}
    click button    ${FAC_LOGIN_LOGIN}
    wait Until element is visible    ${FORTICARE_HOME_NEW_TICKET}
    close window
    #switch back to SSLVPN GUI window
    Select window    ${older_window}
    wait Until page contains element    ${PORTAL_QUICK_CONNECTION_BUTTON}
    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***
