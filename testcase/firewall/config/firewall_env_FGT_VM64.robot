*** Settings ***
Documentation     This file contains environment variables for FW
Resource    ./fw_test_data.robot

*** Variables ***
#Interface Variable
${FW_TEST_INTF_1}    port1
${FW_TEST_INTF_2}    port2
${FW_TEST_INTF_3}    port3
${FW_TEST_INTF_4}    port4
${FW_TEST_INTF_ANY}    any


#FGT platform related info
${FGT_HW_SIZE}    VM