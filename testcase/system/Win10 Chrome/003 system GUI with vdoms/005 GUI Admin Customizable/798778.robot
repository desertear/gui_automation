*** Settings ***
Documentation    Verify FGT can set GUI display/hide hostname on Login Page
Resource    ../../../system_resource.robot

*** Variables ***
${login_page_hostname}    xpath://div[text()="${FGT_HOSTNAME}"]
*** Test Cases ***
798778
## by default, FGT set gui-display-hostname disable, so it will not display hostname at login page. 
### When set gui-display-hostname enable, it will display hostname.
    [Tags]    v6.0    chrome   798778    Medium    win10,64bit    browsers    runable  
    go to Login page  
    ${hostname_exist_status}=    Run keyword and return status   wait until Element Is Visible   ${login_page_hostname}   
    Should Be Equal   "${hostname_exist_status}"    "False"
    #### set gui-display-hostname enable and then go to login page, hostname should be shown on the page ####
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    sleep  2s
    go to Login page  
    ${hostname_exist_status}=    Run keyword and return status   wait until Element Is Visible   ${login_page_hostname}   
    Should Be Equal   "${hostname_exist_status}"    "True"
    [Teardown]   case teardown

*** Keywords ***
case teardown
   Close All Browsers
   Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
   write test result to file    ${CURDIR}
