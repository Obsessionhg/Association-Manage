package entity;

/**
 * Created by Jayce on 2017/7/20.
 */
public class homepage_video {
    private int apply_id;
    private String video_name;
    private String org_name;
    private String applytime;
    private int status;
    private int nextdel;

    public int getApply_id(){
        return apply_id;
    }
    public String getVideo_name(){
        return video_name;
    }
    public String getOrg_name(){
        return org_name;
    }
    public String getApplytime(){
        return applytime;
    }
    public int getStatus(){
        return status;
    }
    public int getNextdel(){
        return nextdel;
    }

    public void show(){//test
        System.out.println("----");
        System.out.println(apply_id);
        System.out.println(video_name);
        System.out.println(org_name);
        System.out.println(applytime);
        System.out.println(status);
        System.out.println(nextdel);
        System.out.println("----");
        System.out.println("");

    }
}
