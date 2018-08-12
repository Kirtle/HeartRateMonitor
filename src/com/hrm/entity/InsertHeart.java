package com.hrm.entity;

import java.sql.PreparedStatement;
import java.sql.SQLException;

public class InsertHeart {
	public void doInser(int uno,String heartrate) throws SQLException{
		String sql="insert into hrm(uno,heartrate) values(?,?)";
		DataBaseConnection db =new DataBaseConnection();
        PreparedStatement pstmt=db.getConnection().prepareStatement(sql)	;
        pstmt.setInt(1,uno);
        pstmt.setString(2,heartrate);
        pstmt.execute();
        pstmt.close();//
        db.close();
	}
	

}
