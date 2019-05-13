*** Settings ***
Documentation     This file contains all locator variables on FortiGate Log&Report

*** Variables ***
##Go to VDOM move to  Security Porfile
####Security Profile####
${SECURITY_PROFILE_ENTRY}    xpath://span[contains(text(),"Security Profiles")]

${APPLICATION_CONTROL_ENTRY}    xpath://span[contains(text(),"Application Control")]                                                                                   
${APP_SENSOR_NEW_BUTTON}    xpath://*[@id="ng-base"]/form/div[1]/span/title-content/button[1]
${APP_SENSOR_LIST_BUTTON}    xpath://*[@id="ng-base"]/form/div[1]/span/title-content/button[2]

${VIEW_APPLICATION_LIST}    xpath://a[@id="view-app-sigs"]
${VIEW_APPLICATION_LIST_ADD_FILTER_BUTTON}    xpath://span[@f-lang="Add Filter"]
${VIEW_APPLICATION_LIST_CREATE_NEW}    xpath://span[contains(text(),"Create New")]
${VIEW_APPLICATION_LIST_DELETE}    xpath://span[contains(text(),"Delete")]
${VIEW_APPLICATION_LIST_DELETE_OK}    xpath://button[contains(text(),"OK")]
${CUSTOM_SIGNATURES_ENTRY}    xpath://span[contains(text(),"Custom Signatures")]
${CUSTOM_SIGNATURES_CREATE_NEW_BUTTON}    xpath://span[contains(text(),"Create New")]
${CUSTOM_SIGNATURES_DELETE_BUTTON}    xpath://span[contains(text(),"Delete")]
${CUSTOM_SIGNATURES_DELETE_BUTTON_OK}    xpath://button[contains(text(),"OK")]
${CUSTOM_SIGNATURES_CREATE_NEW_BUTTON_APP}    xpath:/html/body/div[9]/div[2]/button/div/span

######Edit Application Sensor######
${EDIT_APP_SENSOR_NAME}    xpath://*[@id="ng-base"]/form/div[2]/div[1]/div[2]/dialog-content/section[1]/div[1]/div/input

${EDIT_APP_SENSOR_ADD_SIGNATURES_BUTTON}    xpath://*[@id="ng-base"]/form/div[2]/div[1]/div[2]/dialog-content/section[3]/div/div[1]/div/div/div/div[1]/button/div
${EDIT_APP_SENSOR_DELETE_SIGNATURES_BUTTON}    xpath://*[@id="ng-base"]/form/div[2]/div[1]/div[2]/dialog-content/section[3]/div/div[1]/div/div/div/div[3]/button/div
${EDIT_APP_SENSOR_DELETE_SIGNATURES_EDIT_PARAMETER}    xpath://span[contains(text(),"Edit Parameters")]
${EDIT_APP_SENSOR_ADD_SIGNATURES_1}    xpath://span[contains(text(),"1kxun")]
${EDIT_APP_SENSOR_ADD_SIGNATURES_USE}    xpath://button[contains(text(),"Use Selected Signatures")]
${EDIT_APP_SENSOR_ADD_SIGNATURES_ADD_FILTER}    xpath://span[@f-lang="Add Filter"]
${EDIT_APP_SENSOR_ADD_SIGNATURES_NAME}    xpath://button[contains(text(),"Name")]
${EDIT_APP_SENSOR_ADD_SIGNATURES_NAME_INPUT}    xpath://span[@class='facet-options-container']//input[@type='text']
${EDIT_APP_SENSOR_ADD_SIGNATURES_CLOUD}    xpath://span[@class='ng-binding ng-scope'][contains(text(),"Cloud")]

${EDIT_APP_SENSOR_DELETE_FILTER_BUTTON}    xpath://*[@id="ng-base"]/form/div[2]/div[1]/div[2]/dialog-content/section[4]/div/div[1]/div/div/div/div[3]/button
${EDIT_APP_SENSOR_ADD_FILTER_BUTTON}    xpath://*[@id="ng-base"]/form/div[2]/div[1]/div[2]/dialog-content/section[4]/div/div[1]/div/div/div/div[1]/button/div
${EDIT_APP_SENSOR_ADD_FILTER_ADD_FILTER}    xpath://*[@id="navbar-view-section"]/div/div[2]/div/div[2]/div[1]/f-slide-container/div/div/div[1]/div/div/div/div[2]/div/div/div[1]/button/span
${EDIT_APP_SENSOR_ADD_FILTER_ADD_FILTER_TECHNOLOGY}    xpath://*[@id="navbar-view-section"]/div/div[2]/div/div[2]/div[1]/f-slide-container/div/div/div[1]/div/div/div/div[2]/div/div/div[1]/div/div/ul/li[6]/button
${EDIT_APP_SENSOR_ADD_FILTER_ADD_FILTER_TECHNOLOGY_BROWSER_BASED}    xpath://*[@id="navbar-view-section"]/div/div[2]/div/div[2]/div[1]/f-slide-container/div/div/div[1]/div/div/div/div[2]/div/div/div[1]/div/span/span/div/span[2]/ul/li[1]/label/button
${EDIT_APP_SENSOR_ADD_FILTER_ADD_FILTER_USE}    xpath://button[contains(text(),"Use Filters")]

${EDIT_APP_SENSOR_CATEGORY_GENERAL_INTEREST}    xpath://div[@class='categories']//div[6]//button[1]//div[1]//div[1]//f-icon[1]
${EDIT_APP_SENSOR_CATEGORY_GENERAL_INTEREST_BLOCK}    xpath://div[@class="ng-isolate-scope pop-up-menu"]//div[3]//button[1]

${EDIT_APP_SENSOR_OK}    xpath://*[@id="submit_ok"]
${EDIT_APP_SENSOR_CANCEL}    xpath://*[@id="submit_cancel"]
${EDIT_APP_SENSOR_APPLY}    xpath://span[contains(text(),"Apply")]
${EDIT_APP_SENSOR_ADD_ENTRY_EXIST}    xpath://*[@id="ng-base"]/form/div[2]/div[1]/div[2]/dialog-content/section[3]/div/div[2]/div[1]/div[2]/table/tbody/tr/td[1]/div[2]
${EDIT_APP_SENSOR_FILTER_ENTRY_EXIST}    xpath://*[@id="ng-base"]/form/div[2]/div[1]/div[2]/dialog-content/section[4]/div/div[2]/div[1]/div[2]/table/tbody/tr/td[1]


######View Application Profiles######
${VIEW_LIST_11}    xpath://*[@id="content"]/div[2]/table/tbody/tr[5]/td[1]
${VIEW_LIST_DELETE_BUTTON}    xpath://span[contains(text(),"Delete")]
${VIEW_LIST_DELETE_OK_BUTTON}    xpath://button[contains(text(),"OK")]
${VIEW_LIST_CREATE_NEW_BUTTON}    xpath://span[contains(text(),"Create New")]

######IPv4 Policy apply app profile######
${IPv4_POLICY_LIST_ENTRY}    xpath://*[@id="navbar-view-section"]/div/div/div[2]/div[1]/div/div[2]/div[4]/div[9]/div
${IPv4_POLICY_LIST_APP_PROFILE}    xpath://*[@id="navbar-view-section"]/div/div/div[2]/div[1]/div/div[2]/div[3]/div[7]/div/div/div/div[1]
${IPv4_POLICY_LIST_APP_PROFILE_INCLUDED}    xpath://*[@id="navbar-view-section"]/div/div/div[2]/div[1]/div/div[2]/div[3]/div[12]/div/div/div/div[2]/div/div
${IPv4_POLICY_EDIT}    xpath://*[@id="navbar-view-section"]/div/div/div[1]/div/div/div/div[1]/div[2]/div/button/div
${IPv4_POLICY_APP_PROFILE_ENABLE}    xpath://*[@id="ng-base"]/form/div[2]/div[1]/div[2]/dialog-content/f-utm-profiles/section/div[4]/f-field/label/field-label/span/label
${IPv4_POLICY_APP_PROFILE_ADD}    xpath://*[@id="ng-base"]/form/div[2]/div[1]/div[2]/dialog-content/f-utm-profiles/section/div[4]/f-field/div/field-value/div/div/div[1]/div
${IPv4_POLICY_APP_PROFILE_ADD_NAME}    xpath://div[@class="virtual-results"]//div[6]
${IPv4_POLICY_OK}    xpath://*[@id="submit_ok"]
${IPv4_POLICY_SSL_PROFILE}    xpath:
${IPv4_POLICY_LIST_CREATE_NEW_BUTTON}    xpath://*[@id="navbar-view-section"]/div/div/div[1]/div/div/div/div[1]/div[1]/div/button
${VIEW_LIST_PLUS_DETAIL_BUTTON}    xpath://*[@id="navbar-view-section"]/div/div/div[2]/div[1]/div/div[2]/div[2]/div/label/button
${IPv4_POLICY_EDIT_END}    xpath://*[@id="ng-base"]/form/div[2]/div[1]/div[2]/dialog-content/section[4]/div/label/span/span
${IPv4_POLICY_EDIT_NAME}    xpath://*[@id="ng-base"]/form/div[2]/div[1]/div[2]/dialog-content/section[2]/div[1]/label[1]/span


######Edit Custom Signatures######

${CUSTOM_SIGNATURE_EDIT_NAME}    xpath://*[@id="signature-name"]
${CUSTOM_SIGNATURE_EDIT_SIGNATURE}    xpath://*[@id="signature"]
${CUSTOM_SIGNATURE_EDIT_OK_BUTTON}    xpath://*[@id="submit_ok"]
${CUSTOM_SIGNATURE_EDIT_VERIFY}    xpath://td[@class="q_origin_key"]

