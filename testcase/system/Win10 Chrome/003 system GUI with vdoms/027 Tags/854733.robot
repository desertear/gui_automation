*** Settings ***
Documentation    GUI: Verify tag color, tooltips, and reference count are displayed correctly
...              Failcase  bug #0531622, the ref of tag on interface page is '0', not '1', case failed
Resource    ../../../system_resource.robot

*** Variables ***
${tag1}      location
${tag1_1}    1floor
${tag1_2}    2floor
${tag1_3}    3floor
${tag_color}   9
${tag_interface}    ${FGT_VLAN30_INTERFACE}
${SYSTEM_TAG_TAGS_ON_INTERFACE}   xpath://div[@id="tag-list"]/div/label/span[text()="${tag1}"]
${SYSTEM_TAG_TAGS_ADD_MENU_ON_INTERFACE}   xpath://div[@id="tag-list"]/div[label/span="${tag1}"]/div/div
${SYSTEM_TAG_TAGS_ON_INTERFACE_CLEAN_BUTTON}   xpath://div[@id="tag-list"]/div[label/span="${tag1}"]/div/button
${SYSTEM_TAG_TAGS_CREATE_NEW_COLOR_CHANGE_BUTTON}     xpath://button[contains(text(),"Change")]
${SYSTEM_TAG_TAGS_CREATE_NEW_COLOR_CHANGE}   xpath://li[@cscolorvalue="${tag_color}"]
${SYSTEM_TAG_tool_tip_tag}    xpath://div//tr[td[text()="Tag"]]//span[text()="${tag1_1}"]
${SYSTEM_TAG_tool_tip_ref}    xpath://div//tr[td[text()="Ref."]]//td[text()="1"]
${SYSTEM_TAG_tool_tip_color}  xpath://span[span="1floor"]/f-icon
*** Test Cases ***
854733
    [Documentation]    
    [Tags]    Failcase!Bug#0531622   v6.0    chrome   854733    High    win10,64bit    runable    env2fail
    login FortiGate
    Go To Vdom          ${SYSTEM_TEST_VDOM_NAME_1}
    Go to system
    Go to system_Tags
    wait and click      ${SYSTEM_TAG_CREATE_NEW_BUTTON}
    sleep  2
    clear element text  ${SYSTEM_TAG_TAG_CATEGORY_INPUT}
    input text          ${SYSTEM_TAG_TAG_CATEGORY_INPUT}    ${tag1}
    wait and click      ${SYSTEM_TAG_TAGS_CREATE_NEW_COLOR_CHANGE_BUTTON}
    sleep  2
    click element       ${SYSTEM_TAG_TAGS_CREATE_NEW_COLOR_CHANGE}
    :FOR   ${i}  IN RANGE   4   7
         \   wait and click      ${SYSTEM_TAG_TAGS_ADD_BUTTON}
         \   ${new_locator}=     REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_TAG_TAGS_INPUT}  ${i}
         \   clear element text  ${new_locator}
         \   ${i}=    EVALUATE   ${i}-3
         \   input text          ${new_locator}   ${tag1_${i}}
    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_TAG_TAGS_SCOPE_MANDATORY}   Interface
    wait and click    ${new_locator}
    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_TAG_TAGS_SCOPE_MANDATORY}   Device
    wait and click    ${new_locator}
    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_TAG_TAGS_SCOPE_OPTIONAL}    Address
    wait and click    ${new_locator}
    wait and click    ${SUBMIT_OK_BUTTON}
    Go to network
    Go to network_Interfaces
    network edit interface          ${tag_interface}
    Wait Until Element Is Visible   ${SYSTEM_TAG_TAGS_ON_INTERFACE}
    wait and click    ${SYSTEM_TAG_TAGS_ADD_MENU_ON_INTERFACE}
    SELECT MENU BAR FROM SELECTION PANE   ${tag1_1}
    wait and click    ${SUBMIT_OK_BUTTON}
    unselect frame
    Go to network
    Go to network_Interfaces
    network edit interface          ${tag_interface}
    wait until Element Is Visible   ${SYSTEM_TAG_tool_tip_color}
    ${color}=    get element attribute    ${SYSTEM_TAG_tool_tip_color}     class
    should contain   ${color}    color-${tag_color}
    Mouse Over       ${SYSTEM_TAG_tool_tip_color}
    sleep   2
    Wait Until Element Is Visible    ${SYSTEM_TAG_tool_tip_tag}
    Wait Until Element Is Visible    ${SYSTEM_TAG_tool_tip_ref}
    sleep   2
    unselect frame
    Go to system
    Go to system_Tags
    ${new_locator}=  REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_TAG_EDIT_ENTRIES}    ${tag1}
    wait and click   ${new_locator}
    wait and click   ${SYSTEM_TAG_EDIT_BUTTON}
    ${new_locator}=  REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_TAG_TAGS_SCOPE_OPTIONAL}    Interface
    wait and click   ${new_locator}
    wait and click   ${SUBMIT_OK_BUTTON}
    unselect frame
    Go to network
    Go to network_Interfaces
    network edit interface    ${tag_interface}
    wait and click   ${SYSTEM_TAG_TAGS_ON_INTERFACE_CLEAN_BUTTON}
    wait and click   ${SUBMIT_OK_BUTTON}
    unselect frame
    Go to system
    Go to system_Tags
    ${new_locator}=  REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_TAG_EDIT_ENTRIES}    ${tag1}
    wait and click   ${new_locator}
    wait and click   ${SYSTEM_TAG_DELETE_BUTTON}
    sleep  2
    wait and click   ${SYSTEM_TAG_DELETE_OK_BUTTON}
    [teardown]    case teardown
 
*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file   ${CURDIR}



