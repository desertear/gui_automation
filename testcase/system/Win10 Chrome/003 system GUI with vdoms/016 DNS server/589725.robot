*** Settings ***
Documentation    Verify System>Network>DNS Database fill correctly
Resource    ../../../system_resource.robot

*** Variables ***
${dnscase_dnszone}     fortinet.com
${dnscase_doaminname}     fortinet.com
${dnscase_dnszone_slave}     589725.com
${dnscase_doaminname_slave}     589725.com
${dnscase_hostname of primary}     DNS
${dnscase_email}     email.fortinet.com
${dnscase_hostname_A}     589725A
${dnscase_hostname_NS}     589725NS
${dnscase_hostname_CNAME}     589725CANME
${dnscase_hostname_MX}     589725MX
${dnscase_hostname_AAAA}     589725AAAA
${dnscase_hostname_V4PTR}     589725V4PTR
${dnscase_hostname_V6PTR}     589725V6PTR
${dnscase_specify_day}    0
${dnscase_specify_hour}    10
${dnscase_specify_minute}   10
${dnscase_specify_second}   10
${dnscase_cname}     cname
${dnscase_mx_pre}   00
${dnscase_ip_add}     172.58.97.25
${dnscase_ip_add_slave}     172.58.97.28
${dnscase_ip_add_slave_edited}     172.58.97.29
${dnscase_ip_add_edited}    172.58.97.27
${dnscase_ipv6_add}   2002:172:58:97::25
${dnscase_ip_V4PTR}    172.58.97.26
${dnscase_ip_V6PTR}    2002:172:58:97::26
${dnscase_database_configed_entry}     xpath://tr/td[@class="name" and contains(text(),"fortinet")]
${dnscase_database_configed_entry_slave}     xpath://tr/td[@class="name" and contains(text(),"589725")]
${dnscase_configed_A_ipv4_entry}    xpath://tr/td[text()="Address (A)"]/following-sibling::td[contains(text(),"${dnscase_ip_add}")]
${dnscase_configed_A_ipv4_entry_edited}    xpath://tr/td[text()="Address (A)"]/following-sibling::td[contains(text(),"${dnscase_ip_add_edited}")]
${dnscase_configed_ipv6_PTR_entry}    xpath://tr/td[text()="IPv6 Pointer (PTR)"]/following-sibling::td[contains(text(),"${dnscase_ip_V6PTR}")]
${dnscase_configed_A_ipv4_entry_status_column}    xpath://tr/td[text()="Address (A)"]/following-sibling::td[@class="status"]//span[text()="Disable"]
${dnscase_configed_NS_entry}    xpath://tr/td[text()="Name Server (NS)"]
${dnscase_configed_CNAME_entry}    xpath://tr/td[contains(text(),"CNAME")] 
${dnscase_configed_MX_entry}    xpath://tr/td[contains(text(),"MX")]
${dnscase_configed_AAAA_entry}    xpath://tr/td[contains(text(),"AAAA")] 
${dnscase_configed_ipv4PTR_entry}    xpath://tr/td[contains(text(),"v4 Pointer")] 
${Dns_entry_edit_page_SUBMIT_OK_BUTTON}   xpath:(//button[@id="submit_ok"])[2]
*** Test Cases ***
589725
    [Documentation]    
    [Tags]    v6.0    chrome   589725    critical    win10,64bit    runable
    ##test DNS Database filled correctly via GUI, if it does, current case must pass.
    Login FortiGate
    Go To Vdom     ${SYSTEM_TEST_VDOM_NAME_1}    
    Go to system
    go to system_feature visibility
    ${feature_name}=   Set Variable    DNS Database
    feature_vis_wait_for_feature_vis   ${feature_name}
    feature_vis_if_status_enabled      ${feature_name}
    ${enable_status}=   feature_vis_if_status_enabled   ${feature_name}
    Run keyword if      "${enable_status}"=="False"     feature_vis_click_status_button     ${feature_name}
    Run keyword if      "${enable_status}"=="False"     wait and click    ${system_feature_vis_apply_button}     
    sleep   2
    Go to network
    go to network_dns_server
    
    ###config DNS zone##
    type_master_test    
    sleep    2
    type_slave_test    
    [teardown]    case teardown

*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}

type_master_test
    Wait Until Element Is Visible    ${Network_dns database_createnew}
    Click Element    ${Network_dns database_createnew}   
    wait and click    ${Network_dns database_type_Master}  
    wait and click    ${Network_dns database_view_Public}           
    Wait Until Element Is Visible    ${Network_dns database_dns_zone}
    Press key     ${Network_dns database_dns_zone}      ${dnscase_dnszone}
    Wait Until Element Is Visible    ${Network_dns database_domain_name}
    Press key     ${Network_dns database_domain_name}   ${dnscase_doaminname}   

    Wait Until Element Is Visible    ${Network_dns database_hostname of primary}    
    Clear Element Text     ${Network_dns database_hostname of primary}    
    Press key     ${Network_dns database_hostname of primary}     ${dnscase_hostname of primary}
    
    Wait Until Element Is Visible    ${Network_dns database_dns_email}    
    Clear Element Text     ${Network_dns database_dns_email}    
    Press key            ${Network_dns database_dns_email}      ${dnscase_email}     
    Wait Until Element Is Visible    ${Network_dns database_dns_ttl_day}  
    Clear Element Text   ${Network_dns database_dns_ttl_day}  
    Input Text           ${Network_dns database_dns_ttl_day}     10
    Wait Until Element Is Visible    ${Network_dns database_dns_ttl_hour} 
    Clear Element Text   ${Network_dns database_dns_ttl_hour} 
    Input Text           ${Network_dns database_dns_ttl_hour}    1
    Wait Until Element Is Visible    ${Network_dns database_dns_ttl_minute}    
    Clear Element Text   ${Network_dns database_dns_ttl_minute}
    Input Text    ${Network_dns database_dns_ttl_minute}         1 
    Wait Until Element Is Visible    ${Network_dns database_dns_ttl_second}    
    Clear Element Text   ${Network_dns database_dns_ttl_second}    
    Input Text           ${Network_dns database_dns_ttl_second}  1
    Wait Until Element Is Visible    ${Network_dns database_dns_authoritative}  
    Click Element        ${Network_dns database_dns_authoritative}   
    

    ##go into DNS server page##
    #### creat new A entry adn input the dns config entries##
    Sleep    2
    press_dns_entries_creat_new
    Sleep    1
    select menu    A
    Wait Until Element Is Visible    ${Network_dns database_dns entry_edit_hostname}
    Press key     ${Network_dns database_dns entry_edit_hostname}    ${dnscase_hostname_A}
    
    Wait Until Element Is Visible    ${Network_dns database_dns entry_edit_type_A_IP} 
    Press key     ${Network_dns database_dns entry_edit_type_A_IP}    ${dnscase_ip_add}
    
    Wait Until Element Is Visible    ${Network_dns database_dns entry_edit_type_A_specify}   
    Click Element     ${Network_dns database_dns entry_edit_type_A_specify}
    sleep   2s
    Wait Until Element Is Visible    ${Network_dns database_dns entry_edit_type_A_specify_day}
    Press key     ${Network_dns database_dns entry_edit_type_A_specify_day}   ${dnscase_specify_day}

    Wait Until Element Is Visible    ${Network_dns database_dns entry_edit_type_A_specify_hour}
    Clear Element Text      ${Network_dns database_dns entry_edit_type_A_specify_hour}
    Press key     ${Network_dns database_dns entry_edit_type_A_specify_hour}     ${dnscase_specify_hour}

    Wait Until Element Is Visible    ${Network_dns database_dns entry_edit_type_A_specify_minute}
    Clear Element Text      ${Network_dns database_dns entry_edit_type_A_specify_minute}
    Press key     ${Network_dns database_dns entry_edit_type_A_specify_minute}   ${dnscase_specify_minute}

    Wait Until Element Is Visible    ${Network_dns database_dns entry_edit_type_A_specify_second} 
    Clear Element Text      ${Network_dns database_dns entry_edit_type_A_specify_second} 
    Press key     ${Network_dns database_dns entry_edit_type_A_specify_second}    ${dnscase_specify_second}
    Dns_entry_edit_page_submit_ok    
    
    #### creat new NS entry##
    press_dns_entries_creat_new
    Sleep    1
    select menu    NS
    Wait Until Element Is Visible    ${Network_dns database_dns entry_edit_hostname}
    Press key     ${Network_dns database_dns entry_edit_hostname}    ${dnscase_hostname_NS}
    Dns_entry_edit_page_submit_ok  

    #### creat new CNAME entry##
    press_dns_entries_creat_new
    Sleep    1
    select menu   CNAME
    Wait Until Element Is Visible    ${Network_dns database_dns entry_edit_hostname}
    Press key     ${Network_dns database_dns entry_edit_hostname}    ${dnscase_hostname_CNAME}
    Wait Until Element Is Visible    ${Network_dns database_dns entry_edit_type_cname_cname} 
    Press key     ${Network_dns database_dns entry_edit_type_cname_cname}     ${dnscase_cname}
    Dns_entry_edit_page_submit_ok  
    
    #### creat new MX entry##
    press_dns_entries_creat_new
    Sleep    1
    select menu    MX
    Wait Until Element Is Visible    ${Network_dns database_dns entry_edit_hostname}
    Press key     ${Network_dns database_dns entry_edit_hostname}    ${dnscase_hostname_MX}
    Wait Until Element Is Visible    ${Network_dns database_dns entry_edit_type_mx_pref}    
    Press key     ${Network_dns database_dns entry_edit_type_mx_pref}     ${dnscase_mx_pre}
    Dns_entry_edit_page_submit_ok

    #### creat new AAAA entry##
    press_dns_entries_creat_new
    Sleep    1
    select menu    AAAA
    Wait Until Element Is Visible    ${Network_dns database_dns entry_edit_hostname}
    Press key     ${Network_dns database_dns entry_edit_hostname}    ${dnscase_hostname_AAAA}
    Wait Until Element Is Visible    ${Network_dns database_dns entry_edit_type_AAAA_ipv6add}    
    Press key     ${Network_dns database_dns entry_edit_type_AAAA_ipv6add}    ${dnscase_ipv6_add}
    Dns_entry_edit_page_submit_ok

    #### creat new v4_ptr entry##
    press_dns_entries_creat_new
    Sleep    1
    select menu    ipv4_ptr
    Wait Until Element Is Visible    ${Network_dns database_dns entry_edit_hostname}
    Press key     ${Network_dns database_dns entry_edit_hostname}    ${dnscase_hostname_V4PTR}
    Wait Until Element Is Visible    ${Network_dns database_dns entry_edit_type_ptr_ipv4add}    
    Clear Element Text    ${Network_dns database_dns entry_edit_type_ptr_ipv4add}    
    Press key     ${Network_dns database_dns entry_edit_type_ptr_ipv4add}     ${dnscase_ip_V4PTR} 
    Dns_entry_edit_page_submit_ok
    
    #### creat new v6_ptr entry##
    press_dns_entries_creat_new    
    Sleep    1
    select menu    ipv6_ptr
    Wait Until Element Is Visible    ${Network_dns database_dns entry_edit_hostname}
    Press key     ${Network_dns database_dns entry_edit_hostname}    ${dnscase_hostname_V6PTR}
    Wait Until Element Is Visible    ${Network_dns database_dns entry_edit_type_ptr_ipv6add}   
    Clear Element Text      ${Network_dns database_dns entry_edit_type_ptr_ipv6add}   
    Press key     ${Network_dns database_dns entry_edit_type_ptr_ipv6add}    ${dnscase_ip_V6PTR} 
    Dns_entry_edit_page_submit_ok
    
    
    ##go to dns entry edit, change A records name and ipv4 add, then  click status_button##
    sleep   3
    Wait Until Element Is Visible    ${dnscase_configed_A_ipv4_entry}
    Click Element     ${dnscase_configed_A_ipv4_entry}
    Wait Until Element Is Visible    ${Network_dns database_dns entry_edit}
    sleep    2
    Click Element    ${Network_dns database_dns entry_edit}
    sleep    1
    select menu    A
    Wait Until Element Is Visible    ${Network_dns database_dns entry_edit_hostname}
    Press key     ${Network_dns database_dns entry_edit_hostname}    ${dnscase_hostname_A}
    
    Wait Until Element Is Visible    ${Network_dns database_dns entry_edit_type_A_IP} 
    Clear Element Text      ${Network_dns database_dns entry_edit_type_A_IP} 
    Press key     ${Network_dns database_dns entry_edit_type_A_IP}    ${dnscase_ip_add_edited}
    Wait Until Element Is Visible    ${Network_dns database_dns entry_edit_status_button}    
    Click Element    ${Network_dns database_dns entry_edit_status_button}    
    Dns_entry_edit_page_submit_ok
    Wait Until Element Is Visible    ${Network_dns database_dns entry_satus_disable}  
    
    #######delete ipv6_PTR entry####
    Wait Until Element Is Visible    ${dnscase_configed_ipv6_PTR_entry}
    sleep    2
    Click Element     ${dnscase_configed_ipv6_PTR_entry}

    Wait Until Element Is Visible    ${Network_dns database_dns entry_delete}
    sleep    2
    Click Element    ${Network_dns database_dns entry_delete}
    
    sleep    2    
    Dns_zone_page_submit_ok


    #####double check the entries has been input is there, the status button is correct, then clik cancel to test if cancel button worked###
    Wait Until Element Is Visible    ${dnscase_database_configed_entry}    
    sleep    2
    Click Element    ${dnscase_database_configed_entry}
    Wait Until Element Is Visible    ${Network_dns database_edit}
    sleep    2
    Click Element    ${Network_dns database_edit}
    
    Wait Until Element Is Visible    ${dnscase_configed_A_ipv4_entry_edited}
    sleep   2
    Click Element    ${dnscase_configed_A_ipv4_entry_edited}
    
    Wait Until Element Is Visible    ${dnscase_configed_A_ipv4_entry_status_column} 
    sleep   2
    Click Element    ${dnscase_configed_A_ipv4_entry_status_column} 
    
    Wait Until Element Is Visible    ${dnscase_configed_NS_entry}
    sleep   2
    Click Element     ${dnscase_configed_NS_entry}
    
    Wait Until Element Is Visible    ${dnscase_configed_CNAME_entry}
    sleep   2
    Click Element    ${dnscase_configed_CNAME_entry}
    
    Wait Until Element Is Visible    ${dnscase_configed_MX_entry}   
    sleep   2
    Click Element    ${dnscase_configed_MX_entry}   
    
    Wait Until Element Is Visible    ${dnscase_configed_AAAA_entry}  
    sleep   2
    Click Element    ${dnscase_configed_AAAA_entry}  
    
    Wait Until Element Is Visible    ${dnscase_configed_ipv4PTR_entry}
    sleep   2
    Click Element    ${dnscase_configed_ipv4PTR_entry}
    
    Wait Until Element Is Visible    ${SUBMIT_CANCEL_BUTTON} 
    sleep   2
    Click Element    ${SUBMIT_CANCEL_BUTTON} 
    
    Wait Until Element Is Visible    ${dnscase_database_configed_entry}
    sleep   2
    Click Element     ${dnscase_database_configed_entry}
    sleep   2
    Wait Until Element Is Visible    ${Network_dns database_delete}
    sleep   2
    Click Element     ${Network_dns database_delete}
    Wait Until Element Is Visible    ${Network_dns database_delete_OK}
    sleep   2
    Click Element         ${Network_dns database_delete_OK}
    ${delet_result}=    Run Keyword And Return Status     deleted_test_master
    Should be equal   ${delet_result}    ${False}

type_slave_test
    Wait Until Element Is Visible    ${Network_dns database_createnew}
    Click Element     ${Network_dns database_createnew}   
    Sleep    2s
    wait and click    ${Network_dns database_type_slave} 
    sleep    2s
    wait and click    ${Network_dns database_view_shadow}      
    Sleep    2s
    ###config###
    Wait Until Element Is Visible    ${Network_dns database_dns_zone}
    Sleep    2s
    Press key     ${Network_dns database_dns_zone}     ${dnscase_dnszone_slave}
    sleep   2s
    Wait Until Element Is Visible    ${Network_dns database_domain_name}
    Sleep    2s
    Press key     ${Network_dns database_domain_name}     ${dnscase_doaminname_slave}   
    sleep   2s
    Wait Until Element Is Visible    ${Network_dns database_IP of Master}
    Clear Element Text      ${Network_dns database_IP of Master}
    Press key     ${Network_dns database_IP of Master}    ${dnscase_ip_add_slave}
    sleep   2
    wait and click    ${SUBMIT_OK_BUTTON}
    ##edit###
    Wait Until Element Is Visible    ${dnscase_database_configed_entry_slave}
    sleep    2
    Click Element     ${dnscase_database_configed_entry_slave}
    Wait Until Element Is Visible    ${Network_dns database_edit}
    sleep    2
    Click Element    ${Network_dns database_edit}
    sleep    2
    Wait Until Element Is Visible    ${Network_dns database_IP of Master}
    Clear Element Text      ${Network_dns database_IP of Master}
    Press key     ${Network_dns database_IP of Master}    ${dnscase_ip_add_slave_edited}
    wait and click    ${SUBMIT_OK_BUTTON}
    ###delete###
    sleep    2
    Wait Until Element Is Visible    ${dnscase_database_configed_entry_slave}
    sleep    2
    Click Element     ${dnscase_database_configed_entry_slave}
    
    Wait Until Element Is Visible    ${Network_dns database_delete}
    sleep   2
    Click Element     ${Network_dns database_delete}

    Wait Until Element Is Visible    ${Network_dns database_delete_OK}
    sleep   2
    Click Element         ${Network_dns database_delete_OK}
    ${delet_result}=    Run Keyword And Return Status     deleted_test_slave
    Should be equal   ${delet_result}    ${False}
       

press_dns_entries_creat_new
    sleep    2
    Wait Until Element Is Visible    ${Network_dns database_dns entry_createnew}
    click Element                    ${Network_dns database_dns entry_createnew}

select menu
    [Arguments]    ${type}
    Wait Until Element Is Visible    ${Network_dns database_dns entry_edit_type}    
    click Element    ${Network_dns database_dns entry_edit_type}    
    Wait Until Element Is Visible    ${Network_dns database_dns entry_edit_type_${type}}  
    click Element    ${Network_dns database_dns entry_edit_type_${type}}  

Dns_entry_edit_page_submit_ok
    Wait Until Element Is Visible    ${Dns_entry_edit_page_SUBMIT_OK_BUTTON}
    sleep   2s
    Click Element    ${Dns_entry_edit_page_SUBMIT_OK_BUTTON}

Dns_zone_page_submit_ok
    Wait Until Element Is Visible    ${SUBMIT_OK_BUTTON}
    sleep   2s
    Click Element    ${SUBMIT_OK_BUTTON}

deleted_test_master
    sleep   2
    Wait Until Element Is Visible     ${dnscase_database_configed_entry}
    
deleted_test_slave
    sleep   2
    Wait Until Element Is Visible     ${dnscase_database_configed_entry_slave}
    
