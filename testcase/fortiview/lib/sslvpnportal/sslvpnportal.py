from selenium import webdriver
from selenium.webdriver.support.ui import WebDriverWait
from robot.api import logger
import SeleniumLibrary
from robot.libraries.BuiltIn import BuiltIn
import re
import time

class _FotigateGUI(object):
    '''
    Base Class for All GUI Classes
    '''
    __CHROME=['chrome','gc','google']
    __FIREFOX=['firefox','ff','mozilla']
    __EDGE=['edge','microsoftedge','ms']
    def __init__(self):
        self.screen_width=BuiltIn().get_variable_value('${SCREEN_SIZE_WIDTH}')
        self.screen_heigth=BuiltIn().get_variable_value('${SCREEN_SIZE_HEIGTH}')
        self.implicit_wait=BuiltIn().get_variable_value('${SELENIUM_IMPLICIT_WAIT}')
        self.timeout=BuiltIn().get_variable_value('${SELENIUM_TIMEOUT}')
        self.speed=BuiltIn().get_variable_value('${SELENIUM_TIMEOUT}')
        self.browser='chrome'

    def create_webdriver(self,browser,**parms):
        '''
        parms can be defined according to browser type
        '''
        logger.trace('parms value is: '+str(parms))
        if browser.lower() in self.__CHROME:
            self.driver = webdriver.Chrome(**parms)
        elif browser.lower() in self.__FIREFOX:
            self.driver = webdriver.Firefox(**parms)            
        elif browser.lower() in self.__EDGE:
            self.driver = webdriver.Edge(**parms)
        else:
            raise BrowserError(browser,'unknown browser type')
        return self.driver

    def get_url(self):
        return self.driver.current_url

class sslvpnportal(_FotigateGUI):
    """
    page object of sslvpn portal
    """
    def __init__(self):
        self._create_webdriver=self.create_webdriver
        self.browser=BuiltIn().get_variable_value('${SSLVPN_BROWSER}')

    def open_sslvpn_portal(self,browser,**parms):
        self._driver=self._create_webdriver(browser,**parms)
        return self._driver

    def go_to_login_page(self):
        url=BuiltIn().get_variable_value('${SSLVPN_URL}')
        logger.trace("Browse SSLVPN portal at: "+url)
        self.login_page = SslvpnLoginPage(self._driver,url)
        return self.login_page

    def close_sslvpn_portal(self):
        self.driver.quit()

class SslvpnLoginPage(_FotigateGUI):
    """
    page object of sslvpn portal login
    """
    # driver = None
    def __init__(self,driver,url):
        # if not isinstance(driver,WebDriver):
        #     raise TypeError
        logger.trace(type(driver))
        self.driver = driver
        self.driver.get(url)
        self.username=BuiltIn().get_variable_value('${SSLVPN_GUI_USERNAME}')
        logger.trace('default username is: '+self.username)
        self.password=BuiltIn().get_variable_value('${SSLVPN_GUI_PASSWORD}')
        logger.trace('default password is: '+self.password)

    def set_username(self,*username):
        locator=BuiltIn().get_variable_value('${LOGIN_SSLVPN_USERNAME_TEXT}')
        element = gui_common.find_element_by_locator(self.driver,locator)
        element.clear()
        element.send_keys(username if username else self.username)

    def set_password(self,*password):
        locator=BuiltIn().get_variable_value('${LOGIN_SSLVPN_PASSWORD_TEXT}')
        element = gui_common.find_element_by_locator(self.driver,locator)
        element.clear()
        element.send_keys(password if password else self.password)

    def login(self):
        locator=BuiltIn().get_variable_value('${LOGIN_SSLVPN_LOGIN_BUTTON}')
        element = gui_common.find_element_by_locator(self.driver,locator)
        element.click()
        ##make login sucessfully
        var_locator=BuiltIn().get_variable_value('${PORTAL_VAR_ICON_BUTTON}')
        logger.trace('var_locator: '+var_locator)        
        locator_icon=gui_common.replace_placeholder_in_locator_with_value(var_locator,self.username)
        logger.trace('locator_icon: '+locator_icon)
        # BuiltIn().run_keyword('Wait Until Element Is Visible',locator_icon)
        main_page=SslVpnMainPage()
        return main_page

    def launch_forticlient(self):
        locator=BuiltIn().get_variable_value('${LOGIN_SSLVPN_LAUNCH_FORTICLIENT_BUTTON}')
        element = gui_common.find_element_by_locator(self.driver,locator)
        element.click()


class SslVpnMainPage(_FotigateGUI):
    def __init__(self):
        pass
    


class gui_common(object):
    def __init__(self):
        pass
    @staticmethod
    def separate_strategy_and_value(locator):
        pattern='^(id|name|identifier|class|tag|xpath|css|dom|link|partial link|sizzle|jquery|default)\\s?[:=]\\s?(.*)$'
        matched=re.match(pattern,locator)
        if not matched or len(matched.groups())!=2:
            raise LocatorError(locator,'illegal locator')
        strategy= matched.groups()[0]
        value= matched.groups()[1]
        return strategy,value

    @staticmethod
    def find_element_by_locator(driver,locator):
        logger.trace('fun:_find_element')
        strategy,value=gui_common.separate_strategy_and_value(locator)
        logger.trace('strategy is:'+strategy+', and value is:'+value)
        timeout_str= BuiltIn().get_variable_value('${SELENIUM_TIMEOUT}')
        timeout=int(timeout_str)
        logger.trace(timeout_str)
        if strategy=='id':
            element=WebDriverWait(driver,timeout).until(lambda x:x.find_element_by_id(value))
        elif strategy=='name':
            element=WebDriverWait(driver,timeout).until(lambda x:x.find_element_by_name(value))
        elif strategy=='class':
            element=WebDriverWait(driver,timeout).until(lambda x:x.find_element_by_class_name(value))
        elif strategy=='xpath':
            element=WebDriverWait(driver,timeout).until(lambda x:x.find_element_by_xpath(value))
        elif strategy=='css':
            element=WebDriverWait(driver,timeout).until(lambda x:x.find_element_by_css_selector(value))
        else:
            raise LocatorError(locator,'unsupported strategy')
        return element

    @staticmethod
    def replace_placeholder_in_locator_with_value(locator,val):
        replaced_locator=re.sub('\\${PLACEHOLDER}',val,locator)
        return replaced_locator

class FortiGateError(Exception):
    def __init__(self):
        pass

class LocatorError(FortiGateError):
    def __init__(self,expression,message):
        self.expression=expression
        self.message=message
class BrowserError(FortiGateError):
    def __init__(self,expression,message):
        self.expression=expression
        self.message=message

def run_selenium():
    sslvpn= sslvpnportal()
    sslvpn.open_sslvpn_portal()
    login_page=sslvpn.go_to_login_page()
    login_page.set_username('user')
    login_page.set_password('123456')
    login_page.login()
    time.sleep(10)
    sslvpn.close_sslvpn_portal()

def run_other(locator):
    s,v=gui_common.separate_strategy_and_value(locator)
    print(s)
    print(v)

if __name__=="__main__":
    run_selenium()
