package mapred.exam.air.option;

import java.io.IOException;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.conf.Configured;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.input.TextInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.mapreduce.lib.output.TextOutputFormat;
import org.apache.hadoop.util.GenericOptionsParser;
import org.apache.hadoop.util.Tool;
import org.apache.hadoop.util.ToolRunner;

/* 사용자가 -D 옵션을 이용해 입력한 옵션 값을 프로그램 안에서 사용하기 위해
 * 즉, Mapper가 사용할 수 있도록 전달
 * 1. Configured, Tool 상속
 *    > Configured : 환경설정 정보 활용하기 위해 / Tool : 사용자정의 옵션 사용하기 위해
 * 2. run 메소드 오버라이딩
 *    > run 메소드 안에 Driver에서 구현했던 모든 코드를 구현
 * 3. run 메소드를 main 메소드에서 실행되도록 호출해야 함
 *    > run 메소드를 직접 호출할 수 없음. ToolRunner라는 헬퍼 클래스를 이용해서 호출
 */

public class AirOptionDriver extends Configured implements Tool{

	@Override
	public int run(String[] optionlist) throws Exception {
		//run 메소드는 사용자가 입력한 모든 옵션에 대한 정보를 String[]으로 전달받음
		//-D를 입력하고 설정한 옵션과 사용자가 입력한 명령행 매개변수를 분리하여 관리해야 함
		//getRemainingArgs()를 이용해 공통 옵션(-D와 입력한 값 이외의 입력값)과 사용자가 입력한 옵션을 따로 분리함 > 
		GenericOptionsParser parser = new GenericOptionsParser(getConf(), optionlist);
		String[] otherArgs = parser.getRemainingArgs();
		Job job = new Job(getConf(), "air_exam");
		
		job.setMapperClass(AirOptionMapper.class);
		job.setReducerClass(AirOptionReducer.class);
		job.setJarByClass(AirOptionDriver.class);
		
		job.setInputFormatClass(TextInputFormat.class);
		job.setOutputFormatClass(TextOutputFormat.class);
		
		job.setOutputKeyClass(Text.class);
		job.setOutputValueClass(IntWritable.class);
		
		FileInputFormat.addInputPath(job, new Path(otherArgs[0]));
		FileOutputFormat.setOutputPath(job, new Path(otherArgs[1]));
		
		job.waitForCompletion(true);
		return 0;
	}
	
	public static void main(String[] args) 
			throws Exception{
		ToolRunner.run(new Configuration(), new AirOptionDriver(), args);
		
	}

}

