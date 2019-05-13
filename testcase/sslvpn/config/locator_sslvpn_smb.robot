*** Settings ***
Documentation     This file contains all locator variables on SMB GUI v6.2

*** Variables ***
#Format Definition: ${LOCATION_FRAME-NAME_FRAME-TYPE}###
##First page
${SMB_FIRST_VAR_DIR}    xpath://a[text()="\${PLACEHOLDER}"]

##Main Page
${SMB_HEAD}    id:nwp_curr_dir
${SMB_CURRENT_DIR}    id:nwp_dir_last
${SMB_UPPER_DIR_A}    xpath://a[@id="nwp_dir_last"]/preceding-sibling::a[1]
${SMB_UP_DIR}    xpath://a[img[@id="up_dir_img"]]
${SMB_NEW_DIR}    xpath://a[img[@id="new_dir_img"]]
${SMB_UPLOAD}    xpath://a[img[@id="new_file_img"]]
${SMB_LOGOUT}    xpath://a[img[@id="logout_img"]]
${SMB_DOWNLOAD}    xpath://a[img[@title="Download"]]
${SMB_DELETE}    xpath://a[img[@id="delete_selected_files_img"]]
${SMB_VAR_FILE}    xpath://td[following-sibling::td[text()="File"]]/a[text()="\${PLACEHOLDER}"]
${SMB_VAR_DIR}    xpath://td[following-sibling::td[text()="Folder"]]/a[text()="\${PLACEHOLDER}"]
${SMB_VAR_FILE_CHECKBOX}    xpath://td[a="\${PLACEHOLDER}"]/preceding-sibling::td/input[@type="checkbox"]
${SMB_VAR_FILE_DIR_DELETE}    xpath://td[a="\${PLACEHOLDER}"]/following-sibling::td/a[img[@title="Delete"]]
${SMB_VAR_FILE_DIR_RENAME}    xpath://td[a="\${PLACEHOLDER}"]/following-sibling::td/a[img[@title="Rename"]]
${SMB_VAR_FILE_SIZE}    xpath://td[a="\${PLACEHOLDER}"]/following-sibling::td[1]
${SMB_VAR_DIR_CHECKBOX}    xpath://td[a="\${PLACEHOLDER}"]/preceding-sibling::td/input[@type="checkbox"]


##New Directory Page
${SMB_DIR_HEAD}    xpath://td[text()="New Directory"]
${SMB_DIR_NAME_TEXT}    name:dir_name
${SMB_DIR_OK_INPUT}    id:ok_but
${SMB_DIR_CANCEL_INPUT}    id:cancel_but

##Upload file
${SMB_UPLOAD_HEAD}    xpath://td[text()="Upload File"]
${SMB_UPLOAD_FILE}    name:srcfile
${SMB_UPLOAD_OK_INPUT}    id:ok_but
${SMB_UPLOAD_CANCEL_INPUT}    id:cancel_but

##Rename directory
${SMB_RENAME_FILE_HEAD}    xpath://td[text()="Rename File"]
${SMB_RENAME_DIR_HEAD}    xpath://td[text()="Rename Directory"]
${SMB_RENAME_NAME_TEXT}    name:newfilename
${SMB_RENAME_OK_INPUT}    id:ok_but
${SMB_RENAME_CANCEL_INPUT}    id:cancel_but