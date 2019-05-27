package daoImpl;

import comm.BaseDao;
import dao.RecDao;
import entity.Recruitment;

import java.util.List;

/**
 * Created by asus on 2017/7/13.
 */
public class RecDaoImp extends BaseDao implements RecDao {
    public int addRec(Recruitment rec){
        Object [] obs={rec.getOrg_id(),rec.getContent(),rec.getRelease_date(),rec.getRec_title(),rec.getStatus(),rec.getRec_need()};
        return executeUpdate("insert into recruitment values(?,?,?,?,null,?,?)", obs );
    }

    public int update(Recruitment rec){
        Object [] obs={rec.getContent(),rec.getRec_title(),rec.getRec_id(),rec.getOrg_id()};
        return executeUpdate("update recruitment set content=?,rec_title=? where rec_id=? and org_id=?",obs);
    }

    public int updateRecNeed(int rec_id,String rec_need){
        return executeUpdate("update recruitment set rec_need='"+rec_need+"' where rec_id="+rec_id,null);
    }

    public int deleteRec(int rec_id){
        //Object [] obs={rec.getRec_id(),rec.getOrg_id(),};
        //return executeUpdate("delete from recruitment where =rec_id=?and org_id=?",obs );
       // Object [] obs={rec.getRec_id()};
        return executeUpdate("delete from recruitment where rec_id="+rec_id+"",null );
    }

    public List<Recruitment> queryAllByOrg(int org_id){
        //return executeQuery("select * from recruitment where org_id ="+org_id,null,Recruitment.class);
        return executeQuery("select * from recruitment where org_id= "+org_id,null,Recruitment.class);
    }


    public int StopRec(int rec_id) {
        return executeUpdate("update recruitment set rec_status=0 where rec_id='"+rec_id+"'",null);
    }

    public String RecNeed(int rec_id){
        List<Recruitment> list = executeQuery("select * from recruitment where rec_id="+rec_id,null,Recruitment.class);
        if(list.size()>0)
            return list.get(0).getRec_need();
        return null;
    }
}
