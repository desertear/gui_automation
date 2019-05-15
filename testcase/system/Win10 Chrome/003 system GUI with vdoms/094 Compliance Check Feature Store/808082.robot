*** Settings ***
Documentation    Verify admin can run Compliance Check in NAT/TP vdom manually on GUI, and a log is generated when completed.
...              Fail with bug #534984   bug fixed in B0818 ECO#137494
Resource    ../../../system_resource.robot

*** Variables ***

*** Test Cases ***
808082
    [Tags]    Fixedcase!   v6.0    chrome   808082    Critical    win10,64bit    browsers    runable   
    Login FortiGate     
    Go To Vdom     ${SYSTEM_TEST_VDOM_NAME_1}   
    Go to system
    go to system_advanced
    sleep   2
    ${status}=    run keyword and return status    checkbox should be selected    ${SYSTEM_ADVANCED_COMPLIANCE_CHECKBOX}
    run keyword if    "${status}"=="False"     wait and click    ${SYSTEM_ADVANCED_COMPLIANCE_BUTTON}
    ${status}=    run keyword and return status    checkbox should be selected    ${SYSTEM_ADVANCED_COMPLIANCE_CHKENABLE_CHECKBOX}
    run keyword if    "${status}"=="False"     wait and click    ${SYSTEM_ADVANCED_COMPLIANCE_CHKENABLE_LABEL}
    wait and click   ${SUBMIT_APPLY_BUTTON}
    ${status}=    run keyword and return status    checkbox should be selected    ${SYSTEM_ADVANCED_COMPLIANCE_CHECKBOX}
    run keyword if    "${status}"=="False"     wait and click    ${SYSTEM_ADVANCED_COMPLIANCE_BUTTON}
    wait and click    ${SYSTEM_ADVANCED_COMPLIANCE_RUNNOW}
    sleep   2
    wait and click    ${SYSTEM_ADVANCED_COMPLIANCE_VIEW_RESULT_BUTTON}
    sleep   20
    Go to system
    Go to Log and Report
    Go to Log and Report_compliance
    Wait Until Element Is Visible     ${SYSTEM_ADVANCED_COMPLIANCE_EVENTS_COUNT_SPAN}
    ${num}=    get text    ${SYSTEM_ADVANCED_COMPLIANCE_EVENTS_COUNT_SPAN}
    ${status}=    Evaluate   ${num}>0
    should be equal    "${status}"    "True"


    ####   TEST IN TP MODE ####
    Go To Vdom     ${SYSTEM_TEST_VDOM_NAME_TP}    ${SYSTEM_TEST_VDOM_NAME_1}
    Go to system
    go to system_advanced
    sleep   2
    ${status}=    run keyword and return status    checkbox should be selected    ${SYSTEM_ADVANCED_COMPLIANCE_CHECKBOX}
    run keyword if    "${status}"=="False"     wait and click    ${SYSTEM_ADVANCED_COMPLIANCE_BUTTON}
    ${status}=    run keyword and return status    checkbox should be selected    ${SYSTEM_ADVANCED_COMPLIANCE_CHKENABLE_CHECKBOX}
    run keyword if    "${status}"=="False"     wait and click    ${SYSTEM_ADVANCED_COMPLIANCE_CHKENABLE_LABEL}
    wait and click   ${SUBMIT_APPLY_BUTTON}
    ${status}=    run keyword and return status    checkbox should be selected    ${SYSTEM_ADVANCED_COMPLIANCE_CHECKBOX}
    run keyword if    "${status}"=="False"     wait and click    ${SYSTEM_ADVANCED_COMPLIANCE_BUTTON}
    wait and click    ${SYSTEM_ADVANCED_COMPLIANCE_RUNNOW}
    sleep   2
    wait and click    ${SYSTEM_ADVANCED_COMPLIANCE_VIEW_RESULT_BUTTON}
    sleep   20
    ## check if event exist on the log page ##
    Go to system
    Go to Log and Report
    Go to Log and Report_compliance
    Wait Until Element Is Visible     ${SYSTEM_ADVANCED_COMPLIANCE_EVENTS_FIRST}
    
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Close All Browsers
    write test result to file    ${CURDIR}
