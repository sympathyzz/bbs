package com.yc.biz.impl;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletException;

import org.apache.commons.mail.DefaultAuthenticator;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;

import com.aliyuncs.CommonRequest;
import com.aliyuncs.CommonResponse;
import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.exceptions.ClientException;
import com.aliyuncs.exceptions.ServerException;
import com.aliyuncs.http.MethodType;
import com.aliyuncs.profile.DefaultProfile;
import com.yc.bean.Report;
import com.yc.bean.Tapu;
import com.yc.bean.User;
import com.yc.dao.BoardDao;
import com.yc.dao.UserDao;
import com.yc.utils.DBUtil;
import com.yc.utils.Encrypt;
import com.yc.utils.MyUtils;

public class UserImpl {
	private static BoardDao bd = new BoardDao();
	private static UserDao ud = new UserDao();

	// 用户登录的方法
	public User login(User user, String code1, String code2) throws BizException {
		User NewUser = new User();
		NewUser = bd.login(user);

		if (user.getUname() == null || user.getUpass() == null) {
			throw new BizException("用户名或密码不能为空");
		} else if (!code1.equals(code2)) {
			throw new BizException("验证码错误");
		}
		if (NewUser == null) {
			throw new BizException("用户名或密码错误");
		}

		return NewUser;
	}

	// 注册的方法
	public static void reg(User user, String pwd) throws BizException {
		if (user.getUname().equals("") || user.getUpass().equals("") || pwd.equals("")) {
			throw new BizException("注册信息不能为空");
		}
		if (!user.getUpass().equals(pwd)) {
			throw new BizException("两次输入密码不一致");
		}

		String result = bd.reg(user);

		if (result.equals("exist")) {
			throw new BizException("用户名已存在");
		} else if (result.equals("no")) {
			throw new BizException("注册失败");
		}

	}

	// 获得用户信息
	public User getUser(int uid) {
		User user = new User();
		Map<String, Object> map = bd.getUser0(uid);
		int gender = (int) map.get("gender");
		String head = (String) map.get("head");

		String uname = (String) map.get("uname");
		user.setGender(gender);
		user.setHead(head);

		user.setUname(uname);
		user.setUserid(uid);
		return user;
	}

	public boolean isUname(String name) {

		return bd.checkUser(name);
	}

	public int tapu(int uid, int day) throws BizException {
		if (ud.getTapu(uid) != null) {
			throw new BizException("用户目前禁言状态未取消，无需重复禁言");
		}
		Timestamp tapuTime = new Timestamp(System.currentTimeMillis());
		Long time = System.currentTimeMillis() + day * 86400000L;
		Timestamp conTime = new Timestamp(time);
		return ud.tapu(uid, tapuTime, conTime);

	}

	public Map<String, Object> getTapu(int uid) {
		return ud.getTapu(uid);
	}

	public int removeTapu(int uid) {
		return ud.remove(uid);

	}

	public int report(Report report) {
		return ud.report(report);

	}

	public int follow(int fansid, int uid) {
		return ud.follow(fansid, uid);

	}

	public int cencel(int fansid, int uid) {
		// TODO Auto-generated method stub
		return ud.cencel(fansid, uid);
	}

	public List<Map<String, Object>> getFollow(int uid) {
		return ud.getFollow(uid);

	}

	public List<Map<String, Object>> beFollow(int uid) {
		return ud.beFollow(uid);

	}

	public int changePerson(int uid, String person) {
		return ud.changePerson(uid, person);
	}

	public Map<String, Object> isFollow(int fansid, int uid) {
		return ud.isFollow(fansid, uid);

	}

	public int changeHead(String path, int uid) {
		return ud.changeHead(path, uid);
	}

	/**
	 * 发送验证码给指向用户邮箱
	 * 
	 * @param u
	 * @param code
	 */
	public String sendEmail(String u, String code) {
		try {
			HtmlEmail email = new HtmlEmail();// 创建电子邮件对象
			email.setDebug(true);
			email.setHostName("SMTP.qq.com");// 设置发送电子邮件使用的服务器主机名
			email.setSmtpPort(587);// 设置发送电子邮件使用的邮件服务器的TCP端口地址
			email.setAuthenticator(new DefaultAuthenticator("1054735193", "gfyzceghmsftbeih"));// 邮件服务器身份验证
			email.setFrom("1054735193@qq.com");// 设置发信人邮箱

			email.setSubject("帐号安全【bbs科技论坛】");// 设置邮件主题
			// email.setMsg("this is a test mali with attch");//设置邮件文本内容
			String str = "你的帐号修改了密码，如非本人操作，请及时联系客服";
			email.setContent(new String(str.getBytes(),"utf-8"), "text/html");

			email.addTo(u);// 设置收件人

			// EmailAttachment attach =new EmailAttachment();//附件对象
			// attach.setPath("C:/temp/wenzhi.doc");//附件文件在系统中的路径
			// attach.setDescription(EmailAttachment.ATTACHMENT);
			// email.attach(attach);//添加附件
			email.send();// 发送邮件
		} catch (EmailException e) {
			e.printStackTrace();
			code = "-1";
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return code;
	}



	/**
	 * 发送手机验证码
	 */

	public String sendPhoneCode(String phoneNumber, String c) {
		DefaultProfile profile = DefaultProfile.getProfile("cn-hangzhou", "LTAIN8rgz7YaooVv",
				"5RRHHDkU5qsjTS3c14Pps26nR0pLco");
		IAcsClient client = new DefaultAcsClient(profile);

		CommonRequest request = new CommonRequest();
		// request.setProtocol(ProtocolType.HTTPS);
		request.setMethod(MethodType.POST);
		request.setDomain("dysmsapi.aliyuncs.com");
		request.setVersion("2017-05-25");
		request.setAction("SendSms");
		request.putQueryParameter("RegionId", "cn-hangzhou");
		request.putQueryParameter("PhoneNumbers", phoneNumber);
		request.putQueryParameter("SignName", "bbs科技论坛");
		request.putQueryParameter("TemplateCode", "SMS_160577893");
		String code = "code";

		request.putQueryParameter("TemplateParam", "{" + code + ":" + c + "}");
		try {
			CommonResponse response = client.getCommonResponse(request);
			System.out.println(response.getData());
		} catch (ServerException e) {
			c = "-1";
		} catch (ClientException e) {
			c = "-1";
		}
		return c;
	}
	
	/**
	 * 单点登陆判断
	 * @param u
	 * @param map1
	 * @param map2
	 * @return
	 */
	
	public String checkSingleService(User u, Map<Integer, UUID> map1, Map<Integer, UUID> map2) {
    	if(u!=null) {
    		UUID uuid1 = map1.get(u.getUid());
        	UUID uuid2 = map2.get(u.getUid());
        	// 判断session中的uuid和服务器中的uuid是否相同，相同则正常，不相同则说明其它同名用户登陆后更改了服务器中的uuid
        	if(uuid1.equals(uuid2)) {
        		return "0";
        		
        	}else {
        		return "-1";
        	}
        	
    	}else {
    		return  "1";
    	}
		
	}

	public User login(User user) throws BizException {
		User NewUser = new User();
		NewUser = bd.login(user);
		return NewUser;
	}

	public boolean isLog(String name, String psw) {
		return ud.isLog(name,psw);
	}

	public boolean changePass(String name, String password) {
		return ud.changePass(name,password);
	}
	
	
	//新注册方法
	public void reg(String uname, String psw1, String psw2, String phone, String email, String person) throws BizException {
		if(!psw1.equals(psw2)) {
			throw new BizException("两次密码不一致");
		}else if(!MyUtils.isPhone(phone)){
			System.out.println(phone);
			throw new BizException("手机号码格式错误");
		}else if(!MyUtils.isEmail(email)) {
			throw new BizException("邮箱格式错误");
		}else {
			
			String head = "default.png";
			Timestamp time = new Timestamp(System.currentTimeMillis());
			String gender = "2";
			int type = 0;
			int exp = 0;
			int reg = ud.reg(uname,psw1,head,time,gender,person,type,email,exp,phone);
			if(reg<=0) {
				throw new BizException("注册失败");
			}
		}
	}
	/**
	 * 增加经验值
	 * @param userid
	 * @param i
	 */
	public void growExp(int userid, int i) {
		ud.exp(userid,i);
	}
}
