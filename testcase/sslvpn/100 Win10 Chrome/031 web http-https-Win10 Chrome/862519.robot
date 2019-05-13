*** Settings ***
Documentation    verify Oracle iPortal https://oa.apo.myfortinet.com can be access in web portal
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${url}    ${url_iportal_862519}
${matched_element}    ${IPORTAL_LOGIN_HEAD}
*** Test Cases ***
862519
    [Tags]    v6.0    chrome    firefox    edge    safari    862519    high    win10,64bit    norun
    Login SSLVPN Portal
    click button    ${PORTAL_QUICK_CONNECTION_BUTTON}
    click element    ${QUICK_HTTP_HTTPS_LABEL}
    input text    ${QUICK_HTTP_URL_TEXT}    ${url}
    #record opened windows
    ${exclude}=    Get window handles
    click button    ${QUICK_LAUNCH_BUTTON}
    ${older_window}=    Select window    ${exclude}
    wait Until element is visible    ${matched_element}
    close window
    #switch back to SSLVPN GUI window
    Select window    ${older_window}
    wait Until page contains element    ${PORTAL_QUICK_CONNECTION_BUTTON}
    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***