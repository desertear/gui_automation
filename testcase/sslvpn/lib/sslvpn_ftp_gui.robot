*** Settings ***
Documentation     This file contains SSLVPN FTP page operation

*** Variables ***

*** Keywords ***
##Go to dir specified for automation test
go to ftp directory
    [Arguments]    ${dir_name}
    ${locator_replaced_with_real_value}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${FTP_VAR_DIR}    ${dir_name}
    Wait Until Element Is Visible    ${locator_replaced_with_real_value}
    ${file_dir_index_value}=    get ftp directory index value in table    ${dir_name}
    ${js_replaced_with_real_value}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${JS_FTP_VAR_DIR}    ${file_dir_index_value}
    execute Javascript    ${js_replaced_with_real_value}
    sleep    ${JS_WAITING_TIME}
    # click element    ${locator_replaced_with_real_value}
    wait until element is visible    ${FTP_HEAD}
    wait until page contains element    ${FTP_HEAD}
    wait until element is visible    ${FTP_CURRENT_DIR}
    wait until page contains element    ${FTP_CURRENT_DIR}
    Wait Until Element Contains    ${FTP_CURRENT_DIR}    ${dir_name}

go to upper ftp directory
    Wait Until Element Is Visible    ${FTP_UP_DIR}
    ${upper_dir_name}=    Get Text    ${FTP_UPPER_DIR_A}
    Execute Javascript    ${JS_FTP_UP_DIR}
    sleep    ${JS_WAITING_TIME}
    # click element    ${FTP_UP_DIR}
    wait until element is visible    ${FTP_HEAD}
    wait until page contains element    ${FTP_HEAD}
    wait until element is visible    ${FTP_CURRENT_DIR}
    wait until page contains element    ${FTP_CURRENT_DIR}
    ${current_dir_name}=    Get Text    ${FTP_CURRENT_DIR}
    should be equal    ${upper_dir_name}    ${current_dir_name}

get current ftp dir name
    ${current_dir_name}=    Get Text    ${FTP_CURRENT_DIR}
    [return]    ${current_dir_name}

create new ftp directory
    [Arguments]    ${dir_name}
    Wait Until Element Is Visible    ${FTP_NEW_DIR}
    ${if_dir_exists}=    if ftp directory exists    ${dir_name}
    run keyword if    "${if_dir_exists}"=="True"    delete ftp directory    ${dir_name}
    Execute Javascript    ${JS_FTP_NEW_DIR}
    # click element    ${FTP_NEW_DIR}
    Wait Until Element Is Visible    ${FTP_DIR_HEAD}
    input text    ${FTP_DIR_NAME_TEXT}    ${dir_name}
    click element    ${FTP_DIR_OK_INPUT}
    ${locator_replaced_with_real_value}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${FTP_VAR_DIR}    ${dir_name}
    Wait Until Element Is Visible    ${locator_replaced_with_real_value}

cancel creating new ftp directory
    [Arguments]    ${dir_name}
    Wait Until Element Is Visible    ${FTP_NEW_DIR}
    Execute Javascript    ${JS_FTP_NEW_DIR}
    # click element    ${FTP_NEW_DIR}
    Wait Until Element Is Visible    ${FTP_DIR_HEAD}
    click element    ${FTP_DIR_CANCEL_INPUT}
    Wait Until Element Is Visible    ${FTP_HEAD}

if ftp directory exists
    [Arguments]    ${dir_name}
    ${locator_replaced_with_real_value}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${FTP_VAR_DIR}    ${dir_name}
    ${status}=    run keyword and return status    Wait Until Element Is Visible    ${locator_replaced_with_real_value}
    [return]    ${status}

delete ftp directory
    [Arguments]    ${dir_name}
    ${locator_replaced_with_real_value1}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${FTP_VAR_DIR_DELETE}    ${dir_name}
    ${file_dir_index}=    get ftp directory index in table    ${dir_name}
    ${js_replaced_with_real_value}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${JS_FTP_VAR_DIR_DELETE}    ${file_dir_index}
    execute Javascript    window.confirm = function(){ return true;}
    execute Javascript    ${js_replaced_with_real_value}
    sleep    ${JS_WAITING_TIME}
    # click element    ${locator_replaced_with_real_value1}
    # Handle Alert    ACCEPT
    ${if_failure}=    run keyword and return status    Alert Should Be Present    Failed to delete directory. Maybe it is not empty.
    run keyword if    "${if_failure}"=="True"    Fail    Failed to delete directory. Maybe it is not empty.
    wait until element is visible    ${FTP_CURRENT_DIR}
    wait until page contains element    ${FTP_CURRENT_DIR}
    ${locator_replaced_with_real_value2}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${FTP_VAR_DIR}    ${dir_name}
    wait until page does not contain element    ${locator_replaced_with_real_value2}

upload file to ftp
    [Arguments]    ${file_path}    ${file_name}
    Wait Until Element Is Visible    ${FTP_UPLOAD}
    ${if_file_exists}=    if ftp file exists    ${file_name}
    run keyword if    "${if_file_exists}"=="True"    delete ftp file    ${file_name}
    Wait Until Element Is Visible    ${FTP_UPLOAD}
    Execute Javascript    ${JS_FTP_UPLOAD}
    sleep    ${JS_WAITING_TIME}
    # click element    ${FTP_UPLOAD}
    Wait Until Element Is Visible    ${FTP_UPLOAD_FILE}
    Choose File    ${FTP_UPLOAD_FILE}    ${file_path}${/}${file_name}
    Wait Until Element Is Visible    ${FTP_UPLOAD_HEAD}
    click element    ${FTP_UPLOAD_OK_INPUT}
    ${locator_replaced_with_real_value}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${FTP_VAR_FILE}    ${file_name}
    Wait Until Element Is Visible    ${locator_replaced_with_real_value}

cancel uploading file to ftp
    [Arguments]    ${file_path}    ${file_name}
    Wait Until Element Is Visible    ${FTP_UPLOAD}
    Execute Javascript    ${JS_FTP_UPLOAD}
    sleep    ${JS_WAITING_TIME}
    # click element    ${FTP_UPLOAD}
    Wait Until Element Is Visible    ${FTP_UPLOAD_FILE}
    Choose File    ${FTP_UPLOAD_FILE}    ${file_path}${/}${file_name}
    Wait Until Element Is Visible    ${FTP_UPLOAD_HEAD}
    click element    ${FTP_UPLOAD_CANCEL_INPUT}
    Wait Until Element Is Visible    ${FTP_HEAD}

if ftp file exists
    [Arguments]    ${file_name}
    ${locator_replaced_with_real_value}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${FTP_VAR_FILE}    ${file_name}
    ${status}=    run keyword and return status    Wait Until Element Is Visible    ${locator_replaced_with_real_value}
    [return]    ${status}

delete ftp file
    [Arguments]    ${file_name}
    ${locator_replaced_with_real_value1}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${FTP_VAR_FILE_DELETE}    ${file_name}
    wait until element is visible    ${locator_replaced_with_real_value1}
    ${file_index}=    get ftp file index in table    ${file_name}
    ${js_replaced_with_real_value1}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${JS_FTP_VAR_FILE_DELETE}    ${file_index}
    execute Javascript    window.confirm = function(){ return true;}
    execute Javascript    ${js_replaced_with_real_value1}
    sleep    ${JS_WAITING_TIME}
    # click element    ${locator_replaced_with_real_value1}
    # Handle Alert    ACCEPT
    wait until element is visible    ${FTP_HEAD}
    ${locator_replaced_with_real_value2}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${FTP_VAR_FILE}    ${file_name}
    wait until page does not contain element    ${locator_replaced_with_real_value2}

download ftp file by clicking filename
    [Arguments]    ${file_name}    ${download_path}
    ${locator_replaced_with_real_value1}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${FTP_VAR_FILE}    ${file_name}
    Wait Until Element Is Visible    ${locator_replaced_with_real_value1}
    ${file_index}=    get ftp file index in table    ${file_name}
    ${js_replaced_with_real_value1}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${JS_FTP_VAR_FILE}    ${file_index}
    execute Javascript    ${js_replaced_with_real_value1}
    sleep    ${JS_WAITING_TIME}
    # click element    ${locator_replaced_with_real_value1}
    Wait Until Keyword Succeeds    3600    5s    ftp file download should be done    ${download_path}${/}${file_name}
    Remove File    ${download_path}${/}${file_name}

download mutiple ftp files
    [Arguments]    ${file_names}    ${download_path}
    :For    ${file_name}    IN    @{file_names}
    \    ${locator_replaced_with_real_value1}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${FTP_VAR_FILE}    ${file_name}
    \    Wait Until Element Is Visible    ${locator_replaced_with_real_value1}
    \    ${locator_replaced_with_real_value2}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${FTP_VAR_FILE_CHECKBOX}    ${file_name}
    \    click element    ${locator_replaced_with_real_value2}
    execute Javascript    ${JS_FTP_DOWNLOAD}
    sleep    ${JS_WAITING_TIME}
    # click element    ${FTP_DOWNLOAD}
    :For    ${file_name}    IN    @{file_names}
    \        Wait Until Keyword Succeeds    10    5s    ftp file download should be done    ${download_path}${/}${file_name}
    OperatingSystem.List Files In Directory    ${download_path}
    :For    ${file_name}    IN    @{file_names}
    \    OperatingSystem.Remove File    ${download_path}${/}${file_name}

ftp file download should be done
    [Arguments]    ${file_full_path}
    OperatingSystem.File Should Exist    ${file_full_path}

delete mutiple ftp files
    [Arguments]    ${file_names}    ${download_path}
    :For    ${file_name}    IN    @{file_names}
    \    ${locator_replaced_with_real_value1}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${FTP_VAR_FILE}    ${file_name}
    \    Wait Until Element Is Visible    ${locator_replaced_with_real_value1}
    \    ${locator_replaced_with_real_value2}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${FTP_VAR_FILE_CHECKBOX}    ${file_name}
    \    click element    ${locator_replaced_with_real_value2}
    execute Javascript    window.confirm = function(){ return true;}
    execute Javascript    ${JS_FTP_DELETE}
    sleep    ${JS_WAITING_TIME}
    wait until element is visible    ${FTP_HEAD}
    # click element    ${FTP_DELETE}
    :For    ${file_name}    IN    @{file_names}
    \    ${locator_replaced_with_real_value1}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${FTP_VAR_FILE}    ${file_name}
    \    wait until page does not contain element    ${locator_replaced_with_real_value1}

check ftp file size
    [Arguments]    ${file_name}    ${expected_size}
    ${locator_size}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${FTP_VAR_FILE_SIZE}    ${file_name}
    ${locator_file}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${FTP_VAR_FILE}    ${file_name}
    Wait Until Element Is Visible    ${locator_file}
    Wait Until Element Is Visible    ${locator_size}
    ${file_size}=    get text    ${locator_size}
    should be equal    "${expected_size}"    "${file_size}"

rename ftp file
    [Arguments]    ${original_name}    ${target_name}
    ${original_locator_file}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${FTP_VAR_FILE}    ${original_name}
    Wait Until Element Is Visible    ${original_locator_file}
    ${locator_file_rename}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${FTP_VAR_FILE_RENAME}    ${original_name}
    ${file_index}=    get ftp file index in table    ${original_name}
    ${js_replaced_with_real_value1}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${JS_FTP_VAR_FILE_RENAME}    ${file_index}
    execute Javascript    ${js_replaced_with_real_value1}
    sleep    ${JS_WAITING_TIME}
    # click element    ${locator_file_rename}
    Wait Until Element Is Visible    ${FTP_RENAME_FILE_HEAD}
    input text    ${FTP_RENAME_NAME_TEXT}    ${target_name}
    click element    ${FTP_RENAME_OK_INPUT}
    ${target_locator_file}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${FTP_VAR_FILE}    ${target_name}
    Wait Until Element Is Visible    ${target_locator_file}

get ftp file index in table
    [Arguments]    ${file_name}
    ${file_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${FTP_VAR_FILE}    ${file_name}
    ${id}=    Get Element Attribute    ${file_locator}    id
    should match regexp    ${id}    ^nwp_href_\\d+$
    ${index_list}=    get Regexp matches    ${id}    ^nwp_href_(\\d+)$    1
    [Return]    @{index_list}[0]

get ftp directory index in table
    [Arguments]    ${file_dir_name}
    ${file_dir_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${FTP_VAR_DIR}    ${file_dir_name}
    ${id}=    Get Element Attribute    ${file_dir_locator}    id
    should match regexp    ${id}    ^nwp_href_\\d+$
    ${index_list}=    get Regexp matches    ${id}    ^nwp_href_(\\d+)$    1
    [Return]    @{index_list}[0]

get ftp directory index value in table
    [Arguments]    ${file_dir_name}
    ${file_dir_checkout_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${FTP_VAR_DIR_CHECKBOX}    ${file_dir_name}
    ${value}=    Get Element Attribute    ${file_dir_checkout_locator}    value
    should match regexp    ${value}    ^[0-9A-Z]+$
    [Return]    ${value}

