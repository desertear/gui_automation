*** Settings ***
Documentation     This file contains common environment variables


*** Variables ***
#below value must be set manually.
${FGT_GENERATION}    Gen1
${FGT_TEST_VERSION}    6.2.0

#your LDAP account to login Oriole, you need to change it once you change your ldap password
#If it's called by Jenkins, the Account should be empty
${ORIOLE_ACCOUNT}    ivenlin
#this one can be got from "user profile" after you login Oriole
${ORIOLE_ENCODED_PASSWORD}    Vm1kTlJFTm5jMHhCUmtaS1FtZE5TRlZTTVZGQ1VVRkhVMVl4Vmxoc1pFcFZiRTVTUVVaU1ZsZG5UbEpXYkZKaw==
#Jenkins' ID and URL, you don't need to alter them.
${JENKINS_ID}    ${EMPTY}
${JENKINS_URL}    ${EMPTY}
#Keep it empty if you don't use it
${BRANCH_NAME}    ${EMPTY}

##cases execution parameters
${GLOBAL_REPORT_TO_ORIOLE}    True    #False    #True
#Timeout for case running
${FGT_MAX_RUNNING_TIME}    10 min    #5 min
#Timeout for all keywords
${FGT_KEYWORD_MAX_RUNNING_TIME}    5 min
#Timeout FGT Reboot or Upgrade
${FGT_MAX_STARTUP_TIME}    5 min

#don't change below two variables unless you know them.
${ORIOLE_SUBMIT_URL}    http://172.16.100.117/wsqadb/AutoTestResult?wsdl
${ORIOLE_TASK_PATH}    /FOS/${FGT_TEST_VERSION}/Regression/
#set the report directory where you want to store all reports(.txt and .json)
${REPORT_FILE_TXT_PATH}    ${CURDIR}${/}..${/}result
${REPORT_FILE_JSON_PATH}    ${REPORT_FILE_TXT_PATH}
#Sikuli image directory
${SIKULI_IMAGE_DIR}     ${CURDIR}${/}image
#ImageMagick Dir
${IMAGEMAGICK_DIR}    C:${/}"Program Files"${/}ImageMagick-7.0.8-Q16${/}magick.exe

#Selenium global configuration
${SCREEN_SIZE_WIDTH}    1920
${SCREEN_SIZE_HEIGTH}    1080
${SELENIUM_IMPLICIT_WAIT}    0
${SELENIUM_TIMEOUT}    10    #5
${SELENIUM_SPEED}    0.1
${SELENIUM_SCREENSHOT_DIR}    ${CURDIR}${/}..${/}screenshot


##variables for FortiGate GUI
${FGT_GUI_USERNAME}    admin
${FGT_GUI_PASSWORD}    ${EMPTY}
${FGT_HTTP_PROTOCOL}    https
${FGT_IP_ADDRESS}   10.1.100.1
${FGT_IP_ADDRESS_V6}   2000:10:1:100::1
${FGT_PORT}    443
${FGT_URL}    ${FGT_HTTP_PROTOCOL}://${FGT_IP_ADDRESS}:${FGT_PORT}
${FGT_URL_IPV6}    ${FGT_HTTP_PROTOCOL}://[${FGT_IP_ADDRESS_V6}]:${FGT_PORT}
#$FGT_BROWSER} can be chrome, firefox and edge. browser names are case-insensitive and some browsers have multiple supported names
${FGT_BROWSER}    chrome
#{FGT_REMOTE_URL} is used for Selenium Grid
${FGT_REMOTE_URL}    False
#FGT_RUNNING_PLATFORM should be one of {WINDOWS, XP, VISTA, WIN8_1, WIN10, MAC, LINUX, UNIX, ANDROID, ANY}
${FGT_RUNNING_PLATFORM}    ANY
#format of ${FGT_DESIRED_CAPABILITIES} can be platform:${FGT_RUNNING_PLATFORM},browserName:${FGT_BROWSER}
${FGT_DESIRED_CAPABILITIES}    ${EMPTY}
${FGT_FF_PROFILE_DIR}    None

##CLI Configuration(Telnet or SSH)
${FGT_CLI_USERNAME}    admin
${FGT_CLI_PASSWORD}    ${EMPTY}
${FGT_CLI_PROMPT}    ${FGT_CLI_NEWLINE}.*\\s\#|\\(y/n\\)|${FGT_CLI_NEWLINE}>|login:|Password:|.*\\(Press 'a' to accept\\):|password:|--More--|again:
${FGT_CLI_NEWLINE}    \r\n   
${FGT_CLI_FILE_DIR}    ${CURDIR}${/}cli
${TFTP_IMAGE_SERVER_IP}    172.16.200.55
${FGT_CLI_LOG_DIR}    ${CURDIR}${/}..${/}log

#FGT Terminal Server configuration
${TERMINAL_SERVER_IP}    172.16.106.179
${TERMINAL_SERVER_PORT}    23
${FGT_TELNET_PORT_ON_TERMINAL_SERVER}    2016
${TERMINAL_SERVER_USER_PASSWORD}    cisco
${TERMINAL_SERVER_ADMIN_PASSWORD}    cisco
${TERMINAL_SERVER_PROMPT}    .*\#|\>|Password:
${TERMINAL_SERVER_NEWLINE}    \r\n
#FGT CLI Via Telnet Connection
${FGT_CLI_FGT_TELNET_CONNECTION_IP}    10.1.100.1
${FGT_CLI_TELNET_PORT}    23
${FGT_CLI_TELNET_CONNECTION_TIMEOUT}    20    #10

#FGT CLI Via SSH Connection
${FGT_CLI_SSH_HOST}    10.1.100.1
${FGT_CLI_SSH_PORT}    22
${FGT_CLI_SSH_TIMEOUT}    3
${FGT_CLI_SSH_PATH_SEPARATOR}    /
${FGT_CLI_SSH_ENCODING}    UTF-8
${FGT_CLI_SSH_TERM_TYPE}    vt100
${FGT_CLI_SSH_TERM_WIDTH}    80
${FGT_CLI_SSH_TERM_HEIGHT}    24

#Settings of FGT mode. If you don't need to switch FGT mode, don't update them.
${FGT_FIPS_CC_MODE}    False
${FGT_FIPS_CC_PASSWORD}    Zj#12345
#SSH conection settings for Linux PC(i.e. PC01-PC05)
${PC_LINUX_SSH_PORT}    22
${PC_LINUX_SSH_NEWLINE}    \n
${PC_LINUX_SSH_PROMPT}    ~[\#\$]
${PC_LINUX_SSH_TIMEOUT}    3
${PC_LINUX_SSH_LOG_LEVEL}    INFO
${PC_LINUX_SSH_LOG_FILE}    ${CURDIR}${/}..${/}log${/}pc_ssh.log
${PC_LINUX_SSH_PATH_SEPARATOR}    /
${PC_LINUX_SSH_ENCODING}    UTF-8
${PC_LINUX_SSH_TERM_TYPE}    vt100
${PC_LINUX_SSH_TERM_WIDTH}    80
${PC_LINUX_SSH_TERM_HEIGHT}    24

#Below Variables will be set to correct and be set as global variable automatically, you don't need to update them.
${FGT_SN}    FWF60E4Q16024378
${FGT_HW_TYPE}    FortiWiFi60E
${FGT_AV_DEF}    1.00123
${FGT_AV_ENG}    6.00006
${FGT_BIOS}    05000004
${FGT_BUILD}    0112
${FGT_IPS_DEF}    6.00741
${FGT_IPS_ENG}    4.00016
${FGT_TYPE}    FWF_60E
${FGT_VDOM_STATUS}    False
${FGT_ASIC_VERSION}    CP9