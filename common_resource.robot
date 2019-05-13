*** Settings ***
#Warning!!!: Please don't forget to update locator files and keyword files whenever you change the reference here.
Documentation    import all resource and lib files used by all features.
Library    SeleniumLibrary
Library    SSHLibrary
Library    pyautogui
Library    String
Library    Telnet
Library    Collections
Library    OperatingSystem
Library    lib.OrioleOperation
Library    JSONLibrary
Library    lib.PrivateKeywords

Resource    ./lib/common.robot
##FGT GUI keywords
Resource    ./lib/fgt_cli.robot
Resource    ./lib/pc_ssh.robot
Resource    ./lib/fgt_gui.robot
Resource    ./lib/fgt_gui_sslvpn.robot
Resource    ./lib/fgt_gui_ipsec.robot
Resource    ./lib/fgt_gui_user_definiton.robot
Resource    ./lib/fgt_gui_user_group.robot
Resource    ./lib/fgt_gui_user_ldap.robot
Resource    ./lib/fgt_gui_user_radius.robot
Resource    ./lib/fgt_gui_policy.robot
Resource    ./lib/fgt_gui_policy_object.robot
Resource    ./lib/fgt_gui_shaping.robot
Resource    ./lib/fgt_gui_multicast.robot
Resource    ./lib/fgt_gui_policy46_64.robot
Resource    ./lib/fgt_gui_fw_acl.robot
Resource    ./lib/fgt_gui_network.robot
Resource    ./lib/fgt_gui_system.robot
Resource    ./lib/fgt_gui_monitor.robot
Resource    ./lib/fgt_gui_securityprofile_app.robot
Resource    ./lib/fgt_gui_system_certificates.robot
Resource    ./lib/fgt_gui_securityprofile_dlp.robot
Resource    ./lib/fgt_gui_securityprofile_webfilter.robot
Resource    ./lib/fgt_gui_securityprofile_voip.robot
Resource    ./lib/fgt_gui_wanopt.robot
Resource    ./lib/fgt_gui_securityprofile_ips.robot

##Variable files
Resource    ./config/${FGT_ENV}

##Locator files
Resource    ./config/locator/locator_fgt.robot
Resource    ./config/locator/locator_menu.robot
Resource    ./config/locator/locator_android_forticlent.robot
Resource    ./config/locator/locator_dashboard.robot
Resource    ./config/locator/locator_log_report.robot
Resource    ./config/locator/locator_login.robot
Resource    ./config/locator/locator_monitor.robot
Resource    ./config/locator/locator_network.robot
Resource    ./config/locator/locator_shaping.robot
Resource    ./config/locator/locator_policy46_64.robot
Resource    ./config/locator/locator_multicast.robot
Resource    ./config/locator/locator_policy.robot
Resource    ./config/locator/locator_policy_objects.robot
Resource    ./config/locator/locator_fw_acl.robot
Resource    ./config/locator/locator_system.robot
Resource    ./config/locator/locator_user_definition.robot
Resource    ./config/locator/locator_user_group.robot
Resource    ./config/locator/locator_user_ldap.robot
Resource    ./config/locator/locator_user_radius.robot
Resource    ./config/locator/locator_sslvpn.robot
Resource    ./config/locator/locator_securityprofile_appctrl.robot
Resource    ./config/locator/locator_system_certificates.robot
Resource    ./config/locator/locator_securityprofile_dlp.robot
Resource    ./config/locator/locator_securityprofile_webfilter.robot
Resource    ./config/locator/locator_securityprofile_voip.robot
Resource    ./config/locator/locator_wanopt.robot
Resource    ./config/locator/locator_securityprofile_ips.robot
