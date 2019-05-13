*** Settings ***
Documentation    import all resource and lib files of system
##import all resource and lib files used by all features.
Resource    ../../common_resource.robot
##system GUI keywords
Resource    ./lib/system_ftp_gui.robot
Library    DateTime
##Variable files
Resource    ./config/${SYSTEM_ENV}
##Locator files

##Javascript function files
