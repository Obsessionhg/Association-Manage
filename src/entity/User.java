package entity;

import comm.BaseDao;


import java.sql.Timestamp;
import java.util.List;

public class User {

	private String uid;
	private String uname;
	private String upwd;
	private String sex;
	private String birth;


	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public String getUname() {
		return uname;
	}
	public void setUname(String uname) {
		this.uname = uname;
	}
	public String getUpwd() {
		return upwd;
	}
	public void setUpwd(String upwd) {
		this.upwd = upwd;
	}

	public List<User_Message> getMesList(int ReqNum,boolean needContent)  {
		if (ReqNum < 0) {
			System.out.println("ReqNum Error");
			return null;
		}
		List<User_Message> UMlist;
		BaseDao bd=new BaseDao();
		String sql="select from_uid,title,mes_date from user_message where to_uid='"+uid+"' "+" order by mes_date desc";

		UMlist=bd.executeQuery(sql,null,User_Message.class,2,ReqNum,needContent);
		bd=null;
		return UMlist;
	}

	public User_Message getMesFromKey(String from_uid,String mes_date)  {
		User_Message um;
		BaseDao db=new BaseDao();
		String sql = "select from_uid,title,message,mes_date from user_message where to_uid='"+uid+"' and from_uid='"+from_uid+"' and mes_date='"+mes_date+"'";
		um=(User_Message)db.executeQuery(sql,null,User_Message.class).get(0);
		db=null;
		return um;
	}


	public int setMes(String to_uid,String title,String message){
		Object [] obs={to_uid,uid,title,message,new Timestamp(System.currentTimeMillis())};
		String sql ="insert user_message (to_uid,from_uid,title,message,mes_date) values(?,?,?,?,?)";
		BaseDao bd=new BaseDao();
		int i=bd.executeUpdate(sql,obs);
		return i;
	}
}
