*** Settings ***
Documentation    GUI Automation for FortiGate
Resource    ./common_resource.robot
Suite Setup    Setup testing environment
Suite teardown    clear test data
Test Timeout    ${FGT_MAX_RUNNING_TIME}
Force Tags    FortiGate GUI Automation
*** Variables ***

*** Keywords ***
Setup testing environment
    #set global variable ${OS_TYPE} according to OS type of running host.
    Current Operating System type
    #configure selenium parameters ${SELENIUM_IMPLICIT_WAIT}, ${SELENIUM_TIMEOUT}, ${SELENIUM_SCREENSHOT_DIR} and  ${SELENIUM_SPEED}.
    config selenium
    #define global variable ${RUNNING_TIME}
    Define Running Time as global variable
    #define global variable ${RUNNING_TIME_JSON}
    Define Running Time FOR JSON FILE as global variable
    #Set  ${FGT_SN}, ${FGT_HW_TYPE}, ${FGT_AV_DEF}, ${FGT_AV_ENG}, ${FGT_BIOS}, 
    #${FGT_BUILD}, ${FGT_IPS_DEF}, ${FGT_IPS_ENG}, ${FGT_TYPE},  ${FGT_VDOM_STATUS} and ${FGT_ASIC_VERSION} as global variables
    Get FortiGate hardware and software info
    #init JSON file which will be submitted to Oriole
    init json file

config selenium
    get all selenium config
    Set Selenium Implicit Wait    ${SELENIUM_IMPLICIT_WAIT}
    Set Selenium Timeout    ${SELENIUM_TIMEOUT}
    Set Screenshot Directory    ${SELENIUM_SCREENSHOT_DIR}
    Set Selenium Speed    ${SELENIUM_SPEED}
    get all selenium config

clear test data
    run Keyword and ignore error    close all browsers
    run Keyword and ignore error    run Keyword if    "${GLOBAL_REPORT_TO_ORIOLE}"=="True"    submit test report to oriole

submit test report to oriole
    Define Running Time as global variable
    ${result}=    submit_to_oriole    ${REPORT_FILE_JSON_PATH}${/}test_report_${RUNNING_TIME}.json
    should be equal    ${result}    Success
    