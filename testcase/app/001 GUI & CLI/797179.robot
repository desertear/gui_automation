*** Settings ***
Documentation    Verify traffic-shaping-policy can be created which included app/app_category/url_category
Resource    ../app_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${shaping_policy_name}    testgui
${application_input}    xpath://*[@id="ng-base"]/form/div[2]/div[2]/section[2]/f-field[5]/div/field-value/div[1]/div/div[2]
${url_category_input}    xpath://*[@id="ng-base"]/form/div[2]/div[2]/section[2]/f-field[6]/div/field-value/div/div[2]
${app_signature_1}    xpath://div[@class="dialog"]//div[3]//div[3]
${category_signature_1}    xpath://*[@id="navbar-view-section"]/div/div/div/div[3]/div[28]
${url_category_1}    xpath://*[@id="navbar-view-section"]/div/div/div/div[3]/div[3]
${shaping_policy_edit_submit_cancel}    xpath://*[@id="submit_cancel"]

*** Test Cases ***
797179
    [Documentation]    
    [Tags]    6.2.0    application    chrome    797179    critical    win10    norun

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects
    Go to Shaping policy
    Click Create New Button on Shaping Policy List
    Click Button    ${GENERAL_EDITOR_OK_BUTTON}
    Wait Until Element Is Visible    ${POLICY_SHAPING_NAME_TEXT}
    input text    ${POLICY_SHAPING_NAME_TEXT}    ${shaping_policy_name}

    #select source/destination/service--------ALL
    Wait Until Element Is Visible    xpath://*[@id="ng-base"]/form/div[2]/div[2]/section[2]/f-field[1]/div/field-value/div/div[2]
    click element    xpath://*[@id="ng-base"]/form/div[2]/div[2]/section[2]/f-field[1]/div/field-value/div/div[2]
    sleep    5
    Wait Until Element Is Visible    xpath://*[@id="navbar-view-section"]/div/div/div/div[4]/div[2]
    click element    xpath://*[@id="navbar-view-section"]/div/div/div/div[4]/div[2]

    Wait Until Element Is Visible    xpath://*[@id="ng-base"]/form/div[2]/div[2]/section[2]/f-field[2]/div/field-value/div/div[2]
    click element    xpath://*[@id="ng-base"]/form/div[2]/div[2]/section[2]/f-field[2]/div/field-value/div/div[2]
    sleep    5
    Wait Until Element Is Visible    xpath://*[@id="navbar-view-section"]/div/div/div/div[4]/div[2]
    click element    xpath://*[@id="navbar-view-section"]/div/div/div/div[4]/div[2]

    Wait Until Element Is Visible    xpath://*[@id="ng-base"]/form/div[2]/div[2]/section[2]/f-field[4]/div/field-value/div/div[2]
    click element    xpath://*[@id="ng-base"]/form/div[2]/div[2]/section[2]/f-field[4]/div/field-value/div/div[2]
    sleep    5
    Wait Until Element Is Visible    xpath://*[@id="navbar-view-section"]/div/div/div/div[3]/div[3]
    click element    xpath://*[@id="navbar-view-section"]/div/div/div/div[3]/div[3]

    #Verify and select application/app_category_url_category
    Wait Until Element Is Visible    xpath://field-label[contains(text(),"Application")]
    Wait Until Element Is Visible    xpath://field-label[contains(text(),"URL Category")]
    click element    ${application_input}
    sleep    5
    Wait Until Element Is Visible    ${app_signature_1}
    click element    ${app_signature_1}
    Press Down Key Until an Element is Visible    ${category_signature_1}
    Wait Until Element Is Visible    ${category_signature_1}
    click element    ${category_signature_1}

    click element    ${url_category_input}
    sleep    5
    Wait Until Element Is Visible    ${url_category_1} 
    click element    ${url_category_1}

    #save and verify shaping policy
    Press Down Key
    click element    xpath://*[@id="ng-base"]/form/div[2]/div[2]/section[3]/f-field[2]/div/field-value/div/div[2]
    Wait Until Element Is Visible    xpath://*[@id="navbar-view-section"]/div/div/div/div[3]/div[2]
    sleep    5
    click element    xpath://*[@id="navbar-view-section"]/div/div/div/div[3]/div[2]
    Wait Until Element Is Visible    ${shaping_policy_edit_submit_cancel}
    click element    ${shaping_policy_edit_submit_cancel}
    sleep    5

    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    write test result to file    ${CURDIR}