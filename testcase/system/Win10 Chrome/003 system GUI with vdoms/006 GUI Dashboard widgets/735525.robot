*** Settings ***
Documentation    Verify IPMC sensor information is correct on Sensor Information widget
Resource    ../../../system_resource.robot

*** Variables ***
*** Test Cases ***

735525
## Verify IPMC sensor information is correct on Sensor Information widget, temperature, power and fan speed ###
    [Tags]    v6.0    chrome   735525    High    win10,64bit    browsers    runable    novm
    Login FortiGate     
    Go to system
    go to dashboard
    go to dashboard_main
    
    ${system_widget_sensor_exist}=    Run Keyword And Return Status    system_test_if_widget_exist   Sensor Information
    Run Keyword if   "${system_widget_sensor_exist}"=="False"    system_Add_widget   Sensor Information
    wait and click    ${system_widget_sensorinfo_temp}
    wait and click    ${system_widget_sensorinfo_temp_detail_bar} 
    
    
    ####check temperature####
    wait and click    ${system_widget_sensorinfo_temp_C}
    check the temperature values_C     
    sleep    2
    wait and click    ${system_widget_sensorinfo_temp_F}
    check the temperature values_F 
    wait and click    ${system_widget_sensorinfo_listclose_button}
    
    #####check power supply####
    wait and click    ${system_widget_sensorinfo_power}
    wait and click    ${system_widget_sensorinfo_power_detail_bar}
    check the power_in values    
    check the power_out values   
    wait and click    ${system_widget_sensorinfo_listclose_button}

    #####check fan speed#####
    wait and click   ${system_widget_sensorinfo_fan}
    wait and click   ${system_widget_sensorinfo_fan_detail_bar}
    check the fan values    
    wait and click   ${system_widget_sensorinfo_listclose_button}
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Close All Browsers
    write test result to file    ${CURDIR}

# test_if_sensor_widget_exist
#     sleep  1
#     Wait Until Element is visible   ${system_widget_sensorinfo_widgetbanner}


# Add_sensor_widget_if_needed
#     ${system_widget_sensor_exist}=    Run Keyword And Return Status   test_if_sensor_widget_exist
#     Run Keyword if    "${system_widget_sensor_exist}"=="False"    Mouse over         ${system_widget_dashboard_blank_page}
#     Run Keyword if    "${system_widget_sensor_exist}"=="False"    Wait Until Element Is Visible    ${system_widget_setting_button}
#     Run Keyword if    "${system_widget_sensor_exist}"=="False"    Click Element      ${system_widget_setting_button}
#     Run Keyword if    "${system_widget_sensor_exist}"=="False"    Wait and click     ${system_widget_setting_add_widget_button}
#     ${element}=
#     ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${system_widget_setting_add_widget_name}   ${element}
#     Run Keyword if    "${system_widget_sensor_exist}"=="False"    Wait and click     ${system_widget_setting_add_widget_sensorinfo_button}
#     Run Keyword if    "${system_widget_sensor_exist}"=="False"    Wait and click     ${system_widget_setting_add_widget_close_button}

check the temperature values_C 
    #[Arguments]    ${times}  
     :FOR  ${i}   IN RANGE   1   10
     \   sleep   1
     \   ${test_end}=   Run Keyword and return status    test_if_elemnt_is_the_end_temp    ${i}
     \   EXIT FOR LOOP IF    "${test_end}"=="${False}"
     \   Wait Until Element is visible      xpath://tbody/tr[${i}]/td[3]
     \   Click Element  xpath://tbody/tr[${i}]/td[3]
     \   ${temp}=     Get Text    xpath://tbody/tr[${i}]/td[3]
     \   ${temp}=     Fetch From Left    ${temp}    °C
     \   ${temp}=     Evaluate     0<${temp}<70
     \   Should Be Equal    ${temp}    ${True}


check the temperature values_F
    #[Arguments]    ${times}  
     :FOR  ${i}   IN RANGE   1   10
     \   sleep   1  
     \   ${test_end}=   Run Keyword and return status    test_if_elemnt_is_the_end_temp    ${i}
     \   EXIT FOR LOOP IF    "${test_end}"=="${False}"
     \   Wait Until Element is visible      xpath://tbody/tr[${i}]/td[3]
     \   Click Element  xpath://tbody/tr[${i}]/td[3]
     \   ${temp}=     Get Text    xpath://tbody/tr[${i}]/td[3]
     \   ${temp}=     Fetch From Left    ${temp}    °F
     \   ${temp}=     Evaluate     0<${temp}<150
     \   Should Be Equal    ${temp}    ${True}

test_if_elemnt_is_the_end_temp
    [Arguments]    ${counts}  
    sleep  1
    Wait Until Element is visible     xpath://tbody/tr[${counts}]/td[3]


check the power_in values
    #[Arguments]    ${count}  
     :FOR  ${i}   IN RANGE   1   5
     \   sleep   1
     \   ${test_end}=   Run Keyword and return status    test_if_elemnt_is_the_end_powerin    ${i}   
     \   EXIT FOR LOOP IF    "${test_end}"=="${False}"
     \   Wait Until Element is visible      xpath://tr[td[text()="PS${i} VIN"]]/td[3]
     \   Click Element  xpath://tr[td[text()="PS${i} VIN"]]/td[3]
     \   sleep    1
     \   ${temp}=     Get Text    xpath://tr[td[text()="PS${i} VIN"]]/td[3]
     \   ${temp}=     Fetch From Left    ${temp}    V
     \   ${temp}=     Evaluate     100<${temp}<120
     \   Should Be Equal    ${temp}    ${True}

test_if_elemnt_is_the_end_powerin
    [Arguments]    ${counts}  
    sleep  1
    Wait Until Element is visible     xpath://tr[td[text()="PS${counts} VIN"]]/td[3]


test_if_elemnt_is_the_end_power_out
    [Arguments]    ${counts}  
    sleep  1
    Wait Until Element is visible     xpath://tr[td[text()="PS${counts} VOUT_12V"]]/td[3]


check the power_out values
    #[Arguments]    ${count}  
     :FOR  ${i}   IN RANGE   1   5
     \   sleep   1
     \   ${test_end}=   Run Keyword and return status    test_if_elemnt_is_the_end_power_out    ${i}   
     \   EXIT FOR LOOP IF    "${test_end}"=="${False}"
     \   Wait Until Element is visible      xpath://tr[td[text()="PS${i} VOUT_12V"]]/td[3]
     \   Click Element  xpath://tr[td[text()="PS${i} VOUT_12V"]]/td[3]
     \   sleep    1
     \   ${temp}=     Get Text    xpath://tr[td[text()="PS${i} VOUT_12V"]]/td[3]
     \   ${temp}=     Fetch From Left    ${temp}    V
     \   ${temp}=     Evaluate     10<${temp}<13
     \   Should Be Equal    ${temp}    ${True}



check the fan values
    #[Arguments]    ${count}  
     :FOR  ${i}   IN RANGE   1   5
     \   sleep   1
     \   ${test_end}=   Run Keyword and return status    test_if_elemnt_is_the_end_fan    ${i}   
     \   EXIT FOR LOOP IF    "${test_end}"=="${False}"
     \   Wait Until Element is visible      xpath://tbody/tr[${i}]/td[3]
     \   Click Element  xpath://tbody/tr[${i}]/td[3]
     \   sleep    1
     \   ${temp}=     Get Text    xpath://tbody/tr[${i}]/td[3]
     \   ${temp}=     Fetch From Left    ${temp}    RPM
     \   ${temp}=     Evaluate     5000<${temp}<8000
     \   Should Be Equal    ${temp}    ${True}

test_if_elemnt_is_the_end_fan
    [Arguments]    ${counts}  
    sleep  1
    Wait Until Element is visible     xpath://tbody/tr[${counts}]/td[3]



