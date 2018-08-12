package com.hrm.entity;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DataBaseConnection {
    private Connection conn;
	public static final String DBDRIVER="com.mysql.jdbc.Driver";
	public static final String DBUSER="root";
	public static final String DBURL="jdbc:mysql://localhost:3306/HeartRateMonitor?characterEncoding=UTF-8";
	public static final String DBPASSWORD="";
	public DataBaseConnection(){
		try {
			Class.forName(DBDRIVER);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public Connection getConnection() throws SQLException{
		return DriverManager.getConnection(DBURL,DBUSER,DBPASSWORD);
	}
	public void close(){
		if(conn!=null){
			try {
				this.conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			this.conn=null;
		}
	}
	public static void main(String []args) throws SQLException
	{
		System.out.println("conn:"+new DataBaseConnection().getConnection());
	}

}
