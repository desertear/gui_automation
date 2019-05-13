*** Settings ***
Documentation     This file contains all locator variables on FortiGate DLP

*** Variables ***
##Go to VDOM move to  Security Porfile
####Security Profile####
${SECURITY_PROFILE_ENTRY}    xpath://span[contains(text(),"Security Profiles")]
${IPS_ENTRY}    xpath://span[contains(text(),"Intrusion Prevention")] 
${IPS_FRAME}    xpath://iframe[@name="embedded-iframe"]                                                                                    

####Edit Custom Signatures####
${CUSTOM_SIGNATURE_EDIT_NAME}    xpath://*[@id="signature-name"]
${CUSTOM_SIGNATURE_EDIT_SIGNATURE}    xpath://*[@id="signature"]
${CUSTOM_SIGNATURE_EDIT_OK_BUTTON}    xpath://*[@id="submit_ok"]
${CUSTOM_SIGNATURE_EDIT_VERIFY}    xpath://td[@class="q_origin_key"]
${CUSTOM_SIGNATURES_ENTRY}    xpath://span[contains(text(),"Custom Signatures")]
${CUSTOM_SIGNATURES_CREATE_NEW_BUTTON}    xpath://span[contains(text(),"Create New")]
${CUSTOM_SIGNATURES_DELETE_BUTTON}    xpath://span[contains(text(),"Delete")]
${CUSTOM_SIGNATURES_DELETE_BUTTON_OK}    xpath://button[contains(text(),"OK")]
${CUSTOM_SIGNATURES_CREATE_NEW_BUTTON_IPS}    xpath://div[@class="ng-isolate-scope pop-up-menu button-toggled"]//span[@class="ng-scope"][contains(text(),"IPS Signature")]

####IPS Sensor####
${CREATE_IPS_SENSOR}    xpath://span[contains(text(),"Create New")]
${EDIT_IPS_SENSOR_NAME}    xpath://input[@id="name"]
${IPS_SENSOR_OK_BUTTON}    xpath://button[@id="submit_ok"]
${DELETE_IPS_SENSOR}    xpath://div[@class="ng-isolate-scope menu-bar"]//span[@class="ng-binding ng-scope"][contains(text(),"Delete")]
${DELETE_IPS_SENSOR_CONFIRM}    xpath://button[contains(text(),"OK")]
${IPS_SENSOR_APPLY_BUTTON}    xpath://button[@id="submit_apply"]
${IPS_SENSOR_BLOCK_MALICIOUS_URLS}    xpath://label[@for="block-malicious-url"]//label[@for="block-malicious-url"]
${IPS_SENSOR_BOTNET_MONITOR}    xpath://label[@for="scan-botnet-connections-monitor"]
${IPS_SENSOR_BOTNET_BLOCK}    xpath://label[@for="scan-botnet-connections-block"]
${IPS_SENSOR_BOTNET_DISABLE}    xpath://label[@for="scan-botnet-connections-disable"]

####IPS Signatures####
${IPS_SENSOR_ADD_SIGNATURE}    xpath://span[contains(text(),"Add Signatures")]
${IPS_SENSOR_ADD_SIGNATURE_LOAD_CHECK}    xpath://div[@class="ui-resizable"][contains(text(),"Target")]
${IPS_SENSOR_ADD_SIGNATURE_ADD_FILTER}    xpath://span[@f-lang="Add Filter"]
${IPS_SENSOR_ADD_SIGNATURE_FILTER_NAME}    xpath://button[contains(text(),"Name")]
${IPS_SENSOR_ADD_SIGNATURE_FILTER_NAME_FIELD}    xpath://span[@class="facet-options-container"]//input[@type="text"]
${IPS_SENSOR_ADD_SIGNATURE_ENTRY}    xpath://tr[@class="qlist_row"]
${IPS_SENSOR_USE_SELECTED_SIGNATURE}    xpath://button[contains(text(),"Use Selected Signatures")]

${IPS_SENSOR_ACTION_PLACEHOLDER}    xpath://div[@class="ng-isolate-scope pop-up-menu"]//span[@class="ng-scope"][contains(text(),"\${PLACEHOLDER}")]
${IPS_SENSOR_ACTION_VERIFY_PLACEHOLDER}    xpath://td[@class="action"]//span[text()="\${PLACEHOLDER}"]
# ${IPS_SENSOR_SIGNATURE_ACTION_PASS}    xpath://div[@class="ng-isolate-scope pop-up-menu"]//span[@class="ng-scope"][contains(text(),"Pass")]
# ${IPS_SENSOR_SIGNATURE_ACTION_MONITOR}    xpath://div[@class="ng-isolate-scope pop-up-menu"]//span[@class="ng-scope"][contains(text(),"Monitor")]
# ${IPS_SENSOR_SIGNATURE_ACTION_BLOCK}    xpath://div[@class="ng-isolate-scope pop-up-menu"]//span[@class="ng-scope"][contains(text(),"Block")]
# ${IPS_SENSOR_SIGNATURE_ACTION_RESET}    xpath://div[@class="ng-isolate-scope pop-up-menu"]//span[@class="ng-scope"][contains(text(),"Reset")]
# ${IPS_SENSOR_SIGNATURE_ACTION_DEFAULT}    xpath://div[@class="ng-isolate-scope pop-up-menu"]//span[@class="ng-scope"][contains(text(),"Default")]
# ${IPS_SENSOR_SIGNATURE_ACTION_QUARANTINE}    xpath://div[@class="ng-isolate-scope pop-up-menu"]//span[@class="ng-scope"][contains(text(),"Quarantine")]
${IPS_SENSOR_PACKET_LOGGING}    xpath://div[@class="ng-isolate-scope pop-up-menu"]//span[@class="ng-scope"][contains(text(),"Packet Logging")]
${IPS_SENSOR_PACKET_LOGGING_ENABLE}    xpath://div[@class="ng-scope ng-isolate-scope pop-up-menu"]//span[@class="ng-scope"][contains(text(),"Enable")]
${IPS_SENSOR_PACKET_LOGGING_ENABLE_ICON}    xpath://f-icon[@class="fa-enabled"]
${IPS_SENSOR_PACKET_LOGGING_DISABLE}    xpath://div[@class="ng-scope ng-isolate-scope pop-up-menu"]//span[@class="ng-scope"][contains(text(),"Disable")]
${IPS_SENSOR_PACKET_LOGGING_DISABLE_ICON}    xpath://f-icon[@class="fa-disabled"]
${IPS_SENSOR_SIGNATURE_LIST_ENTRY}    xpath://div[@id="sig_list"]//tbody
${IPS_SENSOR_DELETE_SIGNATURE}    xpath://div[@id="sig_list_menu"]//span[@class="ng-binding ng-scope"][contains(text(),"Delete")]

####IPS Filter####
${IPS_SENSOR_ADD_FILTER}    xpath://span[contains(text(),"Add Filter")]
${IPS_SENSOR_ADD_FILTER_LOAD_CHECK}    xpath://div[@class="qlist-table"]//table//tbody
${IPS_SENSOR_ADD_FILTER_ADD_FILTER}    xpath://span[@f-lang="Add Filter"]   
${IPS_SENSOR_ADD_FILTER_PLACEHOLDER}    xpath://button[contains(text(),"\${PLACEHOLDER}")]
${IPS_SENSOR_ADD_FILTER_FILTER_FIELD}    xpath://span[@class="facet-options-container"]//input[@type="text"]
${IPS_SENSOR_ADD_FILTER_USE_FILTERS}    xpath://button[contains(text(),"Use Filters")]
${IPS_SENSOR_FILTER_ENTRY}    xpath://td[@class="filter_details"]
${IPS_SENSOR_FILTER_DELETE}    xpath://section[2]//div[1]//div[1]//div[1]//div[1]//div[1]//div[1]//div[3]//button[1]//div[1]//span[1]
${IPS_SENSOR_FILTER_OPTIONS_LIST}    xpath://div[@class="facet-options"]
${IPS_SENSOR_FILTER_REMOVE_FILTER}    xpath://button[@title="Remove Filter"]//f-icon[@class="fa-times"]
${IPS_SENSOR_FILTER_CANCEL}    xpath://button[contains(text(),"Cancel")]