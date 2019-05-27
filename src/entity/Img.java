package entity;

import org.apache.commons.lang.StringUtils;

/**
 * Created by Jayce on 2017/7/15.
 */
public class Img {
    private int img_id;
    private String img_name;
    private String date;
    private String uid=null;
    private int org_id;




    public int getImg_id(){
        return  img_id;
    }
    public String getImg_name(){
        return img_name;
    }
    public String getDate(){
        return date;
    }
    public String getUid(){
        return uid;
    }
    public int getOrg_id(){
        return org_id;
    }


    /*public String getRealId(){
        return  StringUtils.substringAfter(img_id,"^" );
    }*/


}
