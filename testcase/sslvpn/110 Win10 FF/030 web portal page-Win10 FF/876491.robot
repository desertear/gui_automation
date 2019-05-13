*** Settings ***
Documentation    Verify MAC OS forticlient can be download in the forticlient-download widget.
...    Create ssl vpn portal with "forticlient download" widget selected. Create ssl vpn related firewall policy with portal and user group associated.
...    Login ssl vpn web mode in MAC OS Safari.
...    Try to download forticlient by clicking the link "Forticlient windows" in "forticlient download" widget.
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${http_url}    ${SSLVPN_HTTP_IP}
${matched_text}    ${SSLVPN_HTTP_PAGE_KEYWORD}
*** Test Cases ***
876491
    [Tags]    v6.0    firefox    chrome    edge    safari     876491    high    win10,64bit
    Login SSLVPN Portal
    #get current time, downlink data and uplink data.
    ${time_with_unit_older}=    Get Text    ${PORTAL_TIME}
    ${downlink_data_with_unit_older}=    Get Text    ${PORTAL_DOWNLINK}
    ${uplink_data_with_unit_older}=    Get Text    ${PORTAL_UPLINK}
    # ${time_with_unit_older_list}=    create list    ${time_with_unit_older}
    ${time_in_seconds_elder}=    convert time to seconds    ${time_with_unit_older}
    ${tmp_str}=    get Regexp matches    ${downlink_data_with_unit_older}    (\\d+) [k|M]?B.*    1
    ${downlink_data_elder}=    Convert To Integer    @{tmp_str}[0]
    ${tmp_str}=    get Regexp matches    ${uplink_data_with_unit_older}    (\\d+) [k|M]?B.*    1
    ${uplink_data_elder}=    Convert To Integer    @{tmp_str}[0]
    #open http connection to generate traffic
    quick connection of http or https    ${http_url}    ${matched_text}
    sleep    10
    #switch back to sslvpn portal
    ${time_with_unit}=    Get Text    ${PORTAL_TIME}
    ${downlink_data_with_unit}=    Get Text    ${PORTAL_DOWNLINK}
    ${uplink_data_with_unit}=    Get Text    ${PORTAL_UPLINK}
    # ${time_with_unit_list}=    create list    ${time_with_unit}
    ${time_in_seconds}=    convert time to seconds    ${time_with_unit}
    ${tmp_str}=    get Regexp matches    ${downlink_data_with_unit}    (\\d+) [k|M]?B.*    1
    ${downlink_data}=    Convert To Integer    @{tmp_str}[0]
    ${tmp_str}=    get Regexp matches    ${uplink_data_with_unit}    (\\d+) [k|M]?B.*    1
    ${uplink_data}=    Convert To Integer    @{tmp_str}[0]
    #judge the time in seconds and the data should be larger than  those when the case began.
    should be true    ${time_in_seconds}>=${time_in_seconds_elder}+10
    should be true    ${downlink_data}>=${downlink_data_elder}
    should be true    ${uplink_data}>=${uplink_data_elder}
    [Teardown]  write test result to file    ${CURDIR}

*** Keywords ***

