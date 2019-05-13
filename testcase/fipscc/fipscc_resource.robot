*** Settings ***
Documentation    import all resource and lib files of FIPSCC
##import all resource and lib files used by all features.
Resource    ../../common_resource.robot
##FIPSCC keywords
Resource    ./lib/fipscc_common.robot
##Variable files
Resource    ./config/${FIPSCC_ENV}
##Locator files
