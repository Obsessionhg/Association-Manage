package dao;

import entity.Notice;

import java.util.List;

/**
 * Created by asus on 2017/7/12.
 */
public interface NotiDao {
    public int addNoti(Notice noti);
    public int deleteNoti(int noti_id);
    public int update(Notice noti);
    //public User queryUserByName(String name);
    //public User login(User u);
    public List<Notice> queryAllNoti();
    public List<Notice> queryNotiByOrg(int org_id);
    public Notice queryNotiByNoti(int noti_id);
    public List<Notice> queryAllAgreed();
    public List<Notice> queryAllApply();
    public void AgreeApply(int[] noti_id);
    public int addApplyNoti(Notice noti);
    public void deleteApplyNoti(int[] noti_id);
}
