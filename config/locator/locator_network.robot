*** Settings ***
Documentation     This file contains all locator variables on FortiGate Network page

*** Variables ***
####Network####
${NETWORK_ENTRY}    xpath://span[text()="Network"]
${NETWORK_FRAME}    name:embedded-iframe
###Interfaces###
${NETWORK_INTERFACES_ENTRY}    xpath://div[div/span="Network"]//span[text()="Interfaces"]
${NETWORK_INTERFACES_FACEPLATE}    id:faceplate
${NETWORK_INTERFACES_EDIT_H1}    xpath://h1[text()="Edit Interface"]
${NETWORK_DNS_ENTRY}      xpath://span[text()="DNS"]
${NETWORK_INTERFACES_VIEW_ALPHABETICALLY_BUTTON}    xpath://button[normalize-space(div/span)="Alphabetically"]
${NETWORK_INTERFACES_VIEW_ALPHABETICALLY_BUTTON_SELECTED}    xpath://button[normalize-space(div/span)="Alphabetically" and contains(@class,"selected")]

###Static Routes###
${NETWORK_STATIC_ROUTES_ENTRY}    xpath://div[div/span="Network"]//span[text()="Static Routes"]
${NETWORK_STATIC_ROUTES_DIV}    xpath://div[@class="qlist-table"]
${VAR_NETWORK_STATIC_ROUTES_DST_COLUMN}    xpath://td[@class="dst"]/span[text()="\${PLACEHOLDER}"]
