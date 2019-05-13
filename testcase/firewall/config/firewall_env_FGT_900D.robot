*** Settings ***
Documentation     This file contains environment variables for FW
Resource    ./fw_test_data.robot

*** Variables ***
#Interface Variable
${FW_TEST_INTF_1}    port9
${FW_TEST_INTF_2}    port10
${FW_TEST_INTF_3}    port17
${FW_TEST_INTF_4}    port18
${FW_TEST_INTF_ANY}    any


#FGT platform related info
${FGT_HW_SIZE}    2U