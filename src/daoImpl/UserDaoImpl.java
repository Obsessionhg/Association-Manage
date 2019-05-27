package daoImpl;

import comm.BaseDao;
import dao.UserDao;
import entity.Org_user;
import entity.User;

import java.security.MessageDigest;
import java.util.List;

public class UserDaoImpl extends BaseDao implements UserDao {



	public User login(User u){
		List<User> list=executeQuery("select * from user where uid ="+u.getUid()+" and upwd='"+u.getUpwd()+"'",null,User.class);
		if(list.size()>0)
			return list.get(0);
		return null;
	}


	public List<User> queryAllUser(){
		return executeQuery("select * from user",null,User.class);
	}

	/*
	 List<User> list=dao.queryAllUser();
         user = list.get(0);
        System.out.println(user.getUid()+user.getUname()+user.getUpwd()+user.getSex()+user.getBirth());
	*/


	public int addUser(User u){
		Object [] obs={u.getUid(),u.getUname(),u.getUpwd(),u.getSex(),u.getBirth()};
		return executeUpdate("insert into user values(?,?,?,?,?)", obs );
	}
	public int deleteUser(String uid){
		return executeUpdate("delete from user where uid ='"+uid+"'",null);
	}
	public int update(User u){
		Object [] obs={u.getUname(),u.getUpwd(),u.getSex(),u.getBirth(),u.getUid()};
		return executeUpdate("update user set  uname=?,upwd=?,sex=?,birth=? where uid=?",obs);
	}//
	public User queryUserByName(String name){
		List<User> list =executeQuery("select * from user where uname ='"+name+"'",null,User.class);
		if(list.size()>0)
			return list.get(0);
		return null;
	}
	public User queryUserByUid(String uid){
		List<User> list =executeQuery("select * from user where uid ='"+uid+"'",null,User.class);
		if(list.size()>0)
			return list.get(0);
		return null;
	}
	public String queryUserNameByUid(String uid){
		List<User> list =executeQuery("select * from user where uid ='"+uid+"'",null,User.class);
		if(list.size()>0)
			return list.get(0).getUname();
		return null;
	}
	public List<User> queryExist(String uid){
		return executeQuery("select * from user where uid ='"+uid+"'",null,User.class);
	}

	public String MD5(String paswd){
		char hexDigits[]={'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};
		try {
			byte[] btInput = paswd.getBytes();
			// 获得MD5摘要算法的 MessageDigest 对象
			MessageDigest mdInst = MessageDigest.getInstance("MD5");
			// 使用指定的字节更新摘要
			mdInst.update(btInput);
			// 获得密文
			byte[] md = mdInst.digest();
			// 把密文转换成十六进制的字符串形式
			int j = md.length;
			char str[] = new char[j * 2];
			int k = 0;
			for (int i = 0; i < j; i++) {
				byte byte0 = md[i];
				str[k++] = hexDigits[byte0 >>> 4 & 0xf];
				str[k++] = hexDigits[byte0 & 0xf];
			}
			char str1[] = new char[j];
			for(int i=0;i<j;i++)
			{
				str1[i]=str[i];
			}
			return new String(str1);
		} catch (Exception e) {
			e.printStackTrace();
			return  null;
		}
	}

}
