*** Settings ***
Documentation     This file contains all locator variables on FortiGate multicast policy

*** Variables ***
###Multicast Policy List
${POLICY_MULTICAST_TABLE_NAME}    xpath://div/span[text()="ID"]
${POLICY_MULTICAST_TABLE_PROTOCOL}    xpath://div/span[text()="Protocol Number"]


###Multicast Policy Editor