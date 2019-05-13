*** Settings ***
Documentation    Verify that HTTPs bookmark can be created and HTTP over SSL works in Web App mode
...    Action:
...    1. VPNSSLBookmarkcreate new,create http bookmark and bookmark group
...    2. useruser groupbookmarks, choose group.
...    3. login ssl portal
...    Expect:
...    the newly created web bookmark is there. Click on it, webpage opened.
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${browser}    firefox
${http_url}    https://${SSLVPN_HTTP_IP}
${http_page_keyword}    ${SSLVPN_HTTP_PAGE_KEYWORD}
${bookmark_name}    https_automation
${bookmark_description}    automation test for bookmark ${bookmark_name}
*** Test Cases ***
715957
    [Tags]    v6.0    firefox    715957    critical    win10,64bit
    Login SSLVPN Portal    browser=${browser}
    create bookmark for http or https    ${bookmark_name}    ${http_url}    ${bookmark_description}
    open and check http bookmark    ${bookmark_name}    ${http_page_keyword}
    [Teardown]   case Teardown    ${bookmark_name}

*** Keywords ***
case Teardown
    [Arguments]    ${name}
    run keyword and ignore error    delete bookmark by name    ${name}
    write test result to file    ${CURDIR}