*** Settings ***
Documentation     This file contains all locator variables on FTP GUI v6.2

*** Variables ***
#Format Definition: ${LOCATION_FRAME-NAME_FRAME-TYPE}###
##Main Page
${FTP_HEAD}    id:nwp_curr_dir
${FTP_CURRENT_DIR}    id:nwp_dir_last
${FTP_UPPER_DIR_A}    xpath://a[@id="nwp_dir_last"]/preceding-sibling::a[1]
${FTP_UP_DIR}    xpath://a[img[@id="up_dir_img"]]
${FTP_NEW_DIR}    xpath://a[img[@id="new_dir_img"]]
${FTP_UPLOAD}    xpath://a[img[@id="new_file_img"]]
${FTP_LOGOUT}    xpath://a[img[@id="logout_img"]]
${FTP_DOWNLOAD}    xpath://a[img[@title="Download"]]
${FTP_DELETE}    xpath://a[img[@id="delete_selected_files_img"]]
${FTP_VAR_FILE}    xpath://td[following-sibling::td[text()="File"]]/a[text()="\${PLACEHOLDER}"]
${FTP_VAR_DIR}    xpath://td[following-sibling::td[text()="Folder"]]/a[text()="\${PLACEHOLDER}"]
${FTP_VAR_FILE_CHECKBOX}    xpath://td[a="\${PLACEHOLDER}"]/preceding-sibling::td/input[@type="checkbox"]
${FTP_VAR_FILE_DELETE}    xpath://td[a="\${PLACEHOLDER}"]/following-sibling::td/a[img[@title="Delete"]]
${FTP_VAR_FILE_RENAME}    xpath://td[a="\${PLACEHOLDER}"]/following-sibling::td/a[img[@title="Rename"]]
${FTP_VAR_FILE_SIZE}    xpath://td[a="\${PLACEHOLDER}"]/following-sibling::td[1]

${FTP_VAR_DIR_CHECKBOX}    xpath://td[a="\${PLACEHOLDER}"]/preceding-sibling::td/input[@type="checkbox"]
${FTP_VAR_DIR_DELETE}    xpath://td[a="\${PLACEHOLDER}" and following-sibling::td[text()="Folder"]]/following-sibling::td/a[img[@title="Delete"]]
${FTP_VAR_DIR_RENAME}    xpath://td[a="\${PLACEHOLDER}" and following-sibling::td[text()="Folder"]]/following-sibling::td/a[img[@title="Rename"]]

##New Directory Page
${FTP_DIR_HEAD}    xpath://td[text()="New Directory"]
${FTP_DIR_NAME_TEXT}    name:dir_name
${FTP_DIR_OK_INPUT}    id:ok_but
${FTP_DIR_CANCEL_INPUT}    id:cancel_but

##Upload file
${FTP_UPLOAD_HEAD}    xpath://td[text()="Upload File"]
${FTP_UPLOAD_FILE}    name:srcfile
${FTP_UPLOAD_OK_INPUT}    id:ok_but
${FTP_UPLOAD_CANCEL_INPUT}    id:cancel_but

##Rename directory
${FTP_RENAME_FILE_HEAD}    xpath://td[text()="Rename File"]
${FTP_RENAME_DIR_HEAD}    xpath://td[text()="Rename Directory"]
${FTP_RENAME_NAME_TEXT}    name:newfilename
${FTP_RENAME_OK_INPUT}    id:ok_but
${FTP_RENAME_CANCEL_INPUT}    id:cancel_but