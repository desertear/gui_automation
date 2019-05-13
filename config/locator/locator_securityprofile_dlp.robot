*** Settings ***
Documentation     This file contains all locator variables on FortiGate DLP

*** Variables ***
##Go to VDOM move to  Security Porfile
####Security Profile####
${SECURITY_PROFILE_ENTRY}    xpath://span[contains(text(),"Security Profiles")]
${DLP_ENTRY}    xpath://span[contains(text(),"Data Leak Prevention")]                                                                                   

######Edit DLP Sensor######
${CREATE_DLP_SENSOR}    xpath://span[contains(text(),"Create New")]
${EDIT_DLP_SENSOR_NAME}    xpath://input[@id="name"]
${EDIT_DLP_SENSOR}    xpath://div[@class="ng-isolate-scope menu-bar"]//span[@class="ng-binding ng-scope"][contains(text(),"Edit")]
${DELETE_DLP_SENSOR}    xpath://div[@class="ng-isolate-scope menu-bar"]//span[@class="ng-binding ng-scope"][contains(text(),"Delete")]
${DELETE_DLP_CONFIRM}    xpath://button[contains(text(),"OK")]
${DLP_FILTER_ENTRY}    xpath://td[@class="seqid"]

######Filter Page######
${ADD_DLP_FILTER}    xpath://span[contains(text(),"Add Filter")]
${EDIT_DLP_FILTER}    xpath://div[@class="ng-isolate-scope menu-bar"]//span[@class="ng-binding ng-scope"][contains(text(),"Edit Filter")]
${DELETE_DLP_FILTER}    xpath://div[@class="ng-isolate-scope menu-bar"]//span[@class="ng-binding ng-scope"][contains(text(),"Delete")]
${FILTER_TYPE_FILE}    xpath://label[@for="type-file"]
${FILTER_TYPE_MESSAGE}    xpath://label[@for="type-message"]
${FILTER_ACTION}    xpath://select[@id="action"]
${FILTER_ACTION_ALLOW}    xpath://option[@value="allow"]
${FILTER_ACTION_LOG}    xpath://option[@value="log-only"]
${FILTER_ACTION_BLOCK}    xpath://option[@value="block"]
${FILTER_ACTION_QUARANTINE}    xpath://option[@value="quarantine-ip"]
${QUARANTINE_FIELD}    xpath://input[@id="expiry"]   
${CREDIT_CARD}    xpath:////option[@value="credit-card"]
${SSN}    xpath://option[@value="ssn"]
${SELECT_CONTAINING}    xpath://input[@id="filter-contain"]
${SELECT_FILESIZE}    xpath://input[@id="filter-file-size"]
${FILESIZE_FIELD}    xpath://input[@id="file-size"]
${SELECT_FILETYPE}    xpath://input[@id="filter-file-type"]
${FILETYPE_SELECTION_PANE}    xpath://div[@class="selection-pane"]
${ADD_FILETYPE}    xpath://div[@id="file-types-type"]//div//div[@class="add-placeholder"]
${FILETYPE_SEARCH}   xpath://input[@placeholder="Search"]
${FILETYPE_SELECT}    xpath://div[@class="entry pseudo-focused"]
${ADD_FILEPATTERN}    xpath://div[@class="select-widget"]//div[@class="add-placeholder"]
${FILE_PATTERN_FIELD}    xpath://input[@placeholder="Search"]
${FILE_PATTERN_CREATE}    xpath://span[@class="create-new-label"]
${FILE_PATTERN_SELECT}    xpath://div[@class="entry new-entry swing-once-subtle animated pseudo-focused"]
${SELECT_REGEXP}    xpath://input[@id="filter-regex"]
${REGEXP_FIELD}    xpath://input[@id="regexp"]
${SELECT_ENCRYPTED}    xpath://input[@id="filter-encrypted"]
${SAVE_FILTER}    xpath://button[contains(text(),"OK")]
${PROTO_HTTP_POST}    xpath://input[@id="http-post"]   
${PROTO_HTTP_GET}    xpath://input[@id="http-get"]     
${PROTO_SMTP}    xpath://input[@id="smtp"]     
${PROTO_POP3}    xpath://input[@id="pop3"]      
${PROTO_IMAP}    xpath://input[@id="imap"]     
${PROTO_MAPI}    xpath://input[@id="mapi"] 
${PROTO_FTP}    xpath://input[@id="ftp"] 
${PROTO_NNTP}    xpath://input[@id="nntp"] 


#####IPv4 Policy#####
${IPV4_BY_SEQUENCE}    xpath://span[contains(text(),"By Sequence")]
${IPV4_DLP_ENABLE}    xpath://span[@class="toggle-label"]//label[@for="chk-dlp-sensor-dialog"]
${IPV4_DLP_DROPDOWN}    xpath://div[@class="ng-scope"]//f-field[@class="ng-scope ng-isolate-scope"]//span[@class="entry-value"]
${IPV4_DLP_CREATE}    xpath://span[@class="create-new-label"]
${IPV4_DLP_SEARCH}    xpath://input[@placeholder="Search"]
${IPV4_DLP_NEWENTRY}    //div[@class="entry new-entry swing-once-subtle animated pseudo-focused"]
${IPV4_OK}    xpath://button[@type="submit"]
${IPV4_EDIT}    xpath://div[@class="ng-scope"]//f-field[@class="ng-scope ng-isolate-scope"]//button[@title="Edit entry"]
${IPV4_DLP_FRAME}    xpath://iframe[contains(@name,"slide-iframe") and @class="slide-iframe"]
###### For Reference ######

# Possible Services
#xpath://td[@class="disp_proto"][contains(text(),"SMTP, POP3, IMAP, HTTP-GET, HTTP-POST, FTP")]

# Possible Actions
#xpath://td[@class="disp_action"][contains(text(),"Quarantine IP Address")]  
#xpath://td[@class="disp_action"][contains(text(),"Block")]  
#xpath://td[@class="disp_action"][contains(text(),"Log Only")]  
#xpath://td[@class="disp_action"][contains(text(),"Allow")] 

# Possible Type
#xpath://td[@class="disp_filter"][contains(text(),"Specified File Types")]
#xpath://td[@class="disp_filter"][contains(text(),"Regular Expression matches: ${dlp_regexp}")]
#xpath://td[@class="disp_filter"][contains(text(),"Containing Credit Card")]
#xpath://td[@class="disp_filter"][contains(text(),"Containing SSN")]
#xpath://td[@class="disp_filter"][contains(text(),"File Size >= ${dlp_file_size} KB")]
#xpath://td[@class="disp_filter"][contains(text(),"Encrypted")]

# Possible Archive
#xpath://td[@class="disp_archive"][contains(text(),"Disable")]
#xpath://td[@class="disp_archive"][contains(text(),"Enable")]
