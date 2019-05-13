*** Variables ***
${FORTIWIKI_MAINPAGE_H1}    xpath://h1[normalize-space()="Welcome to FortiWiki!"]
${ORIOLE_LOGIN_PAGE_H2}    id:id_login_title
${FORTINET_MAINPAGE}    xpath://a[normalize-space()="Customers"]
${FMG_LOGIN_PAGE_HEAD}    xpath://span[contains(text(),"FortiManager")]
${FMG_LOGIN_PAGE_USERNAME}    id:username
${FMG_LOGIN_PAGE_PASSWORD}    id:password
${FMG_LOGIN_PAGE_LOGIN}    id:login
${FMG_SELECT_ROOT_ADOM}    id:id_adom_root
${FMG_LOGIN_WARNING_HEAD}    xpath://h3[text()="Change Password"]
${FMG_HOME_DEVICE_MANAGER}    xpath://div[text()="Device Manager"]
${FAZ_LOGIN_PAGE_HEAD}    xpath://span[contains(text(),"FortiAnalyzer")]
${FAZ_LOGIN_PAGE_USERNAME}    id:username
${FAZ_LOGIN_PAGE_PASSWORD}    id:password
${FAZ_LOGIN_PAGE_LOGIN}    id:login
${FAZ_SELECT_ROOT_ADOM}    id:id_adom_root
${FAZ_HOME_DEVICE_MANAGER}    xpath://div[text()="Device Manager"]
${FAC_WARNING_CONTENT}    xpath://pre[contains(.,"PRE AUTHENTICATION WARNING")]
${FAC_WARNING_ACCEPT}    xpath://input[@value="Accept"]
${FAC_HEAD}    xpath://a[text()="FortiAuthenticator"]
${FAC_LOGIN_HEAD}    xpath://h2[text()="Login"]
${FAC_LOGIN_USERNAME}    id:id_username
${FAC_LOGIN_PASSWORD}    id:id_password
${FAC_LOGIN_LOGIN}    xpath://input[@value="Login"]
${ORIOLE_HOME_TASK}    xpath://span[contains(text(),"Welcome to Oriole")]
${FORTICARE_HOME_NEW_TICKET}    xpath://a[contains(text(),"New Internal Ticket")]
${IPORTAL_LOGIN_HEAD}    xpath://span[normalize-space(.)="Access Manager"]