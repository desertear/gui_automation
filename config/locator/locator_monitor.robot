*** Settings ***
Documentation     This file contains all locator variables on FortiGate Monitor

*** Variables ***
####Monitor####
${MONITOR_ENTRY}    xpath://div[@class="submenu-label"]/span[contains(text(),"Monit")]
###SSL-VPN Monitor###
${MONITOR_SSL_VPN_ENTRY}    xpath://span[text()="SSL-VPN Monitor"]
${MONITOR_SSL_VPN_REFRESH_BUTTON}    xpath://button[div/span="Refresh"]
${MONITOR_DHCP_ENTRY}    xpath://span[text()="DHCP Monitor"]
${MONITOR_FIREWALL_USER_ENTRY}    xpath://span[text()="Firewall User Monitor"]