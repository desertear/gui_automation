*** Settings ***
Documentation     This file contains all locator variables on FortiGate WEBFILTER

*** Variables ***
##Go to VDOM move to  Security Porfile
####Security Profile####
${SECURITY_PROFILE_ENTRY}    xpath://span[contains(text(),"Security Profiles")]
${WEBFILTER_ENTRY}    xpath://span[contains(text(),"Web Filter")]                                                                                   

######Edit WEBFILTER Profile######
${WEBFILTER_NEW_BUTTON}    xpath://span[contains(text(),"Create New")]
${EDIT_WEBFILTER_BUTTON}    xpath://div[@class="ng-isolate-scope menu-bar"]//span[@class="ng-binding ng-scope"][contains(text(),"Edit")]
${DELETE_WEBFILTER_BUTTON}    xpath://div[@class="ng-isolate-scope menu-bar"]//span[@class="ng-binding ng-scope"][contains(text(),"Delete")]

######WEBFILTER Profile######
${webfilter_page}    xpath://h1[contains(text(),"Edit Web Filter Profile")]

######FortiGuard Filter Page######
######FortiGuard Filter table header(part about filter by name)######
${Webfilter_Fortiguard_Table_Header_Name}    xpath://div[@class="header-cell first-cell"]//div[@class="header-cell-centered"]
${Webfilter_Fortiguard_Table_Header_Name_Filter}    xpath://div[@class="header-cell first-cell"]//div[@class="header-cell-centered"]/following-sibling::button
${Webfilter_Fortiguard_Name_Filter}    xpath://input[@placeholder="Regular expression"]
${Webfilter_Fortiguard_Name_Filter_Apply}    xpath://button[@class="standard-button primary"]
${regex_button_of_ftgd_filter}    xpath://span[contains(text(),"Regex")]

######FortiGuard Filter big category name######
${Webfilter_Fortiguard_big_Category_name}    xpath://div[contains(text(),"\${PLACEHOLDER}")]
${Webfilter_Fortiguard_big_Category_number_based_on_name}     xpath://div[@section-id="\${PLACEHOLDER1}"]//span[@class="number-bubble row-count"][contains(text(),"\${PLACEHOLDER2}")] 

######FortiGuard Filter category######
${Webfilter_Fortiguard_Category_name}    xpath://span[text()="\${PLACEHOLDER}"]
${Webfilter_Fortiguard_Big_Category_expand_button}    xpath://label[@class="section-label"]//button[@type="button"]
${Webfilter_Fortiguard_action_button}    xpath://f-mutable-menu-transclude[@class="ng-scope ng-isolate-scope"]//span[@class="ng-binding ng-scope"][contains(text(),"\${PLACEHOLDER}")]

######FortiGuard Filter warning action######
${Webfilter_Fortiguard_warning_action_pop_out_page}    xpath://h1[@title="Edit Filter"]
${Webfilter_Fortiguard_warning_action_time_seconds}    xpath://input[@id="seconds"]
${Webfilter_Fortiguard_warning_action_time_minutes}    xpath://input[@id="minutes"]
${Webfilter_Fortiguard_warning_action_time_hours}    xpath://input[@id="hours"]







${Webfilter_Bandwidth_Consuming}    xpath://div[contains(text(),"Bandwidth Consuming")]
${Webfilter_Freeware_and_Software_Downloads}    xpath://span[contains(text(),"Freeware and Software Downloads")]
${Webfilter_Action_Allow}    xpath://f-mutable-menu-transclude[@class="menu-bar-component ng-scope ng-isolate-scope"]//span[@class="ng-binding ng-scope"][contains(text(),"Allow")]
${Webfilter_Action_Monitor}    xpath://f-mutable-menu-transclude[@class="menu-bar-component ng-scope ng-isolate-scope"]//span[@class="ng-binding ng-scope"][contains(text(),"Monitor")]
${Webfilter_Action_Block}    xpath://f-mutable-menu-transclude[@class="menu-bar-component ng-scope ng-isolate-scope"]//span[@class="ng-binding ng-scope"][contains(text(),"Block")]
${Webfilter_Action_Warning}    xpath://f-mutable-menu-transclude[@class="menu-bar-component ng-scope ng-isolate-scope"]//span[@class="ng-binding ng-scope"][contains(text(),"Warning")]
${Webfilter_Action_Warning_OK}    xpath://f-ftgd-filter-action[@class="ng-isolate-scope"]//span[@class="ng-binding"][contains(text(),"OK")]
${Webfilter_Action_Athenticate}    xpath://f-mutable-menu-transclude[@class="menu-bar-component ng-scope ng-isolate-scope"]//span[@class="ng-binding ng-scope"][contains(text(),"Athenticate")]
${Webfilter_Action_Athenticate_Goup}    xpath://span[contains(text(),"local_group")]
${Webfilter_Action_Athenticate_OK}    xpath://f-ftgd-filter-action[@class="ng-isolate-scope"]//button[@id="submit_ok"]
##absolutely path
${Webfilter_Action_Result}    xpath:/html[1]/body[1]/section[1]/div[1]/f-webfilter-profile-dialog[1]/f-dialog[1]/div[1]/form[1]/div[2]/div[1]/div[2]/dialog-content[1]/section[2]/div[1]/f-ftgd-filters[1]/f-mutable[1]/div[1]/div[2]/div[1]/div[1]/div[2]/div[7]/div[3]/div[1]/div[1]/div[1]/div[1]/span[1]    
