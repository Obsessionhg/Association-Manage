package dao;

import entity.Manager;

/**
 * Created by asus on 2017/7/14.
 */
public interface ManagerDao {
    public Manager login(Manager mana);

    public Manager queryUserByUid(String mid);
}
