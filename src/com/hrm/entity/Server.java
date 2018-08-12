package com.hrm.entity;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.ServerSocket;
import java.net.Socket;
import java.sql.SQLException;
import java.util.HashSet;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hrm.mapper.UserMapper;

public class Server{
	
//	set=new HashSet<String>();
	public static String PORT;
	public  String RateData="";
	static ServerSocket ss;
	static Socket s;
	private InsertHeart ih=new InsertHeart();
	//public static void main(String[] args) throws IOException {
	public void monitor(final Integer uno)throws IOException{
//		if(ss==null){		
		 ss = new ServerSocket(8899);
//		}
			System.out.println("服务器等待连接！");
			s = ss.accept();
			System.out.println(s);
			if(s!=null){
				System.out.println("客户端"+s.getRemoteSocketAddress()+"已连接");
				new Thread(new Runnable() {
					public void run() {
						try {
							System.out.println("接收线程已启动");
							BufferedReader br = new BufferedReader(
									new InputStreamReader(
											s.getInputStream()));
							while(true){
								RateData=br.readLine();
								System.out.println("接收了一个数据");
								System.out.println("数据："+RateData);
//								System.out.println("userMapper:---"+userMapper);
								if(RateData!=null&&!RateData.equals("")){
//									userMapper.saveRate(RateData, uno);
									try {
//										if(!RateData.equals("end"))
										ih.doInser(uno, RateData);
									} catch (SQLException e) {
										// TODO Auto-generated catch block
										e.printStackTrace();
									}
									System.out.println(RateData);
									if(RateData.equals("end")){ 
//										break;
									}
								}
							}
						} catch (IOException e) {
							e.printStackTrace();
						}
					}
				}).start();
			}
//			return RateData;
	}
	
	public static void main(String[] args) throws IOException {
		new Server().monitor(1);
	}
	public void close(){
		
			try {
				if(ss!=null){
					ss.close();
				}
				if(s!=null){
					s.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
	}
}