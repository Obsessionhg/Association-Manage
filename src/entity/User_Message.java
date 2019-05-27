package entity;

/**
 * Created by Jayce on 2017/7/11.
 */
public class User_Message {

    private int mes_id;
    private String from_uid;
    private String to_uid;
    private String mes_title;
    private String mes_content;
    private String mes_date;
    private int stat;//0未发送，1未读，2已读
    private int collectF;//faxian shoucang
    private int collectT;
    private int type;//0私人普通，1系统邮件


    public int getMes_id() {
        return mes_id;
    }

    public void setMes_id(int mes_id) {
        this.mes_id = mes_id;
    }

    public void setStat(int stat) {
        this.stat = stat;
    }

    public int getStat() {
        return stat;
    }



    public int getCollectF() {
        return collectF;
    }

    public void setCollectF(int collectF) {
        this.collectF = collectF;
    }

    public int getCollectT() {
        return collectT;
    }

    public void setCollectT(int collectT) {
        this.collectT = collectT;
    }


    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }


    public String getFrom_uid() {
        return from_uid;
    }

    public void setFrom_uid(String from_uid) {
        this.from_uid = from_uid;
    }

    public String getTo_uid() {
        return to_uid;
    }

    public void setTo_uid(String to_uid) {
        this.to_uid = to_uid;
    }

    public String getMes_title() {
        return mes_title;
    }

    public void setMes_title(String mes_title) {
        this.mes_title = mes_title;
    }

    public String getMes_content() {
        return mes_content;
    }

    public void setMes_content(String mes_content) {
        this.mes_content = mes_content;
    }

    public String getMes_date() {
        return mes_date;
    }

    public void setMes_date(String mes_date) {
        this.mes_date = mes_date;
    }






}
