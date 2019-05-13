*** Settings ***
Documentation    verify user can visit FortiManager admin page and open report page
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${url}    ${FGT_FMG_IP}
${matched_element}    ${FMG_LOGIN_PAGE_HEAD}
*** Test Cases ***
810665
    [Tags]    v6.0    chrome    firefox    edge    safari    810665    critical    win10,64bit
    Login SSLVPN Portal
    click button    ${PORTAL_QUICK_CONNECTION_BUTTON}
    click element    ${QUICK_HTTP_HTTPS_LABEL}
    input text    ${QUICK_HTTP_URL_TEXT}    ${url}
    #record opened windows
    ${exclude}=    Get window handles
    click button    ${QUICK_LAUNCH_BUTTON}
    ${older_window}=    Select window    ${exclude}
    wait Until element is visible    ${matched_element}
    input text    ${FMG_LOGIN_PAGE_USERNAME}    ${FGT_FMG_USERNAME}
    input text    ${FMG_LOGIN_PAGE_PASSWORD}    ${FGT_FMG_PASSWORD}
    click button    ${FMG_LOGIN_PAGE_LOGIN}
    wait Until element is visible    ${FMG_SELECT_ROOT_ADOM}
    click element    ${FMG_SELECT_ROOT_ADOM}
    wait Until element is visible    ${FMG_HOME_DEVICE_MANAGER}
    close window
    #switch back to SSLVPN GUI window
    Select window    ${older_window}
    wait Until page contains element    ${PORTAL_QUICK_CONNECTION_BUTTON}
    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***

