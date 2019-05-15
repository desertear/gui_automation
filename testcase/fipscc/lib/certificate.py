from selenium import webdriver
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from cryptography.hazmat.backends import default_backend
from cryptography.hazmat.primitives import serialization
from cryptography.hazmat.primitives.asymmetric import rsa
from cryptography import x509
from cryptography.x509.oid import NameOID
from cryptography.hazmat.primitives import hashes
from ipaddress import IPv4Address
import datetime

def test():
    driver = webdriver.Chrome()
    locator= "chrome://settings/clearBrowserData"
    driver.get(locator)
    element= WebDriverWait(driver, 10).until(lambda x:x.find_element_by_css_selector(locator))
    element.click()
    driver.close()

def create_key():
    key = rsa.generate_private_key(public_exponent=65537, 
        key_size=2048, 
        backend=default_backend())
    with open("./test.key","wb") as f:
        f.write(key.private_bytes(encoding=serialization.Encoding.PEM, 
            format=serialization.PrivateFormat.TraditionalOpenSSL, 
            encryption_algorithm=serialization.BestAvailableEncryption(b"passphrase")))
    return key

def create_csr(key):
    csr = x509.CertificateSigningRequestBuilder().subject_name(x509.Name([
        x509.NameAttribute(NameOID.COUNTRY_NAME, u"CA"),
        x509.NameAttribute(NameOID.STATE_OR_PROVINCE_NAME, u"BC"),
        x509.NameAttribute(NameOID.LOCALITY_NAME,u"Burnaby"),
        x509.NameAttribute(NameOID.ORGANIZATION_NAME,u"FOSQA"),
    ])).add_extension(
        x509.SubjectAlternativeName([
            x509.IPAddress(IPv4Address('10.1.100.1')),         
            x509.DNSName(u"www.fipscc.com"),
        ]),critical=False,
    ).sign(key, hashes.SHA256(), default_backend())
    with open("./test.csr", "wb") as f:
        f.write(csr.public_bytes(serialization.Encoding.PEM))
    return csr

def create_self_signed_certificate(key):
    subject = issuer = x509.Name([
        x509.NameAttribute(NameOID.COUNTRY_NAME, u"CA"),
        x509.NameAttribute(NameOID.STATE_OR_PROVINCE_NAME, u"BC"),
        x509.NameAttribute(NameOID.LOCALITY_NAME, u"Burnaby"),
        x509.NameAttribute(NameOID.ORGANIZATION_NAME, u"Fortinet"),
        x509.NameAttribute(NameOID.COMMON_NAME, u"*.automation.com"),
    ])
    cert = x509.CertificateBuilder().subject_name(
        subject
    ).issuer_name(
        issuer
    ).public_key(
        key.public_key()
    ).serial_number(
        x509.random_serial_number()
    ).not_valid_before(
        datetime.datetime.utcnow()
    ).not_valid_after(
        datetime.datetime.utcnow() + datetime.timedelta(days=3650)
    ).add_extension(
        x509.SubjectAlternativeName([x509.DNSName(u"*.fos.com")]),
        critical=False,
    ).sign(key,hashes.SHA256(), default_backend())
    with open('./test.cer', 'wb') as f:
        f.write(cert.public_bytes(serialization.Encoding.PEM))
    return cert

if __name__=="__main__":
    key = create_key()
    print(type(key))
    csr = create_csr(key)
    print(type(csr))
    cert = create_self_signed_certificate(key)
    print(type(cert))