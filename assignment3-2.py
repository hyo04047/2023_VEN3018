from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
import time
from bs4 import BeautifulSoup
import pandas as pd

driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()))
url = 'https://www.youtube.com/watch?v=zJI4bgEJ8IU&t=132s&ab_channel=%EC%BD%94%EB%94%A9%EC%95%A0%ED%94%8C'
driver.get(url)
driver.page_source[1:1000]

prev_height = driver.execute_script('return document.documentElement.scrollHeight')

while True:
    driver.execute_script('window.scrollTo(0, document.documentElement.scrollHeight);')
    time.sleep(3)

    curr_height = driver.execute_script('return document.documentElement.scrollHeight')
    if curr_height == prev_height:
        break
    prev_height = curr_height

html = BeautifulSoup(driver.page_source, 'lxml')
comment_list = html.select("yt-formatted-string#content-text")

comments = []

for i in range(len(comment_list)):
    tmp = str(comment_list[i].text)
    tmp = tmp.replace('\n', '')
    tmp = tmp.replace('\t', '')
    tmp = tmp.replace('               ', '')

    comments.append(tmp)

comments_pd = pd.DataFrame({"Comment":comments})
print(comments_pd)