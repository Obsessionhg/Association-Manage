package entity;

/**
 * Created by asus on 2017/7/13.
 */
public class Recruitment {
    private int org_id;
    private String content;
    private String release_date;
    private String rec_title;
    private int rec_id;
    private int status;
    private String rec_need;

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getRec_id() {
        return rec_id;
    }

    public void setRec_id(int rec_id) {
        this.rec_id = rec_id;
    }
    public int getOrg_id() {
        return org_id;
    }

    public void setOrg_id(int org_id) {
        this.org_id = org_id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getRelease_date() {
        return release_date;
    }

    public void setRelease_date(String release_date) {
        this.release_date = release_date;
    }

    public String getRec_title() {
        return rec_title;
    }

    public void setRec_title(String rec_title) {
        this.rec_title = rec_title;
    }

    public String getRec_need() {
        return rec_need;
    }

    public void setRec_need(String rec_need) {
        this.rec_need = rec_need;
    }



}
