*** Settings ***
Documentation    Verify categories and category groups can be shown properly
Resource    ../webfilter_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${webfilter_profile_name}    webfilter
@{category_and_number}    Potentially Liable:9    Adult/Mature Content:15    Bandwidth Consuming:6    Security Risk:6    General Interest - Personal:35    General Interest - Business:15    Unrated:1
    
*** Test Cases ***
716658
    [Documentation]    
    [Tags]    6.2.0    webfilter    chrome    716658    high    win10    runable

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}

    # go to a webfilter profile named webfilter
    Go into a Webfilter profile    ${webfilter_profile_name} 

    # check if the each default big category is there or not
    :FOR    ${category_and_number}    IN    @{category_and_number}
    \    @{split_name_value}=    Split String    ${category_and_number}    :    1
    \    ${locator_of_category}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${Webfilter_Fortiguard_big_Category_name}    @{split_name_value}[0]
    \    wait until element is visible    ${locator_of_category}
    \    ${locator_of_number_of_category}=    REPLACE PLACEHOLDERS IN LOCATOR WITH VALUE    ${Webfilter_Fortiguard_big_Category_number_based_on_name}    ${split_name_value}
    \    wait until element is visible    ${locator_of_number_of_category}

    
 


    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    write test result to file    ${CURDIR}