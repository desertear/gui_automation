*** Settings ***
Documentation     This file contains all Javascript function names and parameters used to operate SSLVPN SMB GUI

*** Variables ***
${JS_SMB_FIRST_VAR_DIR}    browse_file('\${PLACEHOLDER1}','\${PLACEHOLDER2}')

##Main Page
${JS_SMB_UP_DIR}    up_dir()
${JS_SMB_NEW_DIR}    new_dir("/remote/network/mkdir",4)
${JS_SMB_UPLOAD}    upload_file("/remote/network/upload",4)
${JS_SMB_DOWNLOAD}    download_selected_files()
${JS_SMB_VAR_FILE}    download_file(\${PLACEHOLDER})
${JS_SMB_VAR_DIR}    browse_file('\${PLACEHOLDER}','5')

${JS_SMB_VAR_FILE_DIR_DELETE}    delete_selected_files('\${PLACEHOLDER}')
${JS_SMB_VAR_FILE_DIR_RENAME}    rename_file('\${PLACEHOLDER}')