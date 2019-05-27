package dao;

import entity.Recruitment;

import java.util.List;

/**
 * Created by asus on 2017/7/13.
 */
public interface RecDao {
    public int addRec(Recruitment rec);
    public int deleteRec(int rec_id);
    public int update(Recruitment rec);
    public int updateRecNeed(int rec_id,String rec_need);
    public int StopRec(int rec_id);
    //public User login(User u);
    public List<Recruitment> queryAllByOrg(int org_id);
    public String RecNeed(int rec_id);
}
