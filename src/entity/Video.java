package entity;

import org.apache.commons.lang.StringUtils;

/**
 * Created by Jayce on 2017/7/15.
 */
public class Video {
    private int video_id;
    private String video_name;
    private String date;

    public int getVideo_id(){
        return video_id;
    }
    public String getVideo_name(){
        return video_name;
    }
    public String getDate(){
        return date;
    }
    public int getOrgId(){
        return   Integer.parseInt(StringUtils.substringBefore(video_name,"^" )) ;
    }
}
