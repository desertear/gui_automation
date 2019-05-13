*** Settings ***
Documentation    upgrade FGT and compare GUI Screenshots
Suite Setup    begin fgt test
Resource    ./upgrade_resource.robot
Suite Teardown    clear up

*** Variables ***
#please refer to env file env_upgrade.robot under ./config/6.0/
${image_dir}    C:${/}sslvpn_automation${/}script${/}image_comparison${/}screenshot1
${baseline_image_dir}    ${image_dir}${/}baseline
${diff_image_dir}    ${image_dir}${/}diff
${append_image_dir}    ${image_dir}${/}append
${report_dir}    C:${/}sslvpn_automation${/}script${/}image_comparison${/}report
${target_firmware_name}    FGT_301E-v6-build0163-FORTINET.out
${baseline_firmware_name}    FGT_301E-v6-build0131-FORTINET.out
${server_ip}    ${TFTP_IMAGE_SERVER_IP}
${image_server_type}    tftp
# ${image_server_dir}    /home/images02/FortiOS/v6.00/images/build0152/
${image_server_username}    test
${image_server_password}    test
&{dic_file}    vdom1=vdom1    vdom2=1234567890    vdom3=abcdefghijk    vdom4=root    interface1=emacvlan2001    interface2=emacvlan2003    interface3=sf_sw1    interface4=ssid_intf1    interface5=port1
...    interface6=vlan1104    interface7=vlan1106    interface8=s2s    interface9=port2    interface10=vlan1105    interface11=vlan1107
...    interface12=pppoe_intf    interface13=test-vpn-cer    interface14=test-vpn-key    interface15=dailup1    zone=zone_fgta
...    policy4_id1=1000    policy4_id2=1001    policy4_id3=1002    policy4_id4=1    policy4_id5=6    policy4_id6=7001    policy4_id7=7    policy4_id8=8
...    policy6_id1=7001    address_name1=test-vpn-cer_range    address_name2=test-vpn-key_range    address_name3=vlan30
...    av_profile=FIPS-CC    web_profile=FIPS-CC    dns_profile=FIPS-CC    app_profile=FIPS-CC    ips_profile=FIPS-CC    spam_profile=FIPS-CC    dlp_profile=FIPS-CC
...    ssl_ssh_profile=FIPS-CC    ipsec_vpn1=dailup1    ipsec_vpn2=s2s    ipsec_vpn3=test-vpn-cer    ipsec_vpn4=test-vpn-key    sslvpn1=test-portal1
...    user1=localuser    user2=raduser    user3=tacuser    user4=testuser1    user5=user
...    usergrp1=ldap-grp    usergrp2=pkigrp    usergrp3=rad-grp    usergrp4=ssltestug    usergrp5=tac-grp    usergrp6=tokengrp    usergrp7=usergrp
...    ldap_srv1=ldap-srv    rad_srv1=rad-srv    rad_srv2=rad-token-testing    tac_srv1=tac-srv    pki_user1=peer1    pki_user2=pkipeer    pki_user3=test-vpn-cer_peer
${url_file}    C:${/}sslvpn_automation${/}script${/}image_comparison${/}config${/}${VERSION}${/}url_list.txt
# ${url_file_autotcl}    C:${/}sslvpn_automation${/}script${/}image_comparison${/}config${/}${VERSION}${/}urls_used_by_autotcl.txt
${url_file_autotcl}    C:${/}sslvpn_automation${/}script${/}image_comparison${/}config${/}${VERSION}${/}urls_used_by_autotcl_fipscc.txt
${rule_file}    C:${/}sslvpn_automation${/}script${/}image_comparison${/}config${/}${VERSION}${/}comparison_rule.txt
${fgt_url_local}    ${FGT_URL}

*** Test Cases ***
Run by autotcl
    [Tags]    autotcl
    [Timeout]    NONE
    ${scores}    ${append_file_pathes}    ${messages}=    capture Screenshots and compare them with baseline for AutoTcl    chrome    ${fgt_url_local}    ${FGT_GUI_USERNAME}    ${FGT_GUI_PASSWORD}    780675    FGT_301E    v6    0131
    ...    v6    0163    ${baseline_image_dir}    ${image_dir}    ${diff_image_dir}    ${append_image_dir}    ${report_dir}    ${url_file_autotcl}    ${rule_file}    ${1}    &{dic_file}

upgrade FGT and compare GUI Screenshots
    [Tags]    norun
    #define Screenshots name prefix of source firmware according to pltf type and build number
    ${source_screenshot_file_name_prefix}=    set variable    ${FGT_TYPE}_${FGT_VERSION}_b${FGT_BUILD}

    Login FortiGate    url=${fgt_url_local}    browser=chrome    username=${FGT_GUI_USERNAME}    password=${FGT_GUI_PASSWORD}
    ${source_screenshot_name_list}=    go to urls and capture Screenshots    ${fgt_url_local}    ${url_file}    ${source_screenshot_file_name_prefix}    &{dic_file}
    Logout FortiGate
    close browser

    ${source_screenshot_path_list}=    append dir path to filenames    ${image_dir}    ${source_screenshot_name_list}

    #upgrade FGT using CLI
    upgrde FGT using CLI and wait until it is finished    ${target_firmware_name}    ${image_server_type}    ${server_ip}    ${FGT_CLI_FGT_INTERNAL_IP}    image_server_username=${image_server_username}    image_server_password=${image_server_password}

    #define Screenshots name prefix of target firmware according to pltf type and build number
    ${target_build_number_list}=    get Regexp Matches    ${target_firmware_name}    .*\-build(\\d{4})\-    1
    ${target_build_number}=    set variable    @{target_build_number_list}[0]
    ${target_screenshot_file_name_prefix}=    set variable    ${FGT_TYPE}_${FGT_VERSION}_b${target_build_number}

    Login FortiGate    url=${fgt_url_local}    browser=chrome    username=${FGT_GUI_USERNAME}    password=${FGT_GUI_PASSWORD}
    ${target_screenshot_name_list}=    go to urls and capture Screenshots    ${fgt_url_local}    ${url_file}    ${target_screenshot_file_name_prefix}    &{dic_file}
    Logout FortiGate

    ${target_screenshot_path_list}=    append dir path to filenames    ${image_dir}    ${target_screenshot_name_list}
    ${scores}=    compare images captured from many urls    ${source_screenshot_path_list}    ${target_screenshot_path_list}    ${diff_image_dir}    ${append_image_dir}    ${1}


    ${pltf_info}=    set variable    upgrade from ${FGT_TYPE} ${FGT_VERSION} b${FGT_BUILD} to ${FGT_TYPE} ${FGT_VERSION} b${target_build_number}\r\#\#\#\#all Screenshots are stored in directory ${image_dir}\#\#\#\#
    create page comparison report     ${report_dir}${/}gui_comparison_report_${RUNNING_TIME}.txt    ${pltf_info}    ${source_screenshot_name_list}    ${target_screenshot_name_list}    ${scores}

    run keyword and ignore error    run and return rc and output    del ${image_dir}${/}selenium*

generate GUI Screenshots as baseline
    [Tags]    baseline
    ${ori_dir}=    set Screenshot Directory    ${baseline_image_dir}
    #define Screenshots name prefix of target firmware according to pltf type and build number
    ${baseline_build_number_list}=    get Regexp Matches    ${baseline_firmware_name}    .*\-build(\\d{4})\-    1
    ${baseline_build_number}=    set variable    @{baseline_build_number_list}[0]
    ${baseline_version_list}=    get Regexp Matches    ${baseline_firmware_name}    .*\-(v\\d)\-build\\d{4}\-    1
    ${baseline_version}=    set variable    @{baseline_version_list}[0]
    ${baseline_screenshot_file_name_prefix}=    set variable    ${FGT_TYPE}_${baseline_version}_b${baseline_build_number}

    #upgrade FGT using CLI once target firmware is not current firmware
    run keyword if    "${FGT_BUILD}"!="${baseline_build_number}"    upgrde FGT using CLI and wait until it is finished    ${baseline_firmware_name}    ${image_server_type}    ${server_ip}    ${FGT_CLI_FGT_INTERNAL_IP}    image_server_username=${image_server_username}    image_server_password=${image_server_password}

    Login FortiGate    url=${fgt_url_local}    browser=chrome    username=${FGT_GUI_USERNAME}    password=${FGT_GUI_PASSWORD}
    ${target_screenshot_name_list}=    go to urls and capture Screenshots    ${fgt_url_local}    ${url_file_autotcl}    ${baseline_screenshot_file_name_prefix}    baseline=${True}    &{dic_file}
    Logout FortiGate
    run keyword and ignore error    run and return rc and output    del ${baseline_image_dir}${/}selenium*
    run keyword and ignore error    run and return rc and output    del ${image_dir}${/}selenium*
    close browser
    [Teardown]    Set Screenshot Directory    ${ori_dir}

upgrade FGT and compare GUI Screenshots with baseline
    [Tags]    norun
    #define Screenshots name prefix of baseline firmware according to pltf type and build number
    ${baseline_build_number_list}=    get Regexp Matches    ${baseline_firmware_name}    .*\-build(\\d{4})\-    1
    ${baseline_build_number}=    set variable    @{baseline_build_number_list}[0]
    ${baseline_version_list}=    get Regexp Matches    ${baseline_firmware_name}    .*\-(v\\d)\-build\\d{4}\-    1
    ${baseline_version}=    set variable    @{baseline_version_list}[0]
    ${baseline_screenshot_file_name_prefix}=    set variable    ${FGT_TYPE}_${baseline_version}_b${baseline_build_number}

    #define Screenshots name prefix of target firmware according to pltf type and build number
    ${target_build_number_list}=    get Regexp Matches    ${target_firmware_name}    .*\-build(\\d{4})\-    1
    ${target_build_number}=    set variable    @{target_build_number_list}[0]
    ${target_version_list}=    get Regexp Matches    ${target_firmware_name}    .*\-(v\\d)\-build\\d{4}\-    1
    ${target_version}=    set variable    @{target_version_list}[0]
    ${target_screenshot_file_name_prefix}=    set variable    ${FGT_TYPE}_${target_version}_b${target_build_number}

    #upgrade FGT using CLI once target firmware is not current firmware
    run keyword if    "${FGT_BUILD}"!="${target_build_number}"    upgrde FGT using CLI and wait until it is finished    ${target_firmware_name}    ${image_server_type}    ${server_ip}    ${FGT_CLI_FGT_INTERNAL_IP}    image_server_username=${image_server_username}    image_server_password=${image_server_password}

    Login FortiGate    url=${fgt_url_local}    browser=chrome    username=${FGT_GUI_USERNAME}    password=${FGT_GUI_PASSWORD}
    ${target_screenshot_name_list}=    go to urls and capture Screenshots    ${fgt_url_local}    ${url_file}    ${target_screenshot_file_name_prefix}    &{dic_file}
    Logout FortiGate
    ${target_screenshot_path_list}=    append dir path to filenames    ${image_dir}    ${target_screenshot_name_list}

    #create list that contains all baseline Screenshot filenames according to target_screenshot_name_list
    @{baseline_screenshot_file_name_list}=    create list
    ${length}=    get length    ${target_screenshot_name_list}
    :FOR    ${index}    IN RANGE    ${length}
    \    ${url}=    get url string from screeshot file name    @{target_screenshot_name_list}[${index}]
    \    ${case_id}=    get case id from screeshot file name    @{target_screenshot_name_list}[${index}]
    \    append to list    ${baseline_screenshot_file_name_list}    ${case_id}_${baseline_screenshot_file_name_prefix}_${url}_baseline.png
    ${baseline_screenshot_path_list}=    append dir path to filenames    ${baseline_image_dir}    ${baseline_screenshot_file_name_list}

    ${scores}=    compare images captured from many urls    ${baseline_screenshot_path_list}    ${target_screenshot_path_list}    ${diff_image_dir}    ${append_image_dir}    ${1}

    ${pltf_info}=    set variable    compare Screenshots captureed on ${FGT_TYPE} ${target_version} b${target_build_number} with Screenshots captureed on ${FGT_TYPE} ${baseline_version} ${baseline_build_number}\#\#\#\#\r\#\#\#\#all Screenshots are stored in directory ${image_dir}
    create page comparison report     ${report_dir}${/}gui_comparison_report_${RUNNING_TIME}.txt    ${pltf_info}    ${target_screenshot_name_list}    ${baseline_screenshot_file_name_list}    ${scores}
    run keyword and ignore error    run and return rc and output    del ${image_dir}${/}selenium*
    close browser

*** Keywords ***
upgrde FGT using CLI and wait until it is finished
    [Arguments]    ${firmware_name}    ${server_type}    ${server_ip}    ${fgt_access_ip}    ${image_server_username}=${EMPTY}    ${image_server_password}=${EMPTY}
    upgrade FGT using CLI    ${firmware_name}    ${server_type}    ${server_ip}    image_server_username=${image_server_username}    image_server_password=${image_server_password}
    log to console    \rwait until FGT reboots
    wait until fgt begin to reboot    ${fgt_access_ip}
    log to console    \rwait until FGT is accessible
    wait until fgt come to be accessible    ${fgt_access_ip}
    #sleep for more 10 seconds, in case telnet demon hasn't started and the IP is pingable.
    sleep    10

begin fgt test
    Set Library Search Order    SeleniumLibrary
    Set Screenshot Directory    ${image_dir}

clear up
    run keyword and ignore error    Delete All Cookies
    run keyword and ignore error    close browser

