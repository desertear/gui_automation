*** Settings ***
Documentation    import all resource and lib files of Upgrading
##import all resource and lib files used by all features.
Resource    ../common_resource.robot
Resource    ../lib/image_comparison.robot
##Variable files
Resource    ./config/upgrade_env.robot
