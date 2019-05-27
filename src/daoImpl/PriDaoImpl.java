package daoImpl;

import comm.BaseDao;
import dao.PriDao;
import entity.Community;
import entity.User;

/**
 * Created by asus on 2017/7/12.
 */
public class PriDaoImpl  extends BaseDao implements PriDao {
    public int queryPri(String uid , int org_id, String pri) {
        Object[] obj = {org_id, uid};
        return QueryPri("select " + pri + " from org_user where org_id=? and uid=?", obj, pri);
    }


    public int QueryPri(String sql, Object[] para, String pri) {
        connection();
        int hasPri = 0;
        try {
            ps = conn.prepareStatement(sql);
            if (para != null && para.length > 0) {
                for (int i = 0; i < para.length; i++) {
                    ps.setObject(i + 1, para[i]);
                }
            }
            rs = ps.executeQuery();
            while (rs.next()) {
                hasPri = rs.getInt(pri);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            free();
        }
        return hasPri;

    }
}

