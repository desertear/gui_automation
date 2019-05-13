*** Settings ***
Documentation    [GUI] Verify system primary and secondary DNS server add/delete/edit work fine
Resource    ../../../system_resource.robot

*** Variables ***
${primary_dns}   8.8.8.8
${secondary_dns}   208.91.112.52
${domain_name}    fgt1.example.com
@{cmd_list}     config vdom   edit ${SYSTEM_TEST_VDOM_NAME_1}    exec ping www.google.com
${test_tegx}    ${NETWORK_DNS_DNS_PING_TEST_RETURN_CLI}
*** Test Cases ***
713639
    [Documentation]    
    [Tags]    v6.0    chrome   713639    High    win10,64bit    system  runable   
    ######
    Login FortiGate
    Go to Global
    Go to network
    ##  addd dns primary and secondary server ##
    go to network_dns
    wait and click      ${network_dns_dns settings_type_specify}
    wait and click      ${network_dns_dns settings_primary_dns_server}   
    clear element text  ${network_dns_dns settings_primary_dns_server}   
    Input text          ${network_dns_dns settings_primary_dns_server}    ${primary_dns}
    wait and click      ${network_dns_dns settings_secondary_dns_server} 
    clear element text  ${network_dns_dns settings_secondary_dns_server}   
    Input text          ${network_dns_dns settings_secondary_dns_server}  ${secondary_dns}
    wait and click   ${SUBMIT_APPLY_BUTTON}
    ## test if dns works in embed console ##
    Unselect frame
    sleep   10
    TEST FROM CLI AND CHECK REGXP    ${cmd_list}   ${test_tegx}
    ###  disable ddns ####
    Go to network
    go to network_dns
    ${status}=    Run Keyword and return status    Checkbox Should Be Selected   ${network_dns_ddns_enable_checkbox}
    Run Keyword if   "${status}"=="Ture"    wait and click    ${network_dns_ddns_enable_label}
    
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Close All Browsers
    write test result to file    ${CURDIR}

