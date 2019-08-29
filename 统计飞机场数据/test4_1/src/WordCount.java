
import java.io.IOException;
import java.util.StringTokenizer;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat; 
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat; 
public class WordCount {
	   public static class MyMapper extends Mapper<Object,Text,Text,IntWritable>{  
           private final static IntWritable number = new IntWritable();  
           private static String word = new String();  
           public void map(Object key, Text value, Context context) throws IOException,InterruptedException{  
                  
                          String word=value.toString();
                           String arr[]=word.split("\t");
                           System.out.println(word);
                           System.out.println(arr[1]);
                            number.set(Integer.parseInt(arr[3]));
                           if((arr[1].charAt(0))=='C') {
                        	   Text jichang1=new Text();
                        	   jichang1.set(arr[1]);
                        	   context.write(jichang1,number);  
                           }
                            if((arr[2].charAt(0))=='C') {
                        	   Text jichang1=new Text();
                        	   jichang1.set(arr[2]); 
                        	   context.write(jichang1,number);  
                           }
                           else {
                        	   
                           }
                          
                   
                 
           }  
   }  	  

	   public static class MyReducer extends Reducer<Text,IntWritable,Text,IntWritable>{  
           private IntWritable result = new IntWritable();  
           public void reduce(Text key, Iterable<IntWritable> values, Context context) throws IOException,InterruptedException{  
                   int sum = 0;  
                   for (IntWritable val : values)  
                   {  
                           sum += val.get();  
                   }  
                   result.set(sum);  
                  
                   context.write(key,result);  
           }  
   }  
	   
	   public static void main(String[] args) throws Exception{  

         Job job = Job.getInstance();  
         job.setJobName("WordCount");
         job.setJarByClass(WordCount.class);  
         job.setMapperClass(MyMapper.class);  
         job.setReducerClass(MyReducer.class);  
         job.setOutputKeyClass(Text.class);  
         job.setOutputValueClass(IntWritable.class);  
         Path in  = new Path("hdfs://localhost:9000/test/in/test1.txt") ;
         Path out  = new Path("hdfs://localhost:9000/test/out1") ;

         FileInputFormat.addInputPath(job,in);  
         FileOutputFormat.setOutputPath(job,out);  
         System.exit(job.waitForCompletion(true)?0:1);  
 }  
	
}
