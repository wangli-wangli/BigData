def main():
    file=open("F:\大数据\大作业\分词后的文件\data4_xinxi.txt",'r')
    wordCounts={}    #先建立一个空的字典，用来存储单词 和相应出现的频次
    count=50       #显示前多少条（按照单词出现频次从高到低）
    for line in file:

        lineprocess(line.lower(),wordCounts)  #对于每一行都进行处理，调用lineprocess()函数，参数就是从file文件读取的一行
        items0=list(wordCounts.items())       #把字典中的键值对存成列表，形如：["word":"data"]
        items=[[x,y] for (y,x) in items0]     #将列表中的键值对换一下顺序，方便进行单词频次的排序 就变成了["data":"word"]
        items.sort()            #sort()函数对每个单词出现的频次按从小到大进行排序
    gailv=[]#存储像文件中输入的词语以及概率
    for i in range(len(items)-1,1,-1):   #上一步进行排序之后 对items中的元素从后面开始遍历 也就是先访问频次多的单词
            if items[i][0]<10:
                break;
            zz=items[i][1]+"\t"+str(items[i][0])
            gailv.append(zz)
    f2 = open("F:\大数据\大作业\分词后的文件\data5_xinxi.txt", 'a+',encoding='utf-8')
    for z1 in gailv:
        f2.write(z1)
        f2.write("\n")
    f2.close()


def lineprocess(line,wordCounts):
    for ch in line:   #对于每一行中的每一个字符 对于其中的特殊字符需要进行替换操作
        if ch in "~@#$%^&*()_-+=<>?/,.:;{}[]|\'""":
            line=line.replace(ch,"")
    words=line.split()  #替换掉特殊字符以后 对每一行去掉空行操作,也就是每一行实际的单词数量
    for word in words:
        if word in wordCounts:
            wordCounts[word]+=1
        else:
            wordCounts[word]=1

    #这个函数执行完成之后整篇文章里每个单词出现的频次都已经统计好了


main()
