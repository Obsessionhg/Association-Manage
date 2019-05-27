package entity;

/**
 * Created by Jayce on 2017/7/18.
 */
public class layer {
    private int post_id;
    private int layer_id;
    private String uid;
    private String content;
    private String date;
    private String img_name=null;


    public int getPost_id(){
        return post_id;
    }
    public int getLayer_id(){
        return layer_id;
    }
    public String getUid(){
        return uid;
    }
    public String getContent(){
        return content;
    }
    public String getDate(){
        return date;
    }
    public String getImg_name(){
        return img_name;
    }


}
