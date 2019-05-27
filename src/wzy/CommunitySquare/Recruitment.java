package wzy.CommunitySquare;

/**
 * Created by Jayce on 2017/7/11.
 */
public class Recruitment {
    private int org_id;
    private int rec_id;
    private String rec_title;
    private String content;
    private String release_date;
    private int rec_status=1;
    private String rec_need;

    public int getOrg_id(){
        return this.org_id;
    }
    public String getContent(){
        return this.content;
    }
    public String getRelease_date(){
        return this.release_date;
    }
    public String getRec_title(){
        return this.rec_title;
    }
    public int getRec_id(){
        return this.rec_id;
    }
    public int getRec_status(){
        return this.rec_status;
    }
    public void setRec_status(int status){
        this.rec_status=status;
    }

   public String getRec_need(){
       return rec_need;
   }

    public void showRe(){//test
        System.out.println("");
        System.out.println(org_id);
        System.out.println(rec_id);
        System.out.println(rec_title);
        System.out.println(content);
        System.out.println(release_date);
        System.out.println(rec_status);
        System.out.println(rec_need);
    }



}
