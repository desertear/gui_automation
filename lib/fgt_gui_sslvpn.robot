*** Settings ***
Documentation     This file contains FortiGate GUI VPN operation

*** Keywords ***

###VPN->SSL-VPN Portals##
##SSL-VPN Portals##
Go to SSL VPN Portals
    Wait Until element is visible    ${SSL_VPN_PORTALS_ENTRY}
    click element    ${SSL_VPN_PORTALS_ENTRY}

create new ssl vpn portal
    [Arguments]    ${portal_name}=testportal    ${tunnel_mode}=True    ${ipv6_tunnel_mode}=True    ${web_mode}=True
    ...    ${split_tunnel}=False    ${routing_address}=SSLVPN_TUNNEL_ADDR1    ${ipv6_split_tunnel}=False    ${ipv6_routing_address}=SSLVPN_TUNNEL_IPv6_ADDR1
    ...    ${source_ip_pool}=SSLVPN_TUNNEL_ADDR1    ${ipv6_source_ip_pool}=SSLVPN_TUNNEL_IPv6_ADDR1
    ...    ${portal_message}=SSL-VPN Portal    ${theme}=Blue    ${fortinclient_download}=True
    ...    ${download_method}=Direct    ${dns_split}=True    ${split_dns}=@{EMPTY}    ${bookmarks}=@{EMPTY}
    [Documentation]    tunne_mode:True/False,...
    ...    argument @{bookmarks} is a list of dictionaries that contains all required fields according to bookmark's type.
    ...    for example: [{"type":"HTTP/HTTPS","name":"bookmark1","url":"www.google.ca","description":"this is a book mark for http/https"},
    ...    {"type":"FTP","name":"bookmark2","folder":"172.16.200.55","description":"this is a book mark for FTP"}]
    Go to VPN
    Go to SSL VPN Portals
    ${status}=    If ssl vpn portal exists    ${portal_name}
    run keyword if    "${status}"=="True"     delete ssl vpn portal    ${portal_name}
    click element    ${VPN_PORTAL_CREATE}
    wait Until element is Visible    ${VPN_PORTAL_CREATE_H1}

    #Judge if ipv4 tunnel mode is selected
    ${tunnel_selected}=    run keyword and return status    Checkbox Should Be Selected    ${VPN_PORTAL_TUNNEL_MODE_CHECKBOX}
    #Judge if ipv6 tunnel mode is selected
    ${ipv6_tunnel_selected}=    run keyword and return status    Checkbox Should Be Selected    ${VPN_PORTAL_IPV6_TUNNEL_MODE_CHECKBOX}
    #Judge if web mode is selected
    ${web_selected}=    run keyword and return status    Checkbox Should Be Selected    ${VPN_PORTAL_WEB_MODE_CHECKBOX}
    #judge if forticlient download is enabled
    ${forticlient_selected}=    run keyword and return status    Checkbox Should Be Selected    ${VPN_PORTAL_FORTICLIENT_DOWNLOAD_CHECKBOX}
    #import portal name
    input text    ${VPN_PORTAL_CREATE_NAME_TEXT}    ${portal_name}
    #Begin to set Ipv4 Tunnel mode
    #enable IPv4 tunnel mode if it's required
    run keyword if    "${tunnel_mode}"=="True" and "${tunnel_selected}"!="True"    click element    ${VPN_PORTAL_TUNNEL_MODE_LABEL}
    ...    ELSE IF    "${tunnel_mode}"=="False" and "${tunnel_selected}"!="False"    click element    ${VPN_PORTAL_TUNNEL_MODE_LABEL}
    ...    ELSE    log    don't need to change checkbox status
    #enable IPv4 split tunneling if it's required
    ${split_selected}=    run keyword if    "${tunnel_mode}"=="True"    run keyword and return status    Checkbox Should Be Selected    ${VPN_PORTAL_SPLIT_CHECKBOX}
    run keyword if    "${split_tunnel}"=="True" and "${split_selected}"!="True"    click element    ${VPN_PORTAL_SPLIT_LABEL}
    ...    ELSE IF    "${split_tunnel}"=="False" and "${split_selected}"!="False"    click element    ${VPN_PORTAL_SPLIT_LABEL}
    ...    ELSE    log    don't need to change checkbox status
    #add IPv4 routing address
    run keyword if    "${split_tunnel}"=="True"    add routing address to ssl vpn portal    ${routing_address}
    #sleep    5
    #add IPv4 source IP pools
    add source ip pools to ssl vpn portal    ${source_ip_pool}
    sleep    5

    #Begin to set Ipv6 Tunnel mode
    #enable IPv6 tunnel mode if it's required
    run keyword if    "${ipv6_tunnel_mode}"=="True" and "${ipv6_tunnel_selected}"!="True"    click element    ${VPN_PORTAL_IPV6_TUNNEL_MODE_LABEL}
    ...    ELSE IF    "${ipv6_tunnel_mode}"=="False" and "${ipv6_tunnel_selected}"!="False"    click element    ${VPN_PORTAL_IPV6_TUNNEL_MODE_LABEL}
    ...    ELSE    log    don't need to change checkbox status
    #enable IPv6 split tunneling if it's required
    ${ipv6_split_selected}=    run keyword if    "${ipv6_tunnel_mode}"=="True"    run keyword and return status    Checkbox Should Be Selected    ${VPN_PORTAL_SPLIT_IPV6_CHECKBOX}
    run keyword if    "${ipv6_split_tunnel}"=="True" and "${ipv6_split_selected}"!="True"    click element    ${VPN_PORTAL_SPLIT_IPV6_LABEL}
    ...    ELSE IF    "${ipv6_split_tunnel}"=="False" and "${ipv6_split_selected}"!="False"    click element    ${VPN_PORTAL_SPLIT_IPV6_LABEL}
    ...    ELSE    log    don't need to change checkbox status
    #add IPv6 routing address
    run keyword if    "${ipv6_split_tunnel}"=="True"    add routing address to ssl vpn portal    ${ipv6_routing_address}    ipv6
    #sleep    5
    #add IPv6 source IP pools
    add source ip pools to ssl vpn portal    ${ipv6_source_ip_pool}    ipv6
    sleep    5

    #set tunnel mode client options
    #enable DNS split Tunneling as required.
    ${dns_split_selected}=    run keyword if    "${dns_split}"=="True"    run keyword and return status    Checkbox Should Be Selected    ${VPN_PORTAL_DNS_SPLIT_CHECKBOX}
    run keyword if    "${dns_split}"=="True" and "${dns_split_selected}"!="True"    click element    ${VPN_PORTAL_DNS_SPLIT_LABEL}
    ...    ELSE IF    "${dns_split}"=="False" and "${dns_split_selected}"!="False"    click element    ${VPN_PORTAL_DNS_SPLIT_LABEL}
    ...    ELSE    log    don't need to change checkbox status
    run keyword if    "${dns_split}"=="True"    create new split dns entries    @{split_dns}

    #enable web mode if it's required
    run keyword if    "${web_mode}"=="True" and "${web_selected}"!="True"    click element    ${VPN_PORTAL_WEB_MODE_LABEL}
    ...    ELSE IF    "${web_mode}"=="False" and "${web_selected}"!="False"    click element    ${VPN_PORTAL_WEB_MODE_LABEL}
    ...    ELSE    log    don't need to change checkbox status
    input text    ${VPN_PORTAL_PORTAL_MESSAGE_TEXT}    ${portal_message}
    Select From List By Label    ${VPN_PORTAL_PORTAL_THEME_SELECT}    ${theme}

    #add predefined bookmarks to portal
    :FOR    ${bookmark_dic_data}    IN    @{bookmarks}
    \    ${bookmark_name}=    set variable    &{bookmark_dic_data}[name]
    \    ${bookmark_type}=    set variable    &{bookmark_dic_data}[type]
    \    ${bookmark_description}=    set variable    &{bookmark_dic_data}[description]
    \    Remove From Dictionary    ${bookmark_dic_data}    name    type    description
    \    create new bookmark    ${bookmark_name}    ${bookmark_type}    ${bookmark_description}    &{bookmark_dic_data}

    #enable forticlient download as required
    run keyword if    "${fortinclient_download}"=="True" and "${forticlient_selected}"!="True"    click element    ${VPN_PORTAL_FORTICLIENT_DOWNLOAD_LABEL}
    ...    ELSE IF    "${fortinclient_download}"=="False" and "${forticlient_selected}"!="False"    click element    ${VPN_PORTAL_FORTICLIENT_DOWNLOAD_LABEL}
    ...    ELSE    log    don't need to change checkbox status
    wait until page contains element    ${VPN_PORTAL_OK_BUTTON}
    click button    ${VPN_PORTAL_OK_BUTTON}
    #check if the portal is created successfully
    Wait Until Page Contains element    ${VPN_PORTAL_CREATE}
    ${created_portal}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_VPN_PORTAL_NAME_IN_TABLE}    ${portal_name}
    Wait Until Page Contains element    ${created_portal}

add routing address to ssl vpn portal
    [Arguments]    ${address}    ${ip_type}=ipv4
    [Documentation]    ${ip_type} can be either "ipv4" or "ipv6"
    run keyword if    "${ip_type}"!="ipv4" and "${ip_type}"!="ipv6"   fail    Unknown IP type: ${ip_type}
    run keyword if    "${ip_type}"=="ipv4"    click element    ${VPN_PORTAL_ROUTING_ADDR_DIV}
    ...    ELSE    click element    ${VPN_PORTAL_ROUTING_IPV6_ADDR_DIV}
    # wait Until entry list is Visible
    run keyword if    "${ip_type}"=="ipv4"    wait Until element is Visible    ${VPN_PORTAL_ROUTING_ADDR_ENTRY_LIST_DIV}
    ...    ELSE    click element    ${VPN_PORTAL_ROUTING_IPV6_ADDR_ENTRY_LIST_DIV}
    # wait until the entry is visible
    ${locator_address_entry}=    run keyword if    "${ip_type}"=="ipv4"    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_VPN_PORTAL_ROUTING_ADDR_ENTRY_ITEM}    ${address}
    ...    ELSE    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_VPN_PORTAL_ROUTING_IPV6_ADDR_ENTRY_ITEM}    ${address}
    wait Until element is Visible    ${locator_address_entry}
    click element    ${locator_address_entry}
    # click close button
    run keyword if    "${ip_type}"=="ipv4"    click button    ${VPN_PORTAL_ROUTING_ADDR_CLOSE_BUTTON}
    ...    ELSE    click button    ${VPN_PORTAL_ROUTING_IPV6_ADDR_CLOSE_BUTTON}
    # wait until entry page is closed.
    run keyword if    "${ip_type}"=="ipv4"    Wait Until Page Does Not Contain Element    ${VPN_PORTAL_ROUTING_ADDR_CLOSE_BUTTON}
    ...    ELSE    Wait Until Page Does Not Contain Element    ${VPN_PORTAL_ROUTING_IPV6_ADDR_CLOSE_BUTTON}
    # wait until the selected address is visible in div
    ${locator_addr_in_div}=    run keyword if    "${ip_type}"=="ipv4"    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_VPN_PORTAL_ROUTING_ADDR_ENTRY_IN_DIV}    ${address}
    ...    ELSE    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_VPN_PORTAL_ROUTING_IPV6_ADDR_ENTRY_IN_DIV}    ${address}
    wait until element is Visible    ${locator_addr_in_div}

add source ip pools to ssl vpn portal
    [Arguments]    ${address}    ${ip_type}=ipv4
    [Documentation]    ${ip_type} can be either "ipv4" or "ipv6"
    run keyword if    "${ip_type}"!="ipv4" and "${ip_type}"!="ipv6"   fail    Unknown IP type: ${ip_type}
    run keyword if    "${ip_type}"=="ipv4"    click element    ${VPN_PORTAL_SOURCE_IP_DIV}
    ...    ELSE    click element    ${VPN_PORTAL_SOURCE_IPV6_DIV}
    # wait Until entry list is Visible
    run keyword if    "${ip_type}"=="ipv4"    wait Until element is Visible    ${VPN_PORTAL_SOURCE_IP_ENTRY_LIST_DIV}
    ...    ELSE    click element    ${VPN_PORTAL_SOURCE_IPV6_ENTRY_LIST_DIV}
    # wait until the entry is visible
    ${locator_address_entry}=    run keyword if    "${ip_type}"=="ipv4"    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_VPN_PORTAL_SOURCE_IP_ENTRY_ITEM}    ${address}
    ...    ELSE    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_VPN_PORTAL_SOURCE_IPV6_ENTRY_ITEM}    ${address}
    wait Until element is Visible    ${locator_address_entry}
    click element    ${locator_address_entry}
    # click close button
    run keyword if    "${ip_type}"=="ipv4"    click button    ${VPN_PORTAL_SOURCE_IP_CLOSE_BUTTON}
    ...    ELSE    click button    ${VPN_PORTAL_SOURCE_IPV6_CLOSE_BUTTON}
    # wait until entry page is closed.
    run keyword if    "${ip_type}"=="ipv4"    Wait Until Page Does Not Contain Element    ${VPN_PORTAL_SOURCE_IP_CLOSE_BUTTON}
    ...    ELSE    Wait Until Page Does Not Contain Element    ${VPN_PORTAL_SOURCE_IPV6_CLOSE_BUTTON}
    # wait until the selected address is visible in div
    ${locator_addr_in_div}=    run keyword if    "${ip_type}"=="ipv4"    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_VPN_PORTAL_SOURCE_IP_ENTRY_IN_DIV}    ${address}
    ...    ELSE    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_VPN_PORTAL_SOURCE_IPV6_ENTRY_IN_DIV}    ${address}
    wait until element is Visible    ${locator_addr_in_div}

create new bookmark
    [Arguments]    ${bookmark_name}    ${bookmark_type}    ${description}    &{config_data}
    [Documentation]    bookmark_type can be: HTTP/HTTPS, FTP, RDP, SMB/CIFS, SSH, TELNET and VNC
    ...    format of &{config_data}:
    ...    1. when bookmark_type is HTTP/HTTPS, key of &{config_data} includes "url", "sso_status", "sso_form_data_status", "sso_form_key_value_pairs", "username", and "password";
    ...    where sso_status can only be "Disable", "SSL-VPN Login" or "Alternative", sso_form_data_status should be either "enable" or "disable",
    ...    sso_form_key_value_pairs should be dictionary including key and value pairs like {key1:value1,key2:value2}
    ...    2. when bookmark_type is FTP, key of &{config_data} includes "folder","sso_status", "username", and "password",where sso_status can only be "Disable", "SSL-VPN Login" or "Alternative";
    ...    3. when bookmark_type is RDP, key of &{config_data} includes "host","port","sso_status","username","password","layout" and "security",
    ...    where sso_status can only be "Disable" or "SSL-VPN Login".
    ...    4. when bookmark_type is SMB/CIFS, key of &{config_data} includes "folder","sso_status", "username", and "password",where sso_status can only be "Disable", "SSL-VPN Login" or "Alternative";
    ...    5. when bookmark_type is SSH, key of &{config_data} includes "host";
    ...    6. when bookmark_type is TELNET, key of &{config_data} includes "host";
    ...    7. when bookmark_type is VNC, key of &{config_data} includes "host","port", and "password";
    wait until page contains element   ${VPN_PORTAL_BOOKMARKS_CREATE_NEW}
    click button    ${VPN_PORTAL_BOOKMARKS_CREATE_NEW}

    run keyword if    "${bookmark_type}"=="HTTP/HTTPS"    add new bookmark of http or https to portal    ${bookmark_name}    ${description}    &{config_data}
    ...    ELSE IF    "${bookmark_type}"=="FTP"    add new bookmark of ftp to portal    ${bookmark_name}    ${description}    &{config_data}
    ...    ELSE IF    "${bookmark_type}"=="RDP"    add new bookmark of rdp to portal    ${bookmark_name}    ${description}    &{config_data}
    ...    ELSE IF    "${bookmark_type}"=="SMB/CIFS"    add new bookmark of smb or cifs to portal    ${bookmark_name}    ${description}    &{config_data}
    ...    ELSE IF    "${bookmark_type}"=="SSH"    add new bookmark of ssh to portal    ${bookmark_name}    ${description}    &{config_data}
    ...    ELSE IF    "${bookmark_type}"=="TELNET"    add new bookmark of telnet to portal    ${bookmark_name}    ${description}    &{config_data}
    ...    ELSE IF    "${bookmark_type}"=="VNC"    add new bookmark of vnc to portal    ${bookmark_name}    ${description}    &{config_data}
    ...    ELSE    Fail    wrong bookmark type for SSL VPN portal

    ${created_bookmark}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_VPN_PORTAL_BOOKMARK_NAME}    ${bookmark_name}
    wait until page contains element    ${created_bookmark}


add new bookmark of http or https to portal
    [Arguments]    ${bookmark_name}    ${description}    &{config_data}
    #${url}    ${sso_status}=Disable    ${sso_form_data_status}=Disable
    #...    ${sso_username}=${EMPTY}    ${sso_password}=${EMPTY}    ${sso_form_key_value_pairs}=&{EMPTY}
    [Documentation]    key of &{config_data} includes "url", "sso_status", "sso_form_data_status", "sso_form_key_value_pairs", "username", and "password";
    ...    where sso_status can only be "Disable", "SSL-VPN Login" or "Alternative", sso_form_data_status should be either "enable" or "disable",
    wait until page contains element    ${VPN_PORTAL_BOOKMARKS_HEAD_H1}
    Wait Until Keyword Succeeds    5x    1s    wait until element is visible    ${VPN_PORTAL_BOOKMARKS_NAME}
    input text    ${VPN_PORTAL_BOOKMARKS_NAME}    ${bookmark_name}
    Select From List By Label    ${VPN_PORTAL_BOOKMARKS_TYPE}    HTTP/HTTPS
    input text    ${VPN_PORTAL_BOOKMARKS_HTTP_HTTPS_URL}    &{config_data}[url]
    input text    ${VPN_PORTAL_BOOKMARKS_DESCRIPTION}    ${description}
    ##choose single sign-on type
    run keyword if    "&{config_data}[sso_status]"=="Disable"    click element    ${VPN_PORTAL_BOOKMARKS_HTTP_HTTPS_SSO_DISABLE}
    ...    ELSE IF    "&{config_data}[sso_status]"=="SSL-VPN Login"    click element    ${VPN_PORTAL_BOOKMARKS_HTTP_HTTPS_SSO_SSLVPN}
    ...    ELSE IF    "&{config_data}[sso_status]"=="Alternative"    click element    ${VPN_PORTAL_BOOKMARKS_HTTP_HTTPS_SSO_ALTERNATIVE}
    ...    ELSE    Fail    unknown sso status for HTTP/HTTPS bookmark
    ##if sso type is Alternative, input username and password
    run keyword if    "&{config_data}[sso_status]"=="Alternative"    input text    ${VPN_PORTAL_BOOKMARKS_HTTP_HTTPS_SSO_USERNAME}    &{config_data}[username]
    run keyword if    "&{config_data}[sso_status]"=="Alternative"    input text    ${VPN_PORTAL_BOOKMARKS_HTTP_HTTPS_SSO_PASSWORD}    &{config_data}[password]
    ##choose if enable SSO Form Data
    run keyword if    "&{config_data}[sso_status]"!="Disable" and "&{config_data}[sso_form_data_status]"=="enable"    click element    ${VPN_PORTAL_BOOKMARKS_HTTP_HTTPS_SSO_FORM_DATA}
    ##input form key/value
    &{dict_of_sso_form_key_value_pairs}    set variable    &{config_data}[sso_form_key_value_pairs]
    run keyword if    "&{config_data}[sso_status]"!="Disable" and "&{config_data}[sso_form_data_status]"=="enable"    add form key to http or https bookmark    &{dict_of_sso_form_key_value_pairs}
    click button    ${VPN_PORTAL_BOOKMARKS_OK_BUTTON}

add form key to http or https bookmark
    [Arguments]    &{sso_form_key_value_pairs}
    @{keys}=    get dictionary keys     ${sso_form_key_value_pairs}
    ${index}=    set variable    ${1}
    :FOR    ${key}    IN    @{keys}
    \    run keyword if    ${index}!=${1}    click button    ${VPN_PORTAL_BOOKMARKS_HTTP_HTTPS_ADD_NEW_FORM_BUTTON}
    \    ${current_form_key_input}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_VPN_PORTAL_BOOKMARKS_HTTP_HTTPS_FORM_KEY}    ${index}
    \    ${current_form_value_input}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_VPN_PORTAL_BOOKMARKS_HTTP_HTTPS_FORM_VALUE}    ${index}
    \    wait until page contains element    ${current_form_key_input}
    \    wait until page contains element    ${current_form_value_input}
    \    input text    ${current_form_key_input}    ${key}
    \    input text    ${current_form_value_input}    &{sso_form_key_value_pairs}[${key}]
    \    ${index}=    set variable    ${index+1}


add new bookmark of ftp to portal
    [Arguments]    ${bookmark_name}    ${description}    &{config_data}
    [Documentation]    key of &{config_data} includes "folder","sso_status", "username", and "password", where sso_status can only be "Disable", "SSL-VPN Login" or "Alternative";
    wait until page contains element    ${VPN_PORTAL_BOOKMARKS_HEAD_H1}
    Wait Until Keyword Succeeds    5x    1s    wait until element is visible    ${VPN_PORTAL_BOOKMARKS_NAME}
    input text    ${VPN_PORTAL_BOOKMARKS_NAME}    ${bookmark_name}
    Select From List By Label    ${VPN_PORTAL_BOOKMARKS_TYPE}    FTP
    input text    ${VPN_PORTAL_BOOKMARKS_FTP_FOLDER}    &{config_data}[folder]
    input text    ${VPN_PORTAL_BOOKMARKS_DESCRIPTION}    ${description}
    run keyword if    "&{config_data}[sso_status]"=="Disable"    click element    ${VPN_PORTAL_BOOKMARKS_FTP_SSO_DISABLE}
    ...    ELSE IF    "&{config_data}[sso_status]"=="SSL-VPN Login"    click element    ${VPN_PORTAL_BOOKMARKS_FTP_SSO_SSLVPN}
    ...    ELSE IF    "&{config_data}[sso_status]"=="Alternative"    click element    ${VPN_PORTAL_BOOKMARKS_FTP_SSO_ALTERNATIVE}
    ...    ELSE    Fail    unknown sso status for FTP bookmark
    run keyword if    "&{config_data}[sso_status]"=="Alternative"    input text    ${VPN_PORTAL_BOOKMARKS_FTP_SSO_USERNAME}    &{config_data}[username]
    run keyword if    "&{config_data}[sso_status]"=="Alternative"    input text    ${VPN_PORTAL_BOOKMARKS_FTP_SSO_PASSWORD}    &{config_data}[password]
    click button    ${VPN_PORTAL_BOOKMARKS_OK_BUTTON}

add new bookmark of smb or cifs to portal
    [Arguments]    ${bookmark_name}    ${description}    &{config_data}
    [Documentation]    key of &{config_data} includes "folder","sso_status", "username", and "password", where sso_status can only be "Disable", "SSL-VPN Login" or "Alternative";
    wait until page contains element    ${VPN_PORTAL_BOOKMARKS_HEAD_H1}
    Wait Until Keyword Succeeds    5x    1s    wait until element is visible    ${VPN_PORTAL_BOOKMARKS_NAME}
    input text    ${VPN_PORTAL_BOOKMARKS_NAME}    ${bookmark_name}
    Select From List By Label    ${VPN_PORTAL_BOOKMARKS_TYPE}    SMB/CIFS
    input text    ${VPN_PORTAL_BOOKMARKS_SMB_CIFS_FOLDER}    &{config_data}[folder]
    input text    ${VPN_PORTAL_BOOKMARKS_DESCRIPTION}    ${description}
    run keyword if    "&{config_data}[sso_status]"=="Disable"    click element    ${VPN_PORTAL_BOOKMARKS_SMB_CIFS_SSO_DISABLE}
    ...    ELSE IF    "&{config_data}[sso_status]"=="SSL-VPN Login"    click element    ${VPN_PORTAL_BOOKMARKS_SMB_CIFS_SSO_SSLVPN}
    ...    ELSE IF    "&{config_data}[sso_status]"=="Alternative"    click element    ${VPN_PORTAL_BOOKMARKS_SMB_CIFS_SSO_ALTERNATIVE}
    ...    ELSE    Fail    unknown sso status for FTP bookmark
    run keyword if    "&{config_data}[sso_status]"=="Alternative"    input text    ${VPN_PORTAL_BOOKMARKS_SMB_CIFS_SSO_USERNAME}    &{config_data}[username]
    run keyword if    "&{config_data}[sso_status]"=="Alternative"    input text    ${VPN_PORTAL_BOOKMARKS_SMB_CIFS_SSO_PASSWORD}    &{config_data}[password]
    click button    ${VPN_PORTAL_BOOKMARKS_OK_BUTTON}

add new bookmark of rdp to portal
    [Arguments]    ${bookmark_name}    ${description}    &{config_data}
    [Documentation]    when bookmark_type is RDP, key of &{config_data} includes "host","port","sso_status","username","password","layout" and "security";
    ...    where sso_status can only be "Disable" or "SSL-VPN Login". layout should be one of "UK","US","German","French","Italian","Swedish" and "Unknown".
    ...    security should be one of "standard", "network", "tls" and "server"
    wait until page contains element    ${VPN_PORTAL_BOOKMARKS_HEAD_H1}
    Wait Until Keyword Succeeds    5x    1s    wait until element is visible    ${VPN_PORTAL_BOOKMARKS_NAME}
    input text    ${VPN_PORTAL_BOOKMARKS_NAME}    ${bookmark_name}
    Select From List By Label    ${VPN_PORTAL_BOOKMARKS_TYPE}    RDP
    wait until element is visible    ${VPN_PORTAL_BOOKMARKS_RDP_HOST}
    input text    ${VPN_PORTAL_BOOKMARKS_RDP_HOST}    &{config_data}[host]
    input text    ${VPN_PORTAL_BOOKMARKS_RDP_PORT}    &{config_data}[port]
    input text    ${VPN_PORTAL_BOOKMARKS_DESCRIPTION}    ${description}
    run keyword if    "&{config_data}[sso_status]"=="Disable"    click element    ${VPN_PORTAL_BOOKMARKS_RDP_SSO_DISABLE}
    ...    ELSE IF    "&{config_data}[sso_status]"=="SSL-VPN Login"    click element    ${VPN_PORTAL_BOOKMARKS_RDP_SSO_SSLVPN}
    ...    ELSE    Fail    unknown sso status for RDP bookmark
    run keyword if    "&{config_data}[sso_status]"=="Disable"    input text    ${VPN_PORTAL_BOOKMARKS_RDP_USERNAME}    &{config_data}[username]
    run keyword if    "&{config_data}[sso_status]"=="Disable"    input text    ${VPN_PORTAL_BOOKMARKS_RDP_PASSWORD}    &{config_data}[password]
    ${layout_label_value}=    set variable if
    ...    "&{config_data}[layout]"=="UK"    English (UK).
    ...    "&{config_data}[layout]"=="US"    English (US).
    ...    "&{config_data}[layout]"=="German"    German (qwertz).
    ...    "&{config_data}[layout]"=="French"    French (azerty).
    ...    "&{config_data}[layout]"=="Italian"    Italian.
    ...    "&{config_data}[layout]"=="Swedish"    Swedish.
    ...    "&{config_data}[layout]"=="Unknown"    Unknown keyboard.
    select from list by label    ${VPN_PORTAL_BOOKMARKS_RDP_LAYOUT_SELECT}    ${layout_label_value}
    ${security_label_value}=    set variable if
    ...    "&{config_data}[security]"=="standard"    Standard RDP encryption.
    ...    "&{config_data}[security]"=="network"    Network Level Authentication.
    ...    "&{config_data}[security]"=="tls"    TLS encryption.
    ...    "&{config_data}[security]"=="server"    Allow the server to choose the type of security.
    select from list by label    ${VPN_PORTAL_BOOKMARKS_RDP_SECURITY_SELECT}    ${security_label_value}
    click button    ${VPN_PORTAL_BOOKMARKS_OK_BUTTON}

add new bookmark of ssh to portal
    [Arguments]    ${bookmark_name}    ${description}    &{config_data}
    [Documentation]     key of &{config_data} includes "host";
    wait until page contains element    ${VPN_PORTAL_BOOKMARKS_HEAD_H1}
    Wait Until Keyword Succeeds    5x    1s    wait until element is visible    ${VPN_PORTAL_BOOKMARKS_NAME}
    input text    ${VPN_PORTAL_BOOKMARKS_NAME}    ${bookmark_name}
    Select From List By Label    ${VPN_PORTAL_BOOKMARKS_TYPE}    SSH
    input text    ${VPN_PORTAL_BOOKMARKS_SSH_HOST}    &{config_data}[host]
    input text    ${VPN_PORTAL_BOOKMARKS_DESCRIPTION}    ${description}
    click button    ${VPN_PORTAL_BOOKMARKS_OK_BUTTON}

add new bookmark of telnet to portal
    [Arguments]    ${bookmark_name}    ${description}    &{config_data}
    [Documentation]     key of &{config_data} includes "host";
    wait until page contains element    ${VPN_PORTAL_BOOKMARKS_HEAD_H1}
    Wait Until Keyword Succeeds    5x    1s    wait until element is visible    ${VPN_PORTAL_BOOKMARKS_NAME}
    input text    ${VPN_PORTAL_BOOKMARKS_NAME}    ${bookmark_name}
    Select From List By Label    ${VPN_PORTAL_BOOKMARKS_TYPE}    TELNET
    input text    ${VPN_PORTAL_BOOKMARKS_TELNET_HOST}    &{config_data}[host]
    input text    ${VPN_PORTAL_BOOKMARKS_DESCRIPTION}    ${description}
    click button    ${VPN_PORTAL_BOOKMARKS_OK_BUTTON}

add new bookmark of vnc to portal
    [Arguments]    ${bookmark_name}    ${description}    &{config_data}
    [Documentation]     key of &{config_data} includes "host","port", and "password";
    wait until page contains element    ${VPN_PORTAL_BOOKMARKS_HEAD_H1}
    Wait Until Keyword Succeeds    5x    1s    wait until element is visible    ${VPN_PORTAL_BOOKMARKS_NAME}
    input text    ${VPN_PORTAL_BOOKMARKS_NAME}    ${bookmark_name}
    Select From List By Label    ${VPN_PORTAL_BOOKMARKS_TYPE}    VNC
    input text    ${VPN_PORTAL_BOOKMARKS_VNC_HOST}    &{config_data}[host]
    input text    ${VPN_PORTAL_BOOKMARKS_VNC_PORT}    &{config_data}[port]
    input text    ${VPN_PORTAL_BOOKMARKS_DESCRIPTION}    ${description}
    input text    ${VPN_PORTAL_BOOKMARKS_VNC_PASSWORD}    &{config_data}[password]
    click button    ${VPN_PORTAL_BOOKMARKS_OK_BUTTON}


If ssl vpn portal exists
    [Arguments]    ${portal_name}
    Wait Until Element Is Visible    ${VPN_PORTAL_CREATE}
    ${created_portal}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_VPN_PORTAL_NAME_IN_TABLE}    ${portal_name}
    ${status}=    run keyword and return status  wait until page contains element    ${created_portal}
    [return]    ${status}

delete ssl vpn portal
    [Arguments]    ${portal_name}
    ${locator_portal}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_VPN_PORTAL_NAME_IN_TABLE}    ${portal_name}
    Wait Until Page Contains Element    ${locator_portal}
    Wait Until Element Is Visible    ${locator_portal}
    click element    ${locator_portal}
    click button    ${VPN_DELETE_PORTAL_BUTTON}
    Wait Until Element Is Visible    ${VPN_DELETE_CONFIRM_HEAD}
    Wait Until Page Contains Element    ${VPN_DELETE_CONFIRM_OK_BUTTON}
    Wait Until Element Is Visible    ${VPN_DELETE_CONFIRM_OK_BUTTON}
    click button    ${VPN_DELETE_CONFIRM_OK_BUTTON}
    #verify if the user is deleted successfully
    Wait Until Element Is Visible    ${VPN_PORTAL_CREATE}
    Wait Until Page Does Not Contain Element    ${locator_portal}

update ssl vpn portal message
    [Arguments]    ${portal_name}   ${portal_message}
    ${locator_portal}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_VPN_PORTAL_NAME_IN_TABLE}    ${portal_name}
    click element    ${locator_portal}
    click button    ${VPN_EDIT_PORTAL_BUTTON}
    Wait Until Element Is Visible    ${VPN_PORTAL_EDIT_HEAD}
    Wait Until Keyword Succeeds    5x    1s    Wait Until Element Is Visible    ${VPN_EDIT_CONFIRM_OK_BUTTON}
    input text    ${VPN_PORTAL_PORTAL_MESSAGE_TEXT}    ${portal_message}
    click button    ${VPN_EDIT_CONFIRM_OK_BUTTON}
    Wait Until Page Contains Element    ${VPN_PORTAL_CREATE}

create new split dns entries
    [Arguments]    @{dns_entries}
    [Documentation]   &{dns_data} is a dictionary, which has 5 keys: domains, pri_ipv4_dns, sec_ipv4_dns, pri_ipv6_dns and sec_ipv6_dns
    ...    value of key domains is a list of domain name, value of other 4 keys are IP addresses.
    ${len}=    get length    ${dns_entries}
    :FOR    ${index}    IN RANGE    ${len}
    \    ${dns_data}=    set variable    @{dns_entries}[${index}]
    \    ${domain_names}=    set variable    &{dns_data}[domains]
    ##to do: curently, only one domain is supported.
    \    ${domain_name}=    set variable    @{domain_names}[0]
    \    Wait until element is visible    ${VPN_PORTAL_DNS_SPLIT_CREATE_NEW}
    \    click button    ${VPN_PORTAL_DNS_SPLIT_CREATE_NEW}
    \    Wait Until Keyword Succeeds    5x    1s    Wait until element is visible    ${VPN_PORTAL_DNS_ENTRY_H1}
    \    Wait Until Keyword Succeeds    5x    1s    Wait until element is visible    ${VPN_PORTAL_DNS_ENTRY_DOMAINS_TEXT}
    \    input text    ${VPN_PORTAL_DNS_ENTRY_DOMAINS_TEXT}    ${domain_name}
    \    input text    ${VPN_PORTAL_DNS_ENTRY_PRI_DNS_SERVER_TEXT}    &{dns_data}[pri_ipv4_dns]
    \    input text    ${VPN_PORTAL_DNS_ENTRY_SEC_DNS_SERVER_TEXT}    &{dns_data}[sec_ipv4_dns]
    \    input text    ${VPN_PORTAL_DNS_ENTRY_IPV6_PRI_DNS_SERVER_TEXT}    &{dns_data}[pri_ipv6_dns]
    \    input text    ${VPN_PORTAL_DNS_ENTRY_IPV6_SEC_DNS_SERVER_TEXT}    &{dns_data}[sec_ipv6_dns]
    \    Wait until element is visible    ${VPN_PORTAL_DNS_ENTRY_OK}
    \    click button    ${VPN_PORTAL_DNS_ENTRY_OK}
    \    Wait Until Page Does Not Contain Element    ${VPN_PORTAL_DNS_ENTRY_H1}
    \    ${locator_split_dns_in_div}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_VPN_PORTAL_SPLIT_DNS_ROW}    ${domain_name}
    \    wait until page contains element    ${locator_split_dns_in_div}

##SSL-VPN Settings##
Go to SSL VPN Settings
    Wait Until Element Is Visible    ${SSL_VPN_SETTINGS_ENTRY}
    click element    ${SSL_VPN_SETTINGS_ENTRY}

Config SSL VPN Settings
    [Arguments]    ${interfaces}    ${port}    ${hosts}    ${certificate}
    ...    ${ip_ranges}    ${portal_mappings}    ${default_portal}
    [Documentation]    format of portal_mapping:  USER:username:portal_name, where USER indicates it's a USER name;
    ...    "username" is the name, "portal_name" is portal name.
    ...    GROUP:groupname:portal_name
    Go to VPN
    Go to SSL VPN Settings
    Wait Until Element Is Visible    ${SSL_VPN_SETTINGS_FRAME}
    select frame    ${SSL_VPN_SETTINGS_FRAME}
    #select listened interfaces
    wait until element is visible    ${SSL_VPN_SETTINGS_INTERFACE_DIV}
    click element    ${SSL_VPN_SETTINGS_INTERFACE_DIV}
    wait until element is visible    ${SSL_VPN_SETTINGS_ENTRY_H1}
    :FOR    ${intf}    IN    @{interfaces}
    \    ${intf_in_div}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_SSL_VPN_SETTINGS_INTERFACE_IN_DIV}    ${intf}
    \    ${intf_existed}=    run keyword and return status    Wait Until Page Contains Element    ${intf_in_div}
    \    run keyword if     "${intf_existed}"!="True"    click element    xpath://div[span/span="${intf}"]
    \    wait until element is visible    ${intf_in_div}
    wait until element is visible    ${SSL_VPN_SETTINGS_CLOSE_BUTTON}
    click button    ${SSL_VPN_SETTINGS_CLOSE_BUTTON}
    ##input port for listening
    #purposely input conflicted port with HTTPS port
    input text    ${SSL_VPN_SETTINGS_PORT_TEXT}    ${FGT_PORT}
    ${if_show_port_conflict}=    run keyword and return status    wait until element is visible    ${SSL_VPN_SETTINGS_PORT_CONFLICT_WARNING}
    #transfer the test result via global variable
    set global variable    ${PORT_CONFLICT}    ${if_show_port_conflict}
    #input correct port again
    input text    ${SSL_VPN_SETTINGS_PORT_TEXT}    ${port}
    #select hosts
    click element    ${SSL_VPN_SETTINGS_ACCESS_SPECIFIC_HOSTS}
    #check link reference for test case 811236
    sleep    5
    ${locator_ipv4_link}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_SSL_VPN_SETTINGS_SSLVPN_LINK}    ${SSLVPN_URL}
    ${if_ipv4_link_correct}=    run keyword and return status    wait until element is visible    ${locator_ipv4_link}
    ${locator_ipv6_link}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_SSL_VPN_SETTINGS_SSLVPN_LINK}    ${SSLVPN_URL_V6}
    ${if_ipv6_link_correct}=    run keyword and return status    wait until element is visible    ${locator_ipv6_link}
    run keyword if    "${if_ipv4_link_correct}"=="True" and "${if_ipv6_link_correct}"=="True"   set global variable    ${LINK_CORRECT}    True
    #continue regular operation again
    wait until element is visible    ${SSL_VPN_SETTINGS_HOSTS_DIV}
    click element    ${SSL_VPN_SETTINGS_HOSTS_DIV}
    wait until element is visible    ${SSL_VPN_SETTINGS_ENTRY_H1}
    :FOR    ${host}    IN    @{hosts}
    \    ${host_in_div}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_SSL_VPN_SETTINGS_HOSTS_IN_DIV}    ${host}
    \    ${host_existed}=    run keyword and return status    Wait Until Page Contains Element    ${host_in_div}
    \    ${host_to_be_selected}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${VAR_SSL_VPN_SETTINGS_HOSTS_TO_BE_SELECTED}    ${host}
    \    run keyword if     "${host_existed}"!="True"   click element    ${host_to_be_selected}
    \    wait until element is visible    ${host_in_div}
    #if host name is "all", add all IPv6 version also
    \    ${host_in_div_ipv6}=    run keyword if    "${host}"=="all"    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_SSL_VPN_SETTINGS_HOSTS_IN_DIV_IPV6}    ${host}
    \    ${host_existed_ipv6}=    run keyword if    "${host}"=="all"   run keyword and return status    Wait Until Page Contains Element    ${host_in_div_ipv6}
    \    ${host_to_be_selected_ipv6}=    run keyword if    "${host}"=="all"   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${VAR_SSL_VPN_SETTINGS_HOSTS_TO_BE_SELECTED_IPV6}    ${host}
    \    run keyword if    "${host}"=="all"   run keyword if     "${host_existed_ipv6}"!="True"   click element    ${host_to_be_selected_ipv6}
    \    run keyword if    "${host}"=="all"   wait until element is visible    ${host_in_div_ipv6}
    click button    ${SSL_VPN_SETTINGS_CLOSE_BUTTON}
    sleep    3
    #input timeout

    #choose certificate
    click element    ${SSL_VPN_SETTINGS_CERTIFICATE_DIV}
    click element    xpath://div[contains(@class,"selection-dropdown")]/div/div[span/span="${certificate}"]
    sleep    3
    #choose IP ranges
    click element    ${SSL_VPN_SETTINGS_ADDRESS_SPECIFIED}
    click element    ${SSL_VPN_SETTINGS_IP_RANGES_DIV}
    wait until element is visible    ${SSL_VPN_SETTINGS_ENTRY_H1}
    :FOR    ${ip_range}    IN    @{ip_ranges}
    \    ${ip_range_in_div}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_SSL_VPN_SETTINGS_IP_RANGES_IN_DIV}    ${ip_range}
    \    ${ip_range_existed}=    run keyword and return status    Wait Until Page Contains Element    ${ip_range_in_div}
    \    ${ip_range_to_be_selected}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${VAR_SSL_VPN_SETTINGS_IP_RANGES_TO_BE_SELECTED}    ${ip_range}
    \    run keyword if     "${ip_range_existed}"!="True"   click element    ${ip_range_to_be_selected}
    \    wait until element is visible    ${ip_range_in_div}
    click button    ${SSL_VPN_SETTINGS_CLOSE_BUTTON}
    #choose authentication/portal mapping
    :FOR    ${portal_mapping}    IN    @{portal_mappings}
    \    @{split_mapping}=    Split String    ${portal_mapping}    :
    \    Add portal mapping to ssl vpn Settings     @{split_mapping}[0]    @{split_mapping}[1]    @{split_mapping}[2]    @{split_mapping}[3]
    #set default mapping
    Set portal for default users and Groups    ${default_portal}
    wait until element is visible    ${SSL_VPN_SETTINGS_SUBMIT_BUTTON}
    sleep    5
    click button    ${SSL_VPN_SETTINGS_SUBMIT_BUTTON}
    #deal with certificate warning
    unselect frame
    ${if_certificate_warning}=    run keyword and return status    Wait Until Page Contains Element    ${SSL_VPN_SETTINGS_WARNING_H1}
    run keyword if    "${if_certificate_warning}"=="True"    wait until element is visible    ${SSL_VPN_SETTINGS_MAPPING_OK_BUTTON}
    run keyword if    "${if_certificate_warning}"=="True"    click button    ${SSL_VPN_SETTINGS_MAPPING_OK_BUTTON}
    Wait Until Page Does Not Contain Element    ${SSL_VPN_SETTINGS_WARNING_H1}
    #verify
    Wait Until Element Is Visible    ${SSL_VPN_SETTINGS_FRAME}
    select frame    ${SSL_VPN_SETTINGS_FRAME}
    Wait Until Page Does Not Contain Element    ${SSL_VPN_SETTINGS_NOT_CONFIGURED_WARNING}
    #check if no policy warning exsits and transfer it to case via global variable.
    ${if_policy_warning}=    run keyword and return status    wait until element is visible    ${SSL_VPN_SETTINGS_NO_POLICY_WARNING}
    set global variable    ${POLICY_WARNING}    ${if_policy_warning}
    [teardown]    unselect frame

Add portal mapping to ssl vpn Settings
    [Arguments]    ${user_type}    ${name}    ${portal}    ${realm}=${False}
    [Documentation]    user_type--->USER or GROUP
    wait until element is visible    ${SSL_VPN_SETTINGS_MAPPING_CREATE_BUTTON}
    click button    ${SSL_VPN_SETTINGS_MAPPING_CREATE_BUTTON}
    unselect frame
    wait until element is visible    ${SSL_VPN_SETTINGS_MAPPING_ENTRY_H1}
    wait until element is visible    ${SSL_VPN_SETTINGS_MAPPING_USERS_GROUPS_DIV}
    click element    ${SSL_VPN_SETTINGS_MAPPING_USERS_GROUPS_DIV}
    wait until element is visible    ${SSL_VPN_SETTINGS_ENTRY_H1}
    run keyword if    "${user_type}"=="USER"    wait until element is visible    xpath://label[contains(span,"User \(")]/following-sibling::label[contains(span,"User Group \(")]/preceding-sibling::div[span/span="${name}" and preceding-sibling::label[contains(span,"User \(")]]
    ...    ELSE IF    "${user_type}"=="GROUP"    wait until element is visible    xpath://label[contains(span,"User Group \(")]/following-sibling::div[span/span="${name}"]
    ...    ELSE    Fail    wrong user type for SSL VPN
    run keyword if    "${user_type}"=="USER"    click element    xpath://label[contains(span,"User \(")]/following-sibling::label[contains(span,"User Group \(")]/preceding-sibling::div[span/span="${name}" and preceding-sibling::label[contains(span,"User \(")]]
    ...    ELSE IF    "${user_type}"=="GROUP"    click element    xpath://label[contains(span,"User Group \(")]/following-sibling::div[span/span="${name}"]
    ...    ELSE    Fail    wrong user type for SSL VPN
    click button    ${SSL_VPN_SETTINGS_CLOSE_BUTTON}
    wait until element is visible    xpath://label[text()="Users\/Groups"]/following-sibling::div//span[text()="${name}"]

    #set realm
    Run keyword if    "${realm}"!="${False}"    click element    ${SSL_VPN_SETTINGS_MAPPING_SPECIFY_REALM_LABEL}
    Run keyword if    "${realm}"!="${False}"    wait until element is visible    ${SSL_VPN_SETTINGS_MAPPING_REALM_DIV}
    Run keyword if    "${realm}"!="${False}"    click element    ${SSL_VPN_SETTINGS_MAPPING_REALM_DIV}
    ${locator_realm_in_dropdown}=    Run keyword if    "${realm}"!="${False}"    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_SSL_VPN_SETTINGS_MAPPING_REALM_IN_DROPDOWN}    /${realm}
    Run keyword if    "${realm}"!="${False}"    wait until element is visible    ${locator_realm_in_dropdown}
    Run keyword if    "${realm}"!="${False}"    click element    ${locator_realm_in_dropdown}
    ${locator_realm_in_div}=    Run keyword if    "${realm}"!="${False}"    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_SSL_VPN_SETTINGS_MAPPING_REALM_IN_DIV}    /${realm}
    Run keyword if    "${realm}"!="${False}"    wait until element is visible    ${locator_realm_in_div}

    #chosse portal
    sleep    2
    wait until element is visible    ${SSL_VPN_SETTINGS_MAPPING_PORTAL_DIV}
    click element    ${SSL_VPN_SETTINGS_MAPPING_PORTAL_DIV}
    wait until element is visible    xpath://div[@class="selection-dropdown inside-slide"]/div/div[span/span="${portal}"]
    click element    xpath://div[@class="selection-dropdown inside-slide"]/div/div[span/span="${portal}"]
    wait until element is visible    ${SSL_VPN_SETTINGS_MAPPING_OK_BUTTON}
    click button    ${SSL_VPN_SETTINGS_MAPPING_OK_BUTTON}
    Wait Until Element Is Visible    ${SSL_VPN_SETTINGS_FRAME}
    select frame    ${SSL_VPN_SETTINGS_FRAME}
    #verify if the mapping is added successfully
    wait until element is visible    ${SSL_VPN_SETTINGS_MAPPING_TABLE}
    wait until element is visible    ${SSL_VPN_SETTINGS_MAPPING_CREATE_BUTTON}
    Wait Until Page Contains Element    xpath://table/tbody/tr[td/div/span="${name}" and td="${portal}"]

Set portal for default users and Groups
    [Arguments]    ${default_portal}
    click element    ${SSL_VPN_SETTINGS_MAPPING_DEFAULT_ROW}
    click button    ${SSL_VPN_SETTINGS_MAPPING_EDIT_BUTTON}
    unselect frame
    wait until element is visible    ${SSL_VPN_SETTINGS_MAPPING_DEFAULT_H1}
    Wait Until Keyword Succeeds    5x    1s    wait until element is visible    ${SSL_VPN_SETTINGS_MAPPING_PORTAL_DIV}
    # ${web_element}=    get webelement    ${SSL_VPN_SETTINGS_MAPPING_PORTAL_DIV}
    click element    ${SSL_VPN_SETTINGS_MAPPING_PORTAL_DIV}
    click element    xpath://div[@class="selection-dropdown inside-slide"]/div/div[span/span="${default_portal}"]
    click button    ${SSL_VPN_SETTINGS_MAPPING_OK_BUTTON}
    Wait Until Element Is Visible    ${SSL_VPN_SETTINGS_FRAME}
    select frame    ${SSL_VPN_SETTINGS_FRAME}
    #verify if the portal is set successfully
    wait until element is visible    ${SSL_VPN_SETTINGS_MAPPING_DEFAULT_ROW}
    Wait Until Page Contains Element    xpath://table/tbody/tr[last()]/td[last() and text()="${default_portal}"]

Set sslvpn Endpoint Registration
     click element ${SSL_VPN_HEARTBEAT}

Set Customize Download Location
    [Arguments]    ${customized_status}=${False}    ${windows_status}=${False}    ${mac_status}=${False}    ${windows_url}=${EMPTY}    ${mac_url}=${EMPTY}
    ${current_status}=    Run keyword and return status    Checkbox Should Be Selected    ${VPN_PORTAL_CUSTOMIZE_DOWNLOAD_CHECKBOX}
    Run keyword if    "${current_status}"=="${False}" and "${customized_status}"=="${False}"    Return From keyword
    ...    ELSE IF    "${current_status}"!="${False}" and "${customized_status}"=="${False}"    click element    ${VPN_PORTAL_CUSTOMIZE_DOWNLOAD_LABEL}
    ...    ELSE IF    "${current_status}"=="${False}" and "${customized_status}"!="${False}"    click element    ${VPN_PORTAL_CUSTOMIZE_DOWNLOAD_LABEL}
    ...    ELSE    No Operation
    #Return when customized_status is False.
    Run keyword if    "${customized_status}"=="${False}"    Return From keyword
    #select windows checkbox
    ${windows_current_status}=    Run keyword and return status    Checkbox Should Be Selected    ${VPN_PORTAL_WINDOWS_CHECKBOX}
    Run keyword if    "${windows_current_status}"!="${windows_status}"    click element    ${VPN_PORTAL_WINDOWS_LABEL}
    ...    ELSE    No Operation
    #input windows text
    Run keyword if    "${windows_status}"=="${True}"    input text    ${VPN_PORTAL_WINDOWS_INPUT}    ${windows_url}
    #select macos checkbox
    ${mac_current_status}=    Run keyword and return status    Checkbox Should Be Selected    ${VPN_PORTAL_MAC_CHECKBOX}
    Run keyword if    "${mac_current_status}"!="${mac_status}"    click element    ${VPN_PORTAL_MAC_LABEL}
    ...    ELSE    No Operation
    #input macos text
    Run keyword if    "${mac_status}"=="${True}"    input text    ${VPN_PORTAL_MAC_INPUT}    ${mac_url}


delete portal mapping from SSL VPN Settings by portal name
    [Arguments]    ${portal_name}
    [Documentation]    delete all portal mapping according to portal name
    Wait Until Element Is Visible    ${SSL_VPN_SETTINGS_FRAME}
    select frame    ${SSL_VPN_SETTINGS_FRAME}
    wait until element is visible    ${SSL_VPN_SETTINGS_MAPPING_CREATE_BUTTON}
    ${mapping_portal_lists}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_VPN_SETTINGS_MAPPING_VIA_PORTAL_NAME}    ${portal_name}
    ${number_of_portals}=    Get Element Count    ${mapping_portal_lists}
    :FOR    ${index}    IN RANGE    1    ${number_of_portals+1}
    \    click element    ${mapping_portal_lists}\[1\]
    \    click button     ${SSL_VPN_SETTINGS_MAPPING_DELETE_BUTTON}
    \    ${current_number_of_portals}=    Get Element Count    ${mapping_portal_lists}
    \    should be true    ${current_number_of_portals}+${index}==${number_of_portals}
    click button    ${SSL_VPN_SETTINGS_SUBMIT_BUTTON}
    #deal with certificate warning
    unselect frame
    ${if_certificate_warning}=    run keyword and return status    Wait Until Page Contains Element    ${SSL_VPN_SETTINGS_WARNING_H1}
    run keyword if    "${if_certificate_warning}"=="True"    wait until element is visible    ${SSL_VPN_SETTINGS_MAPPING_OK_BUTTON}
    run keyword if    "${if_certificate_warning}"=="True"    click button    ${SSL_VPN_SETTINGS_MAPPING_OK_BUTTON}
    Wait Until Page Does Not Contain Element    ${SSL_VPN_SETTINGS_WARNING_H1}
    Wait Until Element Is Visible    ${SSL_VPN_SETTINGS_FRAME}
    select frame    ${SSL_VPN_SETTINGS_FRAME}
    wait until page Does Not contain    ${mapping_portal_lists}
    [teardown]    unselect frame



##SSL-VPN Realms##
Go to SSL VPN Realms
    Wait Until element is visible    ${SSL_VPN_REALMS_ENTRY}
    click element    ${SSL_VPN_REALMS_ENTRY}

Create ssl vpn realms
    [Arguments]    ${realm_name}
    [Documentation]    Add realm
    Go to VPN
    Go to SSL VPN Realms
    ${status}=    If ssl vpn realms exists    ${realm_name}
    run keyword if    "${status}"=="True"     Delete ssl vpn realms    ${realm_name}
    Wait Until Element Is Visible    ${SSL_VPN_REALMS_FRAME}
    select frame    ${SSL_VPN_REALMS_FRAME}
    wait Until element is Visible    ${SSL_VPN_REALMS_CREATE}
    click element    ${SSL_VPN_REALMS_CREATE}
    wait Until element is Visible    ${SSL_VPN_REALMS_CREATE_H1}
    wait Until element is Visible    ${SSL_VPN_REALMS_CREATE_URL_PATH}
    input text    ${SSL_VPN_REALMS_CREATE_URL_PATH}    ${realm_name}
    wait Until element is Visible    ${SSL_VPN_REALMS_OK_BUTTON}
    click element    ${SSL_VPN_REALMS_OK_BUTTON}
    wait Until element is Visible    ${SSL_VPN_REALMS_CREATE_URL_PATH_NOTICE}
    click element    ${SSL_VPN_REALMS_OK_BUTTON}
    wait Until element is Visible    ${SSL_VPN_REALMS_COLUMN}
    ${created_realm}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_SSL_VPN_REALMS_NAME_IN_TABLE}    ${realm_name}
    wait Until element is Visible    ${created_realm}
    [teardown]    unselect frame

If ssl vpn realms exists
    [Arguments]    ${realm_name}
    Wait Until Element Is Visible    ${SSL_VPN_REALMS_FRAME}
    select frame    ${SSL_VPN_REALMS_FRAME}
    Wait Until Element Is Visible    ${SSL_VPN_REALMS_CREATE}
    ${created_realm}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_SSL_VPN_REALMS_NAME_IN_TABLE}    ${realm_name}
    ${status}=    run keyword and return status    wait until page contains element    ${created_realm}
    unselect frame
    [return]    ${status}

Delete ssl vpn realms
    [Arguments]    ${realm_name}
    Wait Until Element Is Visible    ${SSL_VPN_REALMS_FRAME}
    select frame    ${SSL_VPN_REALMS_FRAME}
    ${realm_in_table}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_SSL_VPN_REALMS_NAME_IN_TABLE}    ${realm_name}
    Wait Until Element Is Visible    ${realm_in_table}
    click element    ${realm_in_table}
    click button    ${SSL_VPN_REALMS_DELETE_BUTTON}
    unselect frame
    Wait Until Element Is Visible    ${SSL_VPN_REALMS_DELETE_CONFIRM_HEAD}
    Wait Until page contains Element    ${SSL_VPN_REALMS_DELETE_CONFIRM_OK_BUTTON}
    Wait Until Element Is Visible    ${SSL_VPN_REALMS_DELETE_CONFIRM_OK_BUTTON}
    click button    ${SSL_VPN_REALMS_DELETE_CONFIRM_OK_BUTTON}
    #verify if the realm is deleted successfully
    Wait Until Element Is Visible    ${SSL_VPN_REALMS_FRAME}
    select frame    ${SSL_VPN_REALMS_FRAME}
    Wait Until Page Does Not Contain Element    ${realm_in_table}
    [teardown]    unselect frame

Update ssl vpn realms
    [Arguments]    ${realm_name}
    Wait Until Element Is Visible    ${SSL_VPN_REALMS_FRAME}
    select frame    ${SSL_VPN_REALMS_FRAME}
    ${realm_in_table}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_SSL_VPN_REALMS_NAME_IN_TABLE}    ${realm_name}
    Wait Until Element Is Visible    ${realm_in_table}
    click element    ${realm_in_table}
    click button    ${SSL_VPN_REALMS_EDIT_REALM_BUTTON}
    wait Until element is Visible    ${SSL_VPN_REALMS_EDIT_HEAD}
    wait Until element is Visible    ${SSL_VPN_REALMS_LIMIT_USER_LABEL}
    click element    ${SSL_VPN_REALMS_LIMIT_USER_LABEL}
    click element    ${SSL_VPN_REALMS_OK_BUTTON}
    Wait Until Element Is Visible    ${SSL_VPN_REALMS_COLUMN}
    ${max_user}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_SSL_VPN_REALMS_NAME_IN_TABLE}    500
    wait Until element is Visible    ${max_user}
    [teardown]    unselect frame
