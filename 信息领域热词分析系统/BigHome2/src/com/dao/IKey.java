package com.dao;

import java.util.List;

import com.model.Key;

public interface IKey {
	public List<String> loadKeyType();//查询种类
	public List<String> loadKeyContent();//查询热词top几
	public List<Key> loadKey();//查询热词top几
	public List<Key> loadKey(String type);
	public String loadKeyCon(String content);
	//public Key loadUser(String username,String password);
	//public List<Key> loadUser(String content);//查询

}
