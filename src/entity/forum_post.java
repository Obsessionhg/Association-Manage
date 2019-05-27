package entity;

/**
 * Created by Jayce on 2017/7/18.
 */
public class forum_post {
    private int post_id;
    private String uid;
    private String title;
    private String date;
   private int layers;

    public int getPost_id(){
        return post_id;
    }
    public String getUid(){
        return uid;
    }
    public String getTitle(){
        return title;
    }
    public String getDate(){
        return date;
    }
    public int getLayers(){
        return layers;
    }
}
