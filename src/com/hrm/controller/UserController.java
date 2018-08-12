package com.hrm.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.hrm.entity.Hrm;
import com.hrm.entity.Server;
import com.hrm.entity.User;
import com.hrm.mapper.UserMapper;

@Controller
@RequestMapping("/user")
public class UserController {
	private UserMapper userMapper;
	private Server server;
	@Autowired
	public void setUserMapper(UserMapper userMapper){
		this.userMapper = userMapper;
	}
	
	@ModelAttribute("user")
	public void setUser(User user){
		if(user==null){
			user = new User();
		}
	}
	
	@RequestMapping("/register.do")
	@ResponseBody
	public void register(HttpServletRequest request,HttpServletResponse response){
		try {
			String uname =request.getParameter("uname"); 
			String upwd =request.getParameter("upwd");
			String uphone =request.getParameter("uphone");
			User user = userMapper.findByUname(uname);
//			Map<String, Object> map = new HashMap<String, Object>();
//			System.out.println(user);
			if(user==null){
				userMapper.register(uname, upwd, uphone);
			}else{
				response.setStatus(500);
//				HttpSession session= request.getSession();
//				session.setAttribute("flag", 1);
			}
		} catch (Exception e) {	
			e.printStackTrace();
		}
	}

	@RequestMapping("/login.do")
	@ResponseBody
	public void doLogin(@RequestParam("uname") String name,@RequestParam("upwd") String upwd,HttpServletRequest request,HttpServletResponse response,ModelMap map1){
		HttpSession session1 = request.getSession(false);
		User user1=(User) session1.getAttribute("user");
		Map<String, Object> map = new HashMap<String, Object>();
		if(user1!=null){
			map.put("message", "已经登录");
		}else{		
			User user=userMapper.login(name,upwd);
			if(user==null){
				map.put("message", "用户不存在");
			}else{
				HttpSession session = request.getSession(false);
				session.setAttribute("user",user);
				map.put("message", "登录成功");
				List<Hrm> hrms = userMapper.findRates(user.getUno());
				session.setAttribute("hrms", hrms);
			}
		}
		response.setCharacterEncoding("UTF_8");//设置Response的编码方式为UTF-8
        response.setHeader("Content-type","text/html;charset=UTF-8");//向浏览器发送一个响应头，设置浏览器的解码方式为UTF-8
        try {
            response.getWriter().write(JSON.toJSONString(map));
            response.getWriter().flush();
            response.getWriter().close();
        } catch (IOException e) {
            e.printStackTrace();
        }
	}
	
	@RequestMapping("/logout.do")
	@ResponseBody
	public void logout(HttpServletRequest request){
		
		try {
			HttpSession session = request.getSession(false);
			System.out.println(session.getAttribute("user"));
			
			if (null != session) {
				session.removeAttribute("user");
				session.invalidate();
			}
			System.out.println("ok");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		}
	
	@RequestMapping("/monitor.saveRate")
	@ResponseBody
	public void saveRate(HttpServletResponse response,HttpServletRequest request) throws IOException, InterruptedException{
		HttpSession session = request.getSession();
		User user=(User) session.getAttribute("user");
		if(server==null){
		server=new Server();
		}
//		Set<String> set=server.set;
//		Map<String, Object> map = new HashMap<String, Object>();
		if(user==null){
			response.setStatus(500);
		}else{
			System.out.println("=====保存"+user.getUname()+"的心率值=====");
			server.monitor(user.getUno());
//			response.setCharacterEncoding("UTF_8");//设置Response的编码方式为UTF-8
//	        response.setHeader("Content-type","text/html;charset=UTF-8");
//	        userMapper.saveRate(tempRate,user.getUno());
//			System.out.println("接受的心率字符串"+tempRate);
//			map.put("monitorRate", tempRate);
		}
//    try {
//        response.getWriter().write(JSON.toJSONString(map));
//        response.getWriter().flush();
//        response.getWriter().close();
//    } catch (IOException e) {
//        e.printStackTrace();
//    }finally{
////    	server.close();
//    }
	}
	
	/**
	 * 获取数据库保存的心率值
	 * @param uno
	 * @param request
	 * @param response
	 */
	@RequestMapping("/monitor.getRate")
	@ResponseBody
	public void findRate(@Param("Uno") Integer uno,HttpServletRequest request,
		HttpServletResponse response){
		HttpSession session = request.getSession(false);
		User user=(User) session.getAttribute("user");
		System.out.println("user.getUname=="+user.getUname());
		if(user!=null){
			Hrm h=userMapper.findRate(user.getUno());
			System.out.println("getHeartrate=="+h.getHeartrate());
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("userRate", h.getHeartrate());
		try {
			response.setCharacterEncoding("UTF_8");//设置Response的编码方式为UTF-8
	        response.setHeader("Content-type","text/html;charset=UTF-8");
			response.getWriter().write(JSON.toJSONString(map));
			response.getWriter().flush();
			response.getWriter().close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		}
//		else{
//			response.setStatus(500);
//		}
	}
	
	@RequestMapping("/monitor.close")
	@ResponseBody
	public void closeServer(){
		server.close();
	}
	
	@RequestMapping("/findRate")
	@ResponseBody
	public void findRates(ModelMap map,Integer id,HttpServletRequest request){
		
		List<Hrm> hrms = userMapper.findRates(id);
		
		request.getSession().removeAttribute("hrms");
		request.getSession().invalidate();
		request.getSession().setAttribute("hrms", hrms);
	}
}

