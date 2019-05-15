*** Settings ***
Documentation     This file contains all locator variables on FortiGate System page

*** Variables ***
####System####
${SYSTEM_ENTRY}    xpath://span[text()="System"]
${SYSTEM_ENTRY_FRN}    xpath://span[text()="Système"]
${SUBMIT_OK_BUTTON}    id:submit_ok
${SUBMIT_CANCEL_BUTTON}    id:submit_cancel
${SUBMIT_RETURN_BUTTON}    id:submit_return
${SUBMIT_APPLY_BUTTON}    id:submit_apply
${CONFIRM_OK_BUTTON}        xpath://button[text()="OK"]
${CONFIRM_CANCEL_BUTTON}        xpath://button[contains(text(),"Cancel")]
${SUBMIT_OK_SPAN}          xpath://button[span[contains(text(),"OK")]]
${SUBMIT_APPLY_SPAN}       xpath://button[span[contains(text(),"Apply")]]
${SUBMIT_APPLY_SPAN_FRN}       xpath://button[span[contains(text(),"Applique")]]
${SUBMIT_SAVE_BUTTON}       xpath://button[@id="menu-save"]
${SUBMIT_RESTORE_BUTTON}       xpath://button[@id="menu-revert"]
${SYSTEM_COMMON_LABEL}            xpath://label[contains(span,"\${PLACEHOLDER}")]
${SYSTEM_COMMON_BUTTON}           xpath://button[div/span[contains(text(),"\${PLACEHOLDER}")]]
${SYSTEM_COMMON_INPUT_BOX}           xpath://f-field[label[contains(field-label,"\${PLACEHOLDER}")]]/div//input
${SYSTEM_COMMON_HREF_BUTTON}     xpath://a[contains(span,"\${PLACEHOLDER}")]
${SYSTEM_SECTION_TOGGLE_BUTTON}    xpath://div[contains(@section-id,"\${PLACEHOLDER}")]//label[@class="section-label"]/button[contains(@class,"visual-toggle")]
${SYSTEM_SLIDE_IFRAME}     xpath://iframe[@class="slide-iframe"]
${SYSTEM_CHANGE_SAVE_NOTIFY_MESSAGE}    xpath://div[@class="notify-message-content"][text()="Your changes have been saved."]
${SYSTEM_GERERAL_CHKBOX_INPUT}    xpath://f-field[label/field-label="\${PLACEHOLDER}"]/div//input
${SYSTEM_GERERAL_CHKBOX_LABEL}    xpath://f-field[label/field-label="\${PLACEHOLDER}"]/div//label
${SYSTEM_GERERAL_ADD_ENTRY_BUTTON}    xpath://f-field[label/field-label[(contains(text(),"\${PLACEHOLDER}"))]]//div[@class="add-placeholder"]
###Firmware###
${SYSTEM_FIRMWARE_ENTRY}    xpath://span[text()="Firmware"]
${SYSTEM_FIRMWARE_H1}    xpath://h1[text()="Firmware Management"]
${SYSTEM_FIRMWARE_BROWSE}    id:firmwareFile
${SYSTEM_FIRMWARE_WRONG_PLTF_WARNING}    xpath://div[normalize-space(.)="Image file doesn\'t match platform."]
${SYSTEM_COMON_DROPDOWN_MENU_MULTMENU}      xpath://f-field[label[contains(field-label,"\${PLACEHOLDER}")]]//div[contains(@class,"select-widget")]
${SYSTEM_COMON_DROPDOWN_MENU_ONEMENU}      xpath:(//div[@class="select-widget single-select"])[2]
${SYSTEM_COMON_DROPDOWN_MENU_BAR}    xpath://div[@class="virtual-results"]/div[span/span="\${PLACEHOLDER}"]
###Backup Configuration###
${SYSTEM_BACKUP_CONFIG_H1}    xpath://h1[text()="Backup System Configuration"]
${SYSTEM_BACKUP_CONFIG_OK_BUTTON}    id:submit_ok
${DROPDOWN_MASK}    xpath://div[@class="base-mask selection-dropdown-mask"]
########## admin menu #####
${ADMIN_SYSTEM_BAR}    xpath://f-header-admin-menu//span[text()="System"]
${ADMIN_SYSTEM_BAR_REBOOT_BUTTON}    xpath://span[text()="Reboot"]
${ADMIN_SYSTEM_BAR_REBOOT_OK_BUTTON}    xpath://button[@id="submit_ok"]
${ADMIN_CONFIGURATION_BAR}     xpath://f-header-admin-menu//span[text()="Configuration"]
${ADMIN_CONFIGURATION_BACKUP_BUTTON}    xpath://button[div/span[text()="Backup"]]
${ADMIN_CONFIGURATION_RESTORE_BUTTON}    xpath://button[div/span[text()="Restore"]]
${ADMIN_CONFIGURATION_REVISION_BUTTON}    xpath://button[div/span[text()="Revisions"]]
${ADMIN_CONFIGURATION_BACKUP_LABEL}   xpath://div[label="Scope"]/div/div/label[text()="\${PLACEHOLDER}"]
${ADMIN_CONFIGURATION_BACKUP_GLOBAL_INPUT}   xpath://div[label="Scope"]/div/div/input[@id="config-full"]
${ADMIN_CONFIGURATION_BACKUP_VDOM_LABEL}     xpath://div[label="Scope"]/div/div/label[text()="VDOM"]
${ADMIN_CONFIGURATION_BACKUP_VDOM_INPUT}     xpath://div[label="Scope"]/div/div/label[@id="config-vdom"]
${ADMIN_CONFIGURATION_BACKUP_USB_LABEL}      xpath://div[label="Backup to"]/div/div/label[text()="USB Disk"]
${ADMIN_CONFIGURATION_BACKUP_USB_INPUT}      id:backup-usb-disk
${ADMIN_CONFIGURATION_BACKUP_PC_LABEL}       xpath://div[label="Backup to"]/div/div/label[text()="Local PC"]
${ADMIN_CONFIGURATION_BACKUP_USB_FILENAME}   id:usb-filename
${ADMIN_CONFIGURATION_BACKUP_ENCRYPT_CHKBOX}    id:toggle-encryption
${ADMIN_CONFIGURATION_BACKUP_ENCRYPT_LABEL}    xpath://span[span="Encryption"]/label
${ADMIN_CONFIGURATION_BACKUP_ENCRYPT_PWD}     id:pwd
${ADMIN_CONFIGURATION_BACKUP_ENCRYPT_PWD_CONFIRM}     id:pwd-confirm
${ADMIN_CONFIGURATION_RESTORE_LABEL}    xpath://label[text()="\${PLACEHOLDER}"]
${ADMIN_CONFIGURATION_RESTORE_FILE_PC}    xpath://div[label/span="Upload"]/input
${ADMIN_CONFIGURATION_RESTORE_FILE_MENU}  xpath://div[label="File"]/div/select
${ADMIN_CONFIGURATION_RESTORE_FILE_MENU_BAR}    /option[text()="\${PLACEHOLDER}"]
${ADMIN_CONFIGURATION_REVISION_ITEM_BUTTON}    xpath://label[contains(text(),"\${PLACEHOLDER}")]/button
${ADMIN_CONFIGURATION_REVISION_ITEM_ENTRY_HEAD}     xpath://tbody[tr/td/label[contains(text(),"\${PLACEHOLDER}")]/button]
${ADMIN_CONFIGURATION_REVISION_ITEM_ENTRY}     /following-sibling::tbody[1]/tr[\${PLACEHOLDER}]
${ADMIN_CONFIGURATION_REVISION_DIFF_BUTTON}    xpath:(//button[div/span="Diff"])[1]
${ADMIN_CONFIGURATION_REVISION_DELETE_BUTTON}    xpath:(//button[div/span="Delete"])[1]
${ADMIN_CONFIGURATION_REVISION_DIFF_DIAGBOX_TITLE}   xpath://div[h1="Configuration Diff"]
#### select entry  from pane ####
${SELECTION_POLICY_TITLE_MENU}    xpath://div[div[h1="Select Entries"]]/div[@class="radio-group"]/label[text()="\${PLACEHOLDER}"]
${SELECTION_SPAN_MENU_BAR}     xpath://div[div[h1="Select Entries"]]/div[@class="virtual-results"]/div[span/span[text()="\${PLACEHOLDER}"]]
${SELECTION_SPAN_MENU_CLOSE_BUTTON}    xpath://div[h1="Select Entries"]/button
####PORTAL Page####
${SYSTEM_LOGIN_TIMEOUT_WAN_MSG}    xpath://div[@id="warn_msg_content"]
${SYSTEM_ADMINISTRATORS_ENTRY}             xpath://span[text()="Administrators"]
${SYSTEM_ADVANCED_ENTRY}                   xpath://span[text()="Advanced"]
${SYSTEM_VDOM_ENTRY}                       xpath://a[span="VDOM"]
${SYSTEM_SETTINGS_ENTRY}                   xpath://div/div[span="System"]/following-sibling::f-navbar-menu//span[text()="Settings"]
${SYSTEM_FEATURE VISIBILITY_ENTRY}         xpath://span[text()="Feature Visibility"]
${SYSTEM_GUI_APPLY}                        xpath://button[span="Apply"]
${SYSTEM_DASHBOARD_ENTRY}                  xpath://span[text()="Dashboard"]
${SYSTEM_DASHBOARD_MAIN_ENTRY}             xpath://span[text()="Status"]
${SYSTEM_VDOMMENU_DROP_DOWN_BUTTON}        xpath://div[contains(@class,"vdom-selection")]
${SYSTEM_VDOMMENU_DROP_DOWN_MENU_BAR}      xpath://div[span/span="\${PLACEHOLDER}"]
${SYSTEM_VDOMMENU_DROP_DOWN_MENU_Global}   xpath://div[2][span/span="Global"]
${SYSTEM_VDOMMENU_DROP_DOWN_MENU_BAR_DEFAULT}   xpath://div[contains(@class,"vdom-selection")]//span[f-icon[@class="ftnt-vdom"]]/span
${SECURITY PROFILES_ENTRY}                 xpath://span[text()="Security Profiles"]
${SYSTEM_MAIN_PORTALPAGE_RELEASE_INFO_TYPE_SPAN}    xpath://f-header-release-info/button/div/div[1]/span
${SYSTEM_MAIN_PORTALPAGE_RELEASE_INFO_BUILD_SPAN}    xpath://f-header-release-info/button/div/div[1]/span/span
${SYSTEM_MAIN_PORTALPAGE_TOPBAR_VDOM}    xpath://div[span[contains(text(),"VDOM:")]][f-omniselect-entry/span/span="\${PLACEHOLDER}"]
${SYSTEM_MAIN_PORTALPAGE_TOPBAR_HA}      xpath://div[span[contains(text(),"HA:")]][span[span="Master"]]
### SYSTEM VDOM ###
${SYSTEM_VDOM_CREATE NEW_BUTTON}           xpath://button[div/span[contains(text(),"Create New")]]
${SYSTEM_VDOM_DELETE_BUTTON}               xpath://button[div/span[contains(text(),"Delete")]]
${SYSTEM_VDOM_NEW_VDOM_NAME}               xpath://f-field[label//span="Virtual Domain"]/div//input
${SYSTEM_VDOM_NEW_VDOM_NGFW_MODE}          xpath://label[span="\${PLACEHOLDER}"]
${SYSTEM_VDOM_NEW_VDOM_COMMENTS}           xpath://textarea[@id="comments"]
${SYSTEM_VDOM_NEW_VDOM_NAME_WARN}          xpath://label[contains(text(),"most 31 characters")]
${SYSTEM_VDOM_TABLE_ENTRY}                    xpath://tr[td[@class="name"]/a="\${PLACEHOLDER}"]
${SYSTEM_VDOM_TABLE_ENTRY_DISABLED}           xpath://tr[td="\${PLACEHOLDER}"]
${SYSTEM_VDOM_TABLE_ENTRY_ENABLE_COLUMN}      /td[@class="enable"]/f-icon
${SYSTEM_VDOM_TABLE_ENTRY_DISABLE_BUTTON}     xpath:(//button[div/span="Disable"])[2]
${SYSTEM_VDOM_TABLE_ENTRY_ENABLE_BUTTON}      xpath:(//button[div/span="Enable"])[2]
${SYSTEM_VDOM_TABLE_ENTRY_SWITCH_MANAGEMENT}      xpath:(//button[div/span[contains(text(),"Switch Management [\${PLACEHOLDER}]")]])[1]
${SYSTEM_VDOM_MAX_NUM_WARN_MSG}    xpath://div[text()="Failed to create Virtual Domain"]
######   system admin #####
${SYSTEM_ADMIN_PROFILES_ENTRY}      xpath://span[text()="Admin Profiles"]
${SYSTEM_ADMINISTRATORS_CREATE NEW}    xpath://span[contains(text(),"Create New")]
${SYSTEM_ADMINISTRATORS_EDIT}       xpath:(//button[div/span="Edit"])[1]
${SYSTEM_ADMINISTRATORS_DELETE}       xpath:(//button[div/span="Delete"])[1]
${SYSTEM_ADMINISTRATORS_DELETE_OK_BUTTON}       xpath://button[text()="OK"]
${SYSTEM_ADMINISTRATORS_CREATE_ADMINISTRATOR}    xpath://button[div/span[contains(text(),"\${PLACEHOLDER}")]]
${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_USERNAME}   id:username
${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_PASSWORD}   xpath:(//input[@type="password"])[1]
${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_PASSWORD_CONFIRM}   xpath:(//input[@type="password"])[2]
${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_BUTTON}    xpath://button[span[contains(text(),"Change Password")]]
${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_OLD}   id:old_password
${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_NEW}   id:new_password
${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_CONFIRM}   id:confirm_password
${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_OK_BUTTON}   xpath:(//button[@id="submit_ok"])[2]
${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_WARN}    xpath://label[contains(text(), "The password must conform to the system password policy.")]
${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_WARN_SPAN}    xpath:(//div[p[contains(text(),"Password must conform to the following rules")]])[3]
${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_RULE_LOGINPAGE}    xpath://div[p="New password must include:"]/div[span[2][contains(text(),"\${PLACEHOLDER}")]]/span/span
${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_LOGINPAGE_OLD}    id:old_pwd
${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_LOGINPAGE_NEW}    id:pwd1
${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_LOGINPAGE_CONFIRM}   id:pwd2
${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_LOGINPAGE_OK}    id:change-button
${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_RULE}    xpath:(//div[p="Password must conform to the following rules:"]//tr[td[2][contains(text(),"\${PLACEHOLDER}")]]/td[1]/span)[2]
${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_ADMIN_PROFILE}      xpath://div[label="Administrator Profile"]//div[contains(@class,"select-widget")]
${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_ADMIN_PROFILE_SELECT}      xpath://div[span/span="\${PLACEHOLDER}"]
${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_VDOM}               xpath://div[@id="vdoms"]
${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_VDOM_SELECT}         xpath://div[@class="selection-pane"]//span[text()="\${PLACEHOLDER}"]
${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_VDOM_DESELECT}       xpath://div[label="Virtual Domains"]/div//div[@class="selected-entry"]/f-icon
${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_TRUST HOST_LABEL}         xpath://label[h2[contains(text(),"trusted hosts")]]/label
${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_TRUST HOST_INPUT}         xpath://label[h2[contains(text(),"trusted hosts")]]/input
${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_TRUST HOST_IPV4}          xpath://label[field-label="Trusted Host \${PLACEHOLDER}"]/following-sibling::div//input
${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_TRUST HOST_IPV4_ADD_BUTTON}    xpath://div[contains(@ng-if,"ipv4")]//button[@f-list-edit-button="add"]
${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_TRUST HOST_IPV6_1}        xpath://label[field-label[contains(text(),"IPv6 Trusted Host 1")]]/following-sibling::div//input
${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_TRUST HOST_IPV6_1_testip}    2000:10:1:100::112/128
${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_OK_BUTTON}    id:submit_ok
${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_NAME_COLUMN}    xpath://div[@column-id="name"]//span[text()="\${PLACEHOLDER}"]
${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_EDIT_BUTTON}    xpath://f-admin-list//span[text()="Edit"]
${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_DELETE_BUTTON}    xpath://f-admin-list//span[text()="Delete"]
${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_DELETE_OK_BUTTON}   xpath://div[@class="slider-area"]//button[text()="OK"]
${SYSTEM_ADMIN_PROFILES_NAME_INPUT}                 xpath://f-field[label/field-label="Name"]/div//input
${SYSTEM_ADMIN_PROFILES_ACCESS_PERMISSION_MENU}     xpath://th[span="Permissions"]/span[2]/button
${SYSTEM_ADMIN_PROFILES_ACCESS_PERMISSION_MENU_BAR}    xpath://div[contains(@ng-repeat,"permission in")]/button[div/span="$\{PLACEHOLDER}"]
${SYSTEM_ADMIN_PROFILES_OVERRIDE_IDEL_LABEL}    xpath://label[h2="Override Idle Timeout"]/label
${SYSTEM_ADMIN_PROFILES_OVERRIDE_IDEL_CHECKBOX}    xpath://label[h2="Override Idle Timeout"]/input
${SYSTEM_ADMIN_PROFILES_OVERRIDE_IDEL_NEVER_LABEL}   xpath://span[span="Never Timeout"]/label
${SYSTEM_ADMIN_PROFILES_OVERRIDE_IDEL_NEVER_CHECKBOX}   xpath://span[span="Never Timeout"]/input
${SYSTEM_ADMIN_PROFILES_OVERRIDE_IDEL_OFFLINE}       xpath://f-field[label/field-label="Offline"]/div//input
${SYSTEM_ADMIN_PROFILES_OVERRIDE_IDEL_MIN_WARN}     xpath://label[contains(text(),"The minimum value")] 
${SYSTEM_ADMIN_PROFILES_OVERRIDE_IDEL_MAX_WARN}     xpath://label[contains(text(),"The maximum value")]
${SYSTEM_ADMIN_PROFILE_TABLE_NAME_ENTRY}            xpath://div[@column-id="name"]//div[text()="\${PLACEHOLDER}"]
${SYSTEM_ADMINISTRATORS_TABLE_NAME_ENTRY}           xpath://div[@column-id="name"]//div[span="\${PLACEHOLDER}"]
${SYSTEM_ADMINISTRATORS_TABLE_NAME_ENTRY_DIV}           xpath://div[div[@column-id="name"]//div[span="\${PLACEHOLDER}"]]
${SYSTEM_ADMINISTRATORS_TABLE_PROFILE_ENTRY}        /div[@column-id="accprofile"]//span[text()="\${PLACEHOLDER}"]
${SYSTEM_ADMINISTRATORS_TABLE_VDOM_ENTRY}           /div[@column-id="vdom"]//span[text()="\${PLACEHOLDER}"]
${SYSTEM_ADMINISTRATORS_EDIT_REST_USERNAME}         xpath://f-field[label/field-label="Username"]/div//input
${SYSTEM_ADMINISTRATORS_EDIT_SSO_USERNAME}         xpath://f-field[label/field-label/span="Username"]/div//input
${SYSTEM_ADMINISTRATORS_EDIT_REST_ADMIN_PROFILE}    xpath://f-field[label="Administrator Profile"]//div[contains(@class,"select-widget")]
${SYSTEM_ADMINISTRATORS_EDIT_REST_API_FIRSTVDOM_REMOVE_BUTTON}    xpath://f-field[label/field-label[(contains(text(),"Virtual Domains"))]]//div[@class="selected-entries"]/div[1]/f-icon
${SYSTEM_ADMINISTRATORS_EDIT_REST_API_VDOM_REMOVE_BUTTON}    xpath://f-field[label/field-label[(contains(text(),"Virtual Domains"))]]//div[@class="selected-entries"]/div[//span="\${PLACEHOLDER}"]/f-icon
${SYSTEM_ADMINISTRATORS_EDIT_REST_API_VDOM_ADD_BUTTON}    xpath://f-field[label/field-label[(contains(text(),"Virtual Domains"))]]//div[@class="add-placeholder"]/f-icon
${SYSTEM_ADMINISTRATORS_EDIT_REST_API_PKI_CHECKBOX}       xpath://span[span="PKI Group"]/input
${SYSTEM_ADMINISTRATORS_EDIT_REST_API_PKI_LABEL}       xpath://span[span="PKI Group"]/label
${SYSTEM_ADMINISTRATORS_EDIT_REST_API_TRUSTED_HOST}    xpath://f-field[label/field-label="Trusted Hosts"]/div//input
${SYSTEM_ADMINISTRATORS_EDIT_REST_API_TRUSTED_WARN_MSG}    xpath://label[contains(text(),"This field is required")]
${SYSTEM_ADMINISTRATORS_EDIT_REST_APIK_CLOSE_BUTTON}   xpath:(//button[@id="submit_return"])[2]
${SYSTEM_ADMINISTRATORS_EDIT_ENTRY}     xpath://div[div[@column-id="name"]//span="\${PLACEHOLDER}"]
${SYSTEM_ADMINISTRATORS_EDIT_ENTRY_COLUMN}    /div[@column-id="\${PLACEHOLDER}"]//div[@class="collection-entries"]
${SYSTEM_ADMINISTRATORS_EDIT_ENTRY_COLUMN_SPAN}    /div[\${PLACEHOLDER}]/div
${SYSTEM_ADMINISTRATORS_EDIT_ENTRY_COLUMN_BUBBLE}    /span
#### System_SETTINGS############
#### System_SETTINGS_NTP ####
${SYSTEM_NTP-MANUAL SETTINGS_LABEL}       xpath://label[text()="Manual settings"]
${SYSTEM_NTP-MANUAL SETTINGS_date}        xpath://input[@ui-jq="datepicker" and ancestor::div/label[text()="Date"]]
${SYSTEM_NTP-MANUAL SETTINGS_hour}        xpath://input[@id="hour"]
${SYSTEM_NTP-MANUAL SETTINGS_minute}      xpath://input[@id="minute"]
${SYSTEM_NTP-MANUAL SETTINGS_second}      xpath://input[@id="second"]
${SYSTEM_NTP-custom_SETTINGS_LABEL}       xpath://label[span="Custom"]
${SYSTEM_TIME_IN_SETTING_PAGE}            xpath://*[@id="system-time-dlg"]//f-system-time/span
${SYSTEM_NTP_SERVER_LABEL}                xpath://label[text()="Synchronize with NTP Server"]
${SYSTEM_NTP_CUSTOM_SERVER_NAME}          xpath://input[contains(@ng-if,"custom")]
${SYSTEM_TIME_SET_TIME_PREV_MONTH}        xpath://span[text()="Prev"]
${SYSTEM_TIME_SET_TIME_DATE_FIRST}        xpath://a[text()="1"]
${SYSTEM_SETTINGS_HTTP_PORT_INPUT}        id:admin-port
${SYSTEM_SETTINGS_HTTPS_PORT_INPUT}       id:admin-sport
${SYSTEM_SETTINGS_VDOM_ENABLE_LABEL}      xpath://span[span[contains(text(),"Virtual Domains")]]/label
${SYSTEM_SETTINGS_VDOM_ENABLE_INPUT}      id:vdom-mode-toggle
${SYSTEM_SETTINGS_VDOM_MULTIVDOM_LABEL}   xpath://label[span="Multi VDOM"]
${SYSTEM_SETTINGS_VDOM_SPLITVDOM_LABEL}   xpath://label[span[contains(text(),"Split")]]
${SYSTEM_SETTINGS_PASSWDPLCY_SECTION}     xpath://div[h2="Password Policy"]/following-sibling::section[1]
${SYSTEM_SETTINGS_PASSWDPLCY_SECTION_SCOPE_INPUT}    /div[label/span="Password scope"]/div/div/input
${SYSTEM_SETTINGS_PASSWDPLCY_SECTION_SCOPE_LABEL}    /div[label/span="Password scope"]/div/div/label[contains(text(),"\${PLACEHOLDER}")]
${SYSTEM_SETTINGS_PASSWDPLCY_SECTION_MIN_LENTH}     id:min-length
${SYSTEM_SETTINGS_PASSWDPLCY_SECTION_CHAR_REQ_CHKBOX}   id:must-contain
${SYSTEM_SETTINGS_PASSWDPLCY_SECTION_CHAR_REQ_LABEL}    xpath://label[@for="must-contain"]
${SYSTEM_SETTINGS_PASSWDPLCY_SECTION_CHAR_REQ}    xpath://input[contains(@id,"\${PLACEHOLDER}")]
${SYSTEM_SETTINGS_PASSWDPLCY_SECTION_REUSE_CHKBX}   id:allow-reuse
${SYSTEM_SETTINGS_PASSWDPLCY_SECTION_REUSE_LABEL}   xpath://span[input[@id="allow-reuse"]]/label
${SYSTEM_SETTINGS_PASSWDPLCY_SECTION_EXPIRE_CHBX_INPUT}      id:pol-expire
${SYSTEM_SETTINGS_PASSWDPLCY_SECTION_EXPIRE_CHBX_LABEL}    xpath://label[@for="pol-expire"]
${SYSTEM_SETTINGS_PASSWDPLCY_SECTION_EXPIRE_DAYS_INPUT}    id:expiration-days
${SYSTEM_SETTINGS_VIEW_LANGUAGE_MENU}    xpath://div[label[@for="admin-language"]]/div
${SYSTEM_SETTINGS_VIEW_LANGUAGE}     xpath://select[@id="admin-language"]/option[contains(text(),"\${PLACEHOLDER}")]
${SYSTEM_SETTINGS_ADMIN_SSH_PORT_INPUT}      id:admin-ssh-port
${SYSTEM_SETTINGS_ADMIN_TELNET_PORT_INPUT}   id:admin-telnet-port
${SYSTEM_SETTINGS_ADMIN_TELNET_PORT_CONFILCT_WARN}    xpath://div[label="Telnet port"]/label[contains(text(),"Port must not conflict with any other port")]
###### System_SNMP ####
${SYSTEM_SNMP_ENTRY}                      xpath://span[text()="SNMP"]
${SYSTEM_SNMPV3_APPLY_BUTTON}           xpath://button[span="Apply"]
${SYSTEM_SNMPV3_DELETE_OK_BUTTON}      xpath://button[text()="OK"]
${SYSTEM_SNMP_DOWNLOAD_MIB_FORTIGATE_BUTTON}    xpath://a[span[contains(text(),"Download FortiGate MIB")]]
${SYSTEM_SNMP_DOWNLOAD_MIB_FORTINET_CORE_BUTTON}    xpath://a[span[contains(text(),"Download Fortinet Core MIB")]]
${SYSTEM_SNMPV3_CREATE_NEW_BUTTON}       xpath://section[preceding-sibling::div[h2="SNMP v3"]]//button[div//span="Create New"]
${SYSTEM_SNMPV3_EDIT_BUTTON}       xpath://section[preceding-sibling::div[h2="SNMP v3"]]//button[div//span="Edit"]
${SYSTEM_SNMPV3_DELETE_BUTTON}       xpath://section[preceding-sibling::div[h2="SNMP v3"]]//button[div//span="Delete"]
${SYSTEM_SNMPV3_STATUS_BUTTON}       xpath://section[preceding-sibling::div[h2="SNMP v3"]]//button[div//span="Status"]
${SYSTEM_SNMPV3_CREATE_NEW_USERNAME_LABEL}     xpath://f-field/label[field-label="User Name"]
${SYSTEM_SNMPV3_CREATE_NEW_USERNAME}     xpath://f-field[label[field-label="User Name"]]/div//input
${SYSTEM_SNMPV3_CREATE_NEW_HOST_IP}      xpath://section[f-field[label[field-label="IP Address"]]]/f-field[\${PLACEHOLDER}]/div//input
${SYSTEM_SNMPV3_CREATE_NEW_AUTHEN_LABEL}    xpath://label[span="Authentication"]
${SYSTEM_SNMPV3_CREATE_NEW_PRIVATE_LABEL}    xpath://label[span="Private"]
${SYSTEM_SNMPV3_CREATE_NEW_AUTH_PSSWD_CHG_BUTTON}   xpath://div[div[h2="Security Level"]]/section/f-field[2]/div//button[text()="Change"]
${SYSTEM_SNMPV3_CREATE_NEW_AES_PSSWD_CHG_BUTTON}    xpath://div[div[h2="Security Level"]]/section/f-field[4]/div//button[text()="Change"]
${SYSTEM_SNMPV3_CREATE_NEW_AUTH_PSSWD_CHG_INPUT}    xpath://div[div[h2="Security Level"]]/section/f-field[2]/div//input[@type="password"]
${SYSTEM_SNMPV3_CREATE_NEW_AES_PSSWD_CHG_INPUT}     xpath://div[div[h2="Security Level"]]/section/f-field[4]/div//input[@type="password"]
${SYSTEM_SNMPV3_testuser_entry_secur}   xpath://div[@column-id="security-level"]/div/div[div[contains(text(),"Auth")]]
${SYSTEM_SNMPV3_testuser_entry_status_disable}   xpath://div[@column-id="status"]/div[//span="Disable"]
${SYSTEM_SNMPV3_status_button_enable}    xpath:(//div[contains(@f-pop-up-menu,"status")])[3]/div/button[div/span="Enable"]
${SYSTEM_SNMPV3_status_button_disable}   xpath:(//div[contains(@f-pop-up-menu,"status")])[3]/div/button[div/span="Disable"]
##### SYSTEM Replacement Message ####
${SYSTEM_RPLCE_MSG_ENTRY}                     xpath://span[text()="Replacement Messages"]
${SYSTEM_RPLCE_MSG_ENTRY_FRN}                 xpath://span[text()="Message de remplacement"]
${SYSTEM_RPLCE_MSG_FRAME_LIST}                     xpath://frame[@name="list"]
${SYSTEM_RPLCE_MSG_FRAME_PREVIEW}                     xpath://frame[@name="preview"]
${SYSTEM_RPLCE_MSG_MANAGE_IMG_BUTTON}         xpath://button[div/span[contains(text(),"Manage Images")]]
${SYSTEM_RPLCE_MSG_MANAGE_CRTNEW_BUTTON}         xpath://button[div/span[contains(text(),"Create")]]
${SYSTEM_RPLCE_MSG_MANAGE_EDIT_BUTTON}         xpath:(//button[div/span[contains(text(),"Edit")]])[1]
${SYSTEM_RPLCE_MSG_MANAGE_DEL_BUTTON}         xpath:(//button[div/span[contains(text(),"Del")]])[1]
${SYSTEM_RPLCE_MSG_MANAGE_NAME_INPUT}          xpath://f-field[label/field-label="Name"]/div/field-value/input
${SYSTEM_RPLCE_MSG_MANAGE_FILE_LABEL}         xpath://label[span="Upload Image"]
${SYSTEM_RPLCE_MSG_MANAGE_FILE_INPUT}         xpath://f-field[label/field-label/span="Upload"]/div/field-value/input
${SYSTEM_RPLCE_MSG_MANAGE_FILE_IMG}         xpath://f-field[label/field-label="Image"]/div/field-value/img
${SYSTEM_RPLCE_MSG_MANAGE_CRTNEW_BUTTON_FRN}         xpath://button[div/span[contains(text(),"Créer nouveau")]]
${SYSTEM_RPLCE_MSG_MANAGE_DEL_BUTTON_FRN}         xpath:(//button[div/span[contains(text(),"supprimer")]])[1]
${SYSTEM_RPLCE_MSG_MANAGE_NAME_INPUT_FRN}          xpath://f-field[label/field-label="Nom"]/div/field-value/input
${SYSTEM_RPLCE_MSG_MANAGE_FILE_LABEL_FRN}         xpath://label[span="Rélécharger l'image"]
${SYSTEM_RPLCE_MSG_MANAGE_FILE_INPUT_FRN}         xpath://f-field[label/field-label/span="Téléverser"]/div/field-value/input
${SYSTEM_RPLCE_MSG_FRAME_PREVIEW_INPUT}        xpath://input[@id="default_msg"]
${SYSTEM_RPLCE_MSG_MANAGE_ITEM}            xpath://div[div[@column-id="name"]//span="\${PLACEHOLDER}"]
${SYSTEM_RPLCE_MSG_MANAGE_GRP_LABEL}       xpath://label[contains(text(),"\${PLACEHOLDER}")]
${SYSTEM_RPLCE_MSG_TABLE_NAME}          xpath://tbody[tr/td/label[contains(text(),"\${PLACEHOLDER}")]]
${SYSTEM_RPLCE_MSG_TABLE_ITEM_NAME}     /following-sibling::tbody[1]/tr[td[@class="label"][contains(text(),"\${PLACEHOLDER}")]]
${SYSTEM_RPLCE_MSG_TABLE_ITEM_MODIFY}     /following-sibling::tbody[1]/tr/td[@class="message-modified"]/f-icon
### system reputation   ####
${SYSTEM_REPUTATION_ENTRY}            xpath://span[text()="Reputation"]
${SYSTEM_REPUTATION_IP_DOMAIN_INPUT}      xpath://div[label="IP or Domain"]/div/input
${SYSTEM_REPUTATION_URL_LIST}         xpath://td/a/span[text()="\${PLACEHOLDER}"]
${SYSTEM_REPUTATION_URL_BOTNET}       xpath://tr[td/span/mark="\${PLACEHOLDER}"]/td[contains(text(),"Botnet")]
${SYSTEM_REPUTATION_URL_TRUST}        xpath://tr[td/span/mark="\${PLACEHOLDER}"]/td[contains(text(),"Trusted")]
${SYSTEM_REPUTATION_URL}       xpath://tr[td/a/span="\${PLACEHOLDER1}"]/td[contains(text(),"\${PLACEHOLDER2}")]
####  system  tags ####
${SYSTEM_TAG_ENTRY}                           xpath://div[div/span="System"]//span[text()="Tags"]
${SYSTEM_TAG_CREATE_NEW_BUTTON}               xpath://span[text()="Create New"]
${SYSTEM_TAG_EDIT_BUTTON}                     xpath:(//span[text()="Edit"])[1]
${SYSTEM_TAG_DELETE_BUTTON}                   xpath:(//span[text()="Delete"])[1]
${SYSTEM_TAG_DELETE_OK_BUTTON}                xpath://button[text()="OK"]
${SYSTEM_TAG_TAG_CATEGORY_INPUT}              xpath://f-field[label="Tag Category"]/div//input
${SYSTEM_TAG_TAGS_INPUT}   xpath://section[f-field[label="Tags"]]/f-field[\${PLACEHOLDER}]//input
${SYSTEM_TAG_TAGS_SCOPE_DISABLE}     xpath://f-field[label/field-label="\${PLACEHOLDER}"]/descendant::label[span="Disable"]
${SYSTEM_TAG_TAGS_SCOPE_MANDATORY}   xpath://f-field[label/field-label="\${PLACEHOLDER}"]/descendant::label[span="Mandatory"]
${SYSTEM_TAG_TAGS_SCOPE_OPTIONAL}    xpath://f-field[label/field-label="\${PLACEHOLDER}"]/descendant::label[span="Optional"]
${SYSTEM_TAG_TAGS_ADD_BUTTON}    xpath://button[contains(@class,"add")]
${SYSTEM_TAG_EDIT_ENTRIES}       xpath://div[text()="\${PLACEHOLDER}"]
#### System_Feature Visibility########
${SYSTEM_FEATURE_VIS_LABEL_1}      xpath://div[@class="additional-features-row"]//label[contains(text(),"\${PLACEHOLDER}")]
${SYSTEM_FEATURE_VIS_LABEL_2}      xpath://div[@class="additional-features-column"]//label[contains(text(),"\${PLACEHOLDER}")]
${SYSTEM_FEATURE_VIS_STATUS_1}     xpath://div[@class="additional-features-row"]//div[label[contains(text(),"\${PLACEHOLDER}")]]/preceding-sibling::div/input
${SYSTEM_FEATURE_VIS_STATUS_2}     xpath://div[@class="additional-features-column"]//div[label[contains(text(),"\${PLACEHOLDER}")]]/preceding-sibling::div/input
${SYSTEM_FEATURE_VIS_BUTTON_1}     xpath://div[@class="additional-features-row"]//div[label[contains(text(),"\${PLACEHOLDER}")]]/preceding-sibling::div/label
${SYSTEM_FEATURE_VIS_BUTTON_2}     xpath://div[@class="additional-features-column"]//div[label[contains(text(),"\${PLACEHOLDER}")]]/preceding-sibling::div/label
${SYSTEM_FEATURE_VIS_LABEL}      xpath://label[text()="\${PLACEHOLDER}"]
${SYSTEM_FEATURE_VIS_STATUS}     xpath://div[label[text()="\${PLACEHOLDER}"]]/preceding-sibling::div/input
${SYSTEM_FEATURE_VIS_BUTTON}     xpath://div[label[text()="\${PLACEHOLDER}"]]/preceding-sibling::div/label
${SYSTEM_FEATURE_VIS_apply_BUTTON}           xpath://button[span="Apply"]
#### SYSTEM_FORTIGUARD ########
${SYSTEM_FORTIGUARD}    xpath://span[text()="FortiGuard"]
${SYSTEM_FORTIGUARD_LICENSE info_entitle_Forticare}    xpath://td[text()="FortiCare Support"]
${SYSTEM_FORTIGUARD_LICENSE info_STATUS1_forticare}     xpath://tr[td[text()="FortiCare Support"]]/td[2]//span[1]
${SYSTEM_FORTIGUARD_LICENSE_INFO_BOTNET_DOMAIN_VIEW_BUTTON}    xpath://tr[td="Botnet Domains"]/td/button[span="View List"]
${SYSTEM_FORTIGUARD_LICENSE_INFO_BOTNET_DOMAIN_DEFINIT_1}    xpath://div[@id="content"]/div//tbody/tr[1]/td[1]
${SYSTEM_FORTIGUARD_LICENSE_INFO_SLID_FRAME}      xpath://iframe[contains(@name,"slide-iframe")]
${SYSTEM_FORTIGUARD_LICENSE_INFO_SLID_FRAME_CLOSE_BUTTON}    xpath://div[contains(@class,"slider-body")]/div/button
#### SYSTEM ADVANCED ###
${SYSTEM_ADVANCED_DOWNLOAD_DEBUG_LOG_DOWNLOAD_BUTTON}       xpath:(//label[a/f-icon[@class="fa-download"]])[1]
${SYSTEM_ADVANCED_DOWNLOAD_DEBUG_LOG_CHECKBOX}     xpath://input[@id="debug-visual-toggle"]
${SYSTEM_ADVANCED_DOWNLOAD_DEBUG_LOG_LABEL}     xpath://label[input[@id="debug-visual-toggle"]]/label
${SYSTEM_ADVANCED_COMPLIANCE_CHECKBOX}     xpath://input[@id="compliance-visual-toggle"]
${SYSTEM_ADVANCED_COMPLIANCE_BUTTON}       xpath://label[h2[contains(text(),"Compliance")]]/label
${SYSTEM_ADVANCED_COMPLIANCE_CHKENABLE_CHECKBOX}    xpath://input[@id="compliance-check-enable-switch"]
${SYSTEM_ADVANCED_COMPLIANCE_CHKENABLE_LABEL}    xpath://label[@for="compliance-check-enable-switch"]
${SYSTEM_ADVANCED_COMPLIANCE_RUNNOW}      xpath://button[span="Run Now"]
${SYSTEM_ADVANCED_COMPLIANCE_VIEW_RESULT_BUTTON}    xpath://button[text()="View Results"]
${SYSTEM_ADVANCED_COMPLIANCE_EVENTS_COUNT_SPAN}       xpath://div/span[@class="legend-count"]
${SYSTEM_ADVANCED_COMPLIANCE_EVENTS_FIRST}      xpath://div[@inserted-index="0"]
${SYSTEM_ADVANCED_CONFIG_SCRIPT_CHECKBOX}    xpath://input[@id="confscript-visual-toggle"]
${SYSTEM_ADVANCED_CONFIG_SCRIPT_LABEL}    xpath://label[input[@id="confscript-visual-toggle"]]/label
${SYSTEM_ADVANCED_CONFIG_SCRIPT_FILE_LABEL}    xpath://input[@id="new_script_file"]
${SYSTEM_ADVANCED_CONFIG_SCRIPT_HISTORY_ITEM}   xpath://div[label/h2[contains(text(),"Configuration Scripts")]]/section//tr[td[@class="name"][text()="\${PLACEHOLDER}"]]
${SYSTEM_ADVANCED_CONFIG_SCRIPT_HISTORY_DELETE_BUTTON}   xpath://div[label/h2[contains(text(),"Configuration Scripts")]]/section//button[div/span="Delete"]
${SYSTEM_ADVANCED_SCHEDULED_SCRIPT_ITEM}     xpath://div[div[h2[contains(text(),"Scheduled Scripts")]]]/section//tr[td[@class="name"][text()="\${PLACEHOLDER}"]]
${SYSTEM_ADVANCED_SCHEDULED_SCRIPT_ITEM_STATUS}     /td[@class="status"]/div/f-icon[contains(@title,"\${PLACEHOLDER}")]
${SYSTEM_ADVANCED_SCHEDULED_SCRIPT_ITEM_DELETE_BUTTON}    xpath://div[div[h2[contains(text(),"Scheduled Scripts")]]]/section//button[div/span="Delete"]
###### widget banner in main page ####
${SYSTEM_WIDGET_DASHBOARD_blank_PAGE}       xpath://f-dashboard/div[2]
${SYSTEM_WIDGET_widgetbanner}     xpath://widget-title[contains(text(),"\${PLACEHOLDER}")]
${SYSTEM_WIDGET_SENSORINFO_widgetbanner}    xpath://widget-title[text()="Sensor Information"]
${SYSTEM_WIDGET_System Information_widgetbanner}    xpath://widget-title[text()="System Information"]
${SYSTEM_WIDGET_LICENSEs_widgetbanner}    xpath://widget-title/div[text()="Licenses"]
${SYSTEM_WIDGET_FortiCloud_widgetbanner}    xpath://widget-title[text()="FortiCloud "]
${SYSTEM_WIDGET_ADMINISTRATORs_widgetbanner}    xpath://widget-title[text()="Administrators"]
${SYSTEM_WIDGET_CPU_widgetbanner}    xpath://widget-title[text()="CPU"]
${SYSTEM_WIDGET_Memory_widgetbanner}    xpath://widget-title[text()="Memory"]
${SYSTEM_WIDGET_Sessions_widgetbanner}    xpath://widget-title[text()="Sessions"]
${SYSTEM_WIDGET_Botnet Activity_widgetbanner}    xpath://widget-title[text()="Botnet Activity"]
${SYSTEM_WIDGET_HA Status_widgetbanner}    xpath://widget-title[text()="HA Status"]
${SYSTEM_WIDGET_Log Rate_widgetbanner}    xpath://widget-title[text()="Log Rate"]
${SYSTEM_WIDGET_Session Rate_widgetbanner}    xpath://widget-title[text()="Session Rate"]
${SYSTEM_WIDGET_Advanced Threat_widgetbanner}    xpath://widget-title[contains(text(),"Advanced Threat")]
${SYSTEM_WIDGET_FortiClient Detected Vulnerabilities_widgetbanner}    xpath://widget-title[contains(text(),"FortiClient")]
${SYSTEM_WIDGET_Host Scan Summary_widgetbanner}   xpath://widget-title[contains(text(),"Host Scan")]
${SYSTEM_WIDGET_FortiMail Stats_widgetbanner}     xpath://widget-title[contains(text(),"FortiMail")]
${SYSTEM_WIDGET_Bandwidth_widgetbanner}    xpath://widget-title[contains(text(),"Bandwidth")]
${SYSTEM_WIDGET_Bandwith_interface}    xpath://widget-title[contains(text(),"Bandwidth")]//span[text()="\${PLACEHOLDER}"]
### button for settting to add widget ###
${SYSTEM_WIDGET_SETTING_BUTTON}             xpath://div[@class="visible-controls"]/button
#### DASHBOARD_Main_setting widget and dashborad ####
${SYSTEM_WIDGET_SETTING_ADD_DASHBOARD_BUTTON}   xpath://dashboard-controls//button[div/div="Add Dashboard"]
${SYSTEM_WIDGET_SETTING_EDIT_DASHBOARD_BUTTON}   xpath://dashboard-controls//button[div/div="Edit Dashboard"]
${SYSTEM_WIDGET_SETTING_DELETE_DASHBOARD_BUTTON}   xpath://dashboard-controls//button[div/div="Delete Dashboard"]
${SYSTEM_WIDGET_SETTING_RESET_DASHBOARDS_BUTTON}   xpath://dashboard-controls//button[div/div="Reset Dashboards"]
${SYSTEM_WIDGET_SETTING_ADD_WIDGET_BUTTON}   xpath://dashboard-controls//button[div/div="Add Widget"]
${SYSTEM_WIDGET_SETTING_ADD_WIDGET_close_BUTTON}    xpath://button[span="Close"]
${SYSTEM_WIDGET_SETTING_RESET_DASHBOARDS_OK_BUTTON}    xpath://button[text()="OK"]
#### DASHBOARD_Main_add widget_BUTTONs of widget in adding page ####
${SYSTEM_WIDGET_SETTING_ADD_WIDGET_NAME}   xpath://button[contains(text(),"\${PLACEHOLDER}")]
${SYSTEM_WIDGET_SETTING_ADD_WIDGET_Sensor Information_BUTTON}    xpath://button[text()="Sensor Information"]
${SYSTEM_WIDGET_SETTING_ADD_WIDGET_System Information_BUTTON}    xpath://button[text()="System Information"]
${SYSTEM_WIDGET_SETTING_ADD_WIDGET_LICENSE Status_BUTTON}    xpath://button[text()="License Status"]
${SYSTEM_WIDGET_SETTING_ADD_WIDGET_FortiCloud_BUTTON}    xpath://button[text()="FortiCloud"]
${SYSTEM_WIDGET_SETTING_ADD_WIDGET_ADMINISTRATORS_BUTTON}    xpath://button[text()="Administrators"]
${SYSTEM_WIDGET_SETTING_ADD_WIDGET_CPU_BUTTON}    xpath://button[contains(text(),"CPU")]
${SYSTEM_WIDGET_SETTING_ADD_WIDGET_Memory_BUTTON}    xpath://button[contains(text(),"Memory")]
${SYSTEM_WIDGET_SETTING_ADD_WIDGET_Sessions_BUTTON}    xpath://button[text()="Sessions"]
${SYSTEM_WIDGET_SETTING_ADD_WIDGET_Botnet Activity_BUTTON}    xpath://button[text()="Botnet Activity"]
${SYSTEM_WIDGET_SETTING_ADD_WIDGET_HA Status_BUTTON}    xpath://button[text()="HA Status"]
${SYSTEM_WIDGET_SETTING_ADD_WIDGET_Log Rate_BUTTON}    xpath://button[text()="Log Rate"]
${SYSTEM_WIDGET_SETTING_ADD_WIDGET_Session Rate_BUTTON}    xpath://button[text()="Session Rate"]
${SYSTEM_WIDGET_SETTING_ADD_WIDGET_Advanced Threat_BUTTON}    xpath://button[contains(text(),"Advanced Threat")]
${SYSTEM_WIDGET_SETTING_ADD_WIDGET_FortiClient Detected Vulnerabilities_BUTTON}    xpath://button[contains(text(),"FortiClient")]
${SYSTEM_WIDGET_SETTING_ADD_WIDGET_FortiView_BUTTON}       xpath://button[contains(text(),"FortiView")]
${SYSTEM_WIDGET_SETTING_ADD_WIDGET_Fortiview_add_title}    id:title
${SYSTEM_WIDGET_SETTING_ADD_WIDGET_Fortiview_Add Widget_BUTTON}   xpath://button[text()="Add Widget"]
${SYSTEM_WIDGET_SETTING_ADD_WIDGET_Host Scan Summary_BUTTON}    xpath://button[contains(text(),"Host Scan")]
${SYSTEM_WIDGET_SETTING_ADD_WIDGET_FortiMail Stats_BUTTON}    xpath://button[contains(text(),"FortiMail")]
${SYSTEM_WIDGET_SETTING_ADD_WIDGET_INTERFACE Bandwith_BUTTON}    xpath://button[text()="Interface Bandwidth"]
${SYSTEM_WIDGET_SETTING_ADD_WIDGET_INTERFACE Bandwith_popup_MENU}    xpath://div[label="Interface"]/div/div/div[2]
${SYSTEM_WIDGET_SETTING_ADD_WIDGET_INTERFACE Bandwith_Add Widget_BUTTON}    xpath://button[text()="Add Widget"]
${SYSTEM_WIDGET_SETTING_ADD_WIDGET_INTERFACE Bandwith_Back_BUTTON}    xpath://button[span[contains(text(),"Back")]]
${SYSTEM_WIDGET_SETTING_ADD_WIDGET_INTERFACE Bandwith_window_banner}    xpath://div[h1[contains(text(),"Bandwidth")]]
${SYSTEM_WIDGET_SETTING_ADD_WIDGET_INTERFACE Bandwith_firstinterface_MENU_BAR}    xpath://div[contains(@class,"selection-dropdown")]/div[@class="virtual-results"]/div[2]
${SYSTEM_WIDGET_SETTING_ADD_WIDGET_INTERFACE Bandwith_firstinterface_MENU_BAR_SPAN}    xpath://div[contains(@class,"selection-dropdown")]/div[@class="virtual-results"]/div[2]/span/span
${SYSTEM_WIDGET_SETTING_ADD_WIDGET_INTERFACE Bandwith_secondinterface_MENU_BAR}    xpath://div[contains(@class,"selection-dropdown")]/div[@class="virtual-results"]/div[3]
${SYSTEM_WIDGET_SETTING_ADD_WIDGET_INTERFACE Bandwith_secondinterface_MENU_BAR_SPAN}    xpath://div[contains(@class,"selection-dropdown")]/div[@class="virtual-results"]/div[3]/span/span
#### DASHBOARD_Main_System informations widget ###
${SYSTEM_INFO_WIDGET_time_in_main_widget}             xpath://tr[td="System Time"]/td[2]//span
${SYSTEM_INFO_WIDGET_hostname}   xpath://tr[td="Hostname"]/td[2]
${SYSTEM_INFO_WIDGET_SN}         xpath://tr[td="Serial Number"]/td[2]
${SYSTEM_INFO_WIDGET_firmware}   xpath://tr[td="Firmware"]/td[2]
${SYSTEM_INFO_WIDGET_SYSTEM_TIME}   xpath://tr[td="System Time"]/td[2]
${SYSTEM_INFO_WIDGET_uptime}   xpath://tr[td="Uptime"]/td[2]
${SYSTEM_INFO_WIDGET_Vdom_mode}    xpath://tbody[tr/td[text()="Hostname"]]/tr[4]/td
${SYSTEM_INFO_WIDGET_SYSTEM_TIME_value}    xpath://tr[td="System Time"]/td[2]//span
${SYSTEM_INFO_WIDGET_WAN IP_value}   xpath://tr[td="WAN IP"]/td[2]/span/span[2]
${SYSTEM_INFO_WIDGET_WAN IP_location_tooltip}      xpth://div[@class="base-tooltip"]//tr[td="Location"]//span
#### DASHBOARD_Main_LICENSEs widget ###
${LICENSE_WIDGET_FortiCare Support_SPAN}             xpath://span[text()="FortiCare Support"]
${LICENSE_WIDGET_FortiCare Support_STATUS icon}    xpath://span[text()="FortiCare Support"]/preceding-sibling::f-icon
##### DASHBOARD_Main_Sensors Information widget ####
${SYSTEM_WIDGET_SENSORINFO_TEMP}                xpath://td[text()="Temperature"]
${SYSTEM_WIDGET_SENSORINFO_TEMP_C}              xpath://span[text()="°C"]
${SYSTEM_WIDGET_SENSORINFO_TEMP_F}              xpath://span[text()="°F"]
${SYSTEM_WIDGET_SENSORINFO_power}               xpath://td[text()="Power Supply"]
${SYSTEM_WIDGET_SENSORINFO_fan}                 xpath://td[text()="Fan Speed"]
${SYSTEM_WIDGET_SENSORINFO_TEMP_detail_BAR}     xpath://div[contains(@f-pop-up-menu,"temp")]
${SYSTEM_WIDGET_SENSORINFO_power_detail_BAR}    xpath://div[contains(@f-pop-up-menu,"power")]
${SYSTEM_WIDGET_SENSORINFO_fan_detail_BAR}      xpath://div[contains(@f-pop-up-menu,"fan")]
${SYSTEM_WIDGET_SENSORINFO_power1_in}           xpath://tr[td[text()="PS1 VIN"]]/td[3]
${SYSTEM_WIDGET_SENSORINFO_power1_out}          xpath://tr[td[text()="PS1 VOUT_12V"]]/td[3]
${SYSTEM_WIDGET_SENSORINFO_listclose_BUTTON}          xpath://div[h1[contains(text(),"Sensor")]]/button

##### DASHBOARD_Main_CPU widget ####
${SYSTEM_WIDGET_CPU_CURRENT USAGE_value}       xpath://f-cpu-usage-widget//span[text()="Current usage"]/following-sibling::span
${SYSTEM_WIDGET_CPU_CURRENT USAGE_TERM_MENU_BUTTON}    xpath://f-cpu-usage-widget//div/div[2]/div//button
${SYSTEM_WIDGET_CPU_CURRENT USAGE_TERM_MENU_BAR_1 minute}    xpath://div[24]/div[1]/button
${SYSTEM_WIDGET_CPU_CURRENT USAGE_TERM_MENU_BAR_10 minutes}    xpath://div[24]/div[2]/button
${SYSTEM_WIDGET_CPU_CURRENT USAGE_TERM_MENU_BAR_30 minutes}    xpath://div[24]/div[3]]/button
${SYSTEM_WIDGET_CPU_CURRENT USAGE_TERM_MENU_BAR_1 hour}    xpath://div[24]/div[4]/button
${SYSTEM_WIDGET_CPU_CURRENT USAGE_TERM_MENU_BAR_12 hours}    xpath://div[24]/div[5]/button
${SYSTEM_WIDGET_CPU_CURRENT USAGE_TERM_MENU_BAR_24 hours}    xpath://div[24]/div[6]/button

##### DASHBOARD_Main_Memory widget ####
${SYSTEM_WIDGET_Memory_CURRENT USAGE_value}       xpath://f-mem-usage-widget//span[text()="Current usage"]/following-sibling::span
${SYSTEM_WIDGET_Memory_CURRENT USAGE_TERM_MENU_BUTTON}    xpath://f-mem-usage-widget//div/div[2]/div//button
${SYSTEM_WIDGET_Memory_CURRENT USAGE_TERM_MENU_BAR_1 minute}    xpath://div[27]/div[1]/button
${SYSTEM_WIDGET_Memory_CURRENT USAGE_TERM_MENU_BAR_10 minutes}    xpath://div[27]/div[2]/button
${SYSTEM_WIDGET_Memory_CURRENT USAGE_TERM_MENU_BAR_10 minutes}    xpath://div[27]/div[2]/button
${SYSTEM_WIDGET_Memory_CURRENT USAGE_TERM_MENU_BAR_30 minutes}    xpath://div[27]/div[3]]/button
${SYSTEM_WIDGET_Memory_CURRENT USAGE_TERM_MENU_BAR_1 hour}    xpath://div[27]/div[4]/button
${SYSTEM_WIDGET_Memory_CURRENT USAGE_TERM_MENU_BAR_12 hours}    xpath://div[27]/div[5]/button
${SYSTEM_WIDGET_Memory_CURRENT USAGE_TERM_MENU_BAR_24 hours}    xpath://div[27]/div[6]/button
##### DASHBOARD_Main_Sessions widget ####
${SYSTEM_WIDGET_SPU_CURRENT USAGE_value}       xpath://f-sessions-widget//span[text()="SPU"]/following-sibling::span
${SYSTEM_WIDGET_nTurbo_CURRENT USAGE_value}       xpath://f-sessions-widget//span[text()="nTurbo"]/following-sibling::span
##### DASHBOARD_Main_add dashboard ####
${SYSTEM_WIDGET_ADD DASHBOARD_NAME_inputbox}   id:name
${SYSTEM_WIDGET_ADD DASHBOARD_Grid size_inputbox}   id:columns
${SYSTEM_WIDGET_ADD DASHBOARD_NOC_LABEL}    xpath://label[span="NOC"]
${SYSTEM_WIDGET_ADD DASHBOARD_OK_BUTTON}    xpath://button[@id="submit_ok"]
${SYSTEM_WIDGET_ADD DASHBOARD_Cancel_BUTTON}    xpath://button[id="submit_cancel"]
${SYSTEM_WIDGET_del DASHBOARD_OK_BUTTON}    xpath://button[text()="OK"]
####EMBED CONSOLE###
${SYSTEM_EMBED_console_slider_area}       xpath://div[@class="slider-area"]
${SYSTEM_EMBED_console_content}           xpath://table[@id="history_txt"]
${SYSTEM_EMBED_console_BUTTON}            xpath://button[f-icon[contains(@class,"terminal")]]
${SYSTEM_CLI_WINDOW_BAR}                  xpath://div[h1[text()="CLI Console"]]
${SYSTEM_EMBEDed_console_connected}       xpath://pre[contains(text(),"\${PLACEHOLDER}")]
${SYSTEM_EMBED_slide_frame}               xpath://iframe[contains(@name,"slide-iframe")]
${SYSTEM_EMBED_console_frame}             id:console_iframe
${SYSTEM_EMBED_clear_BUTTON}              xpath://button[@title="Clear console"]
${SYSTEM_EMBED_download_BUTTON}           xpath://button[@title="Download"]
${SYSTEM_EMBED_copy_BUTTON}               xpath://button[contains(@title,"Copy")]
${SYSTEM_EMBED_detach_BUTTON}             xpath://button[@title='Detach']
${SYSTEM_EMBED_close_BUTTON}              xpath://div[h1="CLI Console"]/button
${SYSTEM_EMBED_CURSOR}                    xpath://span[@id="history_cursor"]
${SYSTEM_EMBED_CONSOLE_TABLE}             xpath://table[@id="history_txt"]
${SYSTEM_COMMAND_GET_sys_STATUS}          get system status
${SYSTEM_COMMAND_diag_sys_flash}          diag sys flash list
${SYSTEM_COMMAND_GET_sys_STATUS_key1}     xpath://pre[contains(text(),'build')]
${SYSTEM_COMMAND_GET_sys_STATUS_key2}     xpath://pre[contains(text(),'BIOS')]
${SYSTEM_COMMAND_GET_sys_STATUS_key3}     xpath://pre[contains(text(),'System time')]
${SYSTEM_COMMAND_GET_sys_flash_key1}      xpath://pre[contains(text(),'Partition')]
${SYSTEM_EMBED_console_current_promt}     xpath://pre[span[@id="history_cursor"]]
${SYSTEM_COMMAND_GET_sys_vdom_key1}       xpath://pre[contains(text(),'devname')]
${SYSTEM_MAINBAR_NOTIFICATIONS_BUTTON}    xpath://button[contains(@f-pop-up-menu-toggle,"notification")]
${SYSTEM_MAINBAR_NOTIFICATIONS_BUTTON_POPMENU}    xpath://div[contains(@class,"notifi")]
${SYSTEM_GUI_MAINPAGE_FULLSCREEN_BUTTON}     xpath://button[contains(@ng-click,"openFullscreen")]
${SYSTEM_GUI_MAINPAGE_FULLSCREEN_EXIT_BUTTON_wrapper}    xpath://f-icon[contains(@class,"fa-angle-left")]
${SYSTEM_GUI_MAINPAGE_FULLSCREEN_EXIT_BUTTON}    xpath://button[span="Exit Full Screen Mode"]
#### Network_DNS Servers_DNS Dtabase####
${NETWORK_DNS Servers_ENTRY}              xpath://div[div//span="Network"]//span[text()="DNS Servers"]
${NETWORK_DNS_DATABASE_CREATEnew}         xpath://section[preceding-sibling::label[h2="DNS Database"]]//button[div//span="Create New"]
${NETWORK_DNS_DATABASE_EDIT}           xpath://section[preceding-sibling::label[h2="DNS Database"]]//button[div//span="Edit"]
${NETWORK_DNS_DATABASE_DELETE}         xpath://section[preceding-sibling::label[h2="DNS Database"]]//button[div//span="Delete"]
${NETWORK_DNS_DATABASE_DELETE_OK}      xpath://button[text()="OK"]
${NETWORK_DNS_DATABASE_TYPE_master}    xpath://span[text()="Master"]
${NETWORK_DNS_DATABASE_TYPE_slave}     xpath://span[text()="Slave"]
${NETWORK_DNS_DATABASE_view_Public}    xpath://span[text()="Public"]
${NETWORK_DNS_DATABASE_view_shadow}    xpath://span[text()="Shadow"]
${NETWORK_DNS_DATABASE_DNS_zone}       xpath://label[field-label="DNS Zone"]/following-sibling::div//input
${NETWORK_DNS_DATABASE_domain_NAME}    xpath://label[field-label="Domain Name"]/following-sibling::div//input
${NETWORK_DNS_DATABASE_hostname of primary}    xpath://label[field-label="Hostname of Primary Master"]/following-sibling::div//input
${NETWORK_DNS_DATABASE_IP of Master}    xpath://label[field-label="IP of Master"]/following-sibling::div//input
${NETWORK_DNS_DATABASE_DNS_email}      xpath://label[field-label/span="Contact Email Address"]/following-sibling::div//input
${NETWORK_DNS_DATABASE_DNS_ttl_day}    xpath://input[following-sibling::span="Day(s)"]
${NETWORK_DNS_DATABASE_DNS_ttl_hour}    xpath://input[following-sibling::span="Hour(s)"]
${NETWORK_DNS_DATABASE_DNS_ttl_minute}    xpath://input[following-sibling::span="Minute(s)"]
${NETWORK_DNS_DATABASE_DNS_ttl_second}      xpath://input[following-sibling::span="Second(s)"]
${NETWORK_DNS_DATABASE_DNS_authoritative}   xpath://label[@for="authoritative"]
${NETWORK_DNS_DATABASE_DNS ENTRY_CREATEnew}    xpath://button[div//span="Create New"]
${NETWORK_DNS_DATABASE_DNS ENTRY_EDIT}    xpath://button[div//span="Edit"]
${NETWORK_DNS_DATABASE_DNS ENTRY_DELETE}    xpath://button[div//span="Delete"]

#########Network_DNS Servers_DNS Dtabase: forllowing locator is in the edit dns entry page####
${NETWORK_DNS_DATABASE_DNS ENTRY_EDIT_TYPE}    xpath://select[@name="type"]
${NETWORK_DNS_DATABASE_DNS ENTRY_EDIT_TYPE_A}    xpath://option[text()="Address (A)"]
${NETWORK_DNS_DATABASE_DNS ENTRY_EDIT_TYPE_NS}    xpath://option[text()="Name Server (NS)"]
${NETWORK_DNS_DATABASE_DNS ENTRY_EDIT_TYPE_CNAME}    xpath://option[contains(text(),"CNAME")]
${NETWORK_DNS_DATABASE_DNS ENTRY_EDIT_TYPE_MX}    xpath://option[contains(text(),"MX")]
${NETWORK_DNS_DATABASE_DNS ENTRY_EDIT_TYPE_AAAA}    xpath://option[contains(text(),"AAAA")]
${NETWORK_DNS_DATABASE_DNS ENTRY_EDIT_TYPE_ipv4_ptr}    xpath://option[contains(text(),"v4 P")]
${NETWORK_DNS_DATABASE_DNS ENTRY_EDIT_TYPE_ipv6_ptr}    xpath://option[contains(text(),"v6 P")]
${NETWORK_DNS_DATABASE_DNS ENTRY_EDIT_hostname}     xpath://f-field[label/field-label="Hostname"]//input
${NETWORK_DNS_DATABASE_DNS ENTRY_EDIT_TYPE_A_IP}    xpath://f-field[label/field-label="IP Address"]//input
${NETWORK_DNS_DATABASE_DNS ENTRY_EDIT_TYPE_A_usezonettl}    xpath://span[text()="Use Zone TTL"]
${NETWORK_DNS_DATABASE_DNS ENTRY_EDIT_TYPE_A_specify}     xpath://span[text()="Specify"]
${NETWORK_DNS_DATABASE_DNS ENTRY_EDIT_TYPE_A_specify_day}    xpath://*[@id="ng-base"]//f-zone-entry-ttl//div[1]/input
${NETWORK_DNS_DATABASE_DNS ENTRY_EDIT_TYPE_A_specify_hour}    xpath://*[@id="ng-base"]//f-zone-entry-ttl//div[2]/input
${NETWORK_DNS_DATABASE_DNS ENTRY_EDIT_TYPE_A_specify_minute}    xpath://*[@id="ng-base"]//f-zone-entry-ttl//div[3]/input
${NETWORK_DNS_DATABASE_DNS ENTRY_EDIT_TYPE_A_specify_second}    xpath://*[@id="ng-base"]//f-zone-entry-ttl//div[4]/input
${NETWORK_DNS_DATABASE_DNS ENTRY_EDIT_TYPE_cname_cname}    xpath://f-field[label/field-label[contains(text(),"CNAME")]]//input
${NETWORK_DNS_DATABASE_DNS ENTRY_EDIT_TYPE_mx_pref}    xpath://f-field[label//span[contains(text(),"Pref")]]//input
${NETWORK_DNS_DATABASE_DNS ENTRY_EDIT_TYPE_AAAA_ipv6add}    xpath://f-field[label/field-label[contains(text(),"v6 A")]]//input
${NETWORK_DNS_DATABASE_DNS ENTRY_EDIT_TYPE_ptr_ipv4add}    xpath://f-field[label/field-label="IP Address"]//input
${NETWORK_DNS_DATABASE_DNS ENTRY_EDIT_TYPE_ptr_ipv6add}    xpath://f-field[label/field-label[contains(text(),"v6 A")]]//input
${NETWORK_DNS_DATABASE_DNS ENTRY_EDIT_STATUS_BUTTON}    xpath://f-field/label[@for="status"]
${NETWORK_DNS_DATABASE_DNS ENTRY_satus_disable}    xpath://span[text()="Disable"]
${NETWORK_DNS_DDNS_INTERFACE_NO ENTRY}     xpath://div[contains(@class,"selection-pane")]//div[text()="No entries"]
${NETWORK_DNS_DDNS_ENABLE_LABEL}    xpath://label[h2[contains(text(),"FortiGuard DDNS")]]/label
${NETWORK_DNS_DDNS_ENABLE_CHECKBOX}    xpath://input[@id="show-ddns-switch"]
${NETWORK_DNS_DDNS_INTERFACE}    xpath://f-field[label/field-label="Interface"]/div/field-value/div
${NETWORK_DNS_DDNS_INTERFACE_SELECT}    xpath://div[@class="selection-pane"]/div/div/div[span/span[text()="\${PLACEHOLDER}"]]
${NETWORK_DNS_DDNS_SERVER}    xpath://field-value/select[@id="ddns-server"]
${NETWORK_DNS_DDNS_SERVER_fortiddns.com}  xpath://select[@id="ddns-server"]/option[text()="fortiddns.com"]
${NETWORK_DNS_DDNS_SERVER_fortidyndns.com}  xpath://select[@id="ddns-server"]/option[text()="fortidyndns.com"]
${NETWORK_DNS_DDNS_SERVER_float-zone.com}  xpath://select[@id="ddns-server"]/option[text()="float-zone"]
${NETWORK_DNS_DDNS_UNIQUE LOCATION_LABEL}    xpath://label[field-label[text()="Unique Location"]]
${NETWORK_DNS_DDNS_UNIQUE LOCATION}    xpath://input[@id="unique-location"]
${NETWORK_DNS_DNS_PING_TEST_RETURN}   xpath://td/pre[contains(text(),"icmp_seq=1")]
${NETWORK_DNS_DNS_PING_TEST_RETURN_CLI}      icmp_seq=
${network_DNS_SUBMIT_APPLY_BUTTON}       xpath://button[@id="submit_apply"]
${NETWORK_DNS_DNS SETTINGS_TYPE_fortiguard}   xpath://label[span="Use FortiGuard Servers"]
${NETWORK_DNS_DNS SETTINGS_TYPE_specify}   xpath://label[span="Specify"]
${NETWORK_DNS_DNS SETTINGS_primary_DNS_SERVER}   id:primary-dns
${NETWORK_DNS_DNS SETTINGS_secondary_DNS_SERVER}   id:secondary-dns
${NETWORK_DNS_DNS SETTINGS_DNS_SERVER_LABEL}   xpath://field-label[contains(text(),"DNS Servers")]
${NETWORK_DNS_DNS SETTINGS_domain_NAME}   xpath://div[label[contains(text(),"Domain")]]/div/input
${NETWORK_DNS_DNS SETTINGS_LATENCY_PRIMARY}    xpath://dl[dt="DNS Servers"]/dd[contains(@ng-if,"original.primary")]/span
${NETWORK_DNS_DNS SETTINGS_LATENCY_PRIMARY_SPAN}    xpath://dl[dt="DNS Servers"]/dd[contains(@ng-if,"original.primary")]//span[contains(@ng-class,"severity")]
${NETWORK_DNS_DNS SETTINGS_LATENCY_SECONDARY}   xpath://dl[dt="DNS Servers"]/dd[contains(@ng-if,"original.secondary")]/span
${NETWORK_DNS_DNS SETTINGS_LATENCY_SECONDARY_SPAN}   xpath://dl[dt="DNS Servers"]/dd[contains(@ng-if,"original.secondary")]//span[contains(@ng-class,"severity")]
${NETWORK_DNS_DNS SETTINGS_LATENCY_PRIMARY_IPV6}    xpath://dl[dt="DNS Servers"]/dd[contains(@ng-if,"ip6-primary")]/span
${NETWORK_DNS_DNS SETTINGS_LATENCY_PRIMARY_IPV6_SPAN}    xpath://dl[dt="DNS Servers"]/dd[contains(@ng-if,"ip6-primary")]//span[contains(@ng-class,"severity")]
${NETWORK_DNS_DNS SETTINGS_LATENCY_SECONDARY_IPV6}    xpath://dl[dt="DNS Servers"]/dd[contains(@ng-if,"ip6-secondary")]/span
${NETWORK_DNS_DNS SETTINGS_LATENCY_SECONDARY_IPV6_SPAN}    xpath://dl[dt="DNS Servers"]/dd[contains(@ng-if,"ip6-secondary")]//span[contains(@ng-class,"severity")]
${NETWORK_DNS_DNS SETTINGS_LATENCY_WEB_FILTER}    xpath://dl[dt[contains(text(),"\${PLACEHOLDER}")]]/dd
${NETWORK_DNS_DNS SETTINGS_LATENCY_WEB_FILTER_SPAN}    xpath://dl[dt[contains(text(),"\${PLACEHOLDER}")]]/dd
${NETWORK_DNS_DNS SETTINGS_LATENCY_WEB_FILTER}    xpath://dl[dt[contains(text(),"\${PLACEHOLDER}")]]/dd
${NETWORK_DNS_DNS SETTINGS_LATENCY_WEB_FILTER_SPAN}    xpath://dl[dt[contains(text(),"\${PLACEHOLDER}")]]/dd
${NETWORK_DNS_DNS SETTINGS_TLS_BUTTON}    xpath://f-field[label[contains(field-label,"DNS over TLS")]]/div//label[span="\${PLACEHOLDER}"]
#### Network dns_servers_DNS Service on Interface ####
${Network_DNS Service_CREATEnew}          xpath://section[following-sibling::label[h2="DNS Database"]]//button[div//span="Create New"]
#### Network interface  DHCP ####
${NETWORK_INTERFACE_DHCP_SERVER_LABEL}    xpath://label[h2="DHCP Server"]/label
${NETWORK_INTERFACE_DHCP_SERVER_enable button}   id:dhcp_server_enabled
${NETWORK_INTERFACE_DHCP_SERVER_ADDRESS RANGE_CREATE_NEW}   xpath://div[label="Address Range"]/descendant::button[descendant::span[text()="Create New"]]
${NETWORK_INTERFACE_DHCP_SERVER_ADDRESS RANGE_EDIT}   xpath://div[label="Address Range"]/descendant::button[descendant::span[text()="Edit"]]
${NETWORK_INTERFACE_DHCP_SERVER_ADDRESS RANGE_DELETE}   xpath://div[label="Address Range"]/descendant::div[button[descendant::span[text()="Delete"]]]
${NETWORK_INTERFACE_DHCP_SERVER_ADDRESS RANGE_entry}    xpath://div[@id="dhcp_server_ip_ranges-qlist"]/div/table/tbody/tr[\${PLACEHOLDER}]
${NETWORK_INTERFACE_DHCP_SERVER_ADDRESS RANGE_startip}   xpath://div[@id="dhcp_server_ip_ranges-qlist"]/div/table/tbody/tr[\${PLACEHOLDER}]/td[1]/input
${NETWORK_INTERFACE_DHCP_SERVER_ADDRESS RANGE_endip}   xpath://div[@id="dhcp_server_ip_ranges-qlist"]/div/table/tbody/tr[\${PLACEHOLDER}]/td[2]/input
${NETWORK_INTERFACE_DHCP_SERVER_NETMASK}   id:dhcp_server_netmask
${NETWORK_INTERFACE_DHCP_SERVER_DNS_system dns}  id:dhcp_server_dns_service_default 
${NETWORK_INTERFACE_DHCP_SERVER_DNS_INTERFACE}   id:dhcp_server_dns_service_local
${NETWORK_INTERFACE_DHCP_SERVER_DNS_specify_LABEL}    xpath://div[label="DNS Server"]/div/div/label[contains(text(),"Specify")]
${NETWORK_INTERFACE_DHCP_SERVER_DNS_specify}     id:dhcp_server_dns_service_specify
${NETWORK_INTERFACE_DHCP_SERVER_DNS_specify_ip}  id:dhcp_server_dns_server
${NETWORK_INTERFACE_DHCP_SERVER_ADVANCED_LABEL}    xpath://label[span[contains(text(),"Advanced")]]/label
${NETWORK_INTERFACE_DHCP_SERVER_ADVANCED_BUTTON}    xpath://label[span(contains(text(),"Advanced")]/input
${NETWORK_INTERFACE_DHCP_SERVER_MAC_RESV_entry}    xpath://div[@id="dhcp_server_mac_list-qlist"]/div/table/tbody/tr[\${PLACEHOLDER}]
${NETWORK_INTERFACE_DHCP_SERVER_MAC_RESV_DESCRIP}   xpath://div[@id="dhcp_server_mac_list-qlist"]/div/table/tbody/tr[\${PLACEHOLDER}]/td[3]/input
${NETWORK_INTERFACE_DHCP_SERVER_MAC_RESV_CREATE_NEW}    xpath://f-dhcp-server-reserved-address-list-menu//button[div/span="Create New"]
${NETWORK_INTERFACE_DHCP_SERVER_IPMAC_RESV}     xpath://f-field[label/field-label="\${PLACEHOLDER}"]/div//input
${NETWORK_INTERFACE_DHCP_SERVER_IPMAC_RESV_TYPE}     xpath://f-radio-group/label[span="\${PLACEHOLDER}"]
${NETWORK_INTERFACE_DHCP_SERVER_ADDITIONAL_CREATE_NEW}   xpath://div[label[contains(text(),"Additional")]]/descendant::button[descendant::span[text()="Create New"]]
${NETWORK_INTERFACE_DHCP_SERVER_ADDITIONAL_EDIT}   xpath://div[label[contains(text(),"Additional")]]/descendant::button[descendant::span[text()="Edit"]]
${NETWORK_INTERFACE_DHCP_SERVER_ADDITIONAL_DELETE}   xpath://div[label[contains(text(),"Additional")]]/descendant::button[descendant::span[text()="Delete"]]
${NETWORK_INTERFACE_DHCP_SERVER_ADDITIONAL_SELECT}   xpath://select[@id="2--\${PLACEHOLDER}-opt_key"]
${NETWORK_INTERFACE_DHCP_SERVER_ADDITIONAL_SELECT_OPTION}    xpath://select[@id="2--\${PLACEHOLDER}-opt_key"]/option[contains(text(),"\${option}")]
${NETWORK_INTERFACE_DHCP_SERVER_ADDITIONAL_SELECT_VALUE}     xpath://input[@id="2--\${PLACEHOLDER}-opt_val"]
${NETWORK_INTERFACE_DHCP_SERVER_ADDITIONAL_SELECT_SPECIFY_VALUE}   xpath://input[@id="2--\${PLACEHOLDER}-specify"]
${NETWORK_INTERFACE_DHCP_SERVER_ADDITIONAL_OPTION_SPAN}    xpath://div[@id="dhcp_additional_option_list-qlist"]//tr/td[descendant::span[contains(text(),"\${PLACEHOLDER}")]]
${NETWORK_INTERFACE_DHCP_SERVER_ADDITIONAL_OPTION_VALUE_SPAN}   xpath://div[@id="dhcp_additional_option_list-qlist"]//tr[descendant::span[contains(text(),"\${PLACEHOLDER}")]]/td[3]/div/span
${NETWORK_INTERFACE_DHCP_SERVER_ADDITIONAL_OPTION_VALUE_INPUT}   xpath://div[@id="dhcp_additional_option_list-qlist"]//tr[descendant::span[contains(text(),"\${PLACEHOLDER}")]]/td[3]/div/input
${NETWORK_INTERFACE_DHCP_SERVER_NTP_SPECIFY_BUTTON}   xpath://div[label="NTP Server"]/descendant::label[contains(text(),"Specify")]
${NETWORK_INTERFACE_DHCP_SERVER_NTP_SPECIFY_VALUE}    id:dhcp_server_ntp-server1
${NETWORK_INTERFACE_DHCP_SERVER_RESERVE_TYPE}    xpath://label[span[contains(text(),"\${PLACEHOLDER}")]]
${NETWORK_INTERFACE_DHCP_SERVER_RESERVE_ID_HEX}     xpath://f-field[label/field-label="\${PLACEHOLDER} ID"]/div//label[span="Hexadecimal"]
${NETWORK_INTERFACE_DHCP_SERVER_RESERVE_ID_HEX_INPUT}    xpath://input[@name="\${PLACEHOLDER}-id-hex"]
${NETWORK_INTERFACE_VDOM_SELECT_BUTTON}     xpath://div[label/span="Virtual Domain"]/div/div
${NETWORK_INTERFACE_VDOM_SELECTED}          xpath://div[label/span="Virtual Domain"]//span[f-icon]/span
${NETWORK_INTERFACE_VDOM_SELECT_MENU_BAR}   xpath://div[@class="selection-dropdown"]/div[2]/div[span//span="\${PLACEHOLDER}"]
####### interface xpath in creat and edit page ####
${NETWORK_INTERFACES_TABLE_PHYSICAL_INTERFACE_SELECT INTERFACE}   xpath://tr[td[3]/span[b="\${PLACEHOLDER}"]]
${NETWORK_INTERFACES_EXPAND_BUTTON}   /td[1]//button
${NETWORK_INTERFACES_TYPE}   xpath://tbody[tr/td/label[contains(text(),"\${PLACEHOLDER}")]]
${NETWORK_INTERFACES_TABLE_INTERFACE}   /following-sibling::tbody[1]//tr[td[@class="name"][span/b="\${PLACEHOLDER}"]]
${NETWORK_INTERFACES_TABLE_VDOM}        /td[@class="vdom"][span="\${PLACEHOLDER}"]
${NETWORK_INTERFACES_TABLE_VDOM_SPAN}    /td[@class="vdom"]/span
${NETWORK_INTERFACES_TABLE_REF}        /td[@class="q_ref"]/a
${NETWORK_INTERFACES_REF_TYPE}   xpath://tr[td/label[contains(text(),"\${PLACEHOLDER}")]]
${NETWORK_INTERFACES_REF_ITEM}   /following-sibling::tr[td[@class="mkey" and text()="\${PLACEHOLDER}"]]
${NETWORK_INTERFACES_REF_ITEM_DELETE_BUTTON}    xpath://div[@class="qlist-view-container"]/descendant::button[div/span="Delete"]
${NETWORK_INTERFACES_REF_ITEM_CLOSE_BUTTON}     xpath://div[@class="slider-area"]/descendant::button[@class="bare"]
#######  creat and edit page info ###
${NETWORK_INTERFACES_CREATE NEW_BUTTON}    xpath:(//button[div/span[contains(text(),"Create New")]])[1]
${NETWORK_INTERFACES_EDIT_BUTTON}          xpath:(//button[div/span="Edit"])[1]
${NETWORK_INTERFACES_DELETE_BUTTON}          xpath:(//button[div/span="Delete"])[1]
${NETWORK_INTERFACES_EDIT_OK_BUTTON}    id:submit_ok
${NETWORK_INTERFACES_DELETE_OK_BUTTON}     xpath://div/button[text()="OK"]
${NETWORK_INTERFACES_CREATE NEW_MENU_BAR}    xpath://button/div/span[contains(text(),"\${PLACEHOLDER}")]
${NETWORK_INTERFACES_CREATE NEW_MENU_BAR_INTERFACE}    xpath://button/div/span[contains(text(),"Interface")]
${NETWORK_INTERFACES_CREATE NEW_MENU_BAR_VIRTUAL}      xpath://button/div/span[contains(text(),"Virtual")]
${NETWORK_INTERFACES_CREATE NEW_MENU_BAR_ZONE}      xpath://button/div/span[contains(text(),"Zone")]
${NETWORK_INTERFACES_CREATE OR EDIT_INTERFACE Name}    xpath://div[label="Interface Name"]/div/input
${NETWORK_INTERFACES_CREATE OR EDIT_Alias}    xpath://div[label="Alias"]/div/input
${NETWORK_INTERFACES_CREATE OR EDIT_TYPE}    xpath://select[@id="type"]
${NETWORK_INTERFACES_CREATE OR EDIT_TYPE_selected}    xpath://select[@id="type"]/option[contains(text(),"\${PLACEHOLDER}")]
${NETWORK_INTERFACES_CREATE OR EDIT_INTERFACE}    xpath://div[label="Interface"]/div/select
${NETWORK_INTERFACES_CREATE OR EDIT_INTERFACE_INTERFACE}    xpath://div[label="Interface"]/div/select/option[text()="\${PLACEHOLDER}"]
${NETWORK_INTERFACES_CREATE OR EDIT_VLAN ID}    xpath://div[label="VLAN ID"]/div/input
${NETWORK_INTERFACES_CREATE OR EDIT_Virtual DOMAIN}    xpath://div[label/span="Virtual Domain"]/div/div
${NETWORK_INTERFACES_CREATE OR EDIT_INTERFACE MEMBERS}    xpath://div[label="Interface Members"]/div
${NETWORK_INTERFACES_CREATE OR EDIT_IP Mask}    xpath://input[@id="ipmask"]
${NETWORK_INTERFACES_CREATE OR EDIT_INTERFACE MEMBERS_CLOSE_BUTTON}   xpath://div[h1="Select Entries"]/button
${NETWORK_INTERFACES_CREATE OR EDIT_INTERFACE_OK_BUTTON}      xpath://button[@id="submit_ok"]
${NETWORK_INTERFACES_CREATE OR EDIT_INTERFACE_Cancel_BUTTON}      xpath://button[@id="submit_cancel"]
${NETWORK_INTERFACES_EDIT_MGMT_DEDICATED_BUTTON}    xpath://label[h2[contains(text(),"Dedicated")]]/label
${NETWORK_INTERFACES_EDIT_MGMT_DEDICATED_CHECKBOX}    xpath://label[h2[contains(text(),"Dedicated")]]/input
${NETWORK_INTERFACES_EDIT_MGMT_DEDICATED_TRUST_HOST}   xpath://div[label="Trusted Hosts"]/div/input
${NETWORK_INTERFACES_EDIT_ROLE_LABEL}    xpath://label[span[contains(text(),"Role")]]
${NETWORK_INTERFACES_EDIT_ROLE_SELECT_MENU}   id:role
${NETWORK_INTERFACES_EDIT_ROLE_SELECT_MENUBAR}   xpath://select[@id="role"]/option[text()="\${PLACEHOLDER}"]
${NETWORK_INTERFACES_EDIT_ROLE_SELECTED}      xpath://select[@id="role"]/option[@selected="selected"]
${NETWORK_INTERFACES_EDIT_ADMISSION_CONTROL}     xpath://div[h2="Admission Control"]
${NETWORK_INTERFACES_EDIT_SECURITY_MODE}     xpath://div[label="Security Mode"]
${NETWORK_INTERFACES_EDIT_SECONDARY_IP_LABEL}   xpath://span[contains(text(),"Secondary IP Address")]/label
${NETWORK_INTERFACES_EDIT_SECONDARY_IP_CHECKBOX}   xpath://span[contains(text(),"Secondary IP Address")]/input
${NETWORK_INTERFACES_EDIT_SECONDARY_IP_CREATE_NEW}    xpath://div[label/span[contains(text(),"Secondary IP Address")]]/div//button[div[span="Create New"]]
${NETWORK_INTERFACES_EDIT_SECONDARY_IP_EDIT}    xpath://div[label/span[contains(text(),"Secondary IP Address")]]/div//button[div[span="Edit"]]
${NETWORK_INTERFACES_EDIT_SECONDARY_IP_DELETE}    xpath://div[label/span[contains(text(),"Secondary IP Address")]]/div//button[div[span="Delete"]]
${NETWORK_INTERFACES_EDIT_SECONDARY_IP_INPUT}    id:second-ipmask
${NETWORK_INTERFACES_EDIT_WIFI_PSKEY_INPUT}      xpath://input[@name="wireless.passphrase"]
${NETWORK_INTERFACES_TABLE_PHYSICAL_INTERFACE1}    xpath://table/tbody[2]/tr[1]
${NETWORK_INTERFACES_TABLE_INTERFACE_selected}   xpath://td/span[b="\${PLACEHOLDER}"]
${NETWORK_INTERFACES_CREATE OR EDIT_INTERFACE_MEMBERS_BUTTON}   xpath://div[label="Interface Members"]/div/div
${NETWORK_INTERFACE_ADDRESSING MODE}     xpath://div[label="Addressing mode"]//label[contains(text(),"\${PLACEHOLDER}")]
${NETWORK_INTERFACE_ADDRESSING MODE_MANUAL}   xpath://div[label="Addressing mode"]//label[contains(text(),"Manual")]
${NETWORK_INTERFACE_ADDRESSING MODE_PPPOE}   xpath://div[label="Addressing mode"]//label[contains(text(),"PPPoE")]
${NETWORK_INTERFACE_ADDRESSING MODE_DHCP}   xpath://div[label="Addressing mode"]//label[contains(text(),"DHCP")]
${NETWORK_INTERFACE_ADDRESSING MODE_ONE_ARM_SNIFFER}   xpath://label[contains(text(),"One-Arm")]
${NETWORK_INTERFACE_ADDRESSING MODE_Dedicated to FortiSwitch}   xpath://label[contains(text(),"Dedicated to FortiSwitch")]
${NETWORK_INTERFACE_ADDRESSING MODE_DHCP_DNSOVER_CHECKBOX}   id:dns-server-override
${NETWORK_INTERFACE_ADDRESSING MODE_DHCP_DNSOVER_LABEL}    xpath://span[input[@id="dns-server-override"]]/label
${NETWORK_INTERFACE_ADDRESSING MODE_DHCP_DNSOVER_INPUT}    xpath://span[span[contains(text(),"Override internal")]]/input
${NETWORK_INTERFACE_ADDRESSING MODE_DHCP_DNSOVER_LABEL}    xpath://span[span[contains(text(),"Override internal")]]/label
${NETWORK_INTERFACE_ADDRESSING MODE_ipv6_manual}   xpath://div[label="IPv6 Addressing mode"]//label[contains(text(),"Manual")]
${NETWORK_INTERFACE_ADDRESSING MODE_IPV6_DHCP}   xpath://div[label="IPv6 Addressing mode"]//label[contains(text(),"DHCP")]
${NETWORK_INTERFACE_ADDRESS_IP}    id:ipmask
${NETWORK_INTERFACE_ADDRESS_IPV6}    id:ip6-address
${NETWORK_INTERFACE_ADMINISTRATIVE ACESS_CHECKBOX_IPV6}    xpath://input[@name="acs6_\${PLACEHOLDER}"]
${NETWORK_INTERFACE_ADMINISTRATIVE ACESS_LABEL_IPV6}    xpath://label[input[@name="acs6_\${PLACEHOLDER}"]]
${NETWORK_INTERFACE_ADMINISTRATIVE_ACESS_LLDP_TRANS_TITLE}   xpath://div[label[contains(text(),"Transmit LLDP")]]
${NETWORK_INTERFACE_ADMINISTRATIVE_ACESS_LLDP_REC_TITLE}    xpath://div[label[contains(text(),"Receive LLDP")]]
${NETWORK_INTERFACE_ADMINISTRATIVE_ACESS_LLDP_REC_LABEL}    xpath://div[label[contains(text(),"Receive LLDP")]]/div/div/label[@for="lldp-reception-\${PLACEHOLDER}"]
${NETWORK_INTERFACE_ADMINISTRATIVE_ACESS_LLDP_REC_SELECT}   xpath://div[label[contains(text(),"Receive LLDP")]]/div/div/input[@id="lldp-reception-\${PLACEHOLDER}"]
${NETWORK_INTERFACE_ADMINISTRATIVE_ACESS_LLDP_TRANS_LABEL}    xpath://div[label[contains(text(),"Transmit LLDP")]]/div/div/label[@for="lldp-transmission-\${PLACEHOLDER}"]
${NETWORK_INTERFACE_ADMINISTRATIVE_ACESS_LLDP_TRANS_SELECT}   xpath://div[label[contains(text(),"Transmit LLDP")]]/div/div/input[@id="lldp-transmission-\${PLACEHOLDER}"]
${NETWORK_INTERFACE_ADDRESSING_IPV6_DHCP_CLIENT_IP}    xpath://tr/td[pre[contains(text(),"ip6-address")]]
${NETWORK_INTERFACES_CREATE NEW_VWP_NAME}    xpath://label[field-label="Name"]
${NETWORK_INTERFACES_CREATE NEW_VWP_NAME_INPUT}   xpath://f-field[label="Name"]/div//input
${NETWORK_INTERFACES_CREATE NEW_VWP_INTERFACE}   xpath://f-field[//span[contains(text(),"Interface Mem")]]/div//div[@class="select-widget"]
${NETWORK_INTERFACES_VWP_EDIT_VWP_INTERFACE}     xpath://f-field[//span[contains(text(),"Interface Mem")]]/div/field-value/div
${NETWORK_INTERFACES_VWP_VLANFILTER_LABEL}    xpath://field-label[span="Wildcard VLAN"]/label
${NETWORK_INTERFACES_VWP_VLANFILTER_CHECKBOX}    xpath://field-label[span="Wildcard VLAN"]/input
${NETWORK_INTERFACES_VWP_VLANFILTER_VALUE_START_INPUT}     xpath://f-field[label//span="VLAN Filter"]//span[1]/input
${NETWORK_INTERFACES_VWP_VLANFILTER_VALUE_END_INPUT}       xpath://f-field[label//span="VLAN Filter"]//span[3]/input
${NETWORK_INTERFACES_CREATE NEW_ZONE_NAME}    xpath://label[field-label="Name"]
${NETWORK_INTERFACES_CREATE NEW_ZONE_NAME_INPUT}   xpath://f-field[label="Name"]/div//input
${NETWORK_INTERFACES_CREATE NEW_ZONE_INTERFACE}   xpath://f-field[//field-label[contains(text(),"Interface Mem")]]/div//div[@class="select-widget"]
${NETWORK_INTERFACES_CREATE NEW_ZONE_INTERFACE_UNSELECT}     xpath://div[span//span="\${PLACEHOLDER}"]/f-icon
${NETWORK_INTERFACES_EDIT_ESTINAMTE_BANDWIDTH_LABEL}   xpath://span[text()="Estimated Bandwidth"]
${NETWORK_INTERFACES_EDIT_ESTINAMTE_BANDWIDTH_UP}      id:estimated-upstream-bandwidth
${NETWORK_INTERFACES_EDIT_ESTINAMTE_BANDWIDTH_DOWN}    id:estimated-downstream-bandwidth
${NETWORK_INTERFACES_EDIT_CREATE_ADDRESS_OBJ_LABEL}       xpath://span[span="Create address object matching subnet"]/label
${NETWORK_INTERFACES_EDIT_CREATE_ADDRESS_OBJ_CHECKBOX}    xpath://span[span="Create address object matching subnet"]/input
${NETWORK_INTERFACES_EDIT_CREATE_ADDRESS_OBJ_NAME}          id:address-object-name
${NETWORK_INTERFACES_EDIT_CREATE_ADDRESS_OBJ_DEFINITION}    id:address-object-definition
${NETWORK_INTERFACES_EDIT_SECURITYMODE_MENU}      xpath://select[@name="security-mode"]
${NETWORK_INTERFACES_EDIT_SECURITYMODE_MENU_CAPTIVE}      xpath://select[@name="security-mode"]/option[contains(text(),"Captive")]
######## Interface VDOM link page  ####
${NETWORK_INTERFACES_VDOMLINK_NAME_INPUT}     xpath://input[@id="name"]
${NETWORK_INTERFACES_VDOMLINK_INT0_IPV4_PING}      xpath://input[@id="access-ping-0"]
${NETWORK_INTERFACES_VDOMLINK_INT1_IPV4_PING}      xpath://input[@id="access-ping-1"]
${NETWORK_INTERFACES_VDOMLINK_INT_DIV}    xpath://section[div/h3[contains(text(),"\${PLACEHOLDER}")]]
${NETWORK_INTERFACES_VDOMLINK_INT_DIV_VDOM}    /div[label="Virtual Domain"]/div/div[contains(@class,"single-select")]
${NETWORK_INTERFACES_VDOMLINK_INT_DIV_IPMASK}    /div[label="IP/Netmask"]/div/input
${NETWORK_INTERFACES_VDOMLINK_INT_DIV_STATE_INPUT}    /div[label="Interface State"]/div/f-radio-group/input[@radio-label="\${PLACEHOLDER}"]
${NETWORK_INTERFACES_VDOMLINK_INT_DIV_STATE_LABEL}    /div[label="Interface State"]/div/f-radio-group/label[span="\${PLACEHOLDER}"]
##### Captive Portal ###
${NETWORK_INTERFACES_CAPTIVE_PTL_LGIN_PRE_BAN}     xpath://div[contains(text(),"PRE")]
${NETWORK_INTERFACES_CAPTIVE_PTL_LGIN_POST_BAN}    xpath://div[contains(text(),"POST")]
${NETWORK_INTERFACES_CAPTIVE_PTL_LGIN_ACPT}        xpath://button[@value="Accept"]
${NETWORK_INTERFACES_CAPTIVE_MENU}    id:wl_mode
${NETWORK_INTERFACES_CAPTIVE_MENU_OP_CAPTIVE}   xpath://option[contains(text(),"Captive")]
${NETWORK_INTERFACES_CAPTIVE_MENU_OP_NONE}   xpath://option[contains(text(),"None")]
${NETWORK_INTERFACES_CAPTIVE_USERGROUP_ADD_BUTTON}    xpath://div[contains(@class,"captive")][label="User Groups"]//div[@class="add-placeholder"]
${NETWORK_INTERFACES_CAPTIVE_USERACCESS_RESTRICT_LABEL}    xpath://div[input[@id="restrict-access"]]/label[contains(text(),"Restrict")]
${NETWORK_INTERFACES_CAPTIVE_PORTALPAGE_USERNAME}     xpath://input[@name="username"]
${NETWORK_INTERFACES_CAPTIVE_PORTALPAGE_PASSWORD}     xpath://input[@name="password"]
${NETWORK_INTERFACES_CAPTIVE_PORTALPAGE_CONTINUE}     xpath://input[@value="Continue"]
${NETWORK_INTERFACES_CAPTIVE_CUSTOMIZE_SLIDE_FRAME}    xpath://iframe[@class="slide-iframe"]
${NETWORK_INTERFACES_CAPTIVE_CUSTOMIZE_EDITOR_FRAME}    xpath://iframe[@id="msg_editor"]
${NETWORK_INTERFACES_CAPTIVE_CUSTOMIZE_CHKBOX}    xpath://input[@id="wl_customize_chk"]
${NETWORK_INTERFACES_CAPTIVE_CUSTOMIZE_LABEL}     xpath://span[input[@id="wl_customize_chk"]]/label
${NETWORK_INTERFACES_CAPTIVE_CUSTOMIZE_SPAN_CLOSE_BUTTON}    xpath://div[@class="title-bar"]/button[@class="bare"]
${NETWORK_INTERFACES_CAPTIVE_CUSTOMIZE_SPAN_MESSAGE}    xpath://span[@id="statistics"]
${NETWORK_INTERFACES_CAPTIVE_EXEMPT_BUTTON}    xpath://div[label[contains(text(),"\${PLACEHOLDER}")]]/div/div[@class="select-widget"]
${NETWORK_INTERFACES_CAPTIVE_EXEMPT_INPUT}     xpath://div[label[contains(text(),"\${PLACEHOLDER}")]]/div/input
${NETWORK_INTERFACES_CAPTIVE_EXEMPT_SPAN_1}   xpath://div[@class="selection-pane"]/div/div[@class="virtual-results"]/div[@draggable="true"][1]
${NETWORK_INTERFACES_CAPTIVE_EXEMPT_SPAN_CLOSE_BUTTON}    xpath://div[h1="Select Entries"]/button[@class="bare"]
#### network packet capture ####
${NETWORK_PACKET_CAPTURE_ENTRY}        xpath://span[text()="Packet Capture"]
${NETWORK_PACKET_CAPTURE_CREATE_NEW_BUTTON}   xpath://span[text()="Create New"]
${NETWORK_PACKET_EDIT_BUTTON}        xpath:(//span[text()="Edit"])[1]
${NETWORK_PACKET_DELETE_BUTTON}        xpath:(//span[text()="Delete"])[1]
${NETWORK_PACKET_VIEW_BUTTON}          xpath:(//span[contains(text(),"View")])[1]
${NETWORK_PACKET_DELETE_OK_BUTTON}     xpath://button[text()="OK"]
${NETWORK_PACKET_CAPTURE_CREATE_NEW_INTERFACE}   xpath://f-field[label/field-label="Interface"]/descendant::div[contains(@class,"select-widget")]
${NETWORK_PACKET_CAPTURE_CREATE_NEW_INTERFACE_ITEM}     xpath://div[span[span="\${PLACEHOLDER}"]]
${NETWORK_PACKET_CAPTURE_CREATE_NEW_MAX}       xpath://f-field[label/field-label[contains(text(),"Max")]]/descendant::input
${NETWORK_PACKET_CAPTURE_CREATE_NEW_FILTER_LABEL}       xpath://f-field[label/field-label[contains(text(),"Filter")]]/div//label
${NETWORK_PACKET_CAPTURE_CREATE_NEW_FILTER_CHECKBOX}       xpath://f-field[label/field-label[contains(text(),"Filter")]]/div//input
${NETWORK_PACKET_CAPTURE_CREATE_NEW_FILTER_ITEM}       xpath://f-field[label/field-label[contains(text(),"\${PLACEHOLDER}")]]/div//input
${NETWORK_PACKET_CAPTURE_CREATE_NEW_IPV6_LABEL}       xpath://f-field[label/field-label[contains(text(),"IPv6")]]/div//label
${NETWORK_PACKET_CAPTURE_CREATE_NEW_IPV6_CHECKBOX}       xpath://f-field[label/field-label[contains(text(),"IPv6")]]/div//input
${NETWORK_PACKET_CAPTURE_CREATE_NEW_NON_IP_LABEL}       xpath://f-field[label/field-label[contains(text(),"Non-IP")]]/div//label
${NETWORK_PACKET_CAPTURE_CREATE_NEW_NON_IP_CHECKBOX}       xpath://f-field[label/field-label[contains(text(),"Non-IP")]]/div//input
${NETWORK_PACKET_CAPTURE_SNIFFER_ITEMS}         xpath://tr/td[span="\${PLACEHOLDER}"]
${NETWORK_PACKET_CAPTURE_SNIFFER_START_BUTTON}        xpath://tr[td[span="\${PLACEHOLDER}"]]/td[@class="progress"]/span/f-icon[contains(@title,"Start/")]
${NETWORK_PACKET_CAPTURE_SNIFFER_STOP_BUTTON}        xpath://tr[td[span="\${PLACEHOLDER}"]]/td[@class="progress"]/span/f-icon[contains(@title,"Stop")]
${NETWORK_PACKET_CAPTURE_SNIFFER_DOWNLOAD_BUTTON}        xpath://tr[td[span="\${PLACEHOLDER}"]]/td[@class="progress"]/span/f-icon[contains(@title,"Download")]
${NETWORK_PACKET_CAPTURE_EDIT_SNIFFER_REPEAT_BUTTON}    xpath://button[f-icon[@class="fa-repeat"]]
${NETWORK_PACKET_CAPTURE_EDIT_SNIFFER_PLAY_BUTTON}    xpath://button[f-icon[@class="fa-play"]]
${NETWORK_PACKET_CAPTURE_EDIT_SNIFFER_STOP_BUTTON}    xpath://button[f-icon[@class="fa-stop"]]
${NETWORK_PACKET_CAPTURE_EDIT_SNIFFER_DOWNLOAD_BUTTON}    xpath://button[f-icon[@class="fa-download"]]
#### NETWORK POLICY and OBJECTS ####
${NETWORK_POLICY_IPV4_VWP}   xpath://span[text()="IPv4 Virtual Wire Pair Policy"]
${NETWORK_POLICY_IPV6_VWP}   xpath://span[text()="IPv6 Virtual Wire Pair Policy"]
### network  SD-WAN ###
${NETWORK_SDWAN_ENTRY}        xpath://span[text()="SD-WAN"]
${NETWORK_SDWAN_ENABLE}       xpath://label[span="Enable"]
${NETWORK_SDWAN_INTERFACE_MEMBER_ADD_BUTTON}    xpath://div[h2="SD-WAN Interface Members"]/following-sibling::div[1]/section/f-field//button
${NETWORK_SDWAN_MEMBER_ADD_INTERFACE_XPATH_HEAD}    xpath://div[h2="SD-WAN Interface Members"]/following-sibling::div[1]/section/div[\${PLACEHOLDER}]
${NETWORK_SDWAN_MEMBER_ADD_INTERFACE_MENU}    /f-field[label[field-label/span="Interface"]]/div/field-value/div
${NETWORK_SDWAN_MEMBER_ADD_INTERFACE_SELECTED}    /f-field[label[field-label/span="Interface"]]/div//span[text()="\${PLACEHOLDER}"]
${NETWORK_SDWAN_MEMBER_ADD_INTERFACE_GATEWAY}  /f-field[label[field-label="Gateway"]]//input
${NETWORK_SDWAN_MEMBER_ADD_INTERFACE_STATUS_LABEL}    /f-field[label[field-label="Status"]]//label[span="\${PLACEHOLDER}"]
${NETWORK_SDWAN_MEMBER_ADD_INTERFACE_STATUS_VALUE}    /f-field[label[field-label="Status"]]//input[@radio-label="\${PLACEHOLDER}"]
${NETWORK_SELECT_INTERFACE_MEMBER_MENU_BAR}    xpath://div[@class="selection-dropdown"]/div[@class="virtual-results"]/div[span/span="\${PLACEHOLDER}"]

####### Security Profiles####
${SECURITY PROFILE_Antivirus_MENU_BAR}     xpath://div[div/span="Security Profiles"]//span[text()="AntiVirus"]
${SECURITY PROFILE_Web Filter_MENU_BAR}     xpath://div[div/span="Security Profiles"]//span[text()="Web Filter"]
${SECURITY PROFILE_IPS_MENU_BAR}     xpath://div[div/span="Security Profiles"]//span[text()="Intrusion Prevention"]
${SECURITY PROFILE_FortiClient Compli_MENU_BAR}     xpath://div[div/span="Security Profiles"]//span[contains(text(),"FortiClient")]
${SECURITY PROFILE_Antivirus_PAGE_SPAN}    xpath://div[h1="Edit AntiVirus Profile"]
${SECURITY PROFILE_Web Filter_PAGE_SPAN}    xpath://div[h1="Edit Web Filter Profile"]
${SECURITY PROFILE_IPS_PAGE_SPAN}    xpath://div[h1="Edit IPS Sensor"]
${SECURITY PROFILE_FortiClient Compli_PAGE_SPAN}    xpath://div[h1="Edit FortiClient Compliance Profile"]
${SECURITY PROFILE_infoframe}        xpath://iframe[@name="embedded-iframe"]
${SECURITY PROFILE_CREATE_NEW_BUTTON}    xpath://button[div/span="Create New"]
#####  user and device ####
${USER AND DEVICE_DEVICE_INVENTORY}    xpath://span[text()="Device Inventory"]

##### Policy and Objects  ####
${POLICY_IPV4_VWP_ENTRY}     xpath://span[contains(text(),"IPv4 Virtual Wire")]
${POLICY_IPV6_VWP_ENTRY}     xpath://span[contains(text(),"IPv6 Virtual Wire")]
${POLICY_IPV4_VWP_CREATE_NEW}    xpath://button[div[span="Create New"]]
${POLICY_IPV4_VWP_POLICY_NAME_LABEL}   xpath://div[label/span="Name"]
${POLICY_IPV4_VWP_POLICY_NAME_INPUT}   xpath://div[label/span="Name"]/div/input
${POLICY_IPV4_VWP_POLICY_BIDIRECTION}   xpath://label[@for="vwp-direction-bidirection"]
${POLICY_IPV4_VWP_POLICY_SERV}          xpath://div[label/span[contains(text(),"\${PLACEHOLDER}")]]/div/div

${SYSTEM_POLICY_IPV4_POLICY_CREATE_NEW}    xpath://button[div[span="Create New"]]
${SYSTEM_POLICY_IPV4_POLICY_NAME_LABEL}    xpath://div[label/span="Name"]
${SYSTEM_POLICY_IPV4_POLICY_NAME_INPUT}    xpath://div[label/span="Name"]/div/input
${SYSTEM_POLICY_IPV4_POLICY_INCOME_INT_LABEL}   xpath://div[label/span="Incoming Interface"]/div/div
${SYSTEM_POLICY_IPV4_POLICY_OUTGO_INT_LABEL}    xpath://div[label="Outgoing Interface"]/div/div
${SYSTEM_POLICY_IPV4_POLICY_SERV}          xpath://div[label/span[contains(text(),"\${PLACEHOLDER}")]]/div/div
${SYSTEM_POLICY_IPV4_POLICY_EDITBY_SEQUENCE_BUTTON}   xpath://button[div/span[contains(text(),"By Sequence")]]
${SYSTEM_POLICY_IPV4_POLICY_EDIT-ENTRY}    xpath://div[div[@column-id="name"][div/div/div="\${PLACEHOLDER}"]]
##### user and device  ##
${SYSTEM_SAML_CREATE_SP_NAME_INPUT}           xpath://section[f-field[label[contains(field-label,"Prefix")]]]/f-field[label[contains(field-label,"Name")]]/div//input
${SYSTEM_SAML_SP_LIST_NAME}    xpath://div[div[@column-id="name"]//div="\${PLACEHOLDER}"]
${SYSTEM_SAML_SP_LIST_PREFIX}    /div[@column-id="prefix"]//div[@class="standard-value-content"]
${SYSTEM_SAML_SP_IDP_CERT_IMPORT_BUTTON}   xpath://button[contains(span,"Import")]
${SYSTEM_SAML_SP_IDP_CERT_UPLOAD_INPUT}   xpath://field-value[label/span="Upload"]/input
${SYSTEM_SAML_HREF_ON_LOGIN_PAGE}    xpath://a[contains(text(),"Single Sign-On")]
${SYSTEM_SAML_CONTINUE_BUTTON_LOGIN_PAGE}   xpath://button[span="Continue"]
${SYSTEM_SAML_IDP_PAGE_SSO_HEADER}    xpath://b[text()="Single Sign-On Provider"]
#### log and report  ###
${LOG_REPORT_COMPLIANCE_EVENTS_ENTRY}           xpath://span[text()="Compliance Events"]

### monitor  ###
${MONITOR_DHCP_REVOKE_BUTTON}       xpath:(//div[button/div/span[contains(text(),"Revoke")]])[1]
${MONITOR_DHCP_REVOKE_OK_BUTTON}    xpath://button[text()="OK"]
${MONITOR_FIREWALLUSER_USER_ENTRY}    xpath://div[div[@column-id="username"]//span="\${PLACEHOLDER}"]
${MONITOR_FIREWALLUSER_USER_DEAUTHEN_BUTTON}    xpath:(//button[div/span="Deauthenticate"])[1]