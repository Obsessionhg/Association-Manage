package daoImpl;

import comm.BaseDao;
import dao.ComUserDao;
import dao.UserDao;
import entity.Org_user;

import java.util.List;

/**
 * Created by asus on 2017/7/14.
 */
public class ComUserDaoImpl extends BaseDao implements ComUserDao{
    public int deleteComUser(int org_id,String uid){
        return executeUpdate("delete from org_user where org_id="+org_id+" and uid='"+uid+"'",null);
    }
    public int addComUser(int org_id,String uid){
        Object[] obj = {"普通"};
        return executeUpdate("insert into org_user values("+org_id+",'"+uid+"',?,0,0,0)",obj);
    }
    public int addComLeader(int org_id,String uid){
        Object[] obj = {"社长"};
        return executeUpdate("insert into org_user values("+org_id+",'"+uid+"',?,1,1,1)",obj);
    }
    public List<Org_user> queryUserByOrg(int org_id){;
       return executeQuery("select *from org_user where org_id ="+org_id,null,Org_user.class);
   }
    public List<Org_user>  queryUserByOrgUid(int org_id,String uid){
        return executeQuery("select *from org_user where org_id ="+org_id+" and uid ='"+uid+"'",null,Org_user.class);
    }
    public int updatePosition(int org_id,String uid,String position){
        return executeUpdate("update org_user set position ='"+position+"' where org_id="+org_id+" and uid='"+uid+"'",null);
    }
    public List<Org_user> queryOrgByUid(String uid){
       return executeQuery("select *from org_user where  uid ='"+uid+"'",null,Org_user.class);
    }
    public int updateManaPri(int org_id,String uid,int stat){
        return executeUpdate("update org_user set priManaUser="+stat+" where org_id="+org_id+" and uid="+uid,null);
    }
    public int updateNotiPri(int org_id,String uid,int stat){
        return executeUpdate("update org_user set priNoNews="+stat+" where org_id="+org_id+" and uid="+uid,null);
    }
    public int updateActiaPri(int org_id,String uid,int stat){
        return executeUpdate("update org_user set priActi="+stat+" where org_id="+org_id+" and uid="+uid,null);
    }
    public String queryLeader(int org_id){
        List<Org_user> list = executeQuery("select *from org_user where org_id="+org_id+" and position='社长'",null,Org_user.class);
        return list.get(0).getUid();
    }
    public String queryLeaderName(int org_id) {
        List<Org_user> list = executeQuery("select *from org_user where org_id=" + org_id + " and position='社长'", null, Org_user.class);
        String uid =  list.get(0).getUid();
        UserDao userdao = new UserDaoImpl();
        return userdao.queryUserNameByUid(uid);
    }
}
