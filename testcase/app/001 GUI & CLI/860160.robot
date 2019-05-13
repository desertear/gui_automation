*** Settings ***
Documentation    Verify view/edit default global profiles and create/edit/delete custom gobal profile in global in GUI
Resource    ../app_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${app_sensor_name}    g-testgui
${list_new_global_profile}    xpath://*[@id="content"]/div[2]/table/tbody/tr[2]/td[1]

*** Test Cases ***
860160
    [Documentation]
    [Tags]    6.2.0    application    chrome    860160    high    win10    norun

    Login FortiGate
    Go to Security Profile
    Go to Application Control
    #view/edit default global profile
    click element    ${EDIT_APP_SENSOR_ADD_SIGNATURES_BUTTON}
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_SIGNATURES_1}
    click element    ${EDIT_APP_SENSOR_ADD_SIGNATURES_1}
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_SIGNATURES_USE}
    click button    ${EDIT_APP_SENSOR_ADD_SIGNATURES_USE}
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_APPLY}
    click element    ${EDIT_APP_SENSOR_APPLY}
    sleep    10
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_ENTRY_EXIST}

    click element    ${EDIT_APP_SENSOR_ADD_ENTRY_EXIST}
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_DELETE_SIGNATURES_BUTTON}
    click element    ${EDIT_APP_SENSOR_DELETE_SIGNATURES_BUTTON}
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_APPLY}
    click element    ${EDIT_APP_SENSOR_APPLY}
    sleep    10
    Wait Until Element Is Not Visible    ${EDIT_APP_SENSOR_ADD_ENTRY_EXIST}

    #create/edit/delete custom global profile
    click button    ${APP_SENSOR_NEW_BUTTON}
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_SIGNATURES_BUTTON}
    input text    ${EDIT_APP_SENSOR_NAME}    ${app_sensor_name}
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_OK}
    click element    ${EDIT_APP_SENSOR_OK}
    sleep    10
    page should contain    ${app_sensor_name}

    click element    ${EDIT_APP_SENSOR_ADD_SIGNATURES_BUTTON}
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_SIGNATURES_1}
    click element    ${EDIT_APP_SENSOR_ADD_SIGNATURES_1}
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_SIGNATURES_USE}
    click button    ${EDIT_APP_SENSOR_ADD_SIGNATURES_USE}
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_APPLY}
    click element    ${EDIT_APP_SENSOR_APPLY}
    sleep    10
    Wait Until Element Is Visible    ${EDIT_APP_SENSOR_ADD_ENTRY_EXIST}
    click button    xpath://title-content[@class="ng-scope"]//button[3]
    Wait Until Element Is Visible    xpath://button[contains(text(),"OK")]
    click element    xpath://button[contains(text(),"OK")]
    sleep    5
    Wait Until Element Is Not Visible    ${list_new_global_profile}

    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    write test result to file    ${CURDIR}