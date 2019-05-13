*** Settings ***
Documentation     This file contains all locator variables on FortiGate IPsec VPN page

*** Variables ***
###IPsec Tunnels
${IPSEC_TUNNELS_ENTRY}    xpath://span[text()="IPsec Tunnels"]
${IPSEC_TUNNELS_CREATE}    xpath://button[div/span="Create New"]
${IPSEC_TUNNELS_DELETE}    xpath://button[div/span="Delete"]
${VAR_IPSEC_TUNNELS_COLUMN}    xpath://div[@column-id="name"]/div/div/div[text()="\${PLACEHOLDER}"]
${VAR_IPSEC_TUNNELS_TOGGLE_BUTTON}    xpath://label[@class="section-label"]/button[./following-sibling::div/div/span/span[text()="\${PLACEHOLDER}"]]
${VAR_IPSEC_TUNNELS_TOGGLE_OPEN}    xpath://label[@class="section-label"]/button[./following-sibling::div/div/span/span[text()="\${PLACEHOLDER}"] and contains(@class,"active")]
