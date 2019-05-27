package wzy.CommunitySquare;

/**
 * Created by Jayce on 2017/7/11.
 */
public class Notice {
    private int org_id;
    private int noti_id;
    private String noti_title;
    private String noti_content=null;
    private String noti_date;










    public int getOrg_id(){
        return this.org_id;
    }
    public String getNoti_content(){
        return this.noti_content;
    }
    public String getNoti_date(){
        return  this.noti_date;
    }
    public String getNoti_title(){
        return this.noti_title;
    }
    public int getNoti_id(){
        return this.noti_id;
    }

    public void showNotice(){//test
        System.out.println("");
        System.out.println(org_id);
        System.out.println(noti_id);
        System.out.println(noti_title);
        System.out.println(noti_content);
        System.out.println(noti_date);
    }
}
