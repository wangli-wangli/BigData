import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.Reducer.Context;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
public class LogApp2 {
	//获取指定字符串中指定标识符的字符串出现的索引位置

	private static int getCharacterPosition(String value, String operator, int index) {
	// 对子字符串进行匹配
	Matcher slashMatcher = Pattern.compile(operator).matcher(value);
	int mInx = 0;// 计数
	// matcher.find();尝试查找与该模式匹配的输入序列的下一个子序列
	while (slashMatcher.find()) {
		mInx++;
		if (mInx == index) {
			break;
		}
	}
	// slashMatcher.start（）返回上一个匹配的起始索引
	return slashMatcher.start();
}

/**
 * Map：读取输入的文件
 */
public static class MyMapper extends Mapper<LongWritable, Text, Text, LongWritable> {

	LongWritable one = new LongWritable(1);

	@Override
	protected void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException {

		// 接收到的每一行数据
		String line = value.toString();
		System.out.println(line);
		String[] parts = line.split(" ");
		String ip = parts[0];
		String time = parts[3] + parts[4];
		time = time.substring(1, time.length() - 1);
		String traffic = parts[9];
		String source = line.substring(getCharacterPosition(line, "\"", 5) + 1,
				getCharacterPosition(line, "\"", 6));
		if (source.length() < 30) {
		//	System.out.println(11+line);
			context.write(new Text(""), one);
		} else {
			System.out.println(22+line);
			String type = source.substring(23);
		//	System.out.println(type);
			String id = "";

			if (type.charAt(0) == 'a') {
				type = "article";
				if(source.length()<32)
				{
				
				}else{
					id = source.substring(31);
				}
				
			} else {
				
				type = "video";
				if(source.length()<30)
				{
				
				}else{
					id = source.substring(29);
				}
			}
			String result = ip + "," + time + "," + traffic + "," + type + "," + id;
			context.write(new Text(result), one);
		}
	}
}

/**
 * Reduce：归并操作
 */
public static class MyReducer extends Reducer<Text, LongWritable, Text, LongWritable> {

	@Override
	protected void reduce(Text key, Iterable<LongWritable> values, Context context)
			throws IOException, InterruptedException {

		long sum = 0;
		for (LongWritable value : values) {
			// 求key出现的次数总和
			sum += value.get();
		}

		// 最终统计结果的输出
		context.write(key, new LongWritable(sum));
	}
}

/**
 * 定义Driver：封装了MapReduce作业的所有信息
 */
public static void main(String[] args) throws Exception {

	// 创建Configuration
	Configuration configuration = new Configuration();

	// 准备清理已存在的输出目录
	Path outputPath = new Path("/data/mapreduce1/log_out");
	FileSystem fileSystem = FileSystem.get(configuration);

	// 创建Job
	Job job = Job.getInstance(configuration, "LogAPP");

	// 设置job的处理类
	job.setJarByClass(LogApp2.class);

	// 设置作业处理的输入路径
	FileInputFormat.setInputPaths(job, new Path("hdfs://localhost:9000/test2/in/log.log"));

	// 设置map相关参数
	job.setMapperClass(MyMapper.class);
	job.setMapOutputKeyClass(Text.class);
	job.setMapOutputValueClass(LongWritable.class);

	// 设置reduce相关参数
	job.setReducerClass(MyReducer.class);
	job.setOutputKeyClass(Text.class);
	job.setOutputValueClass(LongWritable.class);

	// 设置作业处理的输出路径
	//FileOutputFormat.setOutputPath(job, new Path("hdfs://localhost:9000/test2/out"));

	System.exit(job.waitForCompletion(true) ? 0 : 1);
}

}
