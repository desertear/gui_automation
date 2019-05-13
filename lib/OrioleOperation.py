'''
create on April 25, 2018
'''
import re
import os
import time
import sys
import getopt
import json
from copy import deepcopy
import zeep
from robot.libraries.BuiltIn import BuiltIn
from robot.api import logger

class OrioleOperation(object):
    def __init__(self,username=None,encoded_password=None,oriole_url=None,version=None,task_path=None):
        #self.oriole_url = r'http://172.16.100.117/wsqadb/AutoTestResult?wsdl'
        self.oriole_url = oriole_url if oriole_url else BuiltIn().get_variable_value('${ORIOLE_SUBMIT_URL}')
        self.version = version if version else BuiltIn().get_variable_value('${FGT_TEST_VERSION}')
        # self.task_path = r'/FOS/RLS_V/Regression/'
        self.task_path = task_path if task_path else BuiltIn().get_variable_value('${ORIOLE_TASK_PATH}')
        self.username = username if username else BuiltIn().get_variable_value('${ORIOLE_ACCOUNT}')
        self.encoded_password = encoded_password if encoded_password else BuiltIn().get_variable_value('${ORIOLE_ENCODED_PASSWORD}')


    def submit_to_oriole(self,json_file):
        '''submit passed result to Oriole server'''
        #global ORIOLE_ENCODED_PASSWORD
        #global ORIOLE_ACCOUNT
        #global ORIOLE_SUBMIT_URL
        logger.trace('Oriole url is: %s' %self.oriole_url)
        logger.trace('Oriole username is: %s' %self.username)
        with open(json_file, 'r') as f:
            jsonrpt = f.read()
        release = self.version
        release_short = release[:3]
        clt = zeep.Client(wsdl=self.oriole_url)
        dt = clt.get_type('ns0:testResult')
        # print(jsonrpt)
        bdy = dt(encodedPassword=self.encoded_password,jsonReport=jsonrpt, release=release_short,taskPath=self.task_path, username=self.username)
        print(bdy)
        # testResult(encodedPassword: xsd:string, jsonReport: xsd:string,
        # release: xsd:string, taskPath: xsd:string, username: xsd:string)
        result = clt.service.submitResult(bdy)
        # decode_ret_code(result)
        print(result)
        return result["message"]


if __name__ == "__main__":
    ##please don't update oriole_url unless you know it
    oriole_url = r'http://172.16.100.117/wsqadb/AutoTestResult?wsdl'
    #FGT Release version, i.e. 6.2.0, 5.6.7, 6.0.4
    version = '6.2'
    #The Task Path on Oriole.
    task_path = r'/FOS/'+version+r'/Regression/'
    #Your LDAP account name
    username = 'maryzhang'
    #password can be got from "user profile" after you login Oriole
    password= 'Vm1kTlJFTnNTbGxXVVhSS1FtZE5TRlZTTVZGQ1VVRkhVMVl4Vmxoc1pFcFZiRTVTUVVaU1ZsZG5UbEpXYkZKaw=='
    #the JSON file that records all running results, it can be found under folder $HOME/result
    json_file='C:\\sslvpn_automation\\script\\trunk\\gui_automation\\result\\test_report_20181018104231.json'
    OrioleOperation(username,password,oriole_url,version,task_path).submit_to_oriole(json_file)