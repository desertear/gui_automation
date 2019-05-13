*** Settings ***
Documentation     This file contains all locator variables on FortiGate System->Certificates page

*** Variables ***
#System->Certificates
${SYSTEM_CERTIFICATES_ENTRY}    xpath:(//span[text()="Certificates"])[2]
${SYSTEM_CERTIFICATES_FRAME}    xpath://iframe[@name="embedded-iframe"]
${SYSTEM_CERTIFICATES_GENERATE}    xpath://button[div/span="Generate"]
${SYSTEM_CERTIFICATES_EDIT}    xpath://button[div/span="Edit"]
${SYSTEM_CERTIFICATES_DELETE}    xpath://button[div/span="Delete"]
${SYSTEM_CERTIFICATES_VIEW_DETAILS}    xpath://button[div/span="View Details"]
${SYSTEM_CERTIFICATES_DOWNLOAD}    xpath://button[div/span="Download"]
${VAR_SYSTEM_CERTIFICATES_LINE_BY_CERTIFICATE_NAME}    xpath://tr[td[@class="name" and span="\${PLACEHOLDER}"]]
${VAR_SYSTEM_CERTIFICATES_LINE_CONTAINS_CERTIFICATE_NAME}    xpath://tr[td[@class="name" and contains(span,"\${PLACEHOLDER}")]]
${VAR_SYSTEM_CERTIFICATES_STATUS_BY_CERTIFICATE_NAME}    xpath://tr[td[@class="name" and span="\${PLACEHOLDER}"]]/td[@class="status"]/span
#Confirm window
${SYSTEM_CERTIFICATES_CONFIRM_HEAD}    xpath://h1[text()="Confirm"]
${SYSTEM_CERTIFICATES_CONFIRM_OK_BUTTON}    xpath://button[text()="OK"]
${SYSTEM_CERTIFICATES_CONFIRM_CANCEL_BUTTON}    xpath://button[text()="Cancel"]
##Generate Certificate Signing Request
${SYSTEM_CERTIFICATES_GENERATE_HEAD}    xpath://h1[text()="Generate Certificate Signing Request"]
${SYSTEM_CERTIFICATES_GENERATE_NAME_TEXT}    xpath://label[field-label="Certificate Name"]/following-sibling::div//input
${VAR_SYSTEM_CERTIFICATES_GENERATE_TYPE_LABEL}    xpath://label[field-label="ID Type"]/following-sibling::div//label[span="\${PLACEHOLDER}"]
${VAR_SYSTEM_CERTIFICATES_GENERATE_CN_TEXT}    xpath://label[field-label="\${PLACEHOLDER}"]/following-sibling::div//input
${SYSTEM_CERTIFICATES_GENERATE_OU_TEXT}    xpath://label[field-label="Organization Unit"]/following-sibling::div//input

${SYSTEM_CERTIFICATES_GENERATE_ORGANIZATION_TEXT}    xpath://label[field-label="Organization"]/following-sibling::div//input
${SYSTEM_CERTIFICATES_GENERATE_LOCALITY_TEXT}    xpath://label[field-label="Locality(City)"]/following-sibling::div//input
${SYSTEM_CERTIFICATES_GENERATE_STATE_TEXT}    xpath://label[field-label="State / Province"]/following-sibling::div//input
${SYSTEM_CERTIFICATES_GENERATE_COUNTRY_CHECKBOX_LABEL}    xpath://span[text()="Country / Region"]/following-sibling::label
${SYSTEM_CERTIFICATES_GENERATE_COUNTRY_CHECKBOX}    xpath://span[text()="Country / Region"]/following-sibling::input
${SYSTEM_CERTIFICATES_GENERATE_COUNTRY_DIV}    xpath://label[//span="Country / Region"]/following-sibling::div//div[@class="add-placeholder"]
${VAR_SYSTEM_CERTIFICATES_GENERATE_COUNTRY_ITEM_DROPDOWN}    xpath://div[@class="selection-dropdown"]//div[span/span[text()="\${PLACEHOLDER}"]]
${VAR_SYSTEM_CERTIFICATES_GENERATE_COUNTRY_ITEM_IN_DIV}    xpath://label[//span="Country / Region"]/following-sibling::div//span[text()="\${PLACEHOLDER}"]
${SYSTEM_CERTIFICATES_GENERATE_EMAIL_TEXT}    xpath://label[field-label="E-Mail"]/following-sibling::div//input
${SYSTEM_CERTIFICATES_GENERATE_SAN_TEXT}    xpath://label[field-label="Subject Alternative Name"]/following-sibling::div//input
${SYSTEM_CERTIFICATES_GENERATE_PASSWORD_TEXT}    xpath://label[field-label="Password for private key"]/following-sibling::div//input[@type="password"]
${VAR_SYSTEM_CERTIFICATES_GENERATE_KEY_TYPE_LABEL}    xpath://label[field-label="Key Type"]/following-sibling::div//label[span="\${PLACEHOLDER}"]
${VAR_SYSTEM_CERTIFICATES_GENERATE_KEY_SIZE_LABEL}    xpath://label[field-label="Key Size"]/following-sibling::div//label[span="\${PLACEHOLDER}"]
${VAR_SYSTEM_CERTIFICATES_GENERATE_CURVE_NAME_LABEL}    xpath://label[field-label="Curve Name"]/following-sibling::div//label[span="\${PLACEHOLDER}"]
${VAR_SYSTEM_CERTIFICATES_GENERATE_ENROLLMENT_METHOD_LABEL}    xpath://label[field-label="Enrollment Method"]/following-sibling::div//label[span="\${PLACEHOLDER}"]
${SYSTEM_CERTIFICATES_GENERATE_CA_SERVER_URL_TEXT}    xpath://label[field-label="CA Server URL"]/following-sibling::div//input
${SYSTEM_CERTIFICATES_GENERATE_CHALLENGE_PASSWORD_TEXT}    xpath://label[field-label="Challenge Password"]/following-sibling::div//input[@type="password"]
${SYSTEM_CERTIFICATES_GENERATE_CONFIRM_PASSWORD_TEXT}    xpath://label[field-label="Confirm Password"]/following-sibling::div//input[@type="password"]
${SYSTEM_CERTIFICATES_GENERATE_OK_BUTTON}    xpath://button[span="OK"]
${SYSTEM_CERTIFICATES_GENERATE_CANCEL_BUTTON}    xpath://button[normalize-space(.)="Cancel"]

#Import
${SYSTEM_CERTIFICATES_IMPORT}    xpath://button[normalize-space(div/span)="Import"]
${VAR_SYSTEM_CERTIFICATES_IMPORT_CERTIFICATE}    xpath://button[normalize-space(div/span)="\${PLACEHOLDER}"]
${SYSTEM_CERTIFICATES_IMPORT_LOCAL_CERTIFICATE}    xpath://button[normalize-space(div/span)="Local Certificate"]
${SYSTEM_CERTIFICATES_IMPORT_CA_CERTIFICATE}    xpath://button[normalize-space(div/span)="CA Certificate"]
${SYSTEM_CERTIFICATES_IMPORT_REMOTE_CERTIFICATE}    xpath://button[normalize-space(div/span)="Remote Certificate"]
${SYSTEM_CERTIFICATES_IMPORT_CRL}    xpath://button[normalize-space(div/span)="CRL"]
${SYSTEM_CERTIFICATES_IMPORT_FRAME}    xpath://iframe[contains(@name,"slide-iframe")]
${SYSTEM_CERTIFICATES_IMPORT_OK_BUTTON}    xpath://button[span="OK"]
${SYSTEM_CERTIFICATES_IMPORT_CANCEL_BUTTON}    xpath://button[normalize-space(.)="Cancel"]
##Local Certificate
${SYSTEM_CERTIFICATES_IMPORT_LOCAL_HEAD}    xpath://h1[text()="Import Certificate"]
${VAR_SYSTEM_CERTIFICATES_IMPORT_LOCAL_TYPE_LABEL}    xpath://label[field-label="Type"]/following-sibling::div//label[span="\${PLACEHOLDER}"]
${SYSTEM_CERTIFICATES_IMPORT_LOCAL_PKCS_KEY_FILE}    xpath://label[contains(field-label,"Certificate with key file")]/following-sibling::div//input[@type="file"]
${SYSTEM_CERTIFICATES_IMPORT_LOCAL_PASSWORD}    xpath://label[field-label="Password"]/following-sibling::div//input[@type="password"]
${SYSTEM_CERTIFICATES_IMPORT_LOCAL_CONFIRM_PASSWORD}    xpath://label[field-label="Confirm Password"]/following-sibling::div//input[@type="password"]
${SYSTEM_CERTIFICATES_IMPORT_LOCAL_CERTIFICATE_FILE}    xpath://label[contains(field-label,"Certificate file")]/following-sibling::div//input[@type="file"]
${SYSTEM_CERTIFICATES_IMPORT_LOCAL_CERTIFICATE_KEY_FILE}    xpath://label[contains(field-label,"Key file")]/following-sibling::div//input[@type="file"]
##Import CA Certificate
${SYSTEM_CERTIFICATES_IMPORT_CA_HEAD}    xpath://h1[text()="Import CA Certificate"]
${VAR_SYSTEM_CERTIFICATES_IMPORT_CA_TYPE_LABEL}    xpath://label[field-label="Type"]/following-sibling::div//label[span="\${PLACEHOLDER}"]
${SYSTEM_CERTIFICATES_IMPORT_CA_SCEP_URL_TEXT}    xpath://label[field-label="URL of the SCEP server"]/following-sibling::div//input
${SYSTEM_CERTIFICATES_IMPORT_CA_SCEP_OPTIONAL_ID_TEXT}    xpath://label[field-label="Optional CA Identifier"]/following-sibling::div//input
${SYSTEM_CERTIFICATES_IMPORT_CA_UPLOAD_FILE}    xpath://label[contains(field-label,"Upload")]/following-sibling::div//input[@type="file"]
##Upload Remote Certificate
${SYSTEM_CERTIFICATES_IMPORT_REMOTE_HEAD}    xpath://h1[text()="Upload Remote Certificate"]
${SYSTEM_CERTIFICATES_IMPORT_REMOTE_UPLOAD_FILE}    xpath://label[contains(field-label,"Upload")]/following-sibling::div//input[@type="file"]
##Import CRL
${SYSTEM_CERTIFICATES_IMPORT_CRL_HEAD}    xpath://h1[text()="Import CRL"]
${VAR_SYSTEM_CERTIFICATES_IMPORT_CRL_METHOD_LABEL}    xpath://label[field-label="Import Method"]/following-sibling::div//label[span="\${PLACEHOLDER}"]
${SYSTEM_CERTIFICATES_IMPORT_CRL_UPLOAD_FILE}    xpath://label[contains(field-label,"Upload")]/following-sibling::div//input[@type="file"]
${SYSTEM_CERTIFICATES_IMPORT_CRL_HTTP_LABEL}    xpath://h2[text()="HTTP"]
${SYSTEM_CERTIFICATES_IMPORT_CRL_HTTP_CHECKBOX}    id:chk-http
${SYSTEM_CERTIFICATES_IMPORT_CRL_HTTP_URL}    xpath://label[contains(field-label,"URL of the HTTP server")]/following-sibling::div//input
${SYSTEM_CERTIFICATES_IMPORT_CRL_LDAP_LABEL}    xpath://h2[text()="LDAP"]
${SYSTEM_CERTIFICATES_IMPORT_CRL_LDAP_CHECKBOX}    id:chk-ldap
${SYSTEM_CERTIFICATES_IMPORT_CRL_SCEP_LABEL}    xpath://h2[text()="SCEP"]
${SYSTEM_CERTIFICATES_IMPORT_CRL_SCEP_CHECKBOX}    id:chk-scep