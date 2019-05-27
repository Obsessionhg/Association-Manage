package dao;

import entity.User_Message;

import java.util.List;

/**
 * Created by asus on 2017/7/17.
 */
public interface MesDao {
    public List<User_Message> ShowReceive(String uid);
    public List<User_Message> ShowSend(String uid);
    public List<User_Message> ShowDraf(String uid);
    public List<User_Message> showCollect(String uid);
    //public int SendMes(User_Message user_mes);
    public int addMes(User_Message user_mes);
    public int deleteMes(int mes_id);
    public int sendDraf(int mes_id);
    public int Read(int mes_id);
    //public int noRead(int mes_id);
    public int changecollect(int mes_id,int collect,String whocollect);
    public int querayCollectF(int mes_id,String uid);
    public int querayCollectT(int mes_id,String uid);
    public String[] rencentUser(String uid);
    public int noReadcount(String uid);
    //public int cancelCollect(int mes_id);

}
