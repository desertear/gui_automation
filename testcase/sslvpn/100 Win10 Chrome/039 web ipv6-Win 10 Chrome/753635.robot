*** Settings ***
Documentation    verify http/https service works in ipv6 sslvpn web portal
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
${url_ipv6}    ${SSLVPN_URL_V6}
${http_pc5}    http://[2000:172:16:200::55]
${https_pc5}    https://[2000:172:16:200::55]
*** Test Cases ***
753635
    [Tags]    v6.0    firefox    chrome    edge    safari    753635    medium    win10,64bit
    Login SSLVPN Portal    url=${url_ipv6}
    quick connection of http or https    ${http_pc5}    pc5
    quick connection of http or https    ${https_pc5}    pc5
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    write test result to file    ${CURDIR}