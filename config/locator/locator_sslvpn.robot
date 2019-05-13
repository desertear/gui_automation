*** Settings ***
Documentation     This file contains all locator variables on FortiGate VPN page

*** Variables ***
####VPN####
${VPN_ENTRY}    xpath://nav/ul/li/div/div/span[text()="VPN"]
###SSL-VPN Portals
${SSL_VPN_PORTALS_ENTRY}    xpath://span[text()="SSL-VPN Portals"]
${VPN_PORTAL_CREATE}    xpath://button[div/span="Create New"]
${VPN_PORTAL_DELETE}    xpath://button[div/span="Delete"]
${VPN_PORTAL_COLUMN}    xpath://td[@class="name"]
${VPN_DELETE_PORTAL_BUTTON}    xpath://button[div/span="Delete" and not(@disabled)]
${VPN_DELETE_CONFIRM_HEAD}    xpath://h1[@title="Confirm" and text()="Confirm"]
${VPN_DELETE_CONFIRM_OK_BUTTON}    xpath://button[text()="OK"]
${VAR_VPN_PORTAL_NAME_IN_TABLE}    xpath://tbody/tr/td[text()="\${PLACEHOLDER}"]
${VPN_PORTAL_EDIT}    xpath://button[div/span="Edit"]
${VPN_EDIT_PORTAL_BUTTON}    xpath://button[div/span="Edit" and not(@disabled)]
${VPN_PORTAL_EDIT_HEAD}    xpath://h1[text()="Edit SSL-VPN Portal"]
${VPN_EDIT_CONFIRM_OK_BUTTON}    id:submit_ok
##SSL-VPN Create New
${VPN_PORTAL_CREATE_H1}    xpath://h1[text()="New SSL-VPN Portal"]
${VPN_PORTAL_CREATE_NAME_TEXT}    xpath://label[field-label/span="Name"]/following-sibling::div//input
#IPv4 Tunnel Mode
${VPN_PORTAL_TUNNEL_MODE_CHECKBOX}    id:tunnel-mode
${VPN_PORTAL_TUNNEL_MODE_LABEL}    xpath://label/h2[text()="Tunnel Mode"]/preceding-sibling::label
${VPN_PORTAL_SPLIT_CHECKBOX}    id:split-tunnel
${VPN_PORTAL_SPLIT_LABEL}    xpath://input[@id="split-tunnel"]/following-sibling::label
${VPN_PORTAL_ROUTING_ADDR_DIV}    xpath://f-field[.//input[@id="split-tunnel"]]/following-sibling::f-field[label//span="Routing Address"]//div[@class="add-placeholder"]
${VAR_VPN_PORTAL_ROUTING_ADDR_ENTRY_IN_DIV}     xpath://f-field[.//input[@id="split-tunnel"]]/following-sibling::f-field[label//span="Routing Address"]//span[text()="\${PLACEHOLDER}"]
${VPN_PORTAL_ROUTING_ADDR_H1}    xpath://h1[text()="Select Entries"]
${VPN_PORTAL_ROUTING_ADDR_ENTRY_LIST_DIV}    xpath://div[@class="virtual-results"]
${VAR_VPN_PORTAL_ROUTING_ADDR_ENTRY_ITEM}     xpath://div[h1="Select Entries"]/following-sibling::div/div[span/span="\${PLACEHOLDER}"]
${VPN_PORTAL_ROUTING_ADDR_CLOSE_BUTTON}    xpath://div[h1="Select Entries"]//following-sibling::div/button[text()="Close"]
${VPN_PORTAL_SOURCE_IP_DIV}    xpath://label[field-label/span="Source IP Pools"]/following-sibling::div//div[@class="add-placeholder"]
${VAR_VPN_PORTAL_SOURCE_IP_ENTRY_IN_DIV}     xpath://f-field[label//span="Source IP Pools"]//span[text()="\${PLACEHOLDER}"]
${VPN_PORTAL_SOURCE_IP_H1}    xpath://h1[text()="Select Entries"]
${VPN_PORTAL_SOURCE_IP_ENTRY_LIST_DIV}    xpath://div[@class="virtual-results"]
${VAR_VPN_PORTAL_SOURCE_IP_ENTRY_ITEM}     xpath://div[h1="Select Entries"]/following-sibling::div/div[span/span="\${PLACEHOLDER}"]
${VPN_PORTAL_SOURCE_IP_CLOSE_BUTTON}    xpath://div[h1="Select Entries"]//following-sibling::div/button[text()="Close"]
#IPv6 Tunnel Mode
${VPN_PORTAL_IPV6_TUNNEL_MODE_CHECKBOX}    id:ipv6-tunnel-mode
${VPN_PORTAL_IPV6_TUNNEL_MODE_LABEL}    xpath://label/h2[text()="IPv6 Tunnel Mode"]/preceding-sibling::label
${VPN_PORTAL_SPLIT_IPV6_CHECKBOX}    id:ipv6-split-tunnel
${VPN_PORTAL_SPLIT_IPV6_LABEL}    xpath://input[@id="ipv6-split-tunnel"]/following-sibling::label
${VPN_PORTAL_ROUTING_IPV6_ADDR_DIV}    xpath://f-field[.//input[@id="ipv6-split-tunnel"]]/following-sibling::f-field[label//span="Routing Address"]//div[@class="add-placeholder"]
${VAR_VPN_PORTAL_ROUTING_IPV6_ADDR_ENTRY_IN_DIV}     xpath://f-field[.//input[@id="ipv6-split-tunnel"]]/following-sibling::f-field[label//span="Routing Address"]//span[text()="\${PLACEHOLDER}"]
${VPN_PORTAL_ROUTING_IPV6_ADDR_H1}    xpath://h1[text()="Select Entries"]
${VPN_PORTAL_ROUTING_IPV6_ADDR_ENTRY_LIST_DIV}    xpath://div[@class="virtual-results"]
${VAR_VPN_PORTAL_ROUTING_IPV6_ADDR_ENTRY_ITEM}     xpath://div[h1="Select Entries"]/following-sibling::div/div[span/span="\${PLACEHOLDER}"]
${VPN_PORTAL_ROUTING_IPV6_ADDR_CLOSE_BUTTON}    xpath://div[h1="Select Entries"]//following-sibling::div/button[text()="Close"]
${VPN_PORTAL_SOURCE_IPV6_DIV}    xpath://label[field-label/span="Source IPv6 Pools"]/following-sibling::div//div[@class="add-placeholder"]
${VAR_VPN_PORTAL_SOURCE_IPV6_ENTRY_IN_DIV}     xpath://f-field[label//span="Source IPv6 Pools"]//span[text()="\${PLACEHOLDER}"]
${VPN_PORTAL_SOURCE_IPV6_H1}    xpath://h1[text()="Select Entries"]
${VPN_PORTAL_SOURCE_IPV6_ENTRY_LIST_DIV}    xpath://div[@class="virtual-results"]
${VAR_VPN_PORTAL_SOURCE_IPV6_ENTRY_ITEM}     xpath://div[h1="Select Entries"]/following-sibling::div/div[span/span="\${PLACEHOLDER}"]
${VPN_PORTAL_SOURCE_IPV6_CLOSE_BUTTON}    xpath://div[h1="Select Entries"]//following-sibling::div/button[text()="Close"]
#Tunnel Mode Client Options
${VPN_PORTAL_DNS_SPLIT_CHECKBOX}    id:dns-split-tunneling
${VPN_PORTAL_DNS_SPLIT_LABEL}    xpath://input[@id="dns-split-tunneling"]//following-sibling::label
${VPN_PORTAL_DNS_SPLIT_HEAD_LABEL}    xpath://label[text()="Split DNS"]
${VPN_PORTAL_DNS_SPLIT_CREATE_NEW}    xpath://label[text()="Split DNS"]//following-sibling::div//button[.//span="Create New"]
${VPN_PORTAL_DNS_ENTRY_H1}    xpath://h1[text()="New DNS Entry"]
${VPN_PORTAL_DNS_ENTRY_DOMAINS_TEXT}    xpath://label[.//span="Domains"]//following-sibling::div//input
${VPN_PORTAL_DNS_ENTRY_PRI_DNS_SERVER_TEXT}    xpath://label[*="Primary DNS Server"]//following-sibling::div//input
${VPN_PORTAL_DNS_ENTRY_SEC_DNS_SERVER_TEXT}    xpath://label[*="Secondary DNS Server"]//following-sibling::div//input
${VPN_PORTAL_DNS_ENTRY_IPV6_PRI_DNS_SERVER_TEXT}    xpath://label[*="Primary DNS IPv6 Server"]//following-sibling::div//input
${VPN_PORTAL_DNS_ENTRY_IPV6_SEC_DNS_SERVER_TEXT}    xpath://label[*="Secondary DNS IPv6 Server"]//following-sibling::div//input
${VPN_PORTAL_DNS_ENTRY_OK}    xpath://div[h1="New DNS Entry"]//following-sibling::div//button[@id="submit_ok"]
${VPN_PORTAL_DNS_ENTRY_CANCEL}    xpath://div[h1="New DNS Entry"]//following-sibling::div//button[@id="submit_cancel"]
${VAR_VPN_PORTAL_SPLIT_DNS_ROW}    xpath://label[text()="Split DNS"]//following-sibling::div//div[@column-id="domains"]//div[text()="\${PLACEHOLDER}"]
#web mode
${VPN_PORTAL_WEB_MODE_CHECKBOX}    id:web-mode
${VPN_PORTAL_WEB_MODE_LABEL}    xpath://label/h2[text()="Enable Web Mode"]/preceding-sibling::label
${VPN_PORTAL_PORTAL_MESSAGE_TEXT}    xpath://label[field-label/span="Portal Message"]/following-sibling::div//input
${VPN_PORTAL_PORTAL_THEME_SELECT}    xpath://select
${VPN_PORTAL_BOOKMARKS_CREATE_NEW}    xpath://label[text()="Predefined Bookmarks"]//following-sibling::f-mutable//button[.//span="Create New"]
${VAR_VPN_PORTAL_BOOKMARK_NAME}    xpath://label[text()="Predefined Bookmarks"]//following-sibling::f-mutable//div[@column-id="name"]//div[text()="\${PLACEHOLDER}"]
##below locators are elements relating to bookmarks on FGT GUI
${VPN_PORTAL_BOOKMARKS_HEAD_H1}    xpath://div[h1="New Bookmark"]
${VPN_PORTAL_BOOKMARKS_NAME}    id:name
${VPN_PORTAL_BOOKMARKS_TYPE}    xpath://label[field-label/span="Type"]/following-sibling::div//select
${VPN_PORTAL_BOOKMARKS_DESCRIPTION}    id:description
${VPN_PORTAL_BOOKMARKS_OK_BUTTON}    xpath://div[h1="New Bookmark"]/following-sibling::div//button[@id="submit_ok"]
${VPN_PORTAL_BOOKMARKS_HTTP_HTTPS_URL}    id:url
${VPN_PORTAL_BOOKMARKS_HTTP_HTTPS_SSO_DISABLE}    xpath://span[text()="Disable"]
${VPN_PORTAL_BOOKMARKS_HTTP_HTTPS_SSO_SSLVPN}    xpath://span[text()="SSL-VPN Login"]
${VPN_PORTAL_BOOKMARKS_HTTP_HTTPS_SSO_ALTERNATIVE}    xpath://span[text()="Alternative"]
${VPN_PORTAL_BOOKMARKS_HTTP_HTTPS_SSO_FORM_DATA}    xpath://span[text()="SSO Form Data"]/following-sibling::label
${VPN_PORTAL_BOOKMARKS_HTTP_HTTPS_SSO_USERNAME}    id:sso-username
${VPN_PORTAL_BOOKMARKS_HTTP_HTTPS_SSO_PASSWORD}    id:sso-password
${VAR_VPN_PORTAL_BOOKMARKS_HTTP_HTTPS_FORM_KEY}    xpath:(//input[@id="sso-form-key-"])[\${PLACEHOLDER}]
${VAR_VPN_PORTAL_BOOKMARKS_HTTP_HTTPS_FORM_VALUE}    xpath:(//input[@id="sso-form-value-"])[\${PLACEHOLDER}]
${VPN_PORTAL_BOOKMARKS_HTTP_HTTPS_ADD_NEW_FORM_BUTTON}    xpath://*[label/field-label="Form Value"]/following-sibling::f-field//button
${VPN_PORTAL_BOOKMARKS_FTP_FOLDER}    id:folder
${VPN_PORTAL_BOOKMARKS_FTP_SSO_DISABLE}    xpath://span[text()="Disable"]
${VPN_PORTAL_BOOKMARKS_FTP_SSO_SSLVPN}    xpath://span[text()="SSL-VPN Login"]
${VPN_PORTAL_BOOKMARKS_FTP_SSO_ALTERNATIVE}    xpath://span[text()="Alternative"]
${VPN_PORTAL_BOOKMARKS_FTP_SSO_USERNAME}    id:sso-username
${VPN_PORTAL_BOOKMARKS_FTP_SSO_PASSWORD}    id:sso-password
${VPN_PORTAL_BOOKMARKS_RDP_HOST}    id:host
${VPN_PORTAL_BOOKMARKS_RDP_PORT}    id:port
${VPN_PORTAL_BOOKMARKS_RDP_SSO_DISABLE}    xpath://span[text()="Disable"]
${VPN_PORTAL_BOOKMARKS_RDP_SSO_SSLVPN}    xpath://span[text()="SSL-VPN Login"]
${VPN_PORTAL_BOOKMARKS_RDP_USERNAME}    id:rdp-username
${VPN_PORTAL_BOOKMARKS_RDP_PASSWORD}    id:rdp-password
${VPN_PORTAL_BOOKMARKS_RDP_LAYOUT_SELECT}    xpath://label[field-label/span="Keyboard Layout"]/following-sibling::div//select
${VPN_PORTAL_BOOKMARKS_RDP_SECURITY_SELECT}    xpath://label[field-label/span="Security"]/following-sibling::div//select
${VPN_PORTAL_BOOKMARKS_SMB_CIFS_FOLDER}    id:folder
${VPN_PORTAL_BOOKMARKS_SMB_CIFS_SSO_DISABLE}    xpath://span[text()="Disable"]
${VPN_PORTAL_BOOKMARKS_SMB_CIFS_SSO_SSLVPN}    xpath://span[text()="SSL-VPN Login"]
${VPN_PORTAL_BOOKMARKS_SMB_CIFS_SSO_ALTERNATIVE}    xpath://span[text()="Alternative"]
${VPN_PORTAL_BOOKMARKS_SMB_CIFS_SSO_USERNAME}    id:sso-username
${VPN_PORTAL_BOOKMARKS_SMB_CIFS_SSO_PASSWORD}    id:sso-password
${VPN_PORTAL_BOOKMARKS_SSH_HOST}    id:host
${VPN_PORTAL_BOOKMARKS_TELNET_HOST}    id:host
${VPN_PORTAL_BOOKMARKS_VNC_HOST}    id:host
${VPN_PORTAL_BOOKMARKS_VNC_PORT}    id:port
${VPN_PORTAL_BOOKMARKS_VNC_PASSWORD}    id:rdp-password
${VPN_PORTAL_FORTICLIENT_DOWNLOAD_CHECKBOX}    id:forticlient-download
${VPN_PORTAL_FORTICLIENT_DOWNLOAD_LABEL}    xpath://label/h2[text()="Enable FortiClient Download"]/preceding-sibling::label
${VPN_PORTAL_CUSTOMIZE_DOWNLOAD_CHECKBOX}    id:customize-forticlient-download-url
${VPN_PORTAL_CUSTOMIZE_DOWNLOAD_LABEL}    xpath://input[@id="customize-forticlient-download-url"]/following-sibling::label
${VPN_PORTAL_WINDOWS_CHECKBOX}    id:windows-forticlient-download-enable
${VPN_PORTAL_WINDOWS_LABEL}    xpath://input[@id="windows-forticlient-download-enable"]/following-sibling::label
${VPN_PORTAL_WINDOWS_INPUT}    id:windows-forticlient-download-url
${VPN_PORTAL_MAC_CHECKBOX}    id:macos-forticlient-download-enable
${VPN_PORTAL_MAC_LABEL}    xpath://input[@id="macos-forticlient-download-enable"]/following-sibling::label
${VPN_PORTAL_MAC_INPUT}    id:macos-forticlient-download-url
${VPN_PORTAL_OK_BUTTON}    id:submit_ok
${VPN_PORTAL_CANCEL_BUTTON}    id:submit_cancel

###SSL-VPN Settings
${SSL_VPN_SETTINGS_ENTRY}    xpath://span[text()="SSL-VPN Settings"]
${SSL_VPN_SETTINGS_FRAME}    name:embedded-iframe
${SSL_VPN_SETTINGS_NO_POLICY_WARNING}    xpath://a[@id="policy_link"]
${SSL_VPN_SETTINGS_INTERFACE_DIV}    xpath://label[text()="Listen on Interface(s)"]/following-sibling::div/div/div[@class="add-placeholder"]
${VAR_SSL_VPN_SETTINGS_INTERFACE_IN_DIV}    xpath://label[text()="Listen on Interface(s)"]/following-sibling::div//span[text()="\${PLACEHOLDER}"]
${SSL_VPN_SETTINGS_ENTRY_H1}    xpath://div[h1="Select Entries"]
${SSL_VPN_SETTINGS_CLOSE_BUTTON}    xpath://div[h1="Select Entries"]/following-sibling::div/button[text()="Close"]
${SSL_VPN_SETTINGS_PORT_TEXT}    id:port
${SSL_VPN_SETTINGS_PORT_CONFLICT_WARNING}    xpath://div[contains(text(),"Port conflicts with the administrative HTTPS port for this system")]
${VAR_SSL_VPN_SETTINGS_SSLVPN_LINK}    xpath://span[text()="Web mode access will be listening at"]/following-sibling::span/a[text()="\${PLACEHOLDER}"]
${SSL_VPN_SETTINGS_ACCESS_ANY_HOSTS}    xpath://label[text()="Allow access from any host"]
${SSL_VPN_SETTINGS_ACCESS_SPECIFIC_HOSTS}    xpath://label[text()="Limit access to specific hosts"]
${SSL_VPN_SETTINGS_HOSTS_DIV}   xpath://label[text()="Hosts"]/following-sibling::div/div/div[@class="add-placeholder"]
${SELECT_ENTRY_H1}    xpath://h1[text()="Select Entries"]
${SSL_VPN_SETTINGS_HOST_SEARCH}    xpath://*[@class="select-widget-search"]//input
${SSL_VPN_SETTINGS_HOST_FIND}    xpath://*[@class="entry pseudo-focused"]
${VAR_SSL_VPN_SETTINGS_HOSTS_IN_DIV}    xpath://label[text()="Hosts"]/following-sibling::div//f-icon[not(contains(@class,"ipv6"))]/following-sibling::span[text()="\${PLACEHOLDER}"]
${VAR_SSL_VPN_SETTINGS_HOSTS_IN_DIV_IPV6}    xpath://label[text()="Hosts"]/following-sibling::div//f-icon[contains(@class,"ipv6")]/following-sibling::span[text()="\${PLACEHOLDER}"]
${VAR_SSL_VPN_SETTINGS_HOSTS_TO_BE_SELECTED}    xpath://label[contains(span,"Address \(")]/following-sibling::label[contains(span,"IPv6 Address \(")]/preceding-sibling::div[span/span="\${PLACEHOLDER}" and preceding-sibling::label[contains(span,"Address \(")]]
${VAR_SSL_VPN_SETTINGS_HOSTS_TO_BE_SELECTED_IPV6}    xpath://label[contains(span,"IPv6 Address \(")]/following-sibling::div[span/span="\${PLACEHOLDER}"]
${SSL_VPN_SETTINGS_CERTIFICATE_DIV}    xpath://label[text()="Server Certificate"]/following-sibling::div/div/div[@class="add-placeholder"]
${SSL_VPN_SETTINGS_ADDRESS_AUTO}    xpath://label[text()="Automatically assign addresses"]
${SSL_VPN_SETTINGS_ADDRESS_SPECIFIED}    xpath://label[text()="Specify custom IP ranges"]
${SSL_VPN_SETTINGS_IP_RANGES_DIV}   xpath://label[text()="IP Ranges"]/following-sibling::div/div/div[@class="add-placeholder"]
${VAR_SSL_VPN_SETTINGS_IP_RANGES_IN_DIV}    xpath://label[text()="IP Ranges"]/following-sibling::div//span[text()="\${PLACEHOLDER}"]
${VAR_SSL_VPN_SETTINGS_IP_RANGES_TO_BE_SELECTED}    xpath://label[contains(span,"Address \(")]/following-sibling::div[span/span="\${PLACEHOLDER}"]
${SSL_VPN_SETTINGS_MAPPING_CREATE_BUTTON}    xpath://button[div/span="Create New"]
${SSL_VPN_SETTINGS_MAPPING_EDIT_BUTTON}    xpath://button[div/span="Edit"]
${SSL_VPN_SETTINGS_MAPPING_DELETE_BUTTON}    xpath://button[div/span="Delete"]
${SSL_VPN_SETTINGS_MAPPING_ENTRY_H1}    xpath://div[h1="New Authentication\/Portal Mapping"]
${SSL_VPN_SETTINGS_MAPPING_USERS_GROUPS_DIV}    xpath://*[@id="auth-rule-slider"]/section/div/div/div/div[@class="add-placeholder"]
#${SSL_VPN_SETTINGS_MAPPING_USERS_GROUPS_DIV}    xpath://label[text()="Users\/Groups"]/following-sibling::div/div/div[@class="add-placeholder"]
${SSL_VPN_SETTINGS_MAPPING_DEFAULT_REALM_LABEL}    xpath://label[normalize-space(.)="Default realm"]
${SSL_VPN_SETTINGS_MAPPING_SPECIFY_REALM_LABEL}    xpath://label[normalize-space(.)="Specify"]
${SSL_VPN_SETTINGS_MAPPING_REALM_DIV}    xpath://label[@for="auth-realm"]/following-sibling::div/div/div[@class="add-placeholder"]
${VAR_SSL_VPN_SETTINGS_MAPPING_REALM_IN_DROPDOWN}    xpath://div[@class="selection-dropdown inside-slide"]/div/div[span="\${PLACEHOLDER}"]
${VAR_SSL_VPN_SETTINGS_MAPPING_REALM_IN_DIV}    xpath://label[@for="auth-realm"]/following-sibling::div[//span="\${PLACEHOLDER}"]
${SSL_VPN_SETTINGS_MAPPING_PORTAL_DIV}    xpath://label[text()="Portal"]/following-sibling::div/div/div[@class="add-placeholder"]
${SSL_VPN_SETTINGS_MAPPING_OK_BUTTON}    xpath://button[text()="OK"]
${SSL_VPN_SETTINGS_MAPPING_TABLE}    xpath://table
${SSL_VPN_SETTINGS_MAPPING_DEFAULT_ROW}    xpath://table/tbody/tr[last()]
${SSL_VPN_SETTINGS_MAPPING_DEFAULT_H1}    xpath://div[h1="Edit Default Authentication\/Portal Mapping"]
${SSL_VPN_SETTINGS_SUBMIT_BUTTON}    id:submit_apply
${SSL_VPN_SETTINGS_HEAD}    xpath://h1[text()="SSL-VPN Settings"]
${SSL_VPN_SETTINGS_WARNING_H1}    xpath://h1[text()="Warning"]
${SSL_VPN_SETTINGS_NOT_CONFIGURED_WARNING}    xpath://div[contains(text(),"SSL-VPN settings are not fully configured")]
${VAR_VPN_SETTINGS_MAPPING_VIA_PORTAL_NAME}    xpath:(//table/tbody/tr[td="\${PLACEHOLDER}"])
${SSL_VPN_HEARTBEAT}    id:fortiheartbeat

###SSL-VPN Realms
${SSL_VPN_REALMS_ENTRY}    xpath://span[text()="SSL-VPN Realms"]
${SSL_VPN_REALMS_FRAME}    name:embedded-iframe
${SSL_VPN_REALMS_CREATE}    xpath://button[div/span="Create New"]
${SSL_VPN_REALMS_COLUMN}    xpath://td[@class="url-path"]
##SSL-VPN REALMS Create New
${SSL_VPN_REALMS_CREATE_H1}    xpath://h1[text()="New SSL-VPN Realm"]
${SSL_VPN_REALMS_CREATE_URL_PATH}    id:url-path
${SSL_VPN_REALMS_CREATE_URL_PATH_NOTICE}    id:url-path-notice

##SSL-VPN REALMS Delete
${SSL_VPN_REALMS_DELETE_BUTTON}    xpath://button[div/span="Delete" and not(@disabled)]
${SSL_VPN_REALMS_DELETE_CONFIRM_HEAD}    xpath://h1[@title="Confirm" and text()="Confirm"]
${SSL_VPN_REALMS_DELETE_CONFIRM_OK_BUTTON}    xpath://button[text()="OK"]
${VAR_SSL_VPN_REALMS_NAME_IN_TABLE}    xpath://tbody/tr/td[text()="\${PLACEHOLDER}"]
##SSL-VPN REALMS Edit
${SSL_VPN_REALMS_EDIT}    xpath://button[div/span="Edit"]
${SSL_VPN_REALMS_EDIT_REALM_BUTTON}    xpath://button[div/span="Edit" and not(@disabled)]
${SSL_VPN_REALMS_EDIT_HEAD}    xpath://h1[text()="Edit SSL-VPN Realm"]
${SSL_VPN_REALMS_OK_BUTTON}    xpath://*[@id="submit_ok"]
${SSL_VPN_REALMS_LIMIT_USER_CHECKBOX}    id:en_max-concurrent-user
${SSL_VPN_REALMS_LIMIT_USER_LABEL}    xpath://input[@id="en_max-concurrent-user"]/following-sibling::label
${PORT_CONFLIC_WAENING}    id:port_precedence_warning
${PORT_CONFLIC_SSLVPN_LINK}    xpath://*[@id="port_precedence_warning"]/div/a

${LOGIN_SSLVPN_REPLACE_MESSAGE}    xpath://div[contains(text(),"sslvpn replace message testing")]