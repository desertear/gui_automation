*** Settings ***
Documentation     This file contains all locator variables on FortiGate ipv4 and ipv6 Policy

*** Variables ***

###Policy List (xpath that is same on v4 and v6 policy list)
${VAR_POLICY_V4V6_IN_TABLE}    xpath://div[text()="\${PLACEHOLDER}"]
${POLICY_V4V6_TABLE_NAME}    xpath://div/span[text()="Name"]
${POLICY_V4V6_TABLE_ACTION}    xpath: //div/span[text()="Action"]
${POLICY_V4V6_TABLE}    xpath://div[@class="table-container"]
${POLICY_V4V6_VIEW_PAIR_BUTTON}    xpath://button[div/span="Interface Pair View"]
${POLICY_V4V6_VIEW_PAIR_BUTTON_SELECTED}    xpath://button[div/span="Interface Pair View" and @class="selected"]
${POLICY_V4V6_VIEW_PAIR_TOGGLE_OPEN}    xpath://label[@class="section-label"]/button[contains(@class,"active")]
${POLICY_V4V6_VIEW_PAIR_TOGGLE_FIRST_LABEL}    xpath://div[@class="table-container"]/div[contains(@class,"row section")][1]
${POLICY_V4V6_VIEW_PAIR_TOGGLE_FILTER_BUTTON_ON_FIRST_LABEL}    xpath:(//div[@class="table-container"]/div[contains(@class,"row section")][1]//button)[2]
#${VAR_POLICY_V4V6_VIEW_PAIR_TOGGLE_LABEL}    xpath://label[@class="section-label" and div/div/div/span[1]="\${PLACEHOLDER1}" and div/div/div/span[2]="\${PLACEHOLDER2}" and span="\${PLACEHOLDER3}"]
${VAR_POLICY_V4V6_VIEW_PAIR_TOGGLE_LABEL}    xpath://label[@class="section-label" and ./div//span[./span[text()="\${PLACEHOLDER1}"] and ./following-sibling::span/span[text()="\${PLACEHOLDER2}"]] and ./span[text()="\${PLACEHOLDER3}"]]
#${VAR_POLICY_V4V6_VIEW_PAIR_TOGGLE_LABEL_NO_COUNT}    xpath://label[@class="section-label" and div/div/div/span[1]="\${PLACEHOLDER1}" and div/div/div/span[2]="\${PLACEHOLDER2}"]
${VAR_POLICY_V4V6_VIEW_PAIR_TOGGLE_LABEL_NO_COUNT}    xpath://label[@class="section-label" and ./div//span[./span[text()="\${PLACEHOLDER1}"] and ./following-sibling::span/span[text()="\${PLACEHOLDER2}"]]]
#${VAR_POLICY_V4V6_VIEW_PAIR_TOGGLE_FILTER_BUTTON_ON_LABEL}    xpath://label[@class="section-label" and div/div/div/span[1]="\${PLACEHOLDER1}" and div/div/div/span[2]="\${PLACEHOLDER2}"]/following-sibling::button
${VAR_POLICY_V4V6_VIEW_PAIR_TOGGLE_FILTER_BUTTON_ON_LABEL}    xpath://label[@class="section-label" and ./div//span[./span[text()="\${PLACEHOLDER1}"] and ./following-sibling::span/span[text()="\${PLACEHOLDER2}"]]]/following-sibling::button
${POLICY_V4V6_VIEW_SEQUENCE_BUTTON}    xpath://button[div/span="By Sequence"]
${POLICY_V4V6_VIEW_SEQUENCE_BUTTON_SELECTED}    xpath://button[div/span="By Sequence" and @class="selected"]
${POLICY_V4V6_EDIT_BUTTON}    xpath://div[@class="left-menu-items"]//button[div/span="Edit"]
${POLICY_V4V6_EDIT_BUTTON_E}    xpath://div[@class="left-menu-items"]//button[div/span="Edit" and not(@disabled)]
${POLICY_V4V6_DELETE_BUTTON}    xpath://button[div/span="Delete"]
${POLICY_V4V6_DELETE_BUTTON_E}    xpath://button[div/span="Delete" and not(@disabled)]
${POLICY_V4V6_DELETE_CONFIRM_HEAD}    xpath://h1[@title="Confirm" and text()="Confirm"]
${POLICY_V4V6_DELETE_CONFIRM_OK_BUTTON}    xpath://button[text()="OK"]
#${POLICY_V4V6_POLICY_LOOKUP_BUTTON}    xpath://div[contains(@class,"qlist-menu-bar")]//button[div/span="Policy Lookup"] 
${POLICY_V4V6_POLICY_LOOKUP_BUTTON}    xpath://div[@class="mutable-menu"]//button[div/span="Policy Lookup"]
#${VAR_POLICY_V4V6_NAME_BY_ID_COLUMN}    xpath://div[@column-id="policyid" and ./div//label[text()="\${PLACEHOLDER}"] and following-sibling::div[@column-id="srcintf"]]
${VAR_POLICY_V4V6_NAME_BY_ID_COLUMN}    xpath://div[@column-id="policyid" and ./div//label[text()="\${PLACEHOLDER}"]]
${VAR_POLICY_V4V6_NAME_BY_NAME_COLUMN}    xpath://div[@column-id="name" and ./div//div[text()="\${PLACEHOLDER}"]]
${VAR_POLICY_V4V6_NAME_BY_ID_AND_COLUMN}    xpath://div[div[@column-id="policyid" and ./div//label[text()="\${PLACEHOLDER1}"]]]/div[@column-id="\${PLACEHOLDER2}"]
${VAR_POLICY_V4V6_ID_COLUMN}    xpath://div[@column-id="policyid" and ./div//label[text()="\${PLACEHOLDER}"]]
#${POLICY_V4V6_CONTEXT_MENU}    xpath://div[@ng-controller="PolicyListMenuItems" and ./div//div[span="Policy Status"]]
${POLICY_V4V6_CONTEXT_MENU}    xpath://f-policy-list-menu[.//div[text()="Policy"]]
#${VAR_POLICY_V4V6_CONTEXT_MENU_BUTTON}    xpath://div[@ng-controller="PolicyListMenuItems" and ./div//div[span="Policy Status"]]//button[div/span="\${PLACEHOLDER}"]
${VAR_POLICY_V4V6_CONTEXT_MENU_BUTTON}    xpath://f-policy-list-menu[.//div[text()="Policy"]]//button[./div/span="\${PLACEHOLDER}"]
#${VAR_POLICY_V4V6_CONTEXT_MENU_PASTE_SUBMENU}    xpath://div[contains(@f-pop-up-menu,"pasteSubmenu")]//button[div/span[text()="\${PLACEHOLDER}"]]
${VAR_POLICY_V4V6_CONTEXT_MENU_PASTE_SUBMENU}    xpath://div[contains(@f-pop-up-menu,"pasteMenu") and not(contains(@class,"hidden"))]/div/button[./div/span="\${PLACEHOLDER}"]
#${VAR_POLICY_V4V6_CONTEXT_MENU_INSERT_POLICY_SUBMENU}    xpath://div[@f-pop-up-menu="insertSubmenu"]//button[div/span[text()="\${PLACEHOLDER}"]]
${VAR_POLICY_V4V6_CONTEXT_MENU_INSERT_POLICY_SUBMENU}    xpath://div[contains(@f-pop-up-menu,"pasteMenu") and not(contains(@class,"hidden"))]/div/button[./div/span="\${PLACEHOLDER}"]
${VAR_POLICY_V4V6_CONTEXT_MENU_POLICY_SUBMENU}    xpath://div[@f-pop-up-menu="\${PLACEHOLDER1}"]//button[div/span[text()="\${PLACEHOLDER2}"]]
${VAR_POLICY_V4V6_CONTEXT_MENU_POLICY_NAT_ENABLE}    xpath://div[@f-pop-up-menu="natSubmenu"]//button[div/span[text()="Enable"]]
${VAR_POLICY_V4V6_COLUMN_ID_SETTING}    xpath:(//div[@column-id="\${PLACEHOLDER}"]//label)
${VAR_POLICY_V4V6_COLUMN_GENERAL_SETTING}    xpath://div[@column-id="policyid" and ./div//label[text()="\${PLACEHOLDER1}"]]/following-sibling::div[@column-id="\${PLACEHOLDER2}"]
${VAR_POLICY_V4V6_COLUMN_GENERAL_SETTING_BY_NAME}    xpath://div[@column-id="name" and ./div//div[text()="\${PLACEHOLDER1}"]]/following-sibling::div[@column-id="\${PLACEHOLDER2}"]
${VAR_POLICY_V4V6_COLUMN_SETTING_SECURITY_PROFILE}    //span[contains(@class,"\${PLACEHOLDER}")]/following-sibling::span
${VAR_POLICY_V4V6_COLUMN_SETTING_IPPOOL_NAME}    //span[span="\${PLACEHOLDER}"]
#this is the dictionary of displayed column name to the column-id in html.
&{D_POLICY_DISPLAY_NAME_TO_COLUMN_ID}    From=srcintf    To=dstintf    Source=source    Destination=destination    Destination Address=dstaddr    Schedule=schedule    Service=service    Action=action    
...    NAT=poolname    Security Profiles=profile    Log=logtraffic
${POLICY_V4V6_NOTIFY_MSG_SAVED}    xpath://div[contains(@class,"success-notify-message")]//div[contains(text(),"Your changes have been saved")]
${POLICY_V4V6_TOOLTIPS}    xpath://div[@class="base-tooltip"]
#Policy Header
${POLICY_V4V6_TABLE_HEADER_FIRST_DIV}    xpath://div[@class="fixed-header-container"]//div[@class="header-cell first-cell"]
${VAR_POLICY_V4V6_TABLE_HEADER}    xpath://div[@class="fixed-header-container"]//span[text()="\${PLACEHOLDER}"]


###Policy Lookup Slide in Editor (xpath that is same on v4 and v6 policy list)
${POLICY_V4V6_POLICY_LOOKUP_DIV}    xpath://div[@class="slider-area"]
${POLICY_V4V6_POLICY_LOOKUP_H1}    xpath://h1[text()="Policy Lookup"]
${POLICY_V4V6_POLICY_LOOKUP_SRC_INTF}    //input[@id="srcintf"]/preceding-sibling::div
${VAR_V4V6_POLICY_LOOKUP_SRC_INTF_SELECTION}   xpath://div[contains(@class,"selection-dropdown")]//div[span="\${PLACEHOLDER}"]
${VAR_V4V6_POLICY_LOOKUP_SRC_INTF_ITEM}   xpath://div[label="Source Interface"]//div[span="\${PLACEHOLDER}"]
${POLICY_V4V6_POLICY_LOOKUP_PROTOCOL}    id:protocol
${POLICY_V4V6_POLICY_LOOKUP_PROTOCOL_NUMBER}    id:protocol_number
${POLICY_V4V6_POLICY_LOOKUP_SOURCE}    id:sourceip
${POLICY_V4V6_POLICY_LOOKUP_SOURCE_PORT}    id:sourceport
${POLICY_V4V6_POLICY_LOOKUP_DESTINATION}    id:dest
${POLICY_V4V6_POLICY_LOOKUP_DESTINATION_PORT}    id:destport
${POLICY_V4V6_POLICY_LOOKUP_BUTTON_SEARCH}    xpath://button[text()="Search"]
${POLICY_V4V6_POLICY_LOOKUP_BUTTON_CANCEL}    xpath://button[text()="Cancel"]
${POLICY_V4V6_POLICY_LOOKUP_NO_MATCH_MSG}    xpath://div[@class="slider-area"]//div[@class="warning-message"]
${VAR_V4V6_POLICY_LOOKUP_LOCATED_POLICY}    xpath://div[contains(@class,"located")]//div[@column-id="policyid"]//label[text()="\${PLACEHOLDER}"]
${POLICY_V4V6_POLICY_SEARCH_INPUT}    xpath://input[@placeholder="Search"]
${POLICY_V4V6_POLICY_SEARCH_BUTTON}    xpath://div[input[@placeholder="Search"]]/button
###Policy Configure Table in Editor (xpath that is same on v4 and v6 policy list)
${POLICY_V4V6_POLICY_CONFIGURE_TABLE_BUTTON}    xpath://button[contains(@class,"table-settings")]
${POLICY_V4V6_POLICY_CONFIGURE_TABLE_DIV}    xpath://div[@class="base-tooltip"]
${VAR_POLICY_V4V6_POLICY_CONFIGURE_TABLE_ITEM_BUTTON}    xpath://div[@class="base-tooltip"]//button[span="\${PLACEHOLDER}"]
${VAR_POLICY_V4V6_POLICY_CONFIGURE_TABLE_ITEM_ICON}    xpath://div[@class="base-tooltip"]//button[span="\${PLACEHOLDER}"]/f-icon
${POLICY_V4V6_POLICY_CONFIGURE_TABLE_RESET_BUTTON}    xpath://div[@class="base-tooltip"]//button[span="Reset Table"]
${POLICY_V4V6_POLICY_CONFIGURE_TABLE_APPLY_BUTTON}    xpath://div[@class="base-tooltip"]//div[@class="footer"]/button[text()="Apply"]
${POLICY_V4V6_POLICY_CONFIGURE_TABLE_CANCEL_BUTTON}    xpath://div[@class="base-tooltip"]//div[@class="footer"]/button[text()="Cancel"]]
${VAR_POLICY_V4V6_TABLE_HEADER_FILTER_BUTTON}    xpath://div[span="\${PLACEHOLDER}"]//following-sibling::button[@tooltip-id]
${VAR_POLICY_V4V6_TABLE_HEADER_FILTER_ITEM_BUTTON}    xpath://div[@class="base-tooltip"]//button[div/div="\${PLACEHOLDER}"]
${VAR_POLICY_V4V6_TABLE_HEADER_FILTER_ITEM_BUTTON_BY_ORDER}    xpath:(//div[@class="base-tooltip"]//div[@class="auto-overflow"]//button)[\${PLACEHOLDER}]
#${POLICY_V4V6_TABLE_HEADER_FILTER_APPLY_BUTTON}    xpath://div[@class="base-tooltip"]//button[span="Apply"]
${POLICY_V4V6_TABLE_HEADER_FILTER_APPLY_BUTTON}    xpath://div[@class="base-tooltip"]//button[text()="Apply"]
${POLICY_V4V6_TABLE_HEADER_FILTER_REMOVE_BUTTON}    xpath://div[@class="base-tooltip"]//button[span="Remove"]
${VAR_POLICY_V4V6_TABLE_HEADER_FILTER_TAB}    xpath://div[@class="base-tooltip"]//button[contains(@class,"button radio-button") and div/span="\${PLACEHOLDER}"]
${VAR_POLICY_V4V6_TABLE_HEADER_FILTER_TAB_SELECTED}    xpath://div[@class="base-tooltip"]//button[contains(@class,"button radio-button selected") and div/span="\${PLACEHOLDER}"]
${POLICY_V4V6_TABLE_HEADER_FILTER_INPUT}    xpath://div[@class="base-tooltip"]//input
#${VAR_POLICY_V4V6_INTERFACE_PAIR_FILTER_ITEM_BUTTON}    xpath://div[@class="base-tooltip"]//button[div/div/div/div//span[1]="\${PLACEHOLDER1}" and div/div/div/div//span[2]="\${PLACEHOLDER2}"]
${VAR_POLICY_V4V6_INTERFACE_PAIR_FILTER_ITEM_BUTTON}    xpath://div[@class="base-tooltip"]//button[.//span[./span[text()="\${PLACEHOLDER1}"] and ./following-sibling::span/span[text()="\${PLACEHOLDER2}"]]]
###Policy Editor (xpath that is same on v4 and v6 policy list)
${POLICY_V4V6_POLICY_H1}    xpath://h1[text()="New Policy"]
${POLICY_V4V6_POLICY_H1_EDIT}    xpath://h1[text()="Edit Policy"]
${POLICY_V4V6_POLICY_COMMENT}    xpath://textarea[contains(@class,"comment")]
${POLICY_V4V6_POLICY_NETWORK_H2}    //h2[text()="Firewall / Network Options"]
${POLICY_V4V6_POLICY_UTM_H2}    //h2[text()="Security Profiles"]
${POLICY_V4V6_POLICY_TRAFFIC_SHAPING_H2}    //h2[text()="Traffic Shaping"]
${POLICY_V4V6_POLICY_LOG_H2}    //h2[text()="Logging Options"]
${POLICY_V4V6_POLICY_LOG_DENY_H2}    //h2[text()="Log Violation Traffic"]
${POLICY_V4V6_ID}    xpath://label[text()="ID"]
${POLICY_V4V6_ID_TEXT}    xpath://label[text()="ID"]/following-sibling::div/span
${POLICY_V4V6_ID_INPUT}    xpath://label[text()="ID"]/following-sibling::div/input
${POLICY_V4V6_NAME_TEXT}    xpath://label[span="Name"]/following-sibling::div/input
${POLICY_V4V6_CERTIFICATE_CONFIRM_HEAD}    xpath://h1[@title="Confirm" and text()="Confirm"]
${POLICY_V4V6_CERTIFICATE_CONFIRM_OK_BUTTON}    xpath://button[text()="OK"]
${POLICY_V4V6_INCOMING_INTERFACE_DIV}    xpath://label[span="Incoming Interface"]/following-sibling::div/div/div[@class="add-placeholder"]
${POLICY_V4V6_ENTRY_CLOSE_BUTTON}    xpath://div[h1="Select Entries"]//following-sibling::div/button[text()="Close"]
${POLICY_V4V6_OUTGOING_INTERFACE_DIV}    xpath://label[text()="Outgoing Interface"]/following-sibling::div/div/div[@class="add-placeholder"]
${POLICY_V4V6_ENTRY_ADDRESS_LIST}    xpath://div[contains(@class,"virtual-results")]
${POLICY_V4V6_ENTRY_ADDRESS_TAB}    xpath://label[text()="Address"]
${POLICY_V4V6_ENTRY_USER_TAB}    xpath://label[text()="User"]
${POLICY_V4V6_ADDRESS_NONE_IN_SELECT_ENTRY}    xpath://label[contains(span,"Address")]/following-sibling::div[span/span[text()="none"]]
${VAR_POLICY_V4V6_ADDRESS_IN_SELECT_ENTRY}    xpath://label[contains(span,"Address")]/following-sibling::div[span/span[text()="\${PLACEHOLDER}"]]
${VAR_POLICY_V4V6_USER_IN_SELECT_ENTRY}    xpath://label[contains(span,"User \(")]/following-sibling::div[span/span[text()="\${PLACEHOLDER}"]]
${VAR_POLICY_V4V6_GROUP_IN_SELECT_ENTRY}    xpath://label[contains(span,"User Group \(")]/following-sibling::div[span/span[text()="\${PLACEHOLDER}"]]
${VAR_POLICY_V4V6_ADDRESS_IN_DIV}    xpath://label[contains(span,"Source") or contains(span,"Destination")]/following-sibling::div//span[text()="\${PLACEHOLDER}"]
${VAR_POLICY_V4V6_ADDRESS_IN_DIV_SOURCE}    xpath://label[contains(span,"Source")]/following-sibling::div//span[text()="\${PLACEHOLDER}"]
${VAR_POLICY_V4V6_ADDRESS_IN_DIV_DESTINATION}    xpath://label[contains(span,"Destination")]/following-sibling::div//span[text()="\${PLACEHOLDER}"]
${POLICY_V4V6_SOURCE_DIV}    xpath://label[contains(span,"Source")]/following-sibling::div/div/div[@class="add-placeholder"]
${POLICY_V4V6_DESTINATION_DIV}    xpath://label[contains(span,"Destination")]/following-sibling::div/div/div[@class="add-placeholder"]
${POLICY_V4V6_SCHEDULE_DIV}    xpath://label[text()="Schedule"]/following-sibling::div//div[@class="add-placeholder"]
${VAR_POLICY_V4V6_SCHEDULE_IN_DROPDOWN}    xpath://div[@class="selection-dropdown"]/div/div[span/span="\${PLACEHOLDER}"]
${VAR_POLICY_V4V6_SCHEDULE_IN_DIV}    xpath://label[text()="Schedule"]/following-sibling::div//span[text()="\${PLACEHOLDER}"]
${POLICY_V4V6_SERVICE_DIV}    xpath://label[contains(span,"Service")]/following-sibling::div/div/div[@class="add-placeholder"]
${POLICY_V4V6_SERVICE_ENTRY_LIST}    xpath://div[h1="Select Entries"]/following-sibling::div[@class="virtual-results"]
${POLICY_V4V6_SERVICE_ALL_IN_SELECT_ENTRY}    xpath://label[contains(span,"Service")]/following-sibling::div[span/span[text()="ALL"]]
${VAR_POLICY_V4V6_SERVICE_ENTRY_IN_LIST}    xpath://div[h1="Select Entries"]/following-sibling::div/div[span/span="\${PLACEHOLDER}"]
${VAR_POLICY_V4V6_SERVICE_IN_DIV}    xpath://label[contains(span,"Service")]/following-sibling::div//div[contains(@class,"selected-entries")]//span[text()="\${PLACEHOLDER}"]
${POLICY_V4V6_ACTION_ACCEPT_LABEL}    xpath://label[span="ACCEPT"]
${POLICY_V4V6_ACTION_ACCEPT_ID}    id:radio-action-accept
${POLICY_V4V6_ACTION_DENY_LABEL}    xpath://label[span="DENY"]
${POLICY_V4V6_ACTION_DENY_ID}    id:radio-action-deny
${POLICY_V4V6_ACTION_LEARN_LABEL}    xpath://label[span="LEARN"]
${POLICY_V4V6_FIXED_PORT_INPUT}    id:chk-enable-fixedport    #related to below variable
${POLICY_V4V6_FIXED_PORT_ID}    chk-enable-fixedport    #this is for javascript function, should be updated according to above variable
${POLICY_V4V6_IP_POOL_INTF_INPUT}    id:radio-dstintf-addr
${POLICY_V4V6_IP_POOL_INTF_LABEL}    xpath://input[@id="radio-dstintf-addr"]/following-sibling::label
${POLICY_V4V6_IP_POOL_DYNAMIC_POOL_INPUT}    id:radio-nat-pool
${POLICY_V4V6_IP_POOL_DYNAMIC_POOL_LABEL}    xpath://input[@id="radio-nat-pool"]/following-sibling::label
${POLICY_V4V6_IP_POOL_DYNAMIC_POOL_DIV}    xpath://div[label="IP Pool Configuration"]/following-sibling::div//div[@class="add-placeholder"]
${POLICY_V4V6_IP_POOL_DYNAMIC_POOL_SELECT}    xpath://div[label="IP Pool Configuration"]/following-sibling::div//div[@class="selected-entries"]
${POLICY_V4V6_PROFILE_GROUP_INPUT}    id:chk-utm-profile-group-dialog    #related to below variable
${POLICY_V4V6_PROFILE_GROUP_ID}    chk-utm-profile-group-dialog    #this is for javascript function, should be updated according to above variable
${POLICY_V4V6_ANTIVIRUS_INPUT}    id:chk-av-profile-dialog    #related to below variable
${POLICY_V4V6_ANTIVIRUS_ID}    chk-av-profile-dialog        #this is for javascript function, should be updated according to above variable
${POLICY_V4V6_WEB_FILTER_INPUT}    id:chk-webfilter-profile-dialog    #related to below variable
${POLICY_V4V6_WEB_FILTER_ID}    chk-webfilter-profile-dialog        #this is for javascript function, should be updated according to above variable
${POLICY_V4V6_DNS_FILTER_INPUT}    id:chk-dnsfilter-profile-dialog    #related to below variable
${POLICY_V4V6_DNS_FILTER_ID}    chk-dnsfilter-profile-dialog        #this is for javascript function, should be updated according to above variable
${POLICY_V4V6_APP_CONTROL_INPUT}    id:chk-application-list-dialog    #related to below variable
${POLICY_V4V6_APP_CONTROL_ID}    chk-application-list-dialog        #this is for javascript function, should be updated according to above variable
${POLICY_V4V6_IPS_INPUT}    id:chk-ips-sensor-dialog    #related to below variable
${POLICY_V4V6_IPS_ID}    chk-ips-sensor-dialog        #this is for javascript function, should be updated according to above variable
${POLICY_V4V6_SSL_SSH_INPUT}    id:chk-ssl-ssh-profile-dialog    #related to below variable
${POLICY_V4V6_SSL_SSH_ID}    chk-ssl-ssh-profile-dialog        #this is for javascript function, should be updated according to above variable
${POLICY_V4V6_SHARED_SHAPER_INPUT}    id:chk-traffic-shaper    #related to below variable
${POLICY_V4V6_SHARED_SHAPER_ID}    chk-traffic-shaper    #this is for javascript function, should be updated according to above variable
${POLICY_V4V6_SHARED_SHAPER_REVERSE_INPUT}    id:chk-traffic-shaper-reverse    #related to below variable
${POLICY_V4V6_SHARED_SHAPER_REVERSE_ID}    chk-traffic-shaper-reverse    #this is for javascript function, should be updated according to above variable
${POLICY_V4V6_PER_IP_SHAPER_INPUT}    id:chk-per-ip-shaper    #related to below variable
${POLICY_V4V6_PER_IP_SHAPER_ID}    chk-per-ip-shaper    #this is for javascript function, should be updated according to above variable
${POLICY_V4V6_LOG_INPUT}    id:chk-log-enabled-dialog    #related to below variable                           
${POLICY_V4V6_LOG_ID}    chk-log-enabled-dialog    #this is for javascript function, should be updated according to above variable
${POLICY_V4V6_LOG_UTM_INPUT}    id:radio-logtraffic-utm-dialog
${POLICY_V4V6_LOG_UTM_LABEL}    xpath://input[@id="radio-logtraffic-utm-dialog"]/following-sibling::label
${POLICY_V4V6_LOG_ALL_INPUT}    id:radio-logtraffic-all-dialog
${POLICY_V4V6_LOG_ALL_LABEL}    xpath://input[@id="radio-logtraffic-all-dialog"]/following-sibling::label
${POLICY_V4V6_LOG_SESSION_START_TEXT}    xpath://span[text()="Generate Logs when Session Starts"]
${POLICY_V4V6_LOG_SESSION_START_INPUT}    id:chk-logtraffic-start-dialog    #related to below variable
${POLICY_V4V6_LOG_SESSION_START_ID}    chk-logtraffic-start-dialog    #this is for javascript function, should be updated according to above variable
${POLICY_V4V6_CAPTURE_PKT_INPUT}    id:chk-capture-packet-dialog    #related to below variable
${POLICY_V4V6_CAPTURE_PKT_ID}    chk-capture-packet-dialog    #this is for javascript function, should be updated according to above variable
${VAR_POLICY_V4V6_DIV_LABEL}    xpath://label[descendant-or-self::text()="\${PLACEHOLDER}"]
${VAR_POLICY_V4V6_DIV_LIST_SELECTION}    xpath://label[descendant-or-self::text()="\${PLACEHOLDER}"]/following-sibling::div//div[@class="selected-entries"]
${VAR_POLICY_V4V6_DIV_LIST_PLACEHOLDER}    xpath://label[descendant-or-self::text()="\${PLACEHOLDER}"]/following-sibling::div//div[@class="add-placeholder"]
${VAR_POLICY_V4V6_DIV_LIST_ITEM}    xpath://div[./span/span[text()="\${PLACEHOLDER}"]]
${POLICY_V4V6_SELECTION_PANE_DIV}    xpath://div[div/h1="Select Entries"]
${POLICY_V4V6_SELECTION_PANE_H1}    xpath://h1[text()="Select Entries"]
${POLICY_V4V6_SELECTION_PANE_CLOSE}    xpath://h1[text()="Select Entries"]/following-sibling::button
${POLICY_V4V6_SELECTION_PANE_LIST}    xpath://div[h1="Select Entries"]/following-sibling::div[@class="virtual-results"]
${POLICY_V4V6_SELECTION_PANE_LIST_LAST_ITEM}    xpath://div[h1="Select Entries"]/following-sibling::div[@class="virtual-results"]/div[last()]/span
${VAR_POLICY_V4V6_SELECTION_PANE_ITEM}    xpath://div[h1="Select Entries"]/following-sibling::div/div[span/span[text()="\${PLACEHOLDER}"]]
${POLICY_COLUMN_SORT_SPAN}    xpath://span[text()="\${PLACEHOLDER}"]/following-sibling::span
###Policy Editor in Slide in area
${POLICY_V4V6_SLIDER_IFRAME}    //iframe[contains(@name,"slide-iframe") and @class="slide-iframe"]
${POLICY_V4V6_SLIDER_AREA}    xpath://div[@class="slider-area"]

###IPv4 Policy Editor
${POLICY_V4V6_POLICY_EDIT_CHECKBOX_INPUT}    xpath://span[span="\${PLACEHOLDER}"]/input
${POLICY_V4V6_POLICY_EDIT_CHECKBOX_LABEL}    xpath://span[span="\${PLACEHOLDER}"]/label
${POLICY_V4V6_SECURITY_PROFILE_SELECT_MENU}    xpath://f-field[label//span="\${PLACEHOLDER}"]/div//div[contains(@class,"single-select")]
${POLICY_V4V6_INSPECTION_MODE}    xpath://f-filed[label/field-label="Inspection Mode"]/div//label[span="\${PLACEHOLDER}"]
${POLICY_V4V6_ACTION}    xpath://div[label="Action"]/div//label[span="\${PLACEHOLDER}"]
${POLICY_V4V6_LOG_ALLOWED_TRAFFIC}    xpath://div[label//span[contains(text(),"Log Allowed Traffic")]]/div//label[text()="\${PLACEHOLDER}"]
${POLICY_V4V6_IPPOOL_MODE}    xpath://div[label="IP Pool Configuration"]/div//label[contains(text(),"\${PLACEHOLDER}")]
${POLICY_EDIT_PAGE_ELEMENT_FIRST_ENTRY_SELECTED}    xpath://div[label[contains(descendant-or-self::text(),"\${PLACEHOLDER}")]]//div[@class="selected-entries"]/div[1]
${POLICY_EDIT_PAGE_ELEMENT_REMOVE_BUTTON}    /f-icon[contains(@class,"remove-selected-entry")]
###IPv6 Policy Editor
${POLICY_IPV6_ENTRY_LIST_SPAN}    xpath://span[contains(text(),"IPv6 Address \(")]
${VAR_POLICY_IPV6_DES_ADDRESS_IN_SELECT_ENTRY}    xpath://label[contains(span,"IPv6 Address \(")]/following-sibling::div[span/span[text()="\${PLACEHOLDER}"]]

#Gutter
${POLICY_GUTTER_AREA}    xpath://div[@ng-transclude="gutter"]
${POLICY_GUTTER_HELP_LINK}    xpath://a[span="Online Help"]
${POLICY_HELP_LINK_CONTENT}    xpath://div[@id="contentBody"]
${POLICY_HELP_LINK_H}    xpath://div[@id="contentBody"]//*[self::h1 or self::h2]


###Local in Policy List
${POLICY_LOCAL_IN_H}    xpath://h1[text()="Local In Policies"]
${POLICY_LOCAL_IN_TABLE_APP}    xpath://div[contains(text(),"Application") and @class="ui-resizable"]

${VAR_POLICY_LOCAL_IN_TOGGLE_BUTTON}    xpath://label[contains(text(),"\${PLACEHOLDER}")]/button
${VAR_POLICY_LOCAL_IN_TOGGLE_OPEN}    xpath://label[contains(text(),"\${PLACEHOLDER}")]/button[contains(@class,"active")]
#### wildcard fqdn address
${POLICY_ENTRY_TABLE_NAME}   xpath://div[@section-id="\${PLACEHOLDER}"]
${POLICY_ENTRY_TABLE_LINE_NUMBER}   /following-sibling::div[\${PLACEHOLDER}]
${POLICY_ENTRY_TABLE_COLUMN}   /div[@column-id="\${PLACEHOLDER}"]//span/span

###  VWP ####
${POLICY_VWP_PAIR_SELECT_MENU}      xpath://div[@title="Virtual Wire Pair"]/button[//span[@class="caret-down"]]
${POLICY_VWP_PAIR_SELECT_MENU_BAR}      xpath://div[contains(@click,"name")]/button[div/span="\${PLACEHOLDER}"]
${POLICY_VWP_PAIR_SELECTED}      xpath://div[@title="Virtual Wire Pair"]/button[//span[@class="caret-down"]]/div/span[1]
${POLICY_VWP_DIRECTION_LABEL}    xpath://label[contains(@for,"\${PLACEHOLDER}")]