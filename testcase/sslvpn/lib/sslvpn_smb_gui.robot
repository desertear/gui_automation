*** Settings ***
Documentation     This file contains SSLVPN SMB page operation

*** Variables ***

*** Keywords ***
##Go to dir specified for automation test
go to smb upper most directory
    [Arguments]    ${dir_name}
    ${locator_replaced_with_real_value}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SMB_FIRST_VAR_DIR}    ${dir_name}
    Wait Until Element Is Visible    ${locator_replaced_with_real_value}
    ${file_dir_index_value}=    get smb directory index value in table    ${dir_name}
    execute Javascript    browse_file('${file_dir_index_value}','${dir_name}')
    # click element    ${locator_replaced_with_real_value}
    sleep    ${JS_WAITING_TIME}
    wait until element is visible    ${SMB_HEAD}
    wait until page contains element    ${SMB_HEAD}
    Wait Until Element Is Visible    ${SMB_CURRENT_DIR}
    wait until page contains element    ${SMB_CURRENT_DIR}
    Wait Until Element Contains    ${SMB_CURRENT_DIR}    ${dir_name}


go to smb directory
    [Arguments]    ${dir_name}
    ${locator_replaced_with_real_value}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SMB_VAR_DIR}    ${dir_name}
    Wait Until Element Is Visible    ${locator_replaced_with_real_value}
    ${dir_index_value}=    get smb directory index value in table    ${dir_name}
    ${js_replaced_with_real_value}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${JS_SMB_VAR_DIR}    ${dir_index_value}
    execute Javascript    ${js_replaced_with_real_value}
    sleep    ${JS_WAITING_TIME}
    # click element    ${locator_replaced_with_real_value}
    wait until element is visible    ${SMB_HEAD}
    wait until page contains element    ${SMB_HEAD}
    Wait Until Element Is Visible    ${SMB_CURRENT_DIR}
    wait until page contains element    ${SMB_CURRENT_DIR}
    Wait Until Element Contains    ${SMB_CURRENT_DIR}    ${dir_name}

go to upper smb directory
    Wait Until Element Is Visible    ${SMB_UP_DIR}
    ${upper_dir_name}=    Get Text    ${SMB_UPPER_DIR_A}
    Execute Javascript    ${JS_SMB_UP_DIR}
    sleep    ${JS_WAITING_TIME}
    # click element    ${SMB_UP_DIR}
    wait until element is visible    ${SMB_HEAD}
    Wait Until Element Is Visible    ${SMB_CURRENT_DIR}
    ${current_dir_name}=    Get Text    ${SMB_CURRENT_DIR}
    should be equal    ${upper_dir_name}    ${current_dir_name}

get current smb dir name
    Wait Until Element Is Visible    ${SMB_CURRENT_DIR}
    ${current_dir_name}=    Get Text    ${SMB_CURRENT_DIR}
    [return]    ${current_dir_name}

create new smb directory
    [Arguments]    ${dir_name}
    Wait Until Element Is Visible    ${SMB_NEW_DIR}
    ${if_dir_exists}=    if smb directory exists    ${dir_name}
    run keyword if    "${if_dir_exists}"=="True"    delete smb directory    ${dir_name}
    Execute Javascript    ${JS_SMB_NEW_DIR}
    sleep    ${JS_WAITING_TIME}
    # click element    ${SMB_NEW_DIR}
    Wait Until Element Is Visible    ${SMB_DIR_HEAD}
    input text    ${SMB_DIR_NAME_TEXT}    ${dir_name}
    click element    ${SMB_DIR_OK_INPUT}
    ${locator_replaced_with_real_value}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SMB_VAR_DIR}    ${dir_name}
    Wait Until Element Is Visible    ${locator_replaced_with_real_value}

if smb directory exists
    [Arguments]    ${dir_name}
    ${locator_replaced_with_real_value}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SMB_VAR_DIR}    ${dir_name}
    ${status}=    run keyword and return status    Wait Until Element Is Visible    ${locator_replaced_with_real_value}
    [return]    ${status}

delete smb directory
    [Arguments]    ${dir_name}
    ${locator_replaced_with_real_value1}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SMB_VAR_FILE_DIR_DELETE}    ${dir_name}
    ${dir_index}=    get smb directory index in table    ${dir_name}
    ${js_replaced_with_real_value}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${JS_SMB_VAR_FILE_DIR_DELETE}    ${dir_index}
    execute Javascript    window.confirm = function(){ return true;}
    execute Javascript    ${js_replaced_with_real_value}
    sleep    ${JS_WAITING_TIME}
    # click element    ${locator_replaced_with_real_value1}
    # Handle Alert    ACCEPT
    ${if_failure}=    run keyword and return status    Alert Should Be Present    Failed to delete directory. Maybe it is not empty.
    run keyword if    "${if_failure}"=="True"    Fail    Failed to delete directory. Maybe it is not empty.
    wait until element is visible    ${SMB_HEAD}
    ${locator_replaced_with_real_value2}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SMB_VAR_DIR}    ${dir_name}
    wait until page does not contain element    ${locator_replaced_with_real_value2}

upload file to smb
    [Arguments]    ${file_path}    ${file_name}
    Wait Until Element Is Visible    ${SMB_UPLOAD}
    ${if_file_exists}=    if smb file exists    ${file_name}
    run keyword if    "${if_file_exists}"=="True"    delete smb file    ${file_name}
    Wait Until Element Is Visible    ${SMB_UPLOAD}
    execute Javascript    ${JS_SMB_UPLOAD}
    sleep    ${JS_WAITING_TIME}
    # click element    ${SMB_UPLOAD}
    Wait Until Element Is Visible    ${SMB_UPLOAD_FILE}
    Choose File    ${SMB_UPLOAD_FILE}    ${file_path}${/}${file_name}
    Wait Until Element Is Visible    ${SMB_UPLOAD_HEAD}
    click element    ${SMB_UPLOAD_OK_INPUT}
    ${locator_replaced_with_real_value}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SMB_VAR_FILE}    ${file_name}
    Wait Until Element Is Visible    ${locator_replaced_with_real_value}

if smb file exists
    [Arguments]    ${file_name}
    ${locator_replaced_with_real_value}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SMB_VAR_FILE}    ${file_name}
    ${status}=    run keyword and return status    Wait Until Element Is Visible    ${locator_replaced_with_real_value}
    [return]    ${status}

delete smb file
    [Arguments]    ${file_name}
    ${locator_replaced_with_real_value1}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SMB_VAR_FILE_DIR_DELETE}    ${file_name}
    ${file_index}=    get smb file index in table    ${file_name}
    ${js_replaced_with_real_value}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${JS_SMB_VAR_FILE_DIR_DELETE}    ${file_index}
    execute Javascript    window.confirm = function(){ return true;}
    execute Javascript    ${js_replaced_with_real_value}
    sleep    ${JS_WAITING_TIME}
    # click element    ${locator_replaced_with_real_value1}
    # Handle Alert    ACCEPT
    wait until element is visible    ${SMB_HEAD}
    ${locator_replaced_with_real_value2}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SMB_VAR_FILE}    ${file_name}
    wait until page does not contain element    ${locator_replaced_with_real_value2}

download smb file by clicking filename
    [Arguments]    ${file_name}    ${download_path}
    ${locator_replaced_with_real_value1}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SMB_VAR_FILE}    ${file_name}
    Wait Until Element Is Visible    ${locator_replaced_with_real_value1}
    ${file_index}=    get smb file index in table    ${file_name}
    ${js_replaced_with_real_value}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${JS_SMB_VAR_FILE}    ${file_index}
    execute Javascript    ${js_replaced_with_real_value}
    sleep    ${JS_WAITING_TIME}
    # click element    ${locator_replaced_with_real_value1}
    Wait Until Keyword Succeeds    10    5s    smb file download should be done    ${download_path}${/}${file_name}
    Remove File    ${download_path}${/}${file_name}

download mutiple smb files
    [Arguments]    ${file_names}    ${download_path}
    :For    ${file_name}    IN    @{file_names}
    \    ${locator_replaced_with_real_value1}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SMB_VAR_FILE}    ${file_name}
    \    Wait Until Element Is Visible    ${locator_replaced_with_real_value1}
    \    ${locator_replaced_with_real_value2}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SMB_VAR_FILE_CHECKBOX}    ${file_name}
    \    click element    ${locator_replaced_with_real_value2}
    execute Javascript    ${JS_SMB_DOWNLOAD}
    sleep    ${JS_WAITING_TIME}
    # click element    ${SMB_DOWNLOAD}
    :For    ${file_name}    IN    @{file_names}
    \        Wait Until Keyword Succeeds    10    5s    smb file download should be done    ${download_path}${/}${file_name}
    OperatingSystem.List Files In Directory    ${download_path}
    :For    ${file_name}    IN    @{file_names}
    \    Remove File    ${download_path}${/}${file_name}

smb file download should be done
    [Arguments]    ${file_full_path}
    OperatingSystem.File Should Exist    ${file_full_path}

check smb file size
    [Arguments]    ${file_name}    ${expected_size}
    ${locator_size}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SMB_VAR_FILE_SIZE}    ${file_name}
    ${locator_file}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SMB_VAR_FILE}    ${file_name}
    Wait Until Element Is Visible    ${locator_file}
    Wait Until Element Is Visible    ${locator_size}
    ${file_size}=    get text    ${locator_size}
    should be equal    "${expected_size}"    "${file_size}"

rename smb file
    [Arguments]    ${original_name}    ${target_name}
    ${original_locator_file}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SMB_VAR_FILE}    ${original_name}
    Wait Until Element Is Visible    ${original_locator_file}
    ${locator_file_rename}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SMB_VAR_FILE_DIR_RENAME}    ${original_name}
    Wait Until Element Is Visible    ${locator_file_rename}
    ${file_index}=    get smb file index in table    ${original_name}
    ${js_replaced_with_real_value}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${JS_SMB_VAR_FILE_DIR_RENAME}    ${file_index}
    execute Javascript    ${js_replaced_with_real_value}
    sleep    ${JS_WAITING_TIME}
    # click element    ${locator_file_rename}
    Wait Until Element Is Visible    ${SMB_RENAME_FILE_HEAD}
    input text    ${SMB_RENAME_NAME_TEXT}    ${target_name}
    click element    ${SMB_RENAME_OK_INPUT}
    ${target_locator_file}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SMB_VAR_FILE}    ${target_name}
    Wait Until Element Is Visible    ${target_locator_file}


rename smb directory
    [Arguments]    ${original_name}    ${target_name}
    ${original_locator_file}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SMB_VAR_DIR}    ${original_name}
    Wait Until Element Is Visible    ${original_locator_file}
    ${locator_file_rename}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SMB_VAR_FILE_DIR_RENAME}    ${original_name}
    ${dir_index}=    get smb directory index in table    ${original_name}
    ${js_replaced_with_real_value}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${JS_SMB_VAR_FILE_DIR_RENAME}    ${dir_index}
    execute Javascript    ${js_replaced_with_real_value}
    sleep    ${JS_WAITING_TIME}
    # click element    ${locator_file_rename}
    Wait Until Element Is Visible    ${SMB_RENAME_DIR_HEAD}
    input text    ${SMB_RENAME_NAME_TEXT}    ${target_name}
    click element    ${SMB_RENAME_OK_INPUT}
    ${target_locator_file}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SMB_VAR_DIR}    ${target_name}
    Wait Until Element Is Visible    ${target_locator_file}

get smb file index in table
    [Arguments]    ${file_name}
    ${file_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SMB_VAR_FILE}    ${file_name}
    ${id}=    Get Element Attribute    ${file_locator}    id
    should match regexp    ${id}    ^nwp_href_\\d+$
    ${index_list}=    get Regexp matches    ${id}    ^nwp_href_(\\d+)$    1
    [Return]    @{index_list}[0]

get smb directory index in table
    [Arguments]    ${file_dir_name}
    ${file_dir_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SMB_VAR_DIR}    ${file_dir_name}
    ${id}=    Get Element Attribute    ${file_dir_locator}    id
    should match regexp    ${id}    ^nwp_href_\\d+$
    ${index_list}=    get Regexp matches    ${id}    ^nwp_href_(\\d+)$    1
    [Return]    @{index_list}[0]

get smb directory index value in table
    [Arguments]    ${file_dir_name}
    ${file_dir_checkout_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SMB_VAR_DIR_CHECKBOX}    ${file_dir_name}
    ${value}=    Get Element Attribute    ${file_dir_checkout_locator}    value
    should match regexp    ${value}    ^[0-9A-Z]+$
    [Return]    ${value}