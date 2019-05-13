*** Settings ***
Documentation     This file contains all locator variables on SSLVPN GUI v6.2

*** Variables ***
#Format Definition: ${LOCATION_FRAME-NAME_FRAME-TYPE}###
####LOGIN Page####
${LOGIN_SSLVPN_USERNAME_TEXT}    xpath://input[@id="username"]
${LOGIN_SSLVPN_PASSWORD_TEXT}    xpath://input[@id="credential"]
${LOGIN_SSLVPN_LOGIN_BUTTON}    name:login_button
${LOGIN_SSLVPN_LAUNCH_FORTICLIENT_BUTTON}    id:launch-forticlient-button
${LOGIN_SSLVPN_ALREADY_LOGGED_IN}    xpath://b[text()="Already Logged In"]
${LOGIN_SSLVPN_LOGGED_IN_ANYWAY}    xpath://a[text()="Log in Anyway"]
####PORTAL Page####
${PORTAL_QUICK_CONNECTION_BUTTON}    xpath://button[div/span="Quick Connection"]
${PORTAL_NEW_BOOKMARK_BUTTON}    xpath://button[div/span="New Bookmark"]
${PORTAL_NAV_BAR}    xpath:/html/body/section/div/div/h1
${PORTAL_ICON_BUTTON}    xpath:/html/body/header/div[4]/button[3]
${PORTAL_VAR_ICON_BUTTON}    xpath://button[contains(div/div/div,"\${PLACEHOLDER}")]
${PORTAL_LOGOUT}    xpath://button[div/span="Logout"]
${PORTAL_HELP_BUTTON}    xpath://button[@title="Help"]
${PORTAL_LAUNCH_FORTICLIENT_BUTTON}    xpath://button[span=" Launch FortiClient"]
${PORTAL_DOWNLOAD_FORTICLIENT_BUTTON}    xpath://button[div/div/span="Download FortiClient"]
${PORTAL_DOWNLOAD_FORTICLIENT_IOS_BUTTON}    xpath://button[div/span="iOS"]
${PORTAL_DOWNLOAD_FORTICLIENT_ANDROID_BUTTON}    xpath://button[div/span="Android"]
${PORTAL_DOWNLOAD_FORTICLIENT_WINDOWS_BUTTON}    xpath://button[div/span="Windows"]
${PORTAL_DOWNLOAD_FORTICLIENT_MAC_BUTTON}    xpath://button[div/span="Mac"]
${PORTAL_TIME}    xpath://div[@class="platform"]/div/div/div[1]
${PORTAL_DOWNLINK}    xpath://div[@class="platform"]/div/div/div[2]
${PORTAL_UPLINK}    xpath://div[@class="platform"]/div/div/div[3]
${PORTAL_VAR_BOOKMARK_BUTTON}    xpath://h2[text()="Your Bookmarks"]/following-sibling::div/div[@bookmark="bookmark"]/button[div/span="\${PLACEHOLDER}"]
${PORTAL_VAR_BOOKMARK_DELETE_BUTTON}    xpath://h2[text()="Your Bookmarks"]/following-sibling::div/div[@bookmark="bookmark"]/button[div/span="\${PLACEHOLDER}"]/following-sibling::button[@title="Delete"]
${PORTAL_VAR_PREDEFINED_BOOKMARK_BUTTON}    xpath://h2[text()="Bookmarks"]/following-sibling::div/div[@bookmark="bookmark"]/button[div/span="\${PLACEHOLDER}"]

####Fortinet Bar####
${FORTINET_BAR_IFRAME}    xpath://iframe[not(contains(@id,"fortinet-top-bar-menu"))]
${FORTINET_BAR_BOOKMARK_DIV}    xpath://*[@class="widget bookmark_widget"]
${FORTINET_BAR_MENU_IFRAME}    xpath://iframe[contains(@id,"fortinet-top-bar-menu")]
${VAR_FORTINET_BAR_BOOKMARK_LINK}    link:\${PLACEHOLDER}

####QUICK CONNECTION Page####
${QUICK_LAUNCH_BUTTON}    xpath://button[text()="Launch"]
${QUICK_CANCEL_BUTTON}    xpath://button[text()="Cancel"]

###HTTP/HTTPS###
${QUICK_HTTP_HTTPS_LABEL}    xpath://label[text()="HTTP\/HTTPS"]
${QUICK_HTTP_URL_TEXT}    id:url
${QUICK_HTTP_SSO_CREDENTIALS}    xpath://input[@id="sso-enable"]//following-sibling::label
${QUICK_HTTP_SSO_SSL_VPN_LOGIN_LABEL}    xpath://input[@id="sso-credential-login"]//following-sibling::label[@for="sso-credential-login"]
${QUICK_HTTP_SSO_SSL_VPN_LOGIN_LABEL}    xpath://input[@id="sso-credential-login"]//following-sibling::label[@for="sso-credential-alternative"]


###FTP###
${QUICK_FTP_LABEL}    xpath://label[text()="FTP"]
${QUICK_FTP_FOLDER_TEXT}    id:folder
${QUICK_FTP_SSO_CHECKBOX}    id:sso-enable
${QUICK_FTP_SSO_CHECKBOX_LABEL}    xpath://span[text()="SSO Credentials"]/following-sibling::label
${QUICK_FTP_SSO_SSLVPN_LABEL}    xpath://label[text()="SSL-VPN Login"]
${QUICK_FTP_SSO_ALTERNATIVE_LABEL}    xpath://label[text()="Alternative"]
${QUICK_FTP_SSO_USERNAME_TEXT}    id:sso-username
${QUICK_FTP_SSO_PASSWORD_TEXT}    id:sso-password
${QUICK_FTP_USERNAME_TEXT}    name:fsuser
${QUICK_FTP_PASSWORD_TEXT}    name:fspwd
${QUICK_FTP_LOGIN_BUTTON}    name:login

###SFTP 6.2 ###
${QUICK_SFTP_LABEL}    xpath://label[text()="SFTP"]
${QUICK_SFTP_FOLDER_TEXT}    id:folder
${QUICK_SFTP_SSO_CHECKBOX}    id:sso-enable
${QUICK_SFTP_SSO_CHECKBOX_LABEL}    xpath://span[text()="SSO Credentials"]/following-sibling::label
${QUICK_SFTP_SSO_SSLVPN_LABEL}    xpath://label[text()="SSL-VPN Login"]
${QUICK_SFTP_SSO_ALTERNATIVE_LABEL}    xpath://label[text()="Alternative"]
${QUICK_SFTP_SSO_USERNAME_TEXT}    id:sso-username
${QUICK_SFTP_SSO_PASSWORD_TEXT}    id:sso-password
${QUICK_SFTP_USERNAME_TEXT}    name:fsuser
${QUICK_SFTP_PASSWORD_TEXT}    name:fspwd
${QUICK_SFTP_LOGIN_BUTTON}    name:login


###SMB/CIFS###
${QUICK_SMB_CIFS_LABEL}    xpath://label[text()="SMB\/CIFS"]
${QUICK_SMB_FOLDER_TEXT}    id:folder
${QUICK_SMB_SSO_CHECKBOX}    id:sso-enable
${QUICK_SMB_SSO_CHECKBOX_LABEL}    xpath://span[text()="SSO Credentials"]/following-sibling::label
${QUICK_SMB_SSO_SSLVPN_LABEL}    xpath://label[text()="SSL-VPN Login"]
${QUICK_SMB_SSO_ALTERNATIVE_LABEL}    xpath://label[text()="Alternative"]
${QUICK_SMB_SSO_USERNAME_TEXT}    id:sso-username
${QUICK_SMB_SSO_PASSWORD_TEXT}    id:sso-password
${QUICK_SMB_USERNAME_TEXT}    name:fsuser
${QUICK_SMB_PASSWORD_TEXT}    name:fspwd
${QUICK_SMB_LOGIN_BUTTON}    name:login

###RDP###
${QUICK_RDP_LABEL}    xpath://label[text()="RDP"]
${QUICK_RDP_NAME_TEXT}    id:name
${QUICK_RDP_HOST_TEXT}    id:host
${QUICK_RDP_PORT_TEXT}    id:port
${QUICK_RDP_DESCRIPTION_TEXT}    id:description
${QUICK_RDP_CREDENTIALS_CHECKBOX}    id:sso-enable
${QUICK_RDP_CREDENTIALS_CHECKBOX_LABEL}    xpath://span[text()="Use SSL-VPN Credentials"]/following-sibling::label
${QUICK_RDP_USERNAME_TEXT}    id:logon-user
${QUICK_RDP_PASSWORD_PASSWORD}    id:logon-password
${QUICK_RDP_LAYOUT_SELECT}    xpath://label[text()="Keyboard Layout"]/following-sibling::div/select
${QUICK_RDP_SECURITY_SELECT}    xpath://label[text()="Security"]/following-sibling::div/select
${QUICK_RDP_CREDENTIALS_PAGE_HEAD}    xpath://p[text()="Enter your credentials"]
${QUICK_RDP_CREDENTIALS_PAGE_USERNAME}    id:user
${QUICK_RDP_CREDENTIALS_PAGE_PASSWORD}    id:pass
${QUICK_RDP_CREDENTIALS_PAGE_LOGIN_BUTTON}    xpath://button[text()="Login"]
###VNC###
${QUICK_VNC_LABEL}    xpath://label[text()="VNC"]
${QUICK_VNC_HOST_TEXT}    id:host
${QUICK_VNC_PORT_TEXT}    xpath://input[@type="number"]
${QUICK_VNC_PASSWORD_PASSWORD}    id:logon-password

###Citrix###
${QUICK_CITRIX_LABEL}    xpath://label[text()="Citrix"]
${QUICK_CITRIX_URL_TEXT}
${QUICK_CITRIX_CREDENTIALS_CHECKBOX}

###SSH###
${QUICK_SSH_LABEL}    xpath://label[text()="SSH"]
${QUICK_SSH_HOST_TEXT}    id:host
${QUICK_SSH_HEAD}    xpath://p[text()="Enter your credentials"]
${QUICK_SSH_USERNAME_TEXT}    id:user
${QUICK_SSH_PASSWORD_PASSWORD}    id:pass
${QUICK_SSH_LOGIN_BUTTON}    xpath://button[text()="Login"]
${QUICK_SSH_IFRAME}    xpath://iframe

###Telnet###
${QUICK_TELNET_LABEL}    xpath://label[text()="Telnet"]
${QUICK_TELNET_HOST_TEXT}    id:host
${QUICK_TELNET_IFRAME}    xpath://iframe

###Port Forward###
${QUICK_PORT_FORWARD_LABEL}    xpath://label[text()="Port Forward"]
${QUICK_PORT_FORWARD_HOST_TEXT}
${QUICK_PORT_FORWARD_REMOTE_PORT_TEXT}
${QUICK_PORT_FORWARD_LISTEN_PORT_TEXT}
${QUICK_PORT_FORWARD_STATUS_CHECKBOX}

###Ping###
${QUICK_PING_LABEL}    xpath://label[text()="Ping"]
${QUICK_PING_HOST_TEXT}    id:host
${QUICK_PING_OK_BUTTON}    xpath://button[text()="OK"]

###New Bookmark special elements
${BOOKMARK_NAME_TEXT}    id:name
${BOOKMARK_DESCRIPTION_TEXT}    id:description
${BOOKMARK_SAVE_BUTTON}    xpath://button[text()="Save"]
${BOOKMARK_DELETE_CONFIRM_H1}    xpath://h1[text()="Confirm"]
${BOOKMARK_DELETE_OK_BUTTON}    xpath://button[text()="OK"]
${BOOKMARK_DELETE_CANCEL_BUTTON}    xpath://button[text()="Cancel"]

####History
${HISTORY_SHOW_ALL_LABEL}    xpath://label[@title="Show more\/less"]
${HISTORY_TABLE}    xpath://h2[text()="History"]/following-sibling::table
${HISTORY_LINES}    xpath://h2[text()="History"]/following-sibling::table/tbody/tr

##host check ok
${HOST_CHECK_OK_BUTTON}    id:ok_button
${HOST_CHECK_WARNING}    xpath://*[text()[contains(.,"Your PC does not meet the host checking requirements set")]]

##telnet/SSH fail
${CONNECT_FAIL}    xpath://div[text()="Failed to connect"]
${CONNECT_CLOSE}    xpath://button[text()="Close Window"]