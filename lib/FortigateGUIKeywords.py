from selenium.webdriver.common.action_chains import ActionChains
from SeleniumLibrary.base import LibraryComponent, keyword


class FortigateGUIKeywords(LibraryComponent):
    @keyword
    def double_click_element_at_coordinates(self, locator, xoffset, yoffset):
        self.info("Double Clicking element '%s' at coordinates x=%s, y=%s." % (locator, xoffset, yoffset))
        element = self.find_element(locator)
        action = ActionChains(self.driver)
        action.move_to_element(element)
        action.move_by_offset(xoffset, yoffset)
        action.double_click(element).perform()