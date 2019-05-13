*** Settings ***
Documentation     This file contains all locator variables on FortiGate Shaping policy

*** Variables ***

###Traffic Shapers List
${POLICY_SHAPER_TABLE_NAME}    xpath://div[text()="Name" and @class="ui-resizable"]
${VAR_POLICY_SHAPING_NAME_COLUMN}    xpath://td[text()="\${PLACEHOLDER}"]


###Shaping Policy List
${POLICY_SHAPING_TABLE_NAME}    xpath://div/span[text()="Name"]
${POLICY_SHAPING_POLICY_EDIT_BUTTON}    xpath://div[@class="mutable-menu"]//button[div/span="Edit" and not(@disabled)]
${VAR_POLICY_SHAPING_TOGGLE_BUTTON}    xpath://label[@class="section-label"]/button[./following-sibling::div/div[text()="\${PLACEHOLDER}"]]
${VAR_POLICY_SHAPING_TOGGLE_OPEN}    xpath://label[@class="section-label"]/button[./following-sibling::div/div[text()="\${PLACEHOLDER}"] and contains(@class,"active")]
${VAR_POLICY_SHAPING_IN_TABLE}    xpath://div[text()="\${PLACEHOLDER}"]
${VAR_POLICY_SHAPING_ID_IN_TABLE}    xpath://div[@column-id="id" and ./div//span[text()="\${PLACEHOLDER}"]]/following-sibling::div[@column-id="name"]
${POLICY_SHAPING_CONTEXT_MENU}    xpath://div[contains(@class,"left-menu-items")]//span[contains(text(),"Policy Status")]


###Shaping Policy Editor
${POLICY_SHAPING_IPV4}    xpath://f-radio-group/label/span[text()="IPv4"]
${POLICY_SHAPING_IPV6}    xpath://f-radio-group/label/span[text()="IPv6"]
${POLICY_SHAPING_IPV6_SELECT}    xpath://f-field[./label/field-label[text()="IP Version"]]//f-radio-group/label[./span[text()="IPv6"]]/preceding-sibling::input[contains(@class,"ng-valid-parse")]
${POLICY_SHAPING_POLICY_H1}    xpath://h1[text()="New Shaping Policy"]
${POLICY_SHAPING_NAME_TEXT}    xpath://label[./field-label[text()="Name"]]/following-sibling::div//input
${POLICY_SHAPING_SOURCE_DIV}    xpath://label[contains(field-label,"Source")]/following-sibling::div//div[@class="add-placeholder"]
${POLICY_SHAPING_DESTINATION_DIV}    xpath://label[contains(field-label,"Destination")]/following-sibling::div//div[@class="add-placeholder"]