*** Settings ***
Documentation     This file contains all Javascript function names and parameters used to operate SSLVPN FTP GUI

*** Variables ***
${JS_FTP_UP_DIR}    up_dir()
${JS_FTP_NEW_DIR}    new_dir("/remote/network/mkdir",5)
${JS_FTP_UPLOAD}    upload_file("/remote/network/upload",5)
${JS_FTP_LOGOUT}    net_logout("/remote/network/logout")
${JS_FTP_DOWNLOAD}    download_selected_files()
${JS_FTP_DELETE}    delete_selected_files()
${JS_FTP_VAR_FILE}    download_file(\${PLACEHOLDER})
${JS_FTP_VAR_DIR}    browse_file('\${PLACEHOLDER}','5')
${JS_FTP_VAR_FILE_DELETE}    delete_selected_files('\${PLACEHOLDER}')
${JS_FTP_VAR_FILE_RENAME}    rename_file('\${PLACEHOLDER}')
${JS_FTP_VAR_DIR_DELETE}    delete_selected_files('\${PLACEHOLDER}')