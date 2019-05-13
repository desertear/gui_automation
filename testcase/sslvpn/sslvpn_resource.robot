*** Settings ***
Documentation    import all resource and lib files of SSLVPN
##import all resource and lib files used by all features.
Resource    ../../common_resource.robot
##SSLVPN GUI keywords
Resource    ./lib/sslvpn_gui.robot
Resource    ./lib/sslvpn_ftp_gui.robot
Resource    ./lib/sslvpn_smb_gui.robot
Resource    ./lib/sslvpn_forticlient.robot
##Variable files
Resource    ./config/${SSLVPN_ENV}
##Locator files
Resource    ./config/locator_sslvpn.robot
Resource    ./config/locator_sslvpn_servers.robot
Resource    ./config/locator_sslvpn_ftp.robot
Resource    ./config/locator_sslvpn_sftp.robot
Resource    ./config/locator_sslvpn_smb.robot
##Javascript function files
Resource    ./config/js_sslvpn_ftp.robot
Resource    ./config/js_sslvpn_smb.robot