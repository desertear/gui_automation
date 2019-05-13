*** Settings ***
Documentation    APP profile refinement GUI (pmdb2623:remove category:industrial, web.others, all other known options; remove shaper/reset action in dropdown menu)
Resource    ../app_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${category_industrial}    xpath://span[contains(text(),"Industrial")]
${category_web.others}    xpath://span[contains(text(),"Web.Others")]
${category_unknown_applications}    xpath://span[contains(text(),"Unknown Applications")]
${category_all_other_known}    xpath://span[contains(text(),"All Other Known")]
${category_action_reset}    xpath://div[@class='ng-isolate-scope pop-up-menu']//span[@class='ng-binding ng-scope'][contains(text(),"Reset")]
${category_action_traffic_shaping}    xpath://div[@class='ng-isolate-scope pop-up-menu']//span[@class='ng-binding ng-scope'][contains(text(),"Traffic Shaping")]

*** Test Cases ***
797224
    [Documentation]    
    [Tags]    6.2.0    application    chrome    797224    high    win10    norun

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to Security Profile
    Go to Application Control
    Wait Until Element Is Visible     ${VIEW_APPLICATION_LIST}
    Wait Until Element Is Visible     ${category_unknown_applications}
    Wait Until Element Is Not Visible     ${category_industrial}
    Wait Until Element Is Not Visible     ${category_web.others}
    Wait Until Element Is Not Visible     ${category_all_other_known}
    Wait Until Element Is Visible     ${EDIT_APP_SENSOR_CATEGORY_GENERAL_INTEREST}
    click element    ${EDIT_APP_SENSOR_CATEGORY_GENERAL_INTEREST}
    Wait Until Element Is Not Visible     ${category_action_reset}
    Wait Until Element Is Not Visible     ${category_action_traffic_shaping}
    click element    ${EDIT_APP_SENSOR_CATEGORY_GENERAL_INTEREST}
    Go to Application Control
    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    write test result to file    ${CURDIR}