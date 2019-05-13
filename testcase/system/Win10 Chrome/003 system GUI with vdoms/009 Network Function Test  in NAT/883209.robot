*** Settings ***
Documentation    GUI:Verify latency color codes for DNS server in GUI
...              Failcase with bug #534214, frome build829 ipv6 secondary dns is appeared on the page
...              but the span ha no color, another bug #546386, unreachable show "0" on GUI
Resource    ../../../system_resource.robot

*** Variables ***
${dns_primary}         ${FGT_DNS_SERVER1}
${dns_secondary}       ${FGT_DNS_SERVER2}
${dns_primary_ipv6}       ${FGT_DNS_SERVER1_IPV6}
${dns_secondary_ipv6}     ${FGT_DNS_SERVER2_IPV6}
*** Test Cases ***
883209
    [Tags]    Failcase!Bug#534214    v6.0    chrome   883209    High    win10,64bit    browsers    system   runable   
    [Setup]   Run Cli commands in File   ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login FortiGate   
    Go to network
    go to network_dns
    sleep   15
    Wait Until Element Is Visible        ${NETWORK_DNS_DNS SETTINGS_LATENCY_SECONDARY}
    ##  test for ipv4    
    Test Dns Latency Color    primary    ${dns_primary}
    Test Dns Latency Color    secondary    ${dns_secondary}
    ##  test for ipv6
    Test Dns Latency Color    primary_ipv6    ${dns_primary_ipv6}
    Test Dns Latency Color    secondary_ipv6    ${dns_secondary_ipv6}

    [Teardown]   case teardown

*** Keywords ***
case teardown
   Logout FortiGate
   Close All Browsers
   write test result to file    ${CURDIR}



