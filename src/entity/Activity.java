package entity;

/**
 * Created by asus on 2017/7/12.
 */
public class Activity {
    private int Act_id;
    private int org_id;
    private String Act_date;
    private String Act_content;
    private String Act_title;

    public String getAct_title() {
        return Act_title;
    }

    public void setAct_title(String act_title) {
        Act_title = act_title;
    }



    public int getAct_id() {
        return Act_id;
    }

    public void setAct_id(int act_id) {
        Act_id = act_id;
    }

    public int getOrg_id() {
        return org_id;
    }

    public void setOrg_id(int org_id) {
        this.org_id = org_id;
    }

    public String getAct_date() {
        return Act_date;
    }

    public void setAct_date(String act_date) {
        Act_date = act_date;
    }

    public String getAct_content() {
        return Act_content;
    }

    public void setAct_content(String act_content) {
        Act_content = act_content;
    }
}
