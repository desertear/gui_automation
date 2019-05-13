*** Settings ***
Documentation    import all resource and lib files of USER
##import all resource and lib files used by all features.
Resource    ../../common_resource.robot
##USER keywords
Resource    ./lib/user_common.robot
Resource    ./lib/fortitoken_android.robot
##Variable files
Resource    ./config/${USER_ENV}
##Locator files
Resource    ./config/locator/fortitoken_android.robot