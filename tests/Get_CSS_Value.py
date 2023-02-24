from    selenium    import  webdriver
from selenium.webdriver.common.by import By

from selenium.webdriver.remote.webdriver import WebElement


from selenium.webdriver.common.action_chains import ActionChains

driver= webdriver.Chrome()

def Value_display_CSS_property():
    #element = driver.find_element("//*[@id='contents']/a[2]")
    #element = driver.find_element_by_xpath("//*[@id='contents']/a[2]")
    driver.execute_script("window.scrollTo(0, 1000);")
    element = driver.find_element(By.XPATH, "/html/body/div/div[2]/div/a[2]")

    driver.execute_script("arguments[0].scrollIntoView();", element)
    css_value = element.getCssValue("background-color")
    print(css_value)
    return css_value

