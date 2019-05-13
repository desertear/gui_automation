*** Settings ***
Documentation     This file contains all locator variables on FortiGate WAN OPTIMIZATION

*** Variables ***
##Go to VDOM move to  Security Porfile
####Wanopt####
${WANOPT_ENTRY}    xpath://div/div/span[contains(text(),"WAN Opt. & Cache")]
${WANOPT_PROFILES_ENTRY}    xpath://a[@ng-href="page/p/wanopt/profile/"]/span[contains(text(),"Profiles")]
${CREATE_NEW_WANOPT_PROFILE}    xpath://button[div/span="Create New"]
${EDIT_WANOPT_PROFILE_NAME}     xpath://input[@id="name"]
${ADD_WANOPT_PROFILE_OK}        xpath://button[@id="submit_ok"]
${EDIT_WANOPT_PROFILE_APPLY}        xpath://button[@id="submit_apply"]

${WANOPT_PROFILE_LIST_ENTRY2}   xpath://*[@id="content"]/div[2]/table/tbody/tr[2]/td[1]
${WANOPT_PROFILE_LIST_EDIT_BUTTON}  //div[2]/div[1]/div/div/div/div[1]/div[2]/div/button[div/span="Edit"]

${WANOPT_PEERS_ENTRY}       xpath://a[@ng-href="page/p/wanopt/peer/"]/span[contains(text(),"Peers")]
${WANOPT_LOCAL_HOST_ID}     xpath:(//*[@id="id_textbox"])[1]
${WANOPT_LOCAL_HOST_ID_APPLY}       xpath:(//input[@id="id_button"])[1]
${CREATE_NEW_WANOPT_PEER}    xpath://button[div/span="Create New"]
${EDIT_WANOPT_PEER_NAME}     xpath://input[@id="peer-host-id"]
${EDIT_WANOPT_PEER_IP}       xpath://input[@id="ip"]
${EDIT_WANOPT_PEER_OK}       xpath://button[@id="submit_ok"]
# ${WANOPT_PEER_LIST_EDIT_BUTTON}     xpath://div[@class="ng-isolate-scope menu-bar"]//span[@class="ng-binding ng-scope"][contains(text(),"Edit")]
${WANOPT_PEER_LIST_EDIT_BUTTON}     xpath:(//button[div/span="Edit"])[1]
# ${WANOPT_PEER_LIST_EDIT_BUTTON}     xpath:/html/body/div[2]/div[1]/div/div/div/div[1]/div[2]/div/button/div/span
${WANOPT_PEER_LIST_ENTRY2}      xpath://*[@id="content"]/div[2]/table/tbody/tr[2]/td[1]
${WANOPT_PEER_LIST_ENTRY2_NAME}      xpath://td[contains(text(),"peer_test")]
${WANOPT_PEER_LIST_ENTRY2_IP}      xpath://td[contains(text(),"111.111.111.111")]
${WANOPT_PEER_LIST_ENTRY2_name_2}      xpath://td[contains(text(),"peer_name_2")]
${WANOPT_PEER_LIST_ENTRY2_IP_2}      xpath://td[contains(text(),"222.222.222.222")]

${WANOPT_AUTH_GROUPS_ENTRY}      xpath://a[@ng-href="page/p/wanopt/authgrp/"]/span[contains(text(),"Authentication Groups")]
${CREATE_NEW_WANOPT_AUTH_GROUP}     xpath://button[div/span="Create New"]
${EDIT_WANOPT_AUTH_GROUP_NAME}      xpath://input[@id="name"]
${WANOPT_AUTH_GROUP_METHOD_KEY}     xpath:(//label[contains(text(),"Pre-shared Key")])[1]
${EDIT_WANOPT_AUTH_GROUP_KEY}       xpath://input[@id="psk"]
${EDIT_WANOPT_AUTH_GROUP_OK}        xpath://button[@id="submit_ok"]
${WANOPT_AUTH_GROUP_LIST_ENTRY2}        xpath://*[@id="content"]/div[2]/table/tbody/tr[2]/td[1]
${WANOPT_AUTH_GROUP_LIST_EDIT_BUTTON}       xpath:(//button[div/span="Edit"])[1]
${WANOPT_AUTH_GROUP_LIST_DELETE_BUTTON}     xpath:(//button[div/span="Delete"])[1]
${WANOPT_AUTH_GROUP_LIST_DELETE_CONFIRM_BUTTON}        xpath://button[contains(text(),"OK")]
${WANOPT_AUTH_GROUP_LIST_ENTRY2_NAME}       xpath://td[contains(text(),"auth_group_test")]
${WANOPT_AUTH_GROUP_LIST_ENTRY2_NAME_2}     xpath://td[contains(text(),"auth_group_test_2")]
${WANOPT_AUTH_GROUP_METHOD_CERT}            xpath:(//label[contains(text(),"Certificate")])[1]
${WANOPT_AUTH_GROUP_CERT_SELECT}            xpath:(//f-icon[@class="fa-caret-down"])[1]
${WANOPT_AUTH_GROUP_CERT_FORTI_FACTORY}     xpath:/html/body/div[3]/div[2]/div[3]
${WANOPT_AUTH_GROUP_ACCEPT_PEER_DEFINED}           xpath:(//label[contains(text(),"Defined Only")])[1]


# ${APP_SENSOR_NEW_BUTTON}    xpath://*[@id="ng-base"]/form/div[1]/span/title-content/button[1]
# ${APP_SENSOR_LIST_BUTTON}    xpath://*[@id="ng-base"]/form/div[1]/span/title-content/button[2]

# ${VIEW_APPLICATION_LIST}    xpath://a[@id="view-app-sigs"]
# ${VIEW_APPLICATION_LIST_ADD_FILTER_BUTTON}    xpath://span[@f-lang="Add Filter"]
# ${VIEW_APPLICATION_LIST_CREATE_NEW}    xpath://span[contains(text(),"Create New")]
# ${VIEW_APPLICATION_LIST_DELETE}    xpath://span[contains(text(),"Delete")]
# ${VIEW_APPLICATION_LIST_DELETE_OK}    xpath://button[contains(text(),"OK")]
# ${CUSTOM_SIGNATURES_ENTRY}    xpath://span[contains(text(),"Custom Signatures")]
# ${CUSTOM_SIGNATURES_CREATE_NEW_BUTTON}    xpath://span[contains(text(),"Create New")]
# ${CUSTOM_SIGNATURES_DELETE_BUTTON}    xpath://span[contains(text(),"Delete")]
# ${CUSTOM_SIGNATURES_DELETE_BUTTON_OK}    xpath://button[contains(text(),"OK")]
# ${CUSTOM_SIGNATURES_CREATE_NEW_BUTTON_APP}    xpath:/html/body/div[9]/div[2]/button/div/span