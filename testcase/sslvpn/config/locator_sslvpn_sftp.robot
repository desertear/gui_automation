*** Settings ***
Documentation     This file contains all locator variables on SFTP GUI v6.2

*** Variables ***
#Format Definition: ${LOCATION_FRAME-NAME_FRAME-TYPE}###
##Main Page
${SFTP_HEAD}    id:nwp_curr_dir
${SFTP_CURRENT_DIR}    id:nwp_dir_last
${SFTP_UPPER_DIR_A}    xpath://a[@id="nwp_dir_last"]/preceding-sibling::a[1]
${SFTP_UP_DIR}    xpath://a[img[@id="up_dir_img"]]
${SFTP_NEW_DIR}    xpath://a[img[@id="new_dir_img"]]
${SFTP_UPLOAD}    xpath://a[img[@id="new_file_img"]]
${SFTP_LOGOUT}    xpath://a[img[@id="logout_img"]]
${SFTP_DOWNLOAD}    xpath://a[img[@title="Download"]]
${SFTP_DELETE}    xpath://a[img[@id="delete_selected_files_img"]]
${SFTP_VAR_FILE}    xpath://td[following-sibling::td[text()="File"]]/a[text()="\${PLACEHOLDER}"]
${SFTP_VAR_DIR}    xpath://td[following-sibling::td[text()="Folder"]]/a[text()="\${PLACEHOLDER}"]
${SFTP_VAR_FILE_CHECKBOX}    xpath://td[a="\${PLACEHOLDER}"]/preceding-sibling::td/input[@type="checkbox"]
${SFTP_VAR_FILE_DELETE}    xpath://td[a="\${PLACEHOLDER}"]/following-sibling::td/a[img[@title="Delete"]]
${SFTP_VAR_FILE_RENAME}    xpath://td[a="\${PLACEHOLDER}"]/following-sibling::td/a[img[@title="Rename"]]
${SFTP_VAR_FILE_SIZE}    xpath://td[a="\${PLACEHOLDER}"]/following-sibling::td[1]

${SFTP_VAR_DIR_CHECKBOX}    xpath://td[a="\${PLACEHOLDER}"]/preceding-sibling::td/input[@type="checkbox"]
${SFTP_VAR_DIR_DELETE}    xpath://td[a="\${PLACEHOLDER}" and following-sibling::td[text()="Folder"]]/following-sibling::td/a[img[@title="Delete"]]
${SFTP_VAR_DIR_RENAME}    xpath://td[a="\${PLACEHOLDER}" and following-sibling::td[text()="Folder"]]/following-sibling::td/a[img[@title="Rename"]]

##New Directory Page
${SFTP_DIR_HEAD}    xpath://td[text()="New Directory"]
${SFTP_DIR_NAME_TEXT}    name:dir_name
${SFTP_DIR_OK_INPUT}    id:ok_but
${SFTP_DIR_CANCEL_INPUT}    id:cancel_but

##Upload file
${SFTP_UPLOAD_HEAD}    xpath://td[text()="Upload File"]
${SFTP_UPLOAD_FILE}    name:srcfile
${SFTP_UPLOAD_OK_INPUT}    id:ok_but
${SFTP_UPLOAD_CANCEL_INPUT}    id:cancel_but

##Rename directory
${SFTP_RENAME_FILE_HEAD}    xpath://td[text()="Rename File"]
${SFTP_RENAME_DIR_HEAD}    xpath://td[text()="Rename Directory"]
${SFTP_RENAME_NAME_TEXT}    name:newfilename
${SFTP_RENAME_OK_INPUT}    id:ok_but
${SFTP_RENAME_CANCEL_INPUT}    id:cancel_but