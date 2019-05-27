package dao;

import entity.Org_user;

import java.util.List;

/**
 * Created by asus on 2017/7/14.
 */
public interface ComUserDao {
     public int deleteComUser(int org_id,String uid);
     public int addComUser(int org_id,String uid);
     public int addComLeader(int org_id,String uid);
     public List<Org_user>  queryUserByOrg(int org_id);
     public List<Org_user>  queryUserByOrgUid(int org_id,String uid);
     public int updatePosition(int org_id,String uid,String position);
     public List<Org_user> queryOrgByUid(String uid);
     public int updateManaPri(int org_id,String uid,int stat);
     public int updateNotiPri(int org_id,String uid,int stat);
     public int updateActiaPri(int org_id,String uid,int stat);
     public String queryLeader(int org_id);
     public String queryLeaderName(int org_id);
}
