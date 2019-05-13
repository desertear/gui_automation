*** Settings ***
Documentation     This file contains FortiGate GUI main page operation

*** Variables ***
${image_tool_dir}    ${IMAGEMAGICK_DIR}
${image_comparator_command}    ${image_tool_dir} convert "__REFERENCE__" "__TEST__" -metric RMSE -compare -format  "%[distortion]" info:
${image_generate_diff_command}    ${image_tool_dir} convert "__REFERENCE__" "__TEST__" -metric RMSE -compare "__DIFF__"
${image_generate_append_command}    ${image_tool_dir} convert -append -background black -gravity center "__REFERENCE__" "__TEST__" +repage miff:-|${image_tool_dir} convert +append -background black -gravity center - "__DIFF__" "__APPEND__"
${image_comparator_cropped_command}    ${image_tool_dir} convert "__REFERENCE__" "__TEST__" -crop __GEOMETRY__ +repage miff:- | ${image_tool_dir} convert - -metric RMSE -compare -format "%[distortion]" info:
${image_generate_diff_cropped_command}    ${image_tool_dir} convert "__REFERENCE__" "__TEST__" -crop __GEOMETRY__ +repage miff:- | ${image_tool_dir} convert - -metric RMSE -compare "__DIFF__"
*** Keywords ***
Compare Images
    [Arguments]    ${reference_image_path}    ${test_image_path}    ${diff_dir}    ${append_image_dir}    ${cropped_area}    ${allowed_threshold}
    [Documentation]    ${cropped_area}----specify geometry area that is needed to compare between images.
    ...    Please refer to  "https://www.imagemagick.org/script/command-line-processing.php#geometry" for detail.
    ${file1_path}    ${file1_name_ext}=    split path    ${reference_image_path}
    ${file2_path}    ${file2_name_ext}=    split path    ${test_image_path}
    ${file1_name}    ${file1_ext}=    split extension    ${file1_name_ext}
    ${file2_name}    ${file2_ext}=    split extension    ${file2_name_ext}
    ${diff_file_name}=    set variable    diff_${file1_name}_and_${file2_name}.png
    ${tmp_diff_cmd}=    Replace String    ${image_generate_diff_cropped_command}    __REFERENCE__    ${reference_image_path}
    ${tmp_diff_cmd}=      Replace String    ${tmp_diff_cmd}    __TEST__    ${test_image_path}
    ${tmp_diff_cmd}=      Replace String    ${tmp_diff_cmd}    __GEOMETRY__    ${cropped_area}
    ${diff_cmd}=      Replace String    ${tmp_diff_cmd}    __DIFF__    ${diff_dir}${/}${diff_file_name}
    #generate diff file
    ${rc_diff}    ${output_diff}=     Run And Return Rc And Output    ${diff_cmd}
    Log    Return Code: ${rc_diff}
    Log    Return Output: ${output_diff}
    ${diff_file_result}=    Run keyword if    "${rc_diff}"=="${0}"     set variable    PASS
    ...    ELSE    set variable    FAIL

    ${temp_cmd}=    Replace String    ${image_comparator_cropped_command}    __REFERENCE__    ${reference_image_path}
    ${temp_cmd}=      Replace String    ${temp_cmd}    __GEOMETRY__    ${cropped_area}
    ${cmd}=      Replace String    ${temp_cmd}    __TEST__    ${test_image_path}
    Log    Executing: ${cmd}
    ${rc}    ${output}=     Run And Return Rc And Output    ${cmd}
    Log    Return Code: ${rc}
    Log    Return Output: ${output}
    ${result}=    Run keyword if    "${rc}"=="${0}"    Evaluate    ${output}>=${allowed_threshold}
    ...    ELSE    set variable    ${False}
    # Should be True    ${result}
    ${diff_rate}=    Run keyword if    "${rc}"=="${0}"     evaluate    1-${output}
    ...    ELSE    set variable    ${-1}
    #merge source image, dst image and diff image together, to make it easier for user to read.
    ${append_file_path}    ${append_file_result}=    Run keyword if    "${rc}"=="${0}"     append Images    ${reference_image_path}    ${test_image_path}    ${diff_dir}${/}${diff_file_name}    ${append_image_dir}
    ...    ELSE    set variable    NONE    NONE
    #once the output is not number, the comparison failed.
    ${if_number}=    run keyword and return status    Should Match Regexp    ${output}    ^\\d\\.?\\d*(?:e-)?\\d*$
    ${message}=    run keyword if    "${if_number}"=="True"    set variable    comparison succeeds
    ...    ELSE    set variable    ${output}
    [Return]    ${diff_rate}    ${append_file_path}    ${diff_file_result}    ${append_file_result}    ${message}

append Images
    [Arguments]    ${source_image_path}    ${destination_image_path}    ${diff_image_path}    ${append_image_dir}
    [Documentation]    append source image and destination image vertically, and then append diff image to the right horizontally.
    ${file1_path}    ${file1_name_ext}=    split path    ${diff_image_path}
    ${appended_file_name_ext}=    Fetch From Right    ${file1_name_ext}    diff_

    ${tmp_append_cmd}=    Replace String    ${image_generate_append_command}    __REFERENCE__    ${source_image_path}
    ${tmp_append_cmd}=      Replace String    ${tmp_append_cmd}    __TEST__    ${destination_image_path}
    ${tmp_append_cmd}=    Replace String    ${tmp_append_cmd}    __DIFF__    ${diff_image_path}
    ${append_cmd}=      Replace String    ${tmp_append_cmd}    __APPEND__    ${append_image_dir}${/}${appended_file_name_ext}
    log    ${append_cmd}

    ${rc}    ${output}=     Run And Return Rc And Output    ${append_cmd}
    Log    Return Code: ${rc}
    Log    Return Output: ${output}
    ${append_file_result}=    Run keyword if    "${rc}"=="${0}"     set variable    PASS
    ...    ELSE    set variable    FAIL
    [Return]    ${append_image_dir}${/}${appended_file_name_ext}    ${append_file_result}

process file and return as list
    [Documentation]    arguments: file_path---file full absolute path;
    ...    variable_dic--dictionary that contins mapping relation of variable name and variable value.
    ...    Return:file_formatted--list of string which contains case id, url and webelement. need to post process these items.
    [Arguments]    ${file_path}    &{variable_dic}
    OperatingSystem.File Should Exist    ${file_path}
    ${file_content}=    OperatingSystem.Get file    ${file_path}
    @{file_by_lines}=    split string    ${file_content}    \n
    #remove empty lines
    remove values from list    ${file_by_lines}    ${EMPTY}
    ${length}=    get length    ${file_by_lines}
    #remove leading/trailing spaces, remove multiple spaces
    :FOR    ${index}    IN RANGE    ${length}
    \    ${tmp}=    Strip String    @{file_by_lines}[${index}]
    \    ${tmp}=    Replace String Using Regexp    ${tmp}    \\s{1,}    \ \
    # \    ${tmp}=    Remove String    ${tmp}    \"
    \    Set List Value    ${file_by_lines}    ${index}    ${tmp}
    #remove commented lines which begin with char #
    ${file_formatted}=    copy list    ${file_by_lines}
    :FOR    ${index}    IN RANGE    ${length}
    \    ${if_comment_line}=    run keyword and return status    should match Regexp    @{file_by_lines}[${index}]    ^#
    \    run keyword if   "${if_comment_line}"=="True"    Remove Values From List    ${file_formatted}    @{file_by_lines}[${index}]
    ##replace user defined local variables with values
    ${file_formatted}=    replace variable reference in list with variable value    @{file_formatted}    &{variable_dic}
    #replace global variables with values
    ${length}=    get length    ${file_formatted}
    :FOR    ${index}    IN RANGE    ${length}
    \    ${tmp}=    Replace Variables    @{file_formatted}[${index}]
    \    Set List Value    ${file_formatted}    ${index}    ${tmp}
    [return]    ${file_formatted}

go to urls and capture Screenshots
    [Arguments]    ${fgt_url}    ${url_file}    ${screenshot_file_name_prefix}    ${baseline}=${False}    &{variable_dic}
    ${url_list}=    process file and return as list    ${url_file}    &{variable_dic}
    ${num_of_url}=    get length    ${url_list}
    #record current timestamp
    @{current_time}=    Get Time    yearmonthdayhourminsec
    ${timestamp}=    Set Variable    @{current_time}[0]@{current_time}[1]@{current_time}[2]@{current_time}[3]@{current_time}[4]@{current_time}[5]
    #create a list to record all Screenshot names.
    @{screenshot_file_names}=    create list
    :FOR    ${index}    IN RANGE    ${num_of_url}
    \    ${case_id}    ${url}    ${element}=    split string    @{url_list}[${index}]    ${SPACE}    2
    \    ${str}=    conver url to string    ${url}
    \    ${filename}=    run keyword if    "${baseline}"=="${False}"    set variable    ${case_id}_${screenshot_file_name_prefix}_${str}_${timestamp}.png
    \    ...    ELSE    set variable    ${case_id}_${screenshot_file_name_prefix}_${str}_baseline.png
    \    ${status}=    run keyword and return status    go to url and capture screenshot    ${fgt_url}    ${url}    ${element}    ${filename}
    \    Run keyword if    "${status}"=="${True}"    append to list    ${screenshot_file_names}    ${filename}
    [Return]    ${screenshot_file_names}

go to urls and capture Screenshots by case id
    [Arguments]    ${target_case_id}    ${fgt_url}    ${url_file}    ${screenshot_file_name_prefix}    ${baseline}=${False}    &{variable_dic}
    ${url_list}=    process file and return as list    ${url_file}    &{variable_dic}
    ${num_of_url}=    get length    ${url_list}
    #record current timestamp
    @{current_time}=    Get Time    yearmonthdayhourminsec
    ${timestamp}=    Set Variable    @{current_time}[0]@{current_time}[1]@{current_time}[2]@{current_time}[3]@{current_time}[4]@{current_time}[5]
    #create a list to record all Screenshot names.
    @{screenshot_file_names}=    create list
    :FOR    ${index}    IN RANGE    ${num_of_url}
    \    ${case_id}    ${url}    ${element}=    split string    @{url_list}[${index}]    ${SPACE}    2
    \    Continue For Loop If    "${case_id}"!="${target_case_id}"
    \    ${str}=    conver url to string    ${url}
    \    ${filename}=    run keyword if    "${baseline}"=="${False}"    set variable    ${case_id}_${screenshot_file_name_prefix}_${str}_${timestamp}.png
    \    ...    ELSE    set variable    ${case_id}_${screenshot_file_name_prefix}_${str}_baseline.png
    \    ${status}=    run keyword and return status    go to url and capture screenshot    ${fgt_url}    ${url}    ${element}    ${filename}
    \    Run keyword if    "${status}"=="${True}"    append to list    ${screenshot_file_names}    ${filename}
    [Return]    ${screenshot_file_names}

go to url and capture screenshot
    [Arguments]    ${fgt_url}    ${relative_url}    ${element}    ${filename}
    go to    ${fgt_url}${/}${relative_url}
    Hide Interim build label
    Wait Until Element Is Visible regardless of iframe    ${element}
    capture page Screenshot    ${filename}

create page comparison report
    [Arguments]    ${file_path}    ${pltf_info}    ${source_screenshot_name_list}    ${target_screenshot_name_list}    ${match_scores}
    [Documentation]    ${file_path}--report file absolute path
    create file    ${file_path}    \#\#\#\#${pltf_info}\#\#\#\#\r
    Append to file    ${file_path}    \#\#\#\#url${SPACE * 4}source screenshot name${SPACE * 4}destination sreenshot name${SPACE * 4}match score\#\#\#\#\r
    ${length1}=    get length    ${source_screenshot_name_list}
    ${length2}=    get length    ${target_screenshot_name_list}
    ${length3}=    get length    ${match_scores}
    should be equal as integers    ${length1}    ${length2}
    should be equal as integers    ${length2}    ${length3}
    :FOR    ${index}    IN RANGE    ${length1}
    \    ${url}=    get url from screeshot file name    @{source_screenshot_name_list}[${index}]
    \    ${test_pass_result}=    set variable    ${url}${SPACE * 4}@{source_screenshot_name_list}[${index}]${SPACE * 4}@{target_screenshot_name_list}[${index}]${SPACE * 4}@{match_scores}[${index}]\r
    \    Append to file    ${file_path}    ${test_pass_result}

compare images captured from many urls
    [Arguments]    ${reference_image_paths}    ${target_image_paths}    ${cropped_areas}    ${diff_dir}    ${append_dir}    ${allowed_threshold}
    [Documentation]    variables ${reference_image_paths}, ${target_image_paths} and ${match_scores} should be lists with same length
    @{match_scores}=    create list
    @{append_file_pathes}=    create list
    @{messages}=    create list
    @{diff_file_results}=    create list
    @{append_file_results}=    create list
    ${len_ref}=    get length    ${reference_image_paths}
    ${len_tar}=    get length    ${target_image_paths}
    should be equal as integers    ${len_ref}    ${len_tar}
    :FOR    ${index}    IN RANGE    ${len_ref}
    \    ${match_score}    ${append_file_path}    ${diff_file_result}    ${append_file_result}    ${message}=    compare images    @{reference_image_paths}[${index}]    @{target_image_paths}[${index}]    ${diff_dir}    ${append_dir}    @{cropped_areas}[${index}]    ${allowed_threshold}
    \    append to list    ${match_scores}    ${match_score}
    \    append to list    ${append_file_pathes}    ${append_file_path}
    \    append to list    ${diff_file_results}    ${diff_file_result}
    \    append to list    ${append_file_results}    ${append_file_result}
    \    append to list    ${messages}    ${message}
    log    ${diff_file_results}
    log    ${append_file_results}    
    [Return]    ${match_scores}    ${append_file_pathes}    ${messages}

conver url to string
    [Arguments]    ${url}
    [Documentation]    In Windows filename can not contain chars: \, /, :, *, ?, ", <, >, |, while on FGT name can not contain: <, >, (, ), #, ', ".
    ...    As a result, it's needed to map these characters to accpetable chars. Mappings relations are : /-->_, ?-->!
    ${str}=    replace string    ${url}    /    \#
    ${str}=    replace string    ${str}    ?    !
    [Return]    ${str}

get url from screeshot file name
    [Arguments]    ${filename}
    ${tmp_str}=    get regexp matches    ${filename}    b\\d{4}_([a-zA-Z0-9_!=%&\\-#]*)_(?:\\d{14}|baseline)    1
    ${url}=        replace string    @{tmp_str}[0]    \#    /
    ${url}=        replace string    ${url}    !    ?
    [Return]    ${url}

get url string from screeshot file name
    [Arguments]    ${filename}
    ${url_str}=    get regexp matches    ${filename}    b\\d{4}_([a-zA-Z0-9_!=%&\\-#]*)_(?:\\d{14}|baseline)    1
    [Return]    @{url_str}[0]

get case id from screeshot file name
    [Arguments]    ${filename}
    ${url_str}=    get regexp matches    ${filename}    ^(\\d{6})_.*    1
    [Return]    @{url_str}[0]

append dir path to filenames
    [Arguments]    ${dir_path}    ${filenames}
    ${length}=    get length    ${filenames}
    ${absolute_paths}=    create list
    :FOR    ${index}    IN RANGE    ${length}
    \    ${absolute_path}=    Join Path    ${dir_path}    @{filenames}[${index}]
    \    append to list    ${absolute_paths}    ${absolute_path}
    [return]    ${absolute_paths}

capture Screenshots and compare them with baseline for AutoTcl
    [Arguments]    ${browser}    ${fgt_url}    ${gui_username}    ${gui_password}    ${case_id}    ${fgt_type}    ${baseline_release_version}    ${baseline_build_number}
    ...    ${current_release_version}    ${current_build_number}    ${baseline_image_dir}    ${image_dir}   ${diff_image_dir}    ${append_image_dir}    ${report_dir}    ${config_file}    ${crop_rule_file}    ${threshold}    &{dic_file}
    [Documentation]
    ##get URls from config file that are required to capture according to testcase id

    #Open browser and capture Screenshots.
    Login FortiGate    url=${fgt_url}    browser=${browser}    username=${gui_username}    password=${gui_password}
    ${target_screenshot_name_list}=    go to urls and capture Screenshots by case id    ${case_id}    ${fgt_url}    ${config_file}    ${fgt_type}_${current_release_version}_b${current_build_number}    &{dic_file}
    Logout FortiGate

    ${target_screenshot_path_list}=    append dir path to filenames    ${image_dir}    ${target_screenshot_name_list}

    #create list that contains all baseline Screenshot filenames according to target_screenshot_name_list
    @{baseline_screenshot_file_name_list}=    create list
    ${length}=    get length    ${target_screenshot_name_list}
    :FOR    ${index}    IN RANGE    ${length}
    \    ${url}=    get url string from screeshot file name    @{target_screenshot_name_list}[${index}]
    \    ${case_id}=    get case id from screeshot file name    @{target_screenshot_name_list}[${index}]
    \    append to list    ${baseline_screenshot_file_name_list}    ${case_id}_${fgt_type}_${baseline_release_version}_b${baseline_build_number}_${url}_baseline.png
    ${baseline_screenshot_path_list}=    append dir path to filenames    ${baseline_image_dir}    ${baseline_screenshot_file_name_list}
    ##get area geometry paras to be cropped according to URL
    ${url_geo_list}=    process file and return as list    ${crop_rule_file}    &{dic_file}
    &{url_geo_dic}=    Get DIC of URL and Geometry from List     ${url_geo_list}
    ${geo_full_image}=    set variable    100x100%+0+0
    @{cropped_area_list}=    create list
    :FOR    ${index}    IN RANGE    ${length}
    \    ${url}=    get url from screeshot file name    @{target_screenshot_name_list}[${index}]
    \    ${if_contain_key}=    run keyword and return status    Dictionary Should Contain Key    ${url_geo_dic}    ${url}
    \    Run keyword if     "${if_contain_key}"!="True"    append to list    ${cropped_area_list}    ${geo_full_image}
    \    ...    ELSE    append to list    ${cropped_area_list}    &{url_geo_dic}[${url}]
    ${scores}    ${append_file_pathes}    ${messages}=    compare images captured from many urls    ${baseline_screenshot_path_list}    ${target_screenshot_path_list}    ${cropped_area_list}    ${diff_image_dir}    ${append_image_dir}    ${threshold}
    ${pltf_info}=    set variable    compare Screenshots captureed on ${fgt_type} ${current_release_version} b${current_build_number} with Screenshots captureed on ${fgt_type} ${baseline_release_version} ${baseline_build_number}\#\#\#\#\r\#\#\#\#all Screenshots are stored in directory ${image_dir}
    create page comparison report     ${report_dir}${/}gui_comparison_report_${RUNNING_TIME}.txt    ${pltf_info}    ${target_screenshot_name_list}    ${baseline_screenshot_file_name_list}    ${scores}
    run keyword and ignore error    run and return rc and output    del ${image_dir}${/}selenium*
    close browser
    [return]    ${scores}    ${append_file_pathes}    ${messages}


Get DIC of URL and Geometry from List
    [Arguments]    ${url_geo_list}
    ${length}=    get length    ${url_geo_list}
    &{url_geo_dic}=    Create Dictionary
    :FOR    ${index}    IN RANGE    ${length}
    \    ${url}    ${geometry_cropped_area}=    split string    @{url_geo_list}[${index}]    ${SPACE}    1
    \    Set To Dictionary    ${url_geo_dic}    ${url}    ${geometry_cropped_area}
    [return]    ${url_geo_dic}