import pymysql
id=[]
name=[]
explain=[]
db=pymysql.Connection(host="localhost",port=3307,user="root", password="root",database="jiansuo",charset="utf8")
cursor=db.cursor()
sql="select * from yuan"
try:
    cursor.execute(sql)
    results=cursor.fetchall()
    for row in results:
        id.append(row[0])
        name.append(row[1])
        explain.append(row[2])
except:
    print("出错了！")
db.close()
