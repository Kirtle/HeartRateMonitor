package com.hrm.mapper;


import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hrm.annotation.MyBatisRepository;
import com.hrm.entity.Hrm;
import com.hrm.entity.User;
@MyBatisRepository
public interface UserMapper {
	public User login(@Param("uname")String uname,@Param("upwd")String upwd);
	
	public User findByUname(@Param("uname")String uname);
	
	public void register(@Param("uname")String uname,@Param("upwd")String upwd,@Param("uphone")String uphone);
	
	public void saveRate(@Param("heartrate")String rate,@Param("uno")Integer uno);
	
	public Hrm findRate(@Param("uno")Integer uno);
	
	public List<Hrm> findRates(@Param("uno")Integer uno);
}
