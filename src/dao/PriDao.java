package dao;

import entity.Community;
import entity.User;

/**
 * Created by asus on 2017/7/12.
 */
public interface PriDao {
    public int queryPri(String uid , int org_id,String pri);
}
