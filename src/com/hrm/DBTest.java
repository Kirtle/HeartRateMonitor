package com.hrm;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBTest {
	
//	public  DBTest(){};
//	public  DBTest(String a){};
	
	//ip+port
//	static String URL ="jdbc:mysql://119.29.36.221:3306/test";//服务器数据库
//	static String URL ="jdbc:mysql://592ba7b93d216.gz.cdb.myqcloud.com:17534/e_market";//腾讯云数据库
	static String URL="jdbc:mysql://localhost:3306/HeartRateMonitor?characterEncoding=UTF-8";
	//uid
//	static String userName="cdb_outerroot";
	static String userName="root";
	//pwd
//	static String userPassword="gmgmgm520@@";
//	static String userPassword="gmgmgmmysql";
	static String userPassword="";
	//mysql SQL;
	static String SQL="select * from user";	
	//mysql connection 
	static Connection conn =null;
	//prestatement
	static PreparedStatement pst = null;
	//resultSet 
	static ResultSet rs = null;
	
	static {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("驱动加载成功！");
		} catch (ClassNotFoundException e) {
			System.out.println("没有找到驱动！");
			e.printStackTrace();
		}
	}
	public static void conectDB(String URL,String userName,String userPassword){
		try {
			conn = DriverManager.getConnection(URL, userName, userPassword);
			System.out.println("已连接上"+URL+"：\n数据库"+conn);
		} catch (SQLException e) {
			System.out.println("获取链接失败");
			e.printStackTrace();
		}
	}
	public static void querryByid(String SQL){
		try {
			pst = conn.prepareStatement(SQL);
			System.out.println("执行查询语");
			rs = pst.executeQuery();
			while(rs.next()){
				System.out.println("id\t"+"uname\t"+"upwd\t\n"+
						rs.getInt(1)+"\t"+rs.getString(2)+"\t"+rs.getString(3));
			}
		} catch (SQLException e) {
			System.out.println("查询失败");
			e.printStackTrace();
		}
	}
	public static void close(Connection conn,PreparedStatement pst, ResultSet rs){
		if(rs!=null){
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}finally{
				if(pst!=null){
					try {
						pst.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}finally{
						if(conn!=null){
							try {
								conn.close();
								System.out.println("数据库链接已关闭，资源已释放");
							} catch (SQLException e) {
								e.printStackTrace();
							}finally{
								conn=null;
								pst= null;
								rs = null;
							}
						}
					}
				}
			}
		}
	}
	
	public static void main(String[] args) {
		DBTest dbUtil = new DBTest();
		dbUtil.conectDB(URL, userName, userPassword);
		dbUtil.querryByid(SQL);
		dbUtil.close(conn, pst, rs);
	}
}
