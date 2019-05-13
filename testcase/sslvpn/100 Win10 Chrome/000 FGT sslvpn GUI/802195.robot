*** Settings ***
Documentation    Verify GUI sslvpn portal can be created/edited/deleted and display well
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${portal_name}  newportal
${portal_head}    ${portal_name}
${routing_address}    ${FGT_SSLVPN_ROUTING_ADDRESS_NAME}
${routing_ipv6_address}    ${FGT_SSLVPN_ROUTING_IPV6_ADDRESS_NAME}
${source_ip_pool}    ${FGT_SSLVPN_ROUTING_ADDRESS_NAME}
${source_ipv6_pool}    ${FGT_SSLVPN_ROUTING_IPV6_ADDRESS_NAME}

*** Test Cases ***
802195
    [Tags]    v6.0    firefox    chrome   802195    critical    win10,64bit
    Login FortiGate
    Go to VPN
    Go to SSL VPN Portals
    #delete the exist ssl vpn portal
    ${status}=    If ssl vpn portal exists    ${portal_name}
    run keyword if    "${status}"=="True"     delete ssl vpn portal    ${portal_name}
    #add a ssl vpn portal

    create new ssl vpn portal    portal_name=${portal_name}    tunnel_mode=True    ipv6_tunnel_mode=True
    ...    web_mode=True    split_tunnel=False    routing_address=${routing_address}
    ...    ipv6_split_tunnel=False    ipv6_routing_address=${routing_ipv6_address}
    ...    source_ip_pool=${source_ip_pool}    ipv6_source_ip_pool=${source_ipv6_pool}
    ...    portal_message=${portal_head}    theme=Red
    ...    fortinclient_download=True    download_method=Direct    dns_split=False
    #edit the ssl vpn portal
    update ssl vpn portal message   ${portal_name}      update portal message
    #delete the ssl vpn portal
    delete ssl vpn portal    ${portal_name}
    Logout FortiGate
    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***
