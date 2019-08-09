package com.yc.web.servlets;

import java.io.IOException;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.mail.internet.MimeMessage;
import javax.print.attribute.TextSyntax;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.mail.DefaultAuthenticator;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;

import com.yc.bean.User;
import com.yc.biz.impl.UserImpl;
import com.yc.utils.MyUtils;
import com.yc.utils.TestSendEmail;

/**
 * Servlet implementation class AjaxServlet
 */
@WebServlet("/ajax.s")
public class CheckUserServlet extends BaseServlet {
	private static final long serialVersionUID = 1L;
       
	UserImpl ul = new UserImpl();//用户业务
	
	//判断用户名是否被注册
    public void check(HttpServletRequest request, HttpServletResponse response) throws IOException {
    	 String name = request.getParameter("uname");
         
    	 if(name==null||name.equals("")) {
    		 response.getWriter().append("-1");
    	 }
    	 else if(ul.isUname(name))
    	    	response.getWriter().append("-1");
    	    else
    	    	response.getWriter().append("0");
    }
    
	//判断旧密码是否正确 
    public void changePass(HttpServletRequest request, HttpServletResponse response) throws IOException {
    	 String name = request.getParameter("name");
    	 String oldpsw = request.getParameter("oldpassword");
    	 String password = request.getParameter("password");
         
    	 if(name==null||name.equals("")||oldpsw==null||oldpsw.equals("")) {
    		 response.getWriter().append("-1");
    	 }
    	 else if(ul.isLog(name,oldpsw)) {
    		 if(ul.changePass(name,password)) {
    			 response.getWriter().append("0");
    		 }else {
    			 response.getWriter().append("1");
    		 }
    	 }
    	 else
    	    response.getWriter().append("-1");
    }
    

    
  //判断用户是否在另一设备登陆
    public void checkU(HttpServletRequest request, HttpServletResponse response) throws IOException {
    	User u = (User) request.getSession().getAttribute("user");
    	
    	Map<Integer,UUID> map1= (Map<Integer, UUID>) request.getSession().getAttribute("usermap");
    	
    	Map<Integer,UUID> map2 = (Map<Integer, UUID>) request.getServletContext().getAttribute("usermap");
    	
    	String statusCode = ul.checkSingleService(u,map1,map2);
    	
    	response.getWriter().print(statusCode.trim());
    	
    }
    
    /**
     	* 发送邮箱
     * @param request
     * @param response
     * @throws IOException
     * @throws EmailException
     */
    public void sendMail(HttpServletRequest request, HttpServletResponse response) throws IOException, EmailException {
    	
    	//验证数字
    	String code = MyUtils.getCode();
    	
    	//验证邮箱
    	String u = request.getParameter("email");

    	//发送
    	code = ul.sendEmail(u,code);//发送失败则把验证码改成-1，前台判断是否发送成功
    	
    	//验证
    	response.getWriter().append(code);
    	
    }
    
    /**
     * 发送手机验证码
     * @param request
     * @param response
     * @throws IOException
     */
    public void sendPhoneCode(HttpServletRequest request, HttpServletResponse response) throws IOException  {
    	
    	//验证数字
    	String c = MyUtils.getCode();
    	
    	//验证手机
    	String u = request.getParameter("phoneNumber");

    	//发送
    	c = ul.sendPhoneCode(u, c);
    	System.out.println(c);
    	//验证
    	response.getWriter().append(c);
    }
    
}
