package com.yc.web.servlets;

import java.io.BufferedReader;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.yc.biz.impl.BizException;
import com.yc.biz.impl.ManageBiz;
import com.yc.biz.impl.SenstivewordBiz;
import com.yc.biz.impl.UserImpl;
import com.yc.filter.WordFilter;

@WebServlet("/manage")
public class ManageServlet extends BaseServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private ManageBiz mb = new ManageBiz();
	private SenstivewordBiz sw = new SenstivewordBiz();
	
	
	public void manageAddAd(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		String adname = req.getParameter("adname");
		String img = req.getParameter("img");
		String href = req.getParameter("href");
		String acount = req.getParameter("acount");
		int acount1=Integer.parseInt(acount);
		int a=mb.addAd(adname,img,href,acount1);
		if(a!=0){
			resp.getWriter().write("yes");
		}else{
			resp.getWriter().write("no");
		}
	}
	
	public void manageDelAd(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		String adname = req.getParameter("adname");
		int a=mb.delAd(adname);
		if(a!=0){
			resp.getWriter().write("yes");
		}else{
			resp.getWriter().write("no");
		}
	}
	
	
	
	
	
	/**
	 * 查询所有用户信息
	 * @param req
	 * @param resp
	 */
	public void query(HttpServletRequest req, HttpServletResponse resp) {
		Integer pageNum = Integer.parseInt(req.getParameter("page"));
		Integer pageSize = 10;
		List<Map<String,Object>> list = mb.query(pageNum,pageSize);
		Map<String,Object> map = new HashMap<String, Object>();
		int total = mb.getUserTotal();
		map.put("total", total);
		map.put("rows", list);
		String json = JSON.toJSONString(map);
		
		try {
			resp.getWriter().append(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void manageGetUser(HttpServletRequest req, HttpServletResponse resp) {
		String id = req.getParameter("id");
		try {
			List<Map<String,Object>> list =  mb.getUser(id);
			String json = JSON.toJSONString(list);
			
			
			resp.getWriter().append(json);
		} catch (BizException e) {
			try {
				resp.getWriter().append("-1");
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	public void addManage(HttpServletRequest req, HttpServletResponse resp) {
		String uid = req.getParameter("uid");
		Integer flag = mb.Addmanage(uid);
		try {
			resp.getWriter().append(flag.toString());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void cencelManage(HttpServletRequest req, HttpServletResponse resp) {
		String uid = req.getParameter("uid");
		Integer flag = mb.Cenclemanage(uid);
		try {
			resp.getWriter().append(flag.toString());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void getReport(HttpServletRequest req, HttpServletResponse resp) {
		Integer pageNum = Integer.parseInt(req.getParameter("page"));
		Integer pageSize = 10;
		Map<String,Object> map = new HashMap<String, Object>();
		int total = mb.getReportTotal();
		List<Map<String,Object>> list = mb.getReport(pageNum,pageSize);
		map.put("total", total);
		map.put("rows", list);
		if(list != null) {
			String json = JSON.toJSONString(map);
			try {
				resp.getWriter().append(json);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	public void getTapu(HttpServletRequest req, HttpServletResponse resp) {
		Integer pageNum = Integer.parseInt(req.getParameter("page"));
		Integer pageSize = 10;
		Map<String,Object> map = new HashMap<String, Object>();
		List<Map<String,Object>> list = mb.getTapu(pageNum,pageSize);
		int total = mb.getTapuTotal();
		map.put("total", total);
		map.put("rows", list);
		if(list != null) {
			String json = JSON.toJSONString(map);
			try {
				resp.getWriter().append(json);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	public void delReport(HttpServletRequest req, HttpServletResponse resp) {
		int reportid = Integer.parseInt(req.getParameter("reportid"));
		int flag = mb.delReport(reportid);
		try {
			if(flag > 0) {
				resp.getWriter().append("1");
			}else {
				resp.getWriter().append("0");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void manageTapu(HttpServletRequest req, HttpServletResponse resp) {
		String id = req.getParameter("id");
		try {
			List<Map<String,Object>> list =  mb.manageTapu(id);
			String json = JSON.toJSONString(list);
			resp.getWriter().append(json);
		} catch (BizException e) {
			try {
				resp.getWriter().append("-1");
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void cencelTapu(HttpServletRequest req, HttpServletResponse resp) {
		int uid = Integer.parseInt(req.getParameter("uid"));
		int flag = mb.cencelTapu(uid);
		try {
			if(flag > 0) {
				resp.getWriter().append("1");
			}else {
				resp.getWriter().append("0");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void addFather(HttpServletRequest req, HttpServletResponse resp) {
		String content = req.getParameter("content");
		Integer flag = mb.AddFather(content);
		try {
			resp.getWriter().append(flag.toString());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void getFather(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		List<Map<String,Object>> list = mb.getFather();
		if(list != null && list.size() > 0) {
			String json = JSON.toJSONString(list);
			resp.getWriter().append(json);
		}else {
			resp.getWriter().append("0");
		}
	}
	
	public void getChild(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		int index = Integer.parseInt(req.getParameter("index"));
		List<Map<String,Object>> list = mb.getChild(index);
		
		if(list != null && list.size() > 0) {
			String json = JSON.toJSONString(list);
			resp.getWriter().append(json);
		}else {
			resp.getWriter().append("0");
		}
	}
	
	public void addChild(HttpServletRequest req, HttpServletResponse resp) {
		String content = req.getParameter("content");
		int index = Integer.parseInt(req.getParameter("index"));
		Integer flag = mb.addChild(index,content);
		try {
			resp.getWriter().append(flag.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void addSenstive(HttpServletRequest req, HttpServletResponse resp) {
		String content = req.getParameter("content");
		int index = sw.addSenstive(content);
		try {
			if(index > 0) {
				resp.getWriter().append("1");
			}else {
				resp.getWriter().append("0");
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void delSenstive(HttpServletRequest req, HttpServletResponse resp) {
		String content = req.getParameter("content");
		int index = sw.delSenstive(content);
		try {
			if(index > 0) {
				resp.getWriter().append("1");
			}else {
				resp.getWriter().append("0");
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void delFather(HttpServletRequest req, HttpServletResponse resp) {
		int index = Integer.parseInt(req.getParameter("id"));
		int flag = mb.delFather(index);
		try {
			if(flag > 0) {
				resp.getWriter().append("1");
			}else {
				resp.getWriter().append("0");
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void delChild(HttpServletRequest req, HttpServletResponse resp) {
		int boardid = Integer.parseInt(req.getParameter("boardid"));
		int flag = mb.delChild(boardid);
		try {
			if(flag > 0) {
				resp.getWriter().append("1");
			}else {
				resp.getWriter().append("0");
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void tapu(HttpServletRequest req, HttpServletResponse resp) {
		int uid = Integer.parseInt(req.getParameter("uid"));
		int day = Integer.parseInt(req.getParameter("day"));
		int reportid = Integer.parseInt(req.getParameter("reportid"));
		
		int i = 0;
		
			try {
				i = mb.tapu(uid,day);
			} catch (BizException e1) {
				try {
					mb.delReport(reportid);
					resp.getWriter().append("-1");
					return;
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		
		
		try {
			if(i > 0) {
				mb.delReport(reportid);
				resp.getWriter().append("1");
			}else {
				resp.getWriter().append("0");
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
	}
}
