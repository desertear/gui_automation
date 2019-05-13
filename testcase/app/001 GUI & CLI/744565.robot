*** Settings ***
Documentation    Verify custom defined application signature can be create/delete in GUI
Resource    ../app_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${custom_signature_name}    AirVantage
${custom_signature_signature}    F-SBID( --attack_id 6238; --name airvantage; --dst_addr [172.16.200.216]; --dst_port 80:80; --app_cat 29; )


*** Test Cases ***
744565
    [Documentation]    
    [Tags]    6.2.0    application    chrome    744565    high    win10    norun

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to Security Profile
    Go to Application Control

    #create new defined custom signature in view app list page
    click element    ${VIEW_APPLICATION_LIST}
    Wait Until Element Is Visible    ${VIEW_APPLICATION_LIST_CREATE_NEW}
    click element    ${VIEW_APPLICATION_LIST_CREATE_NEW}
    Wait Until Element Is Visible    ${CUSTOM_SIGNATURE_EDIT_NAME}
    input text    ${CUSTOM_SIGNATURE_EDIT_NAME}    ${custom_signature_name}
    input text    ${CUSTOM_SIGNATURE_EDIT_SIGNATURE}    ${custom_signature_signature}
    click element    ${CUSTOM_SIGNATURE_EDIT_OK_BUTTON}
    sleep    3
    Wait Until Element Is Visible    xpath://span[contains(text(),"${custom_signature_name}")]

    #delete defined custom signature in view app list page
    click element    xpath://span[contains(text(),"${custom_signature_name}")]
    click element    ${VIEW_APPLICATION_LIST_DELETE}
    Wait Until Element Is Visible    ${VIEW_APPLICATION_LIST_DELETE_OK}
    click element    ${VIEW_APPLICATION_LIST_DELETE_OK}
    sleep    5
    Wait Until Element Is Not Visible    xpath://span[contains(text(),"${custom_signature_name}")]

    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    write test result to file    ${CURDIR}