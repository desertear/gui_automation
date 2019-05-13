*** Settings ***
Documentation     This file contains all locator variables on FortiGate ACL policy

*** Variables ***

###Traffic Shapers List



###ACL-DOS Policy List

###ACL-DOS Policy Editor
${POLICY_ACL_SOURCE_DIV}    xpath://label[contains(text(),"Source")]/following-sibling::div//div[@class="add-placeholder"]
${POLICY_ACL_DESTINATION_DIV}    xpath://label[contains(text(),"Destination")]/following-sibling::div//div[@class="add-placeholder"]
${POLICY_DOS_SOURCE_DIV}    xpath://label[contains(text(),"Source")]/following-sibling::div//div[@class="add-placeholder"]
${POLICY_DOS_DESTINATION_DIV}    xpath://label[contains(text(),"Destination")]/following-sibling::div//div[@class="add-placeholder"]

${POLICY_ACL_INCOMING_INTERFACE_DIV}    xpath://label[text()="Incoming Interface"]/following-sibling::div/div/div[@class="add-placeholder"]
${POLICY_NAT64_INCOMING_INTERFACE_DIV}    xpath://label[span="Incoming Interface"]/following-sibling::div/div/div[@class="add-placeholder"]
${POLICY_NAT64_OUTGOING_INTERFACE_DIV}    xpath://label[text()="Outgoing Interface"]/following-sibling::div/div/div[@class="add-placeholder"]
${POLICY_NAT46_INCOMING_INTERFACE_DIV}    xpath://label[span="Incoming Interface"]/following-sibling::div/div/div[@class="add-placeholder"]
${POLICY_NAT46_OUTGOING_INTERFACE_DIV}    xpath://label[text()="Outgoing Interface"]/following-sibling::div/div/div[@class="add-placeholder"]
${POLICY_MULTICAST_INCOMING_INTERFACE_DIV}    xpath://label[span="Incoming Interface"]/following-sibling::div/div/div[@class="add-placeholder"]
${POLICY_MULTICAST_OUTGOING_INTERFACE_DIV}    xpath://label[text()="Outgoing Interface"]/following-sibling::div/div/div[@class="add-placeholder"]
${POLICY_DOS_INCOMING_INTERFACE_DIV}    xpath://label[text()="Incoming Interface"]/following-sibling::div/div/div[@class="add-placeholder"]
${POLICY_SHAPING_OUTGOING_INTERFACE_DIV}    xpath://label[field-label="Outgoing interface"]/following-sibling::div//div[@class="add-placeholder"]
#${MENU_DROPDOWN_SELECTION}   xpath://div[@class="selection-dropdown"]
${MENU_DROPDOWN_SELECTION}   xpath://div[@class="virtual-results"]