package dao;

import entity.Enter;

import java.util.List;

/**
 * Created by asus on 2017/7/13.
 */
public interface EnterDao {
    public int addEnter(Enter enter);
    public int deleteEnter(int rec_id);
    public int deleteEnterAgree(int rec_id,String uid);
    public List<Enter> queryEnterByOrg(int org_id,int rec_id);
    public List<Enter> queryExist(int rec_id,String uid);
    public List<Enter> querySexNum(int rec_id,String sex);
    public List<Enter> queryGradeNum(int rec_id,String grade);
}
