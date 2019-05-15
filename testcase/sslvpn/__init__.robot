*** Settings ***
Documentation    GUI automation for SSLVPN feature
Resource    ./sslvpn_resource.robot
Suite Setup    Setup SSLVPN Testing Environment
Suite teardown    clear SSLVPN test data
Test Timeout    5 min
Force Tags    sslvpn

*** Variables ***
${user_name}    ${SSLVPN_GUI_USERNAME}
${user_password}    ${SSLVPN_GUI_PASSWORD}
${group_name}    ${FGT_USER_GROUP_NAME}
${address_name}    ${FGT_ADDRESS_NAME}
${address_subnet}    ${FGT_ADDRESS_SUBNET}
${vpn_portal_name}    ${FGT_SSLVPN_PORTAL_NAME}
# ${realm_name}    ${FGT_SSLVPN_REALM}
${realm_name}    ${False}
${routing_address}    ${FGT_SSLVPN_ROUTING_ADDRESS_NAME}
${routing_ipv6_address}    ${FGT_SSLVPN_ROUTING_IPV6_ADDRESS_NAME}
${source_ip_pool}    ${FGT_SSLVPN_ROUTING_ADDRESS_NAME}
${source_ipv6_pool}    ${FGT_SSLVPN_ROUTING_IPV6_ADDRESS_NAME}
@{interfaces}    ${FGT_SSLVPN_INCOMING_INTERFACE_NAME}
${port}    ${SSLVPN_PORT}
@{hosts}    ${FGT_SSLVPN_ACCESS_HOST}
${portal_head}    ${vpn_portal_name}
${certificate}    ${FGT_SSLVPN_SERVER_CERTIFICATE}
@{ip_ranges}    ${FGT_SSLVPN_CLIENT_ADDRESS_RANGE}    ${FGT_SSLVPN_CLIENT_IPV6_ADDRESS_RANGE}
@{portal_mappings}    GROUP:${group_name}:${vpn_portal_name}:${realm_name}
@{incoming}    SSL-VPN tunnel interface (ssl.root)
@{incoming_ipv6}    SSL-VPN tunnel interface (ssl.root)
@{outgoing}    ${FGT_SSLVPN_OUTGOING_INTERFACE_NAME}
@{outgoing_ipv6}    ${FGT_SSLVPN_OUTGOING_INTERFACE_NAME}
@{source_addresses}    ADDRESS:all    GROUP:${group_name}
@{source_addresses_ipv6}    ADDRESS:all    GROUP:${group_name}
@{destination_addresses}    ADDRESS:all
@{destination_addresses_ipv6}    NONE:all
${policy_name}    ${FGT_POLICY_NAME_FOR_SSLVPN}
${policy6_name}    ${FGT_POLICY6_NAME_FOR_SSLVPN}
#DNS split
${split_dns_domain_name}    ${FGT_SSLVPN_SPLIT_DNS_DOMAIN}
@{split_dns_domain_names}    ${split_dns_domain_name}
&{split_dns}    domains=${split_dns_domain_names}
...    pri_ipv4_dns=${FGT_SSLVPN_SPLIT_DNS_SERVER1}    sec_ipv4_dns=${FGT_SSLVPN_SPLIT_DNS_SERVER2}
...    pri_ipv6_dns=${FGT_SSLVPN_SPLIT_DNS_SERVER1_IPV6}    sec_ipv6_dns=${FGT_SSLVPN_SPLIT_DNS_SERVER2_IPV6}
@{split_dns_list}    &{split_dns}
#predefined bookmark
&{form_data}    key1=1    key2=2
&{bookmark_http}    type=HTTP/HTTPS    name=bookmark_http    url=www.google.ca    sso_status=Alternative    sso_form_data_status=enable
...    sso_form_key_value_pairs=${form_data}    username=httpuser    password=httppwd    description=this is http/https bookmark
&{bookmark_ftp}    type=FTP    name=bookmark_ftp    sso_status=Alternative    username=${SSLVPN_FTP_USERNAME}    password=${SSLVPN_FTP_PASSWORD}    folder=${SSLVPN_FTP_HOST}    description=this is ftp bookmark
&{bookmark_smb}    type=SMB/CIFS    name=bookmark_smb    sso_status=Alternative    username=${SSLVPN_SMB_USERNAME}    password=${SSLVPN_SMB_PASSWORD}    folder=${SSLVPN_SMB_HOST}    description=this is smb bookmark
&{bookmark_rdp}    type=RDP    name=bookmark_rdp    host=${SSLVPN_RDP_HOST}    port=${SSLVPN_RDP_PORT}    description=this is rdp bookmark
...    sso_status=Disable    username=${SSLVPN_RDP_USERNAME}    password=${SSLVPN_RDP_PASSWORD}    layout=US    security=network
&{bookmark_ssh}    type=SSH    name=bookmark_ssh    host=${SSLVPN_SSH_HOST}    description=this is ssh bookmark
&{bookmark_telnet}    type=TELNET    name=bookmark_telnet    host=${SSLVPN_TELNET_HOST}    description=this is telnet bookmark
&{bookmark_vnc}    type=VNC    name=bookmark_vnc    host=${SSLVPN_VNC_HOST}    port=${SSLVPN_VNC_PORT}    password=${SSLVPN_VNC_PASSWORD}    description=this is vnc bookmark
@{bookmark_list}    ${bookmark_http}    ${bookmark_ftp}    ${bookmark_smb}    ${bookmark_rdp}    ${bookmark_ssh}    ${bookmark_telnet}    ${bookmark_vnc}
*** Keywords ***
Setup SSLVPN testing environment
    ${browser_fgt_lower}=    Convert To Lowercase    ${FGT_BROWSER}
    ${browser_sslvpn_lower}=    Convert To Lowercase    ${SSLVPN_BROWSER}
    Run keyword if    "${browser_fgt_lower}"=="safari" and "${browser_sslvpn_lower}"=="safari"    Fail    Wedriver for Safari cannot be created parallelly.
    Run Cli commands in File on Terminal Server    ${SSLVPN_CLI_FILE_DIR}${/}sslvpn_pre_setup_cli.txt
    wait until fgt come to be accessible    ${FGT_CLI_FGT_TELNET_CONNECTION_IP}
    Run keyword if    "${browser_fgt_lower}"=="edge" and "${browser_sslvpn_lower}"=="edge"    Fail    Wedriver for Edge cannot be created parallelly.
    run keyword if    "${IF_CONFIG_SSLVPN_ON_FGT_FIRSTLY}"=="GUI"    Config SSLVPN ON FGT
    ...    ELSE IF    "${IF_CONFIG_SSLVPN_ON_FGT_FIRSTLY}"=="CLI"    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}sslvpn_setup_cli.txt
    ...    ELSE    Log    don't configure FGT

Config SSLVPN ON FGT
    Login FortiGate
    #add a group and add user to this group
    #Create new group    firewall    ${group_name}
    #add a user
    #Create new user    user_type=Local   username=${user_name}    password=${user_password}    user_group=${group_name}
    #add address
    #create new addresses    address    ${address_name}    subnet    ${address_subnet}    @{outgoing}[0]
    #add a ssl vpn portal
    create new ssl vpn portal    portal_name=${vpn_portal_name}    tunnel_mode=True    ipv6_tunnel_mode=True
    ...    web_mode=True    split_tunnel=False    routing_address=${routing_address}
    ...    ipv6_split_tunnel=False    ipv6_routing_address=${routing_ipv6_address}
    ...    source_ip_pool=${source_ip_pool}    ipv6_source_ip_pool=${source_ipv6_pool}
    ...    portal_message=${portal_head}    theme=Red
    ...    fortinclient_download=True    download_method=Direct    dns_split=True
    ...    split_dns=@{split_dns_list}    bookmarks=@{bookmark_list}
    # create ssl vpn realm
    # create ssl vpn realm    ${realm_name}
    # config ssl vpn settings
    Config SSL VPN Settings    ${interfaces}    ${port}    ${hosts}    ${certificate}
    ...    ${ip_ranges}    ${portal_mappings}    full-access
    # create a firewall ipv4 policy for SSLVPN
    create ip policy    ${policy_name}    ${incoming}    ${outgoing}    ${source_addresses}    ${destination_addresses}
    ...    always    ALL    ACCEPT    enable
    # create a firewall ipv6 policy for SSLVPN
    create ip policy    ${policy6_name}    ${incoming_ipv6}    ${outgoing_ipv6}    ${source_addresses_ipv6}    ${destination_addresses_ipv6}
    ...    always    ALL    ACCEPT    enable   ip_version=6 
    Logout FortiGate
    [Teardown]    Close Browser

remove config SSLVPN ON FGT
    Login FortiGate
    #delete policy4
    Go to policy and objects
    Go to IPv4 policy
    wait until element is visible    ${GENERAL_LIST_CREATE_NEW_BUTTON}
    ${status_policy4}=    if ip policy exists    ${policy_name}
    run keyword if    "${status_policy4}"=="True"     delete ip policy    ${policy_name}
    #delete policy6
    Go to policy and objects
    Go to IPv6 policy
    wait until element is visible    ${GENERAL_LIST_CREATE_NEW_BUTTON}
    ${status_policy6}=    if ip policy exists    ${policy6_name}
    run keyword if    "${status_policy6}"=="True"     delete ip policy    ${policy6_name}
    #delete mapped portal in settings
    Go to VPN
    Go to SSL VPN Settings
    delete portal mapping from SSL VPN Settings by portal name    ${vpn_portal_name}
    # delete ssl vpn realm
    # Delete ssl vpn realm    ${realm_name}
    #delete portal
    Go to VPN
    Go to SSL VPN Portals
    ${status_portal}=    If ssl vpn portal exists    ${vpn_portal_name}
    run keyword if    "${status_portal}"=="True"     delete ssl vpn portal    ${vpn_portal_name}
    #delete address
    Go to policy and objects
    Go to Addresses
    ${status_address}=    if address exists    ${address_name}
    run keyword if    "${status_address}"=="True"     delete address    ${address_name}
    #delete group
    Go to User and Device
    Go to User Groups
    ${status_group}=    If group exists    ${group_name}
    run keyword if    "${status_group}"=="True"     Delete Group    ${group_name}
    #delete user
    Go to User and Device
    Go to User Definition
    ${status_user}=    If users exist    ${user_name}
    run keyword if    "${status_user}"=="True"     Delete user    ${user_name}
    Logout FortiGate
    [Teardown]    Close Browser

clear SSLVPN test data
    #because some settings cannot be erased on GUI(i.e. sslvpn user-bookmark), remove them using CLI before clear other data on GUI.
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}sslvpn_pre_teardown_cli.txt
    run keyword if    "${IF_REMOVE_SSLVPN_ON_FGT_FINALLY}"=="GUI"    remove config SSLVPN ON FGT
    ...    ELSE IF    "${IF_REMOVE_SSLVPN_ON_FGT_FINALLY}"=="CLI"    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}sslvpn_teardown_cli.txt
    ...    ELSE    Log    don't configure FGT

clear all bookmarks
    Login SSLVPN Portal
    ${num}=    Get Element Count    xpath://div[@bookmark="bookmark"]
    :For    ${index}    IN RANGE    1    ${num}+1
    \    wait Until page contains element    xpath://div[@bookmark="bookmark"][1]
    \    Mouse Over    xpath://div[@bookmark="bookmark"][1]
    \    click button    xpath://div[@bookmark="bookmark"][1]/button[@title="Delete"]
    \    wait Until page contains element    ${BOOKMARK_DELETE_CONFIRM_H1}
    \    click button    ${BOOKMARK_DELETE_OK_BUTTON}
    Logout SSLVPN Portal
    [teardown]    close browser
