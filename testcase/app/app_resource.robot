*** Settings ***
Documentation    import all resource and lib files of FW
##import all resource and lib files used by all features.
Resource    ../../common_resource.robot
##Variable files
Resource    ./config/${APP_ENV}
##Locator files
