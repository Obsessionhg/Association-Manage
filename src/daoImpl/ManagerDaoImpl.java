package daoImpl;

import comm.BaseDao;
import dao.ManagerDao;
import entity.Manager;

import java.util.List;

/**
 * Created by asus on 2017/7/14.
 */
public class ManagerDaoImpl extends BaseDao implements ManagerDao{
    public Manager login(Manager mana){
        List<Manager> list=executeQuery("select * from manager where mid ='"+mana.getMid()+"' and password='"+mana.getPassword()+"'",null,Manager.class);
        if(list.size()>0)
            return list.get(0);
        return null;
    }
    public Manager queryUserByUid(String mid){
        List<Manager> list=executeQuery("select * from manager where mid ='"+mid+"'",null,Manager.class);
        if(list.size()>0)
            return list.get(0);
        return null;
    }
}
