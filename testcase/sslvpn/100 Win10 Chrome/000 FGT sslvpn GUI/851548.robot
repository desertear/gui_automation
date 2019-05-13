*** Settings ***
Documentation    Verify sslvpn settings page and portals page select entry searching work
Resource    ../../sslvpn_resource.robot

*** Variables ***
${access_host}     vlan10
${address_range}    vlan30
*** Test Cases ***
851548
    [Tags]    v6.0    chrome    firefox    edge    851548    high    win10,64bit
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login FortiGate    http://${FGT_IP_ADDRESS}
    Go to VPN
    Go to SSL VPN Settings
    Wait Until Element Is Visible    ${SSL_VPN_SETTINGS_FRAME}
    select frame    ${SSL_VPN_SETTINGS_FRAME}

    # verify restrict access search
    click element    ${SSL_VPN_SETTINGS_ACCESS_SPECIFIC_HOSTS}
    sleep    2
    wait until element is visible    ${SSL_VPN_SETTINGS_HOSTS_DIV}
    click element    ${SSL_VPN_SETTINGS_HOSTS_DIV}
    wait until element is visible    ${SELECT_ENTRY_H1}
    click element    ${SSL_VPN_SETTINGS_HOST_SEARCH}
    input text    ${SSL_VPN_SETTINGS_HOST_SEARCH}    ${access_host}
    wait until element is visible    ${SSL_VPN_SETTINGS_HOST_FIND}
    Wait Until Page Contains regardless of iframe    ${access_host}
    sleep    5

    # verify  address range search
    click element    ${SSL_VPN_SETTINGS_ADDRESS_SPECIFIED}
    sleep    2
    wait until element is visible    ${SSL_VPN_SETTINGS_IP_RANGES_DIV}
    click element    ${SSL_VPN_SETTINGS_IP_RANGES_DIV}
    wait until element is visible    ${SELECT_ENTRY_H1}
    click element    ${SSL_VPN_SETTINGS_HOST_SEARCH}
    input text    ${SSL_VPN_SETTINGS_HOST_SEARCH}    ${address_range}
    wait until element is visible    ${SSL_VPN_SETTINGS_HOST_FIND}
    Wait Until Page Contains regardless of iframe    ${address_range}
    sleep    5
    unselect frame

    #verify sslvpn portal routing address search
    Go to VPN
    Go to SSL VPN Portals
    click element    ${VPN_PORTAL_CREATE}
    sleep    2
    wait Until element is Visible    ${VPN_PORTAL_CREATE_H1}
    click element    ${VPN_PORTAL_ROUTING_ADDR_DIV}
    wait until element is visible    ${SELECT_ENTRY_H1}
    click element    ${SSL_VPN_SETTINGS_HOST_SEARCH}
    input text    ${SSL_VPN_SETTINGS_HOST_SEARCH}    ${address_range}
    wait until element is visible    ${SSL_VPN_SETTINGS_HOST_FIND}
    Wait Until Page Contains regardless of iframe    ${address_range}
    sleep    5

    # verify sslvpn portal source ip pools search
    click element    ${VPN_PORTAL_SOURCE_IP_DIV}
    sleep    2
    wait until element is visible    ${SELECT_ENTRY_H1}
    click element    ${SSL_VPN_SETTINGS_HOST_SEARCH}
    input text    ${SSL_VPN_SETTINGS_HOST_SEARCH}    ${access_host}
    wait until element is visible    ${SSL_VPN_SETTINGS_HOST_FIND}
    Wait Until Page Contains regardless of iframe    ${access_host}
    sleep    5

    click element    ${VPN_PORTAL_CANCEL_BUTTON}

    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    [Arguments]
    Logout FortiGate
    Close All Browsers
    run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}