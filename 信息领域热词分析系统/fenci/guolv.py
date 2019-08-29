#创建停用词表
def stopwordlist():
    stopwords=[line.strip() for line in open ('F:\大数据\大作业\分词后的文件\stopWord.txt','r').readlines()]
    return stopwords

f=open(r"F:\大数据\大作业\分词后的文件\data2_xinxi.txt",'r')
s=f.read()
#切割文件中的字符串
zifuchuan=s.split("\n");#按行分割
i=0
stopwords=stopwordlist()
zifuchuan2=[]#过滤后的信息
zifuchuan3=[]
for ss in zifuchuan:
      zifu=ss.split(" ")
      print(":"+zifu[0])
      if zifu[0].isdigit()==False:
         if zifu[0] not in stopwords:
            zifuchuan2.append(ss)
            zifuchuan3.append(zifu[0])

#写入文件
f1=open("F:\大数据\大作业\分词后的文件\data3_xinxi.txt",'a+')
for z in zifuchuan2:
    f1.write(z)
    f1.write("\n")
f1.close()
f2=open("F:\大数据\大作业\分词后的文件\data4_xinxi.txt",'a+')
for z1 in zifuchuan3:
    f2.write(z1)
    f2.write("\n")
f2.close()


