*** Settings ***
Documentation    import all resource and lib files of Fortiview
##import all resource and lib files used by all features.
Resource    ../../common_resource.robot
##Fortiview GUI keywords
Resource    ./lib/fortiview_gui.robot
#Resource    ./lib/sslvpn_ftp_gui.robot
#Resource    ./lib/sslvpn_smb_gui.robot
##PC1 setup keywords
Resource    ./lib/pcsetup.robot

##Variable files
Resource    ./config/${FORTIVIEW_ENV}
##Locator files
Resource    ./config/locator_fortiview.robot
#Resource    ./config/${VERSION}/locator_sslvpn_ftp.robot
#Resource    ./config/${VERSION}/locator_sslvpn_smb.robot
##Javascript function files
#Resource    ./config/${VERSION}/js_sslvpn_ftp.robot
#Resource    ./config/${VERSION}/js_sslvpn_smb.robot