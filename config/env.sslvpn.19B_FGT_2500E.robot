*** Settings ***
Documentation     This file contains common environment variables
Resource    ./env.robot

*** Variables ***
#below value should be set manually.
${FGT_SN}    FG2K5E3916900086
${FGT_HOSTNAME}    FGT_A
${FGT_GENERATION}    Gen1
${FGT_TEST_VERSION}    6.2.0
${FGT_VLAN20_INTERFACE}    port38
${FGT_VLAN30_INTERFACE}    port37
${GENERAL_SERVER}    172.16.200.55

#your LDAP account to login Oriole, you need to change it once you change your ldap password
${ORIOLE_ACCOUNT}    maryzhang
#this one can be get from "user profile" after you login Oriole
${ORIOLE_ENCODED_PASSWORD}    Vm1kTlJFTnNTbGxXVVhSS1FtZE5TRlZTTVZGQ1VVRkhVMVl4Vmxoc1pFcFZiRTVTUVVaU1ZsZG5UbEpXYkZKaw==



