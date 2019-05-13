*** Settings ***
Documentation     This file contains common environment variables
Resource    ./sslvpn_env.robot

*** Variables ***
#below value should be set manually.
${FGT_HOSTNAME}    ${FGT_SN}
${FGT_VLAN20_INTERFACE}    port2
${FGT_VLAN30_INTERFACE}    port1
