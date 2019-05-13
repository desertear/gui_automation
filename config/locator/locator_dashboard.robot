*** Settings ***
Documentation     This file contains all locator variables on FortiGate Dashboard Page

*** Variables ***
####Main Page####
${PLTF_TYPE_DIV}    xpath:/html/body/header/div[2]/div[1]
${LOGOUT_ICON_BUTTON}    xpath://button[div/div/span="\${PLACEHOLDER}"]
${LOGOUT_LOGOUT_BUTTON}    xpath://button[div/span="Logout"]
${INTERIM_VERSION_BUTTON}    xpath://button[contains(div/div/span,"interim build")]
${INTERIM_VERSION_HIDE_BUTTON}    xpath://button[div/span="Hide Label"]