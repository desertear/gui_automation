*** Settings ***
Documentation      To verify that an administrator could be created for each vdom
Resource    ../../../system_resource.robot

*** Variables ***
${test_vdom_name}    737192
@{vdom_list_1}    ${SYSTEM_TEST_VDOM_NAME_1}
@{vdom_list_2}    ${SYSTEM_TEST_VDOM_NAME_2}
${vdom_fw_mode}      Policy-based
${vdom_comments}     this is a test vdom
@{ssh_cmd_fgt}    get system status | grep "Max number of virtual domains"
@{ssh_cmd_fgt_init_1}     config global    config system interface     edit ${SYSTEM_TEST_INTF_3}     set vdom ${test_vdom_name}1    set ip 34.34.34.1 255.255.255.0   set allow ping    end    end
@{ssh_cmd_fgt_init_2}     config global    config system interface     edit ${SYSTEM_TEST_INTF_4}     set vdom ${test_vdom_name}1    set ip 43.43.43.1 255.255.255.0   set allow ping    end    end

@{ssh_cmd_fgtb_init_1}    config global    config system interface     edit ${FGTB_PORT3_INTERFACE}   set vdom ${FGTB_VDOM_NAME_1}   set ip 34.34.34.34 255.255.255.0  set allow ping    end    end
...                       config vdom      edit ${FGTB_VDOM_NAME_1}    config router static    edit 1    set gateway 34.34.34.1   set device ${FGTB_PORT3_INTERFACE}    end    end

@{ssh_cmd_fgtb_init_2}    config global    config system interface     edit ${FGTB_PORT4_INTERFACE}   set vdom ${FGTB_VDOM_NAME_2}    set ip 43.43.43.43 255.255.255.0  set allow ping    end    end
...                       config vdom      edit ${FGTB_VDOM_NAME_2}    config router static    edit 1    set gateway 43.43.43.1   set device ${FGTB_PORT4_INTERFACE}    end    end

@{ssh_cmd_FGT_B_test}     config vdom      edit ${FGTB_VDOM_NAME_1}    exec ping 43.43.43.43   

@{ssh_cmd_fgt_clean}      config vdom      edit ${test_vdom_name}1     config firewall policy    delete 1    end    end
...                       config global    config system interface     edit ${SYSTEM_TEST_INTF_3}   set ip 0.0.0.0 0.0.0.0    set vdom ${SYSTEM_TEST_VDOM_NAME_1}  end    
...                                        config system interface     edit ${SYSTEM_TEST_INTF_4}   set ip 0.0.0.0 0.0.0.0    set vdom ${SYSTEM_TEST_VDOM_NAME_1}  end    end

@{ssh_cmd_fgtb_clean_1}   config vdom      edit ${FGTB_VDOM_NAME_1}    config router static    delete 1   end    end
...                       config global    config system interface     edit ${FGTB_PORT3_INTERFACE}   set vdom ${FGTB_VDOM_NAME_1}    set ip 0.0.0.0 0.0.0.0  end    end
@{ssh_cmd_fgtb_clean_2}   config vdom      edit ${FGTB_VDOM_NAME_2}    config router static    delete 1   end    end
...                       config global    config system interface     edit ${FGTB_PORT4_INTERFACE}   set vdom ${FGTB_VDOM_NAME_1}    set ip 0.0.0.0 0.0.0.0  end    end

*** Test Cases ***
737192
##
    [Tags]    v6.0    chrome   737192    high    win10,64bit    browsers    runable   test10
    @{responses_ssh}=    Execute CLI commands on FortiGate Via Terminal Server   ${ssh_cmd_fgt}
    ${response}=    set variable       @{responses_ssh}[-1]
    ${vdom_num}=    Fetch From Right   ${response}    domains:
    ${vdom_num}=    Fetch From Left    ${vdom_num}    \r
    ${vdom_num}=    Strip String       ${vdom_num} 
    ${fgt_vdom_num_max}=    Set Variable    ${vdom_num}
    ${fgt_vdom_num_max}=    Evaluate    ${fgt_vdom_num_max}-1
    Login FortiGate   
    Go to system
    sleep  2
    ###    create a new vdom   ####
    Go to system_VDOM
    sleep  2
    ${new_locator}=     REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_VDOM_NEW_VDOM_NGFW_MODE}    ${vdom_fw_mode}
    :FOR  ${i}   IN RANGE   1    ${fgt_vdom_num_max}
        \    select frame        ${NETWORK_FRAME}
        \    wait and click      ${SYSTEM_VDOM_CREATE NEW_BUTTON}
        \    sleep  2
        \    wait and click      ${SYSTEM_VDOM_NEW_VDOM_NAME}
        \    clear element text  ${SYSTEM_VDOM_NEW_VDOM_NAME}
        \    input text          ${SYSTEM_VDOM_NEW_VDOM_NAME}    ${test_vdom_name}${i}
        \    wait and click      ${new_locator}
        \    wait and click      ${SYSTEM_VDOM_NEW_VDOM_COMMENTS}
        \    clear element text  ${SYSTEM_VDOM_NEW_VDOM_COMMENTS}
        \    input text          ${SYSTEM_VDOM_NEW_VDOM_COMMENTS}    ${vdom_comments}${i}
        \    wait and click      ${SUBMIT_OK_SPAN}
        \    sleep   2
    Wait Until Element Is Visible    ${SYSTEM_VDOM_MAX_NUM_WARN_MSG}
    wait and click    ${CONFIRM_CANCEL_BUTTON}
    sleep   2
    Execute CLI commands on FortiGate Via Direct Telnet    ${ssh_cmd_fgt_init_1}
    Execute CLI commands on FortiGate Via Direct Telnet    ${ssh_cmd_fgt_init_2}
    Execute CLI commands on FortiGate Via Direct Telnet    ${ssh_cmd_fgtb_init_1}   ip_address=${FGTB_CLI_FGT_INTERNAL_IP}   prompt=${FGTB_CLI_PROMPT}
    Execute CLI commands on FortiGate Via Direct Telnet    ${ssh_cmd_fgtb_init_2}   ip_address=${FGTB_CLI_FGT_INTERNAL_IP}   prompt=${FGTB_CLI_PROMPT}
    go to vdom     ${test_vdom_name}1
    Go to system
    Go to policy and objects
    Go to IPv4 policy
    system create ipv4 policy   181541   ${SYSTEM_TEST_INTF_3}   ${SYSTEM_TEST_INTF_4}
    @{response}=      Execute CLI commands on FortiGate Via Direct Telnet    ${ssh_cmd_FGT_B_test}   ip_address=${FGTB_CLI_FGT_INTERNAL_IP}   prompt=${FGTB_CLI_PROMPT}
    ${resp}=    set variable    @{response}[-1]
    should contain   ${resp}    icmp_seq=1
    Execute CLI commands on FortiGate Via Direct Telnet    ${ssh_cmd_fgt_clean}
    Execute CLI commands on FortiGate Via Direct Telnet    ${ssh_cmd_fgtb_clean_1}    ip_address=${FGTB_CLI_FGT_INTERNAL_IP}   prompt=${FGTB_CLI_PROMPT}
    Execute CLI commands on FortiGate Via Direct Telnet    ${ssh_cmd_fgtb_clean_2}    ip_address=${FGTB_CLI_FGT_INTERNAL_IP}   prompt=${FGTB_CLI_PROMPT}
    Go to Global
    go to system
    Go to system_VDOM
    select frame        ${NETWORK_FRAME}
    ${fgt_vdom_num_max}=    Evaluate    ${fgt_vdom_num_max}-1
    :FOR  ${i}   IN RANGE   1   ${fgt_vdom_num_max}
        \    DELETE VDOM  ${test_vdom_name}${i}
        \    sleep   2
    unselect frame
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Execute CLI commands on FortiGate Via Direct Telnet    ${ssh_cmd_fgt_clean}
    Execute CLI commands on FortiGate Via Direct Telnet    ${ssh_cmd_fgtb_clean_1}    ip_address=${FGTB_CLI_FGT_INTERNAL_IP}   prompt=${FGTB_CLI_PROMPT}
    Execute CLI commands on FortiGate Via Direct Telnet    ${ssh_cmd_fgtb_clean_2}    ip_address=${FGTB_CLI_FGT_INTERNAL_IP}   prompt=${FGTB_CLI_PROMPT}
    Close All Browsers
    write test result to file   ${CURDIR}
