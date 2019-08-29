#!/usr/bin/env python
# coding=utf-8
import sys
import jieba
from sklearn.pipeline import Pipeline
from sklearn.feature_extraction.text import CountVectorizer, TfidfTransformer
from sklearn.svm import LinearSVC
from sklearn.multiclass import OneVsRestClassifier
from sklearn.preprocessing import MultiLabelBinarizer
import pymysql
import pandas as pd
import re
import numpy as np
import csv


def jieba_tokenizer(x): return jieba.cut(x, cut_all=True)


def partition(x): return x


def filter_html(s):
    d = re.compile(r'<[^>]+>', re.S)
    s = d.sub('', s)
    return s


def gbk_utf8(s):
    s = s.decode('gbk', "ignore").encode('utf8')
    return s
def write_sql(id,classs):
    db = pymysql.Connection(host="localhost", port=3307, user="root", password="root", database="jiansuo",
                            charset="utf8")
    cursor = db.cursor()
    sql = "update yuan set classs='" + classs + "'  where id=" + str(id)
    try:
        cursor.execute(sql)
        db.commit()
    except:
        db.commit()
        print("出错了！")
    db.close()

# 训练数据样本
data_ret = pd.DataFrame()


f=open(r"F:\大数据\讨厌的\a1.csv",'r')
s=f.read()
f.close()
#print(s)
#切割文件中的字符串
zifuchuan=s.split("\n");#按行分割
i=0
id=[]
article=[]
word_seg=[]
classs=[]
k=1
for ss in zifuchuan:
       str=ss.split(",")
       #print(str[0])
       id.append(str[0])
       if(len(str)>1):
           article.append(str[1])
           word_seg.append(str[2])
           classs.append(str[3])

txt_ret=article
X_train = txt_ret#训练数据
class_ret=classs
Y_train = class_ret

classifier = Pipeline([
    ('counter', CountVectorizer(tokenizer=jieba_tokenizer)),
    ('tfidf', TfidfTransformer()),
    ('clf', OneVsRestClassifier(LinearSVC())),
])
mlb = MultiLabelBinarizer()
Y_train = mlb.fit_transform(Y_train)
classifier.fit(X_train, Y_train)
#print(classifier.score(X_train,Y_train))
# 测试数据
f=open(r"F:\大数据\讨厌的\b1.csv",'r')
s=f.read()
f.close()
#print(s)
#切割文件中的字符串
zifuchuan=s.split("\n");#按行分割
id2=[]
article2=[]
word_seg2=[]
for ss in zifuchuan:
   str=ss.split(",")
   #print(str[0])
   id.append(str[0])
   if(len(str)>1):
    article.append(str[1])
    word_seg.append(str[2])
X_test = article#测试数据

prediction = classifier.predict(X_test)

result = mlb.inverse_transform(prediction)
# 展示结果
for i, label1 in enumerate(result):
    classstr = ''
    print(''.join(label1))
    # for j, label2 in enumerate(label1):
    #     print('c')
    #     classstr += str(label2) + ""
    #     print(classstr)
    # print("ID:" + str(id2[i]) + " =>class:" + classstr)
    #write_sql(test_id_ret[i],classstr)
