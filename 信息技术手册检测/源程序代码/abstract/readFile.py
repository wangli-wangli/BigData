import jieba
import csv
#读取文件
f=open(r"F:\大数据\Preliminary-finals.csv.csv",'r')
s=f.read()
f.close()
#print(s)
#切割文件中的字符串
zifuchuan=s.split("\n");#按行分割
i=0
id=[]
article=[]

k=1
for ss in zifuchuan:
   str=ss.split(",")
   id.append(str[0])
   article.append(str[1])
   i=i+1
   if i==200:
      break
for h in range(0,i):
   print(len(id[h]))
   if(len(id[h])<=6):
         with open('a%d.csv'%k, 'a', newline='', encoding='utf-8')as d:
               write = csv.writer(d)
               write.writerow(id[h],article[h])
               d.close()

print("写完了！")







