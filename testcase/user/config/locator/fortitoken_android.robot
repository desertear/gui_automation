*** Settings ***
Documentation     This file contains all locator variables for FortiToken on Android

*** Variables ***
##FortiToken Mobile
${FTM_TOKEN_TEXT}    id=detail_row_subtitle
${FTM_TOKEN_HIDE_BUTTON}    id=detail_row_hide_button
${FTM_ENTER_MANUALLY}    id=btn_enter_manually
${FTM_ACCOUNT_TYPE_TEXT}    xpath=//android.widget.TextView[@text="Fortinet"]
${FTM_ACCOUNT_NAME}    id=editTextAccountName
${FTM_ACCOUNT_KEY}    id=editTextSecretKey
${FTM_ACCOUNT_ADD_BUTTON}    id=btnAddToken
