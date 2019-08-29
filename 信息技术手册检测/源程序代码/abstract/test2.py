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


# 链接mysql数据库
conn = pymysql.Connection(host="localhost",port=3307,user="root", password="root",database="jiansuo",charset="utf8")
cursor = conn.cursor()
cursor=conn.cursor()

# 训练数据样本
data_ret = pd.DataFrame()

sql = "SELECT id, name,yuan_copy.class,yuan_copy.explain FROM yuan_copy "
# print sql
cursor.execute(sql)

txt_ret = []
#class_ret = [["信息化"],["大数据"],["云计算"],["区块链"],["智慧城市"],["工业互联网"],["信息安全"],["操作系统"],["计算机"],["法律法规"],["信息化战略"]]
class_ret=[]
id_ret = []
for row in cursor.fetchall():
    content = filter_html(row[3])
    txt_ret.append(content)
    class_s = row[2]
    class_l = class_s.split("  ")
    class_ret.append(class_l)
    id_ret.append(row[0])

txt_ret = txt_ret

X_train = txt_ret
print(class_ret)
Y_train = class_ret

classifier = Pipeline([
    ('counter', CountVectorizer(tokenizer=jieba_tokenizer)),
    ('tfidf', TfidfTransformer()),
    ('clf', OneVsRestClassifier(LinearSVC())),
])
mlb = MultiLabelBinarizer()
Y_train = mlb.fit_transform(Y_train)
classifier.fit(X_train, Y_train)
print(classifier.score(X_train,Y_train))
# 测试数据
test_txt_set = []
sql = "SELECT id, name,keywords,yuan.explain FROM yuan  "
cursor.execute(sql)
test_id_ret = []

for row in cursor.fetchall():
    test_txt_set.append(filter_html(row[3]))
    test_id_ret.append(row[0])
X_test = test_txt_set

prediction = classifier.predict(X_test)

result = mlb.inverse_transform(prediction)
# 展示结果
for i, label1 in enumerate(result):
    classstr = ''
    for j, label2 in enumerate(label1):
        classstr += str(label2) + ""
    print("ID:" + str(test_id_ret[i]) + " =>class:" + classstr)
    write_sql(test_id_ret[i],classstr)
