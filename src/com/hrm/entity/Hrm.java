package com.hrm.entity;

import java.util.Date;

public class Hrm {
	private Integer hrmno;
	private Integer uno;
	public Integer getUno() {
		return uno;
	}
	public void setUno(Integer uno) {
		this.uno = uno;
	}
	private Date startTime ;
	private Date endTime;
	private String heartrate;
	public String getHeartrate() {
		return heartrate;
	}
	public Integer getHrmno() {
		return hrmno;
	}
	public void setHrmno(Integer hrmno) {
		this.hrmno = hrmno;
	}
	public Date getStartTime() {
		return startTime;
	}
	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	public Date getEndTime() {
		return endTime;
	}
	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	
}
