*** Settings ***
Documentation    verify DNS service is working in ssl vpn web mode.
...    Set dns server 172.16.200.208 in global setting in fgt. The dns server is active directory domain controller(domain: qa.fortinet.com) with dns service installed. Server 172.16.200.209(2k8s1.qa.fortinet.com) is the member server in the domain.
...    In vdom1, set ssl vpn web mode related user group, portal and firewall policy.
...    Login ssl vpn web portal. Access Server 172.16.200.209 through domain name 2k8s1.qa.fortinet.com with ping/http in "connection tools" or "bookmark" widget .
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${http_url}    ${SSLVPN_HTTP_PAGE_KEYWORD}.qatest.com
${http_page_keyword}    ${SSLVPN_HTTP_PAGE_KEYWORD}
*** Test Cases ***
730229
    [Tags]    v6.0    firefox    chrome    edge    safari    730229    high    win10,64bit
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login SSLVPN Portal
    quick connection of http or https    ${http_url}    ${http_page_keyword}
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}