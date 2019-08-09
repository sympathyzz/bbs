package com.yc.websocket;
import java.io.IOException;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;

import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import com.alibaba.fastjson.JSON;
import com.yc.bean.Message;
import com.yc.biz.impl.SocketBiz;  
  
@ServerEndpoint("/websocket/{forname}")  
public class WebSocket {     
    private static Map<String,Session> Allsession = new HashMap<String, Session>();
    private String id;
    @OnOpen  
    public void onOpen(@PathParam(value="forname") String uid,Session session) throws IOException {  
    	id=uid;
    	Allsession.put(uid, session);
    }  
  
    @OnClose  
    public void onClose() throws IOException {  
    	Allsession.remove(id);
    }  
  
    @OnMessage  
    public void onMessage(Session  session,String getMessage) throws IOException { 
    	Message message = new Message();
    	Map<String,Object> map = JSON.parseObject(getMessage);
    	int forname = Integer.parseInt(map.get("forname").toString());
    	int toname = Integer.parseInt(map.get("toname").toString());
    	message.setForname(forname);
    	message.setToName(toname);
    	message.setMessgeText(map.get("msg").toString());
    	Timestamp time = new Timestamp(System.currentTimeMillis());
    	message.setMessageDate(time);
    	sendMessageTo(message);
    }  
  
    
  
    public void sendMessageTo(Message message) throws IOException {  
         for(Entry<String, Session> entry :Allsession.entrySet()) {
        	 int id = Integer.parseInt(entry.getKey());
        	 if(id == message.getToName()) {
        		 String json = JSON.toJSONString(message);
        		 entry.getValue().getBasicRemote().sendText(json);
        		 return;
        	 }
         }
         SocketBiz sb = new SocketBiz();
         sb.setChat(message);
    }   
}  