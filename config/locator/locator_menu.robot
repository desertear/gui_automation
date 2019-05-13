*** Settings ***
Documentation     This file contains all locators of FortiGate GUI menu and submenu

*** Variables ***

#${MENU_VDOM_LIST_CURRENT_VDOM}    xpath://nav/div[contains(@class,"vdom-selection")]//span[text()="\${PLACEHOLDER}"]
${MENU_VDOM_LIST_CURRENT_VDOM}    xpath://nav//div[contains(@class,"vdom-selection")]//div[//div/span="\${PLACEHOLDER}"]/div[@class="add-placeholder"]

${MENU_VDOM_LIST_NEW_VDOM}    xpath://div[./div[./span/span[text()="root"] and contains(@class,"entry")]]/div[./span/span[text()="\${PLACEHOLDER}"]]
                                    


####Policy & Objects####
${MENU_POLICY_AND_OBJECT}    xpath://span[text()="Policy & Objects"]
${MENU_POLICY_IPV4_POLICY}    xpath://span[text()="IPv4 Policy"]
${MENU_POLICY_IPV6_POLICY}    xpath://span[text()="IPv6 Policy"]
${MENU_POLICY_NAT64_POLICY}    xpath://span[text()="NAT64 Policy"]
${MENU_POLICY_NAT46_POLICY}    xpath://span[text()="NAT46 Policy"]
${MENU_POLICY_CENTRAL_SNAT}    xpath://span[text()="Central SNAT"]
${MENU_POLICY_MULTICAST_POLICY}    xpath://span[text()="Multicast Policy"]
${MENU_POLICY_LOCAL_IN_POLICY}    xpath://span[text()="Local In Policy"]
${MENU_POLICY_IPV4_ACL}    xpath://span[text()="IPv4 Access Control List"]
${MENU_POLICY_IPV4_DOS_POLYCY}    xpath://span[text()="IPv4 DoS Policy"]
${MENU_POLICY_IPV6_ACL}    xpath://span[text()="IPv6 Access Control List"]
${MENU_POLICY_IPV6_DOS_POLYCY}    xpath://span[text()="IPv6 DoS Policy"]
${MENU_POLICY_SCHEDULE}    xpath://span[text()="Schedules"]
${MENU_POLICY_SERVICE}    xpath://span[text()="Services"]
${MENU_POLICY_ADDRESS}    xpath://span[text()="Addresses"]
${MENU_POLICY_FQDN_ADDRESS}    xpath://span[text()="Wildcard FQDN Addresses"]
${MENU_POLICY_INTERNET_SERVICE_DATABASE}    xpath://span[text()="Internet Service Database"]
${MENU_POLICY_VIRTUAL_IP}    xpath://span[text()="Virtual IPs"]
${MENU_POLICY_IP_POOL}    xpath://span[text()="IP Pools"]

${MENU_POLICY_TRAFFIC_SHAPER}    xpath://span[text()="Traffic Shapers"]
${MENU_POLICY_SHAPING_POLICY}    xpath://span[text()="Traffic Shaping Policy"]



#### Monitor ####
${MENU_VDOM_MONITOR}    xpath://div[@class="submenu-label"]/span[contains(text(),"Monit")]
