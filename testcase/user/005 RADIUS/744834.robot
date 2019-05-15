*** Settings ***
Documentation    Verify radius primary server and secondary server can be switched (mantis 0193211)
Resource    ../user_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${radius_name}    ${USER_RADIUS1_NAME}
${radius_server}    ${USER_RADIUS1_SERVER}
${radius_secret}    ${USER_RADIUS1_SECRET}
${radius_fake_server}    2.2.2.2
${radius_fake_secret}    654321
*** Test Cases ***
744834
    [Tags]    v6.2    chrome    744834    high
    Login FortiGate
    Create New RADIUS Server    ${radius_name}    Default    ${EMPTY}    ${False}    ${radius_server}    ${radius_secret}    ${radius_fake_server}    ${radius_fake_secret}
    switch Radius between primary setting and secondary setting    ${radius_name}
    Delete RADIUS Server  ${radius_name}
    Logout FortiGate
    Close Browser
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    write test result to file    ${CURDIR}


switch Radius between primary setting and secondary setting
    [Arguments]    ${radius_server_name}
    Go to User and Device
    Go to Radius Servers
    ${status}=    If Radius Server exists    ${radius_server_name}
    Should be True    ${status}
    ${locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_RADIUS_SERVERS_IN_TABLE}    ${radius_server_name}
    click element    ${locator}
    Click button    ${USER_RADIUS_SERVERS_EDIT_BUTTON}
    Wait Until Element Is Visible    ${USER_RADIUS_SERVERS_EDIT_H1}
    ${primary_ip}=    Get Element Attribute    ${USER_RADIUS_SERVERS_PRIMARY_IP_INPUT}    value
    ${primary_secret}=    Get Element Attribute    ${USER_RADIUS_SERVERS_PRIMARY_SECRET_INPUT}    value
    ${secondary_ip}=    Get Element Attribute    ${USER_RADIUS_SERVERS_SECONDARY_IP_INPUT}    value
    ${secondary_secret}=    Get Element Attribute    ${USER_RADIUS_SERVERS_SECONDARY_SECRET_INPUT}    value
    set Radius primary server ip    ${secondary_ip}
    set Radius primary server secret    ${secondary_secret}
    set Radius Secondary server ip    ${primary_ip}
    set Radius Secondary server secret    ${primary_secret}    
    click button    ${USER_RADIUS_SERVERS_USER_OK}
    #verify if the user is updated successfully
    Wait Until Element Is Visible    ${USER_RADIUS_SERVERS_CREATE_NEW}