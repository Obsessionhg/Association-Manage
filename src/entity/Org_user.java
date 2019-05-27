package entity;

/**
 * Created by asus on 2017/7/14.
 */
public class Org_user {

    private int org_id;
    private String uid;
    private String position;
    private int priManaUser;
    private int priNoNews;
    private int priActi;
    public int getOrg_id() {
        return org_id;
    }

    public void setOrg_id(int org_id) {
        this.org_id = org_id;
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public int getPriManaUser() {
        return priManaUser;
    }

    public void setPriManaUser(int priManaUser) {
        this.priManaUser = priManaUser;
    }

    public int getPriNoNews() {
        return priNoNews;
    }

    public void setPriNoNews(int priNoNews) {
        this.priNoNews = priNoNews;
    }

    public int getPriActi() {
        return priActi;
    }

    public void setPriActi(int priActi) {
        this.priActi = priActi;
    }

}

