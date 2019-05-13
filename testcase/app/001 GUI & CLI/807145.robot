*** Settings ***
Documentation    Verify mobile category contains signature Android/iPad/iPhone
Resource    ../app_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***

${mobile}    xpath://f-category-table[@class='ng-isolate-scope']//div[7]//button[1]//div[1]//div[1]
${mobile_view}    xpath://div[@class='ng-isolate-scope pop-up-menu']//div[7]//button[1]
${mobile_include_android}    xpath://span[contains(text(),"Android")]
${mobile_include_iPad}    xpath://span[contains(text(),"Apple.iPad")]
${mobile_include_iPhone}    xpath://span[contains(text(),"Apple.iPhone")]

*** Test Cases ***
807145
    [Documentation]    
    [Tags]    6.2.0    application    chrome    807145    high    win10    norun

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to Security Profile
    Go to Application Control

    Wait Until Element Is Visible    ${mobile}
    click element    ${mobile}
    Wait Until Element Is Visible    ${mobile_view}
    click element    ${mobile_view}
    Wait Until Element Is Visible    ${mobile_include_android}
    Wait Until Element Is Visible    ${mobile_include_iPad}
    Wait Until Element Is Visible    ${mobile_include_iPhone}

    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    write test result to file    ${CURDIR}