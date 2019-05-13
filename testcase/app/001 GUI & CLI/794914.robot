*** Settings ***
Documentation    verify filter works in view application list page
Resource    ../app_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${add_filter}    xpath://span[@f-lang="Add Filter"]
${filter_category}    xpath://button[contains(text(),"Category")]
${filter_category_email}    xpath://button[contains(text(),"Email")]
${filter_category_email_verify}    xpath://tbody//tr[11]//td[1]//span[1]//span[2]

*** Test Cases ***
794914
    [Documentation]    
    [Tags]    6.2.0    application    chrome    794914    high    win10    norun

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to Security Profile
    Go to Application Control
    Wait Until Element Is Visible     ${VIEW_APPLICATION_LIST}
    click element    ${VIEW_APPLICATION_LIST}
    Wait Until Element Is Visible     ${add_filter}
    click element    ${add_filter}
    Wait Until Element Is Visible     ${filter_category}
    click element    ${filter_category}
    Wait Until Element Is Visible     ${filter_category_email} 
    click element    ${filter_category_email}
    Wait Until Element Is Visible     ${filter_category_email_verify}
    SeleniumLibrary.Mouse Down    ${filter_category_email_verify}
    SeleniumLibrary.Mouse Up    ${filter_category_email_verify}
 


    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    write test result to file    ${CURDIR}