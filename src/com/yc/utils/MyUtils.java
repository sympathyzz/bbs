package com.yc.utils;

import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class MyUtils {
	
	public static final String REGEX_MOBILE = "^((17[0-9])|(14[0-9])|(13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
	public static final String REGEX_EMAIL = "^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$";
	
	    //获得随机数
		public static  String getCode() {
			Random r = new Random();
			int a  = r.nextInt(9)+1;
			int b = r.nextInt(9)+1;
			int c = r.nextInt(9)+1;
			int d = r.nextInt(9)+1;
			return Integer.toString(a*1000+b*100+c*10*d).trim();
		}
		
		//验证手机号
		public static boolean isPhone(String phone) {
			return Pattern.matches(REGEX_MOBILE, phone);
		}
		
		//验证邮箱
		public static boolean isEmail(String email) {
			return Pattern.matches(REGEX_EMAIL, email);
	    }
		
		//经验值获取方式 发贴+5  被点赞+1 回复+1
		//根据经验值计算等级
		public static int getLevel(int exp) {
			int level = 0;
			if(exp<5) {
				level = 1;
			}else if(exp<20) {
				level = 2;
			}else if(exp<50) {
				level = 3;
			}else if(exp<100) {
				level = 4;
			}else if(exp<200) {
				level = 5;
			}else if(exp<500) {
				level = 6;
			}else if(exp<1000) {
				level = 7;
			}else{
				level = 8;
			}
			return level;
		}
		
		public static int getLimit(int exp) {
			if(exp<5) {
				return 5;
			}else if(exp<20) {
				return 20;
			}else if(exp<50) {
				return 50;
			}else if(exp<100) {
				return 100;
			}else if(exp<200) {
				return 200;
			}else if(exp<500) {
				return 500;
			}else if(exp<1000) {
				return 1000;
			}else{
				return 10000;
			}
		}
		
		
}
