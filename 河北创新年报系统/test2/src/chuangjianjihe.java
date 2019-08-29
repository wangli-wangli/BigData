
import java.util.ArrayList;  
import com.mongodb.MongoClient;  
import com.mongodb.MongoCredential;   
import com.mongodb.ServerAddress;  
import com.mongodb.client.MongoDatabase;   
public class chuangjianjihe
{     public static void main(String[] args)
{   
	try
        {     
		ServerAddress serverAddress = new ServerAddress("localhost",27017); 
		ArrayList<ServerAddress> addrs = new ArrayList<ServerAddress>();
	    addrs.add(serverAddress);   
	    MongoCredential credential =MongoCredential.createCredential("root", "admin",
				"wangli".toCharArray());  
	    ArrayList<MongoCredential> credentials = new ArrayList<MongoCredential>();  
	    credentials.add(credential);   
	    MongoClient mongoClient = new MongoClient(addrs,credentials);  
	    MongoDatabase mongoDatabase = mongoClient.getDatabase("admin");  
	    System.out.println("Connect to database successfully");  
	    mongoDatabase.createCollection("platform");  
	    System.out.println("Collection mycol was created successfully"); 
	    
        } 
	catch (Exception e) 
	{      
		System.err.println( e.getClass().getName() + ": " + e.getMessage() );  
		}         
	}   
}  
