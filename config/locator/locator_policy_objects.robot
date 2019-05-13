*** Settings ***
Documentation     This file contains all locator variables on FortiGate Policy Objects

*** Variables ***
${POLICY_OBJECT_FRAME}    name:embedded-iframe
${POLICY_OBJECT_TABLE_COLUMN_NAME}    xpath://span[contains(text(),"Name")]
${POLICY_CONTEXT_MENU_BUTTON_EDIT_IN_CLI}    xpath://div[contains(@class,"left-menu-items")]//button[div/span="Edit in CLI"]
${POLICY_CONTEXT_MENU_BUTTON_EDIT}    xpath://div[contains(@class,"pop-up-menu")]//div[contains(@class,"left-menu-items")]//button[div/span="Edit"]
${POLICY_CONTEXT_MENU_BUTTON_DELETE}    xpath://div[contains(@class,"pop-up-menu")]//div[contains(@class,"left-menu-items")]//button[div/span="Delete"]
###REF 
${POLICY_OBJECTS_REF_H1}    xpath://div[@class="slider-area"]//h1
${POLICY_OBJECTS_REF_ENTRIES}    xpath:(//div[@class="slider-area"]//table//td[@class="mkey"])
${POLICY_OBJECTS_REF_CLOSE}    xpath://div[@class="slider-area"]//button[@class="bare"]

###Addresses List
${POLICY_ADDRESSES_ADDRESS_BUTTON}    xpath://button[normalize-space(div/span)="Address"]
${POLICY_ADDRESSES_ADDRESS_GROUP_BUTTON}    xpath://button[normalize-space(div/span)="Address Group"]
${POLICY_ADDRESSES_ADDRESS_TEMPLATE_BUTTON}    xpath://button[normalize-space(div/span)="IPv6 Address Template"]
${VAR_POLICY_ADDRESSES_CREATE_BUTTON_SUB_MENU}    xpath://button[normalize-space(div/span)="\${PLACEHOLDER}"]
${POLICY_ADDRESSES_ADDRESS_TOGGLE_BUTTON}    xpath://div[@section-id="Address"]/div/label/button
${VAR_ADDRESSES_TOGGLE_BUTTON}    xpath://div[@section-id="\${PLACEHOLDER}"]/div/label/button
${POLICY_ADDRESSES_PORTAL_DELETE_BUTTON}    xpath://button[div/span="Delete" and not(@disabled)]
${POLICY_ADDRESSES_DELETE_CONFIRM_HEAD}    xpath://h1[@title="Confirm" and text()="Confirm"]
${POLICY_ADDRESSES_DELETE_CONFIRM_OK_BUTTON}    xpath://button[text()="OK"]
${VAR_POLICY_ADDRESSES_IN_TABLE}    xpath://span[text()="\${PLACEHOLDER}"]
${POLICY_ADDRESSES_EDIT_HEAD}    xpath://h1[text()="Edit Address"]
${VAR_POLICY_ADDRESSES_NAME_COLUMN}    xpath://div[@column-id="name"]//div[span[text()="\${PLACEHOLDER}"]]
${POLICY_ADDRESS_REF}    xpath://div[div[@column-id="name" and *//span/text()="\${PLACEHOLDER}"]]/div[@column-id="cmdbReferences"]//a
${VAR_ADDRESS_ICON}    xpath://div[@column-id="name"]//div[span[descendant-or-self::text()="\${PLACEHOLDER}"]]//f-icon
${VAR_ADDRESS_ICON_POLICY_LIST}    xpath://div[span[descendant-or-self::text()="\${PLACEHOLDER}"]]//f-icon
&{D_ADDRESS_DISPLAY_NAME_TO_COLUMN_ID}    Name=name    Type=type    Details=details    Interface=intf    Visibility=visibility
${VAR_ADDRESS_COLUMN_GENERAL_SETTING}    xpath://div[@column-id="name" and ./div//span="\${PLACEHOLDER1}"]/following-sibling::div[@column-id="\${PLACEHOLDER2}"]

###Addresses Editor
${POLICY_ADDRESSES_ADDRESS_H1}    xpath://h1[text()="New Address"]
${POLICY_ADDRESSES_ADDRESS_GROUP_H1}    xpath://h1[text()="New Address Group"]
${POLICY_ADDRESSES_ADDRESS_H1_EDIT}    xpath://h1[text()="Edit Address"]
${POLICY_ADDRESSES_ADDRESS_GROUP_H1_EDIT}    xpath://h1[text()="Edit Address Group"]
${POLICY_ADDRESSES_IPV6_TEMPLATE_H1}    xpath://h1[text()="New IPv6 Address Template"]
${POLICY_ADDRESSES_CATEGORY_ADDRESS}    xpath://label[text()="Address"]
${POLICY_ADDRESSES_ADDRESS_IPV4}    xpath://input[@radio-label="Address"]
${POLICY_ADDRESSES_ADDRESS_IPV6}    xpath://input[@radio-label="IPv6 Address"]
${POLICY_ADDRESSES_ADDRESS_IPV4_LABEL}    xpath://label[.//text()="Address"]
${POLICY_ADDRESSES_ADDRESS_IPV6_LABEL}    xpath://label[.//text()="IPv6 Address"]
${POLICY_ADDRESSES_ADDRESS_GROUP_IPV4}    id:group_type_ipv4
${POLICY_ADDRESSES_ADDRESS_GROUP_IPV6}    id:group_type_ipv6
${POLICY_ADDRESSES_ADDRESS_GROUP_IPV4_LABEL}    xpath://label[span="IPv4 Group"]
${POLICY_ADDRESSES_ADDRESS_GROUP_IPV6_LABEL}    xpath://label[span="IPv6 Group"]
${POLICY_ADDRESSES_NAME_TEXT}    xpath://label[./*[text()="Name"]]/following-sibling::div//input
${POLICY_ADDRESSES_TYPE_SELECT}    xpath://label[./*[text()="Type"]]/following-sibling::div//select
#${POLICY_ADDRESSES_IPV6_TYPE_SELECT}    xpath://label[./*[text()="Type"]]/following-sibling::div//select
${POLICY_ADDRESSES_SUBNET_TEXT}    xpath://input[@id="ipmask"]
${POLICY_ADDRESSES_INPUT_TEXT}    xpath://f-field[label/field-label="\${PLACEHOLDER}"]/div//input[1]
${POLICY_ADDRESSES_INPUT_TEXT_MAC_END}    xpath://f-field[label/field-label="\${PLACEHOLDER}"]/div//input[2]
${POLICY_ADDRESSES_IP_RANGE_TEXT}    xpath://label[./*[text()="IP Range"]]/following-sibling::div//input
${POLICY_ADDRESSES_INTERFACE_DIV}    xpath://label[./*[text()="Interface"]]/following-sibling::div//div[@class="add-placeholder"]
${POLICY_ADDRESSES_INTERFACE_SELECTION}    xpath://div[@class="selection-dropdown"]/div[@class="virtual-results"]
${POLICY_ADDRESSES_INTERFACE_SELECTED}    xpath://div[@class="selection-dropdown"]/div[@class="virtual-results"]/div[contains(@class,"selected")]
${POLICY_ADDRESSES_INTERFACE_INPUT}    xpath://div[@class="selection-dropdown"]/div/div[span/span="\${PLACEHOLDER}"]
${POLICY_ADDRESSES_IPV4_MEMBER_DIV}    xpath://div[./label[text()="Members" and @for="addrgrp-member"]]/div/div/div[@class="add-placeholder"]
${POLICY_ADDRESSES_IPV6_MEMBER_DIV}    xpath://div[./label[text()="Members" and @for="addrgrp6-member"]]/div/div/div[@class="add-placeholder"]
${POLICY_ADDRESSES_OK_BUTTON}    id:submit_ok

###Wildcard FQDN Address list
${POLICY_FQDN_ADDRESS_TOGGLE_BUTTON}    xpath://div[@section-id="Wildcard FQDN"]/div/label/button

###Services List
${POLICY_SERVICE_TABLE_SHOW}    xpath://div[span/text()="Show in Service List"]
${VAR_POLICY_SERVICE_NAME_COLUMN}    xpath://div[@column-id="name"]//div[*/span[text()="\${PLACEHOLDER}"]]
${VAR_POLICY_SERVICE_TOGGLE_BUTTON}    xpath://label[@class="section-label"]/button[./following-sibling::div/div[text()="\${PLACEHOLDER}"]]
${VAR_POLICY_SERVICE_TOGGLE_OPEN}    xpath://label[@class="section-label"]/button[./following-sibling::div/div[text()="\${PLACEHOLDER}"] and contains(@class,"active")]
${VAR_POLICY_SERVICE_CREATE_BUTTON_SUB_MENU}    xpath://div[contains(@class,"menu-item")]/a[span="\${PLACEHOLDER}"]

###Services Editor
${POLICY_SERVICE_SERVICE_H1}    xpath://h1[text()="New Service"]
${POLICY_SERVICE_SERVICE_GROUP_H1}    xpath://h1[text()="New Service Group"]
${POLICY_SERVICE_SERVICE_GROUP_MEMBER_DIV}    xpath://div[./label[text()="Members"]]/div/div/div[@class="add-placeholder"]
${POLICY_SERVICE_CATEGORY_H1}    xpath://h1[text()="Create Service Category"]

###Schedules
${POLICY_SCHEDULE_TABLE_MEMBER}    xpath://div[text()="Days/Members" and @class="ui-resizable"]
${VAR_POLICY_SCHEDULE_NAME_COLUMN}    xpath://td[span[text()="\${PLACEHOLDER}"]]
${POLICY_SCHDULE_REF}    xpath://tr[td[@class="name" and span/text()="\${PLACEHOLDER}"]]/td[@class="q_ref"]/a
${VAR_SCHEDULE_ICON}    xpath://td[@class="name" and span="\${PLACEHOLDER}"]/f-icon


###Virtual IP List
${POLICY_VIRTUAL_IP_TABLE_INTF}    xpath://div[span="Interfaces"]
${VAR_POLICY_VIRTUAL_IP_CREATE_BUTTON_SUB_MENU}    xpath://button[normalize-space(div/span)="\${PLACEHOLDER}"]
${VAR_POLICY_VIP_NAME_COLUMN}     xpath://div[div[@column-id="name"]//span[text()="\${PLACEHOLDER}"]]/div[@column-id="member"]
###Virtual IP Editor
${POLICY_VIRTUAL_IP_VIP_H1}    xpath://h1[contains(text(),"New Virtual IP")]

${POLICY_VIRTUAL_IP_VIP_H1_EDIT}    xpath://h1[contains(text(),"Edit Virtual IP")]
${POLICY_VIRTUAL_IP_VIP_GROUP_H1_EDIT}    xpath://h1[contains(text(),"Edit VIP Group")]
#${POLICY_VIRTUAL_IP_VIP_INTERFACE_DIV}    xpath://label[text()="Interface"]/following-sibling::div/div
${POLICY_VIRTUAL_IP_VIP_INTERFACE_DIV}    xpath://label[contains(.,"Interface")]/following-sibling::div//div[@class="add-placeholder"]
${POLICY_VIRTUAL_IP_VIP_INTERFACE_SELECTION}    xpath://div[@class="selection-dropdown"]/div[@class="virtual-results"]
${POLICY_VIRTUAL_IP_VIP_INTERFACE_SELECTED}    xpath://div[@class="selection-dropdown"]/div[@class="virtual-results"]/div[contains(@class,"selected")]
${POLICY_VIRTUAL_IP_VIP_GROUP_H1}    xpath://h1[text()="New VIP Group"]
${POLICY_VIRTUAL_IP_VIP_TYPE}        xpath://div[label="Type"]/div/span
${POLICY_VIRTUAL_IP_VIP_MAPIPV4}    xpath://div[label="\${PLACEHOLDER1}"]/div/div/input[contains(@name,"\${PLACEHOLDER2}-ipv4")]
${POLICY_VIRTUAL_IP_VIP_MAPIPV6}    xpath://div[label="\${PLACEHOLDER1}"]/div/div/input[contains(@name,"\${PLACEHOLDER2}-ipv6")]
${POLICY_VIRTUAL_IP_VIP_MAPPORT}    xpath://div[contains(label,"\${PLACEHOLDER1}")]/div/input[\${PLACEHOLDER2}]
${POLICY_VIRTUAL_IP_VIP_FILTER_SRC}    xpath://div[label="Source address"]/div/input[\${PLACEHOLDER}][contains(@class,"IP4")]
${POLICY_VIRTUAL_IP_VIP_FQDN_EXIP}    xpath://div[label="External IP Address"]/div/input
${POLICY_VIRTUAL_IP_VIP_FQDN_MAP_ADDR}    xpath://div[label="Mapped Address"]/div//span/span/span
###IP Pools List
${POLICY_IP_POOL_TABLE_IP_RANGE}    xpath://div[text()="External IP Range" and @class="ui-resizable"]
${POLICY_IP_POOL_REF}    xpath://tr[td[@class="name" and text()="\${PLACEHOLDER}"]]/td[@class="q_ref"]/a

###IP Pools Editor
${POLICY_IP_POOL_H1}    xpath://h1[text()="New Dynamic IP Pool"]


###Internet Service Database
${POLICY_ISDB_TABLE_REPUTATION}    xpath://div[span="Reputation"]
${POLICY_ISDB_TABLE_DIRECTION}    xpath://div[span="Direction"]
&{D_ISDB_DISPLAY_NAME_TO_COLUMN_ID}    Name=name    Reputation=reputation    Direction=direction    Number of Entries=ip-range-number
&{D_WILDCARD_FQDN_NAME_TO_COLUMN_ID}   Name=name    Details=member
${VAR_POLICY_ISDB_COLUMN_GENERAL_SETTING}    xpath://div[@column-id="name" and ./div//span="\${PLACEHOLDER1}"]/following-sibling::div[@column-id="\${PLACEHOLDER2}"]
${VAR_POLICY_ISDB_NAME_COLUMN}    xpath://div[@column-id="name"]//div[span[span="\${PLACEHOLDER}"]]
