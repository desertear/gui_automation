*** Settings ***
Documentation    Verify fortinet wiki site can be opened in web portal
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${url_wiki_216753}    wiki.fortinet.com
${FORTIWIKI_MAINPAGE}   Welcome to the new FortiWiki

*** Test Cases ***
216753
    [Tags]    v6.0    chrome    firefox    edge    safari    216753    medium    win10,64bit
    Login SSLVPN Portal
    quick connection of http or https    ${url_wiki_216753}    ${FORTIWIKI_MAINPAGE}
    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***
