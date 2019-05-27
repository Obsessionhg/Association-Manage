package entity;

/**
 * Created by asus on 2017/7/12.
 */
public class Community {

    private int org_id;
    private String org_intro;
    private String org_name;
    private String org_found_date;
    private String org_status;
    private String uid;

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }


    public String getOrg_status() {
        return org_status;
    }

    public void setOrg_status(String org_status) {
        this.org_status = org_status;
    }
    public int getOrg_id() {
        return org_id;
    }

    public void setOrg_id(int org_id) {
        this.org_id = org_id;
    }

    public String getOrg_intro() {
        return org_intro;
    }

    public void setOrg_intro(String org_intro) {
        this.org_intro = org_intro;
    }

    public String getOrg_name() {
        return org_name;
    }

    public void setOrg_name(String org_name) {
        this.org_name = org_name;
    }

    public String getOrg_found_date() {
        return org_found_date;
    }

    public void setOrg_found_date(String org_found_date) {
        this.org_found_date = org_found_date;
    }

}
