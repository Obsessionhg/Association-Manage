package daoImpl;

import comm.BaseDao;
import dao.EnterDao;
import entity.Enter;

import java.util.List;

/**
 * Created by asus on 2017/7/13.
 */
public class EnterDapImpl extends BaseDao implements EnterDao {
    public int addEnter(Enter enter){
        Object [] obs={enter.getOrg_id(),enter.getRec_id(),enter.getUid(),enter.getName(),enter.getSex(),enter.getGrade(),enter.getQq(),enter.getTel(),enter.getMail()};
        return executeUpdate("insert into Enter values(?,?,?,?,?,?,?,?,?)", obs );
    }
    public int deleteEnter(int rec_id){
       // Object [] obs={org_id,rec_id};
        return executeUpdate("delete from Enter where  rec_id="+rec_id+"",null);
    }
    public int deleteEnterAgree(int rec_id,String uid){
        return executeUpdate("delete from Enter where  rec_id="+rec_id+" and uid='"+uid+"'",null);
    }

    public List<Enter> queryEnterByOrg(int org_id,int rec_id){
        return executeQuery("select * from Enter where org_id ="+org_id+" and rec_id="+rec_id,null,Enter.class);
    }
    public List<Enter> queryExist(int org_id,String uid){
        return  executeQuery("select * from Enter where org_id="+org_id+" and uid='"+uid+"'",null,Enter.class);
    }
    public List<Enter> querySexNum(int rec_id,String sex){
        return  executeQuery("select * from Enter where rec_id="+rec_id+" and sex='"+sex+"'",null,Enter.class);
    }
    public List<Enter> queryGradeNum(int rec_id,String grade){
        return  executeQuery("select * from Enter where rec_id="+rec_id+" and grade='"+grade+"'",null,Enter.class);
    }
}
