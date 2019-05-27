package entity;

/**
 * Created by Jayce on 2017/7/19.
 */
public class homepage_img {
    private int apply_id;
    private String img_name;
    private String org_name;
    private String applytime;
    private int status;
    private int nextdel;

    public int getApply_id(){
        return apply_id;
    }
    public String getImg_name(){
        return img_name;
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
        System.out.println(img_name);
        System.out.println(org_name);
        System.out.println(applytime);
        System.out.println(status);
        System.out.println(nextdel);
        System.out.println("----");
        System.out.println("");

    }

}
