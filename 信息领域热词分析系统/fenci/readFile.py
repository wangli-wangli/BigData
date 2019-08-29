import jieba
#读取文件
f=open(r"F:\大数据\大作业\爬取到的数据\data1_xinxi.txt",'r')
s=f.read()
#print(s)
#切割文件中的字符串
zifuchuan=s.split("\n");#按行分割
i=0
zifuchuan1=[]#标题
zifuchuan2=[]#文章链接
zifuchuan3=[]#作者
for ss in zifuchuan:
   if ss!='':#去掉空行
      #print(":"+ss)
      zifu=ss.split("\t")
      zifuchuan1.append(zifu[0])
      zifuchuan2.append(zifu[1])
      zifuchuan3.append(zifu[2])
#print(zifuchuan1)
#分词
k1=0
k2=0
fencihou2=[]
for ss in zifuchuan1:
    #print(ss)
    fencihou=jieba.lcut(ss,cut_all=True)
    #print(fencihou)
    for f in fencihou:
        if f.isspace()==False:
             print("@:"+f)
             fencihou3 = f + ' ' + zifuchuan2[k2] + ' ' + zifuchuan3[k2]
             fencihou2.append(fencihou3)
             k1 = k1 + 1

    k2=k2+1
#print(fencihou2)
#写入文件
f1=open("F:\大数据\大作业\分词后的文件\data2_xinxi.txt",'a+')
for fencihou4 in fencihou2:
    f1.write(fencihou4)
    f1.write("\n")
f1.close()










