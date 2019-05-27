package entity;

/**
 * Created by asus on 2017/7/12.
 */
public class Notice {

    private int org_id;
    private String noti_content;
    private String noti_date;
    private int noti_id;
    private String noti_title;
    private int stat;//0内部，1外部申请，2外部展示

    public int getStat() {
        return stat;
    }

    public void setStat(int stat) {
        this.stat = stat;
    }

    public int getOrg_id() {
        return org_id;
    }

    public void setOrg_id(int org_id) {
        this.org_id = org_id;
    }

    public String getNoti_content() {
        return noti_content;
    }

    public void setNoti_content(String noti_content) {
        this.noti_content = noti_content;
    }

    public String getNoti_date() {
        return noti_date;
    }

    public void setNoti_date(String noti_date) {
        this.noti_date = noti_date;
    }

    public int getNoti_id() {
        return noti_id;
    }

    public void setNoti_id(int noti_id) {
        this.noti_id = noti_id;
    }

    public String getNoti_title() {
        return noti_title;
    }

    public void setNoti_title(String noti_title) {
        this.noti_title = noti_title;
    }

}
