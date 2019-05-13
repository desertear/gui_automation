*** Settings ***
Documentation     This file contains keywords for FIPSCC only

*** Keywords ***
If entropy is required
    [Documentation]    Judge if entropy token is required for FGT according to its' ASIC Version
    [Arguments]    ${asic_version}=${FGT_ASIC_VERSION}
    ${upper_asic_version}=    Convert To Uppercase    ${asic_version}
    @{predefined_asic_versions}=    Create List    CP9    SOC3
    ${if_required}=    Run keyword and return status    List Should Not Contain Value    ${predefined_asic_versions}    ${upper_asic_version}
    [Return]    ${if_required}