*** Settings ***
Documentation    Verify quick connection HTTP/HTTPS tool works with both HTTP and HTTPS
...   Action:
...   1. establish vpn connection,portal appears.
...   2. choose web tool, input target web URL. Click \'go\'
...   Expect:
...   The target website\'s page displayed.
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${http_url1}    ${SSLVPN_HTTP_IP}
${http_url2}    https://${SSLVPN_HTTP_IP}
${http_url3}    http://${SSLVPN_HTTP_IP}
${matched_text}    ${SSLVPN_HTTP_PAGE_KEYWORD}
*** Test Cases ***
182946
    [Tags]    v6.0    chrome    firefox    edge    safari    182946    critical    win10,64bit
    Login SSLVPN Portal
    quick connection of http or https    ${http_url1}    ${matched_text}
    quick connection of http or https    ${http_url2}    ${matched_text}
    quick connection of http or https    ${http_url3}    ${matched_text}
    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***