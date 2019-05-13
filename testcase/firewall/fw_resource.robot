*** Settings ***
Documentation    import all resource and lib files of FW
Library    lib.sort_custom_list
##import all resource and lib files used by all features.
Resource    ../../common_resource.robot
##Variable files
Resource    ./config/fw_test_data.robot
Resource    ./config/${FIREWALL_ENV}
##Locator files
