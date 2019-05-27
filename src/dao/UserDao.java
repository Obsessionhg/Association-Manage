package dao;

import entity.User;

import java.util.List;

public interface UserDao {
	public int addUser(User u);
	public int deleteUser(String uname);
	public int update(User u);
	public User queryUserByName(String name);
	public User queryUserByUid(String uid);
	public String queryUserNameByUid(String uid);
	public User login(User u);
	public List<User> queryAllUser();
	public List<User> queryExist(String uid);
	public String MD5(String paswd);
}
