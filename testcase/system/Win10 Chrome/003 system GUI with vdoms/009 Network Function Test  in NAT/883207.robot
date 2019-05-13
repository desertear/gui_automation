*** Settings ***
Documentation    GUI:Verify the values obtained as DNS latency time in GUI and get dynamically updated for ipv6
...              Failcase with bug #534214 #546386
Resource    ../../../system_resource.robot

*** Variables ***
${latency__primary_ip}       ${FGT_DNS_SERVER1_IPV6}
${latency_secondary_ip}     ${FGT_DNS_SERVER2_IPV6}

*** Test Cases ***
883207
    [Tags]    Failcase!Bug#534214#546386    v6.0    chrome   883207    High    win10,64bit    browsers    system   runable   
    [Setup]   Run Cli commands in File   ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login FortiGate   
    Go to network
    go to network_dns
    sleep   15
    Wait Until Element Is Visible        ${NETWORK_DNS_DNS SETTINGS_LATENCY_SECONDARY_IPV6}
    Test Ipv6 Dns Latency    primary      ${latency__primary_ip}
    Test Ipv6 Dns Latency    secondary    ${latency_secondary_ip}
    [Teardown]   case teardown

*** Keywords ***
case teardown
   Logout FortiGate
   Close All Browsers
   write test result to file    ${CURDIR}
