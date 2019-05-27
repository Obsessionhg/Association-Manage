package dao;

import entity.Community;

import java.util.List;

/**
 * Created by asus on 2017/7/14.
 */
public interface CommuDao {
    public List<Community> queryAllCommu();
    public List<Community> queryCommuBystat(int stat);
    public int addCommu(Community comm);
    public int deleteCommu(int org_id);
    public int updateStat(int org_id,int stat);
    public Community queryCommuByOrg(int org_id);
    public List<Community> queryOrgBykey(String keywd);
}
