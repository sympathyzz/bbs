package com.yc.utils;
import org.apache.commons.mail.DefaultAuthenticator;

import org.apache.commons.mail.Email;
import org.apache.commons.mail.EmailAttachment;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;
 
public class TestSendEmail {
    public static void test() throws EmailException{
    	try{
    	HtmlEmail email=new HtmlEmail();//创建电子邮件对象
    	email.setDebug(true);
    	email.setHostName("SMTP.qq.com");//设置发送电子邮件使用的服务器主机名
    	email.setSmtpPort(587);//设置发送电子邮件使用的邮件服务器的TCP端口地址
    	email.setAuthenticator(new DefaultAuthenticator("1054735193", "gfyzceghmsftbeih"));//邮件服务器身份验证
    	email.setFrom("1054735193@qq.com");//设置发信人邮箱
    	
    	email.setSubject("666666");//设置邮件主题
        email.setMsg("this is a test mali with attch");//设置邮件文本内容
    	email.setMsg("this is mail with test1");
    	email.addTo("2794314490@qq.com");//设置收件人
    	
    	//EmailAttachment attach =new EmailAttachment();//附件对象
    	//attach.setPath("C:/temp/wenzhi.doc");//附件文件在系统中的路径
    	//attach.setDescription(EmailAttachment.ATTACHMENT);
    	//email.attach(attach);//添加附件
    	email.send();//发送邮件
    	}catch(EmailException e){
    		e.printStackTrace();
    	}
    }
}
