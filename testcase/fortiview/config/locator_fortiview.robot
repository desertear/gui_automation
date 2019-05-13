*** Settings ***
Documentation     This file contains all locator variables on FORTIVIEW GUI v6.2

*** Variables ***
#Format Definition: ${LOCATION_FRAME-NAME_FRAME-TYPE}###
####MAIN MENU ITEMS####
${FORTIVIEW}    xpath://span[contains(text(),'FortiView')]
${LANDMZ_SOURCES}    xpath:(//span[contains(@class,'ng-binding')][contains(text(),'Sources')])[1]
${LANDMZ_DESTINATIONS}    xpath://span[contains(@class,'ng-binding')][contains(text(),'Destinations')]
${LANDMZ_APPLICATIONS}    xpath://span[contains(@class,'ng-binding')][(text()='Applications')]
${LANDMZ_CLOUDAPPLICATIONS}    xpath://span[contains(@class,'ng-binding')][contains(text(),'Cloud Applications')]
${LANDMZ_WEBSITES}    xpath://span[contains(@class,'ng-binding')][contains(text(),'Web Sites')]
${LANDMZ_THREATS}    xpath://span[contains(@class,'ng-binding')][contains(text(),'Threats')][1]
${LANDMZ_TRAFFICSHAPING}    xpath://span[contains(@class,'ng-binding')][(text()='Traffic Shaping')][1]

${FROMWAN_SOURCES}    xpath:(//span[contains(@class,'ng-binding')][contains(text(),'Sources')])[2]
${FROMWAN_SERVERS}    xpath://span[contains(@class,'ng-binding')][(text()='Servers')]
#${FROMWAN_THREATS}    xpath://span[contains(@class,'ng-binding')][contains(text(),'Threats')][2]
${FROMWAN_THREATS}    xpath://li[div/div/a/span="Servers"]/following-sibling::li/div/div/a/span[text()="Threats"]

${ALLSEGMENTS_SYSTEMEVENTS}    xpath://span[contains(@class,'ng-binding')][(text()='System Events')][1]
${ALLSEGMENTS_ENDPOINTVUL}    xpath://span[contains(@class,'ng-binding')][contains(text(),'Endpoint Vulnerability')]
${ALLSEGMENTS_THREATMAP}    xpath://span[contains(@class,'ng-binding')][contains(text(),'Threat Map')]
${ALLSEGMENTS_POLICIES}    xpath://span[contains(@class,'ng-binding')][(text()='Policies')]
${ALLSEGMENTS_INTERFACES}    xpath://span[contains(@class,'ng-binding')][(text()='Interfaces')][1]
${ALLSEGMENTS_ALLSESSIONS}    xpath://span[contains(@class,'ng-binding')][contains(text(),'All Sessions')]

${FIRST_ENTRY}    xpath://span[contains(text(),'${PC1_VLAN20_IP}')]
#${FIRST_ENTRY_DIFFXPATH}    //td[contains(text(),'${PC1_VLAN20_IP}')]
${FORTIVIEW_TIME_SELECTION_BUTTON}    xpath:(//button[normalize-space(./div/span)="now"])[1]
${FORTIVIEW_TIME_SELECTION_BUTTON_5 MINUTES}    xpath:(//button[normalize-space(./div/span)="5 minutes"])[1]
#${FORTIVIEW_DRILLDOWN_BACKBUTTON}    xpath://div[@title='Return']//button[@type='button']
${FORTIVIEW_DRILLDOWN_BACKBUTTON}    xpath://f-icon[@class='fa-arrow-left ng-scope']

${FORTIVIEW_RIGHTCLICK_DRILLDOWN_BUTTON}    xpath:(//button[normalize-space(./div/span)="Drill Down to Details"])
${FORTIVIEW_1STLEVEL_FIRSTENTRY}    xpath://div[@class='row-cell first-cell']
#$x(//button[normalize-space(./div/span)="now"])[1]
#/html/body/header/div[2]/div[2]/span
#${FORTIVIEW_TEXT_SERIALNUMBER}    xpath://td[contains(text(),'${FGT_SN}')]
#${FORTIVIEW_TEXT_SERIALNUMBER}    xpath://td[contains(text(),'${PC1_VLAN20_IP}')]

${FORTIVIEW_1STLEVEL_HOSTIP}    xpath://span[contains(text(),'${PC1_VLAN20_IP}')]
${FORTIVIEW_1STLEVEL_BYTES}    xpath://td[contains(text(),'Bytes')]
${FORTIVIEW_1STLEVEL_SESSIONS}    xpath://td[contains(text(),'Sessions')]
${FORTIVIEW_1STLEVEL_AVATARICON}    xpath://f-icon[@class='icon-xxxl fa-user-unknown']


${FORTIVIEW_1STLEVEL_APPLICATIONS}    xpath://span[contains(@class,'ng-binding ng-scope')][contains(text(),'Applications')]
${FORTIVIEW_1STLEVEL_DESTINATIONS}    xpath://span[contains(@class,'ng-binding ng-scope')][contains(text(),'Destinations')]
${FORTIVIEW_1STLEVEL_THREATS}    xpath://span[contains(@class,'ng-binding ng-scope')][contains(text(),'Threats')]
${FORTIVIEW_1STLEVEL_WEBSITES}    xpath://span[contains(@class,'ng-binding ng-scope')][contains(text(),'Web Sites')]
${FORTIVIEW_1STLEVEL_WEBCATEGORIES}    xpath://span[contains(@class,'ng-binding ng-scope')][contains(text(),'Web Categories')]
${FORTIVIEW_1STLEVEL_SEARCHPHRASES}    xpath://span[contains(@class,'ng-binding ng-scope')][contains(text(),'Search Phrases')]
${FORTIVIEW_1STLEVEL_POLICIES}    xpath://span[contains(@class,'ng-binding ng-scope')][contains(text(),'Policies')]
${FORTIVIEW_1STLEVEL_SESSIONS}    xpath://span[contains(@class,'ng-binding ng-scope')][contains(text(),'Sessions')]

${FORTIVIEW_1STLEVEL_TABLE_APPLICATIONS}    xpath://span[contains(@class,'header-cell-label')][contains(text(),'Application')]
${FORTIVIEW_1STLEVEL_TABLE_CATEGORY}    xpath://span[contains(@class,'header-cell-label')][contains(text(),'Category')]
${FORTIVIEW_1STLEVEL_TABLE_RISK}    xpath://span[contains(@class,'header-cell-label')][contains(text(),'Risk')]
${FORTIVIEW_1STLEVEL_TABLE_BYTES}    xpath://span[contains(@class,'header-cell-label')][contains(text(),'Bytes')]
${FORTIVIEW_1STLEVEL_TABLE_SESSIONS}    xpath://span[contains(@class,'header-cell-label')][contains(text(),'Sessions')]
${FORTIVIEW_1STLEVEL_TABLE_BANDWIDTH}    xpath://span[contains(@class,'header-cell-label')][contains(text(),'Bandwidth')]
${FORTIVIEW_1STLEVEL_TABLE_SOURCE}    xpath://span[contains(@class,'header-cell-label')][contains(text(),'Source')]
${FORTIVIEW_1STLEVEL_TABLE_DEVICE}    xpath://span[contains(@class,'header-cell-label')][contains(text(),'Device')]
${FORTIVIEW_1STLEVEL_TABLE_DESTINATION}    xpath://span[contains(@class,'header-cell-label')][contains(text(),'Destination')]
${FORTIVIEW_1STLEVEL_TABLE_PROTOCOL}    xpath://span[contains(@class,'header-cell-label')][contains(text(),'Protocol')]
${FORTIVIEW_1STLEVEL_TABLE_SOURCEPORT}    xpath://span[contains(@class,'header-cell-label')][contains(text(),'Source Port')]
${FORTIVIEW_1STLEVEL_TABLE_DESTINATIONPORT}    xpath://span[contains(@class,'header-cell-label')][contains(text(),'Destination Port')]
${FORTIVIEW_1STLEVEL_TABLE_DURATION}    xpath://span[contains(@class,'header-cell-label')][contains(text(),'Duration (seconds)')]
${FORTIVIEW_1STLEVEL_TABLE_DATETIME}    xpath://div[contains(@class,'ui-resizable')][contains(text(),'Date/Time')]
${FORTIVIEW_1STLEVEL_TABLE_APPLICATIONNAME}    xpath://div[contains(@class,'ui-resizable')][contains(text(),'Application Name')]
${FORTIVIEW_1STLEVEL_TABLE_SECURITYACTION}    xpath://div[contains(@class,'ui-resizable')][contains(text(),'Security Action')]
${FORTIVIEW_1STLEVEL_TABLE_SECURITYEVENTS}    xpath://div[contains(@class,'ui-resizable')][contains(text(),'Security Events')]
${FORTIVIEW_1STLEVEL_TABLE_SENTRECEIVED}    xpath://div[contains(@class,'ui-resizable')][contains(text(),'Sent / Received')]
${FORTIVIEW_1STLEVEL_TABLE_ICON_NUMBER}    xpath://div[contains(@class,'ui-resizable')][contains(text(),'#')]
${FORTIVIEW_1STLEVEL_TABLE_ICON_PAPERCLIP}    xpath://f-icon[@class='fa-paperclip']
${FORTIVIEW_1STLEVEL_TABLE_SESSIONS_SOURCE}    xpath://div[contains(@class,'ui-resizable')][contains(text(),'Source')]
${FORTIVIEW_1STLEVEL_TABLE_SESSIONS_DESTINATION}    xpath://div[contains(@class,'ui-resizable')][contains(text(),'Destination')]









#${FORTIVIEW_TEXT_HOSTIP}    xpath://td[contains(text(),'${PC1_VLAN20_IP}')]

#${FORTIVIEW_TEXT_SERIALNUMBER}    xpath://td[contains(text(),'${PC1_VLAN20_IP}')]

#${FORTIVIEW_TEXT_SERIALNUMBER}    xpath://td[contains(text(),'${PC1_VLAN20_IP}')]


${FORTIVIEW_TEXT_DESTINATIONINT}    xpath://span[contains(text(),'Destination Interfaces')]

${FORTIVIEW_TEXT_SOURCEIP}    xpath://td[contains(text(),'${PC1_VLAN20_IP}')]
${FORTIVIEW_TEXT_DSTIP}    xpath://td[contains(text(),'${GENERAL_SERVER}')]



#<td class="srcaddr address" selector="srcaddr">10.1.100.11</td>
#//*[@id="navbar-view-section"]/div/div/div/div[3]/div/div/div[1]/div[2]/table/tbody/tr/td[1]

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