package Utils;

import java.sql.Connection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import Bean.*;
import java.text.DecimalFormat;

public class UserDao {

	public UserDao() {
		
	}
	
	public static List<Company> getCompany(String cname) {
		Company company = null;
		List<Company> lists=new ArrayList<Company>();
		try {
			Connection con = DBUtil.getConection();
			String sql = "select * from t_corp where CORP_NAME like '%"+cname+"%'";
			PreparedStatement pre = con.prepareStatement(sql);
			System.out.println("sql:"+sql);
			ResultSet rs = pre.executeQuery();
			
			while(rs.next()) {
				company = new Company();
				company.setCname(rs.getString("CORP_NAME"));
				company.setCtelno(rs.getString("TEL"));
				company.setCaddr(rs.getString("ADDR"));
				company.setCstand(rs.getString("OPER_MAN_NAME"));
				company.setCdate(rs.getString("START_DATE"));
				company.setCmoney(rs.getString("REG_CAPI"));
				company.setCkind(rs.getString("ECON_KIND"));
				company.setCsno(rs.getString("REG_NO"));
				company.setCfield(rs.getString("FARE_SCOPE"));
				company.setClogin(rs.getString("BELONG_ORG"));
				lists.add(company);
			}
			DBUtil.close(rs);
			DBUtil.close(pre);
			DBUtil.close(con);
		} catch (SQLException e) {
		
			e.printStackTrace();
		}finally {
			
			
		}
		
		return lists;
	}
	
	public static List<Gud> getGudList(String cname){
		List<Gud>list = new ArrayList<>();
		try {
			Connection con = DBUtil.getConection();
			String sql = "select ID from t_corp where CORP_NAME = ?";
			PreparedStatement pre = con.prepareStatement(sql);
			pre.setString(1,cname);
			ResultSet rs = pre.executeQuery();
			String ID = null;
			while(rs.next())ID = rs.getString("ID");
			System.out.println(ID);
			String sql2 = "select STOCK_CAPI,STOCK_NAME,STOCK_PERCENT from t_corp_stock where t_corp_stock.ID in (select SUB_ID from t_m_corp_corp_stock    where t_m_corp_corp_stock.ID = ?)";
			pre = con.prepareStatement(sql2);
			pre.setString(1,ID);
			rs = pre.executeQuery();
			while(rs.next()) {
				
				
				Gud gud = new Gud();
				gud.setGname(rs.getString("STOCK_NAME"));
				gud.setGmoney(rs.getDouble("STOCK_CAPI"));
				gud.setGpercent(rs.getString("STOCK_PERCENT"));
				if(gud.getGpercent()==null)gud.setGpercent("100%");
				list.add(gud);
			}
			DBUtil.close(rs);
			DBUtil.close(pre);
			DBUtil.close(con);
		} catch (SQLException e) {
		
			e.printStackTrace();
		}finally {
			
			
		}
		
		//System.out.println(list.size());
		return list;
	}
	
	public static List<Company> getBGud(String cname){
		List<Company>list = new ArrayList<>();
		try {
			Connection con = DBUtil.getConection();
			String sql = "select ID from t_corp_stock where STOCK_NAME = ?";
			PreparedStatement pre = con.prepareStatement(sql);
			pre.setString(1,cname);
			ResultSet rs = pre.executeQuery();
			String ID = null;
			while(rs.next())ID = rs.getString("ID");
			System.out.println(ID);
			String sql2 = "select CORP_NAME from t_corp where ID in (select ID from t_m_corp_corp_stock where SUB_ID ='"+ID+"')";
			//String sql2 = "select ID from d73 where SUB_ID = '78497'";
			System.out.println("sql:"+sql2);
			pre = con.prepareStatement(sql2);
			
			rs = pre.executeQuery();
			while(rs.next()) {
				Company gud = new Company();
				gud.setCname(rs.getString("CORP_NAME"));
				
				list.add(gud);
			}
			DBUtil.close(rs);
			DBUtil.close(pre);
			DBUtil.close(con);
		} catch (SQLException e) {
			
			e.printStackTrace();
		}finally {
			
			
		}
		return list;
	}
	
	public static List<Gud>getY(String cname){
		List<Gud>list = new ArrayList<>();
		try {
			Connection con = DBUtil.getConection();
			String sql = "select ID from t_corp where CORP_NAME = ?";
			PreparedStatement pre = con.prepareStatement(sql);
			pre.setString(1,cname);
			ResultSet rs = pre.executeQuery();
			String ID = null;
			while(rs.next())ID = rs.getString("ID");
			System.out.println(ID);
			String sql2 = "select PERSON_NAME from t_corp_pertains where t_corp_pertains.ORG in (select SUB_ID from t_m_corp_corp_pertains where ID='"+ID+"')";
			//String sql2 = "select SUB_ID from d73 where d73.ID = ?";
			System.out.println("sql:"+sql2);
			pre = con.prepareStatement(sql2);
			rs = pre.executeQuery();
			System.out.println(rs.next());
			while(rs.next()) {	
				Gud gud = new Gud();
			    gud.setGname(rs.getString("PERSON_NAME"));	
			    System.out.println("Dao:"+gud.getGname());
				list.add(gud);
			}
			DBUtil.close(rs);
			DBUtil.close(pre);
			DBUtil.close(con);
		} catch (SQLException e) {
		
			e.printStackTrace();
		}finally {
			
			
		}
		
		System.out.println(list.size());
		return list;
	}
	
	public static List<Company>getChild(String cname){
		List<Company>list = new ArrayList<>();
		try {
			Connection con = DBUtil.getConection();
			String sql = "select ID from t_corp where CORP_NAME = ?";
			PreparedStatement pre = con.prepareStatement(sql);
			pre.setString(1,cname);
			ResultSet rs = pre.executeQuery();
			String ID = null;
			while(rs.next())ID = rs.getString("ID");
			System.out.println(ID);
			String sql2 = "select DIST_NAME from t_corp_dist where ID in (select SUB_ID from t_m_corp_corp_dist where t_m_corp_corp_dist.`﻿ID`='"+ID+"')";
			System.out.println("sql:"+sql2);
			pre = con.prepareStatement(sql2);
			
			rs = pre.executeQuery();
			System.out.println(rs.next());
			while(rs.next()) {
				
				Company gud = new Company();
				gud.setCname(rs.getString("DIST_NAME"));
				System.out.println("Dao:"+gud.getCname());
				list.add(gud);
			}
			DBUtil.close(rs);
			DBUtil.close(pre);
			DBUtil.close(con);
		} catch (SQLException e) {
			
			e.printStackTrace();
		}finally {
			
			
		}
		
		//System.out.println(list.size());
		return list;
	}

	public static void main(String[]args) {
		getGudList("中国林业科学研究院林产化学工业设计所");
	}
	
}
