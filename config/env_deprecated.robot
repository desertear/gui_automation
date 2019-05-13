*** Settings ***
Documentation     This file contains global variables that will be deprecated, to make the frame clearer and less confusing

*** Variables ***
${FGT_HOSTNAME}    FortiWifi-60E
${FGT_VLAN10_INTERFACE}    wan2
${FGT_VLAN20_INTERFACE}    lan
${FGT_VLAN30_INTERFACE}    wan1
${GENERAL_SERVER}    172.16.200.55

#the name of certificate that HTTPS uses.
${FGT_HTTPS_CERTIFICATE_NAME}    fgt_gui_automation
${FGT_PKI_PEER_CA_NAME}    pkica

##FGT common configuration
${FGT_VLAN10_IP}    10.6.30.1
${FGT_VLAN10_IP_V6}    2000:10:6:30::1
${FGT_VLAN30_IP}    172.16.200.1
${FGT_VLAN30_IP_V6}    2000:172:16:200::1
#Because GUI access IPs can be mapped to external IPs.Below Vlan20 addresses are used internal.
${FGT_VLAN20_IP}    10.1.100.1
${FGT_VLAN20_IP_V6}    2000:10:1:100::1
${FGT_VLAN30_GATEWAY}    172.16.200.254
${FGT_VLAN30_GATEWAY_V6}    2000:172:16:200::254
${FGT_DNS_SERVER1}    8.8.8.8
${FGT_DNS_SERVER2}    172.16.100.100
${FGT_DNS_SERVER1_IPV6}    2001:4860:4860::8888
${FGT_DNS_SERVER2_IPV6}    2000:172:16:100::100

#Settings of FGT mode. If you don't need to switch FGT mode, don't update them.
${FGT_LENC_MODE}    False
${FGT_FACTORY_LICENSE}    1234567890
${FGT_LENC_LICENSE}    1234567890
${FGT_LOW_CRYPTO_LICENSE}    1234567890

##Connectivity Settings
# FAZ from Vivian Wu
${FGT_FAZ_IP}    172.18.64.234
${FGT_FAZ_USERNAME}    fosqa
${FGT_FAZ_PASSWORD}    123456
# FMG from Jason Xue
${FGT_FMG_IP}    172.18.60.115
${FGT_FMG_USERNAME}    fosqa
${FGT_FMG_PASSWORD}    123456
${FGT_FMG_SN}    FMG-VM0A17009361
${FGT_FGD_ACCOUNT}    fosqa@fortinet.com
${FGT_FGD_PASSWORD}    123456

##PC5 configurations
${PC5_VLAN10_IP}    10.6.30.55
${PC5_VLAN30_IP}    172.16.200.55
${PC5_SSH_PORT}    22
${PC5_USERNAME}    root
${PC5_PASSWORD}    123456
${PC5_OS_TYPE}    Linux
${PC5_SSH_PROMPT}    ~[\#\$]
${PC5_SSH_TIMEOUT}    20 seconds

##PC4 configurations
${PC4_VLAN10_IP}    10.6.30.44
${PC4_VLAN30_IP}    172.16.200.44
${PC4_SSH_PORT}    22
${PC4_USERNAME}    root
${PC4_PASSWORD}    123456
${PC4_OS_TYPE}    Linux
${PC4_SSH_PROMPT}    ~[\#\$]
${PC4_SSH_TIMEOUT}    20 seconds