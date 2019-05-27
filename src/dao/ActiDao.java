package dao;

import java.util.List;
import entity.Activity;

/**
 * Created by asus on 2017/7/12.
 */
public interface ActiDao {
    public int addActi(Activity Acti);
    public int deleteActi(int Act_id);
    public int update(Activity Acti);
    //public User queryUserByName(String name);
    //public User login(User u);
    public List<Activity>  queryAllActi();
    public List<Activity>  queryActiByOrg(int org_id);
}
