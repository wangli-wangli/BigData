

import java.util.ArrayList;

import org.bson.Document;

import com.mongodb.MongoClient;
import com.mongodb.MongoCredential;
import com.mongodb.ServerAddress;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;

public class shanchuwendang {
	public static void main(String[] args) {
		ServerAddress serverAddress = new ServerAddress("localhost", 27017);
		ArrayList<ServerAddress> addrs = new ArrayList<ServerAddress>();
		addrs.add(serverAddress);

		MongoCredential credential =MongoCredential.createCredential("root", "admin",
				"wangli".toCharArray());  
		ArrayList<MongoCredential> credentials = new ArrayList<MongoCredential>();
		credentials.add(credential);

		MongoClient mongoClient = new MongoClient(addrs, credentials);

		MongoDatabase mongoDatabase = mongoClient.getDatabase("test");
		System.out.println("Connect to database successfully");
         MongoCollection<org.bson.Document> collection=mongoDatabase.getCollection("platform");
         System.out.println("Collect mycol selection is successful");
		
         //删除符合条件的第一个文档
         //collection.deleteOne(Filters.eq("likes",200));
         //删除所有符合要求的文档
        collection.deleteMany(Filters.eq("国家名称","aaaa"));
        //检索查看结果
        FindIterable<Document> findIterable=collection.find();
        MongoCursor<Document> mongoCursor=findIterable.iterator();
        while(mongoCursor.hasNext()) {
        	System.out.println(mongoCursor.next());
        }
	}

}
