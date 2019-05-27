package daoImpl;

import comm.BaseDao;
import dao.NotiDao;
import entity.Notice;

import java.util.List;

/**
 * Created by asus on 2017/7/12.
 */
public class NotiDaoImpl extends BaseDao implements NotiDao{
    public List<Notice> queryAllNoti(){
        return executeQuery("select * from comm_notice",null,Notice.class);
    }
    public int addNoti(Notice noti){
        Object [] obs={noti.getOrg_id(),noti.getNoti_content(),noti.getNoti_date(),noti.getNoti_id(),noti.getNoti_title(),"0"};
        return executeUpdate("insert into comm_notice values(?,?,?,?,?,?)", obs);
    }
    public int deleteNoti(int noti_id){
        Object [] obs={noti_id};
        return executeUpdate("delete from comm_notice where  Noti_id=?",obs);
    }
    public int update(Notice noti){
        Object [] obs={noti.getNoti_content(),noti.getNoti_title(),noti.getNoti_id(),noti.getOrg_id()};
        return executeUpdate("update comm_noti set noti_content=?,noti_title=? where noti_id=? and org_id=?",obs);
    }
    public List<Notice> queryNotiByOrg(int org_id){
            return executeQuery("select * from comm_notice where org_id="+org_id+" order by noti_date DESC",null,Notice.class);
    }
    public Notice queryNotiByNoti(int noti_id){
        List<Notice> list = executeQuery("select * from comm_notice where noti_id="+noti_id,null,Notice.class);
        return list.get(0);
    }
    public List<Notice> queryAllAgreed(){
        return executeQuery("select * from comm_notice where stat=2",null,Notice.class);
    }

    public List<Notice> queryAllApply(){
        return executeQuery("select * from comm_notice where stat=1 order by noti_date DESC",null,Notice.class);
    }
    public void AgreeApply(int[] noti_id){
        executeUpdate("update comm_notice set stat=1 where stat=1 or stat=2" , null);
        for(int i=0;i<noti_id.length;i++) {
            executeUpdate("update comm_notice set stat=2 where noti_id=" + noti_id[i], null);
        }
    }
    public int addApplyNoti(Notice noti){
        Object [] obs={noti.getOrg_id(),noti.getNoti_content(),noti.getNoti_date(),noti.getNoti_id(),noti.getNoti_title(),1};
        return executeUpdate("insert into comm_notice values(?,?,?,?,?,?)", obs);
    }
    public void deleteApplyNoti(int[] noti_id){
        for(int i=0;i<noti_id.length;i++) {
            executeUpdate("delete from comm_notice where  noti_id=" + noti_id[i], null);
        }
    }
}
