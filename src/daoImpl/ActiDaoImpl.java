package daoImpl;

import comm.BaseDao;
import dao.ActiDao;
import entity.Activity;

import java.util.List;

/**
 * Created by asus on 2017/7/12.
 */
public class ActiDaoImpl extends BaseDao implements ActiDao {
    public int addActi(Activity Acti){
        Object [] obs={Acti.getOrg_id(),Acti.getAct_date(),Acti.getAct_content(),Acti.getAct_title()};
        return executeUpdate("insert into Activity values(null,?,?,?,?)", obs );
    }
    public List<Activity> queryAllActi(){
        return executeQuery("select * from Activity",null,Activity.class);
    }
    public int deleteActi(int Act_id) {
        return executeUpdate("delete from Activity where Act_id ="+Act_id,null);
    }

    @Override
    public int update(Activity Acti) {
        Object [] obs={Acti.getAct_content(),Acti.getAct_title(),Acti.getAct_id()};
        return executeUpdate("update Activity set Act_content=?,Act_title=? where Act_id=?",obs);
    }
    public List<Activity>  queryActiByOrg(int org_id){
        return executeQuery("select * from Activity where org_id ="+org_id+" order by act_date DESC",null,Activity.class);
    }
}
