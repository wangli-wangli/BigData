import pymysql
def write(id,keywords,abstract):
    db=pymysql.Connection(host="localhost",port=3307,user="root", password="root",database="jiansuo",charset="utf8")
    cursor=db.cursor()
    sql="update yuan set keywords='"+keywords+"',abstract='"+abstract+"' where id="+str(id)
    try:
        cursor.execute(sql)
        db.commit()
    except:
        db.commit()
        print("出错了！")
    db.close()
