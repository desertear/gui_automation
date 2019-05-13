*** Settings ***
Documentation    Verify new application entry has a default settings with blocking proxy and P2P in GUI
Resource    ../app_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${app_sensor_name}    testgui
${category_proxy}    xpath://div[@class='categories']//div[10]//button[1]//div[1]//div[1]//f-icon[1]
${category_P2P}    xpath://div[@class='categories']//div[9]//button[1]//div[1]//div[1]//f-icon[1]

*** Test Cases ***
808496
    [Documentation]    
    [Tags]    6.2.0    application    chrome    808496    high    win10    norun

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to Security Profile
    Go to Application Control
    click button    ${APP_SENSOR_NEW_BUTTON}
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_SIGNATURES_BUTTON}
    input text    ${EDIT_APP_SENSOR_NAME}    ${app_sensor_name}
    
    #verify category proxy/p2p has default block action
    Wait Until Element Is Visible    ${category_proxy}[@class="fa-denied"]
    Wait Until Element Is Visible    ${category_P2P}[@class="fa-denied"]
 

    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    write test result to file    ${CURDIR}