import requests
from bs4 import BeautifulSoup
import json

save_file = "data.json"
content = []
title = []
sourceUrl = []
summary = []
date = []

def getHTMLText(url, code="utf-8"):
    try:
        r = requests.get(url)
        r.raise_for_status()
        r.encoding = code
        return r.text
    except:
        return ""

"""
* 按时间线获取事件 - 响应
*
* @param title 标题
* @param sourceUrl 原文Url
* @param summary 概要
* @param date 时间
"""

if __name__ == '__main__':
    url = 'https://www.xinli001.com/info/tag_823'

    html_doc = getHTMLText(url)

    soup = BeautifulSoup(html_doc, "html.parser", from_encoding="utf-8")
    articleList = soup.find('div', id={'articleListM'})
    #print(articleList)
    for item in articleList.find_all(class_ = 'item'):
        name = item.find(class_ = 'title')
        #title.append(name.string)        # 标题
        temphref = name['href']
        href = temphref[2:]
        #sourceUrl.append(href)        # 原文链接
        desc = item.find(class_='desc')
        #summary.append(desc.string)        # 摘要
        time = item.find(class_='date')
        #date.append(time.string)        # 时间
        content.append({'title': name.string, 'sourceUrl': href, 'summary': desc.string, 'date': time.string})

    print(content)
    with open(save_file,'w') as fp:
        json.dump(content, fp = fp, ensure_ascii = False, indent = 4)
        fp.close()

