*** Settings ***
Documentation    verify user can visit FAZ admin page and open report page (mantis 0285406)
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${url}    ${FGT_FAZ_IP}
${matched_element}    ${FAZ_LOGIN_PAGE_HEAD}
*** Test Cases ***
796046
    [Tags]    v6.0    chrome    firefox    edge    safari    796046    critical    win10,64bit
    Login SSLVPN Portal
    click button    ${PORTAL_QUICK_CONNECTION_BUTTON}
    click element    ${QUICK_HTTP_HTTPS_LABEL}
    input text    ${QUICK_HTTP_URL_TEXT}    ${url}
    #record opened windows
    ${exclude}=    Get window handles
    click button    ${QUICK_LAUNCH_BUTTON}
    ${older_window}=    Select window    ${exclude}
    wait Until element is visible    ${matched_element}
    input text    ${FAZ_LOGIN_PAGE_USERNAME}    ${FGT_FAZ_USERNAME}
    input text    ${FAZ_LOGIN_PAGE_PASSWORD}    ${FGT_FAZ_PASSWORD}
    wait Until element is visible    ${FAZ_LOGIN_PAGE_LOGIN}
    click button    ${FAZ_LOGIN_PAGE_LOGIN}
    wait Until element is visible    ${FAZ_SELECT_ROOT_ADOM}
    click element    ${FAZ_SELECT_ROOT_ADOM}
    wait Until element is visible    ${FAZ_HOME_DEVICE_MANAGER}
    close window
    #switch back to SSLVPN GUI window
    Select window    ${older_window}
    wait Until page contains element    ${PORTAL_QUICK_CONNECTION_BUTTON}
    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***
