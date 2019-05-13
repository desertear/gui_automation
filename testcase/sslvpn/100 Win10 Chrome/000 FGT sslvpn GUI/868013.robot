*** Settings ***
Documentation    Verify GUI sslvpn realms can be created/edited/deleted and display well
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${realm_name}  test
${new_name}  new
${realms_head}    ${realm_name}
${routing_address}    ${FGT_SSLVPN_ROUTING_ADDRESS_NAME}
${routing_ipv6_address}    ${FGT_SSLVPN_ROUTING_IPV6_ADDRESS_NAME}
${source_ip_pool}    ${FGT_SSLVPN_ROUTING_ADDRESS_NAME}
${source_ipv6_pool}    ${FGT_SSLVPN_ROUTING_IPV6_ADDRESS_NAME}

*** Test Cases ***
868013
    [Tags]    v6.0     v6.2    firefox    chrome   868013    critical    win10,64bit
    Login FortiGate
    Create ssl vpn realms    realm_name=${realm_name}
    #edit the ssl vpn realms to enable max user
    Update ssl vpn realms    ${realm_name}
    #delete the ssl vpn realms
    Delete ssl vpn realms    ${realm_name}
    Logout FortiGate
    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***
