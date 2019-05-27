package wzy.CommunitySquare;

import comm.BaseDao;
import entity.forum_post;
import entity.layer;

import java.sql.Timestamp;
import java.util.List;

/**
 * Created by Jayce on 2017/7/18.
 */
public class Forum_Ctr {
    public static int addLayer(int post_id,String uid,String content){
        Object [] obs={post_id,uid,content,new Timestamp(System.currentTimeMillis())};
        String sql ="insert into layer (post_id,uid,content,date) values(?,?,?,?)";
        BaseDao bd=new BaseDao();
        int id=bd.executeUpdate2(sql,obs);
        sql="update forum_post  set layers=layers+1 where post_id =?";
        Object [] obs1={post_id};
        bd.executeUpdate(sql,obs1);

        bd=null;
        return id;
    }
    public static int creatPost(String uid,String title,String content){
        Object [] obs={uid,title,new Timestamp(System.currentTimeMillis())};
        String sql ="insert into forum_post (uid,title,date) values(?,?,?)";
        BaseDao bd=new BaseDao();
        int id=bd.executeUpdate2(sql,obs);
        bd=null;
        return id;
    }

    public static int updateImgName(String img_name,int post_id,int layer_id){
        BaseDao bd=new BaseDao();
        int i;
        String sql="update layer set img_name=? where post_id=? and layer_id=?";
        Object [] obs={img_name,post_id,layer_id};
        i=bd.executeUpdate(sql,obs);
        bd=null;
        return i;

    }

    public static List<forum_post> getPostsList(int ReqNum,boolean byLayers){ //false按时间倒序取帖子,true按帖子层数从高到低
        if (ReqNum < 0) {
            System.out.println("ReqNum Error");
            return null;
        }
        List<forum_post> plist;
        BaseDao bd = new BaseDao();
        String sql=null;
        if (byLayers){
             sql = "select * from forum_post order by layers desc";
        }else {
            sql = "select * from forum_post order by post_id desc";
        }


        plist = bd.executeQuery(sql, null, forum_post.class, 9, ReqNum,true);
        bd = null;
        return plist;
    }

    public static forum_post getPostById(int post_id){  //按post_id获取帖子实例
        List<forum_post> plist;
        BaseDao bd = new BaseDao();
        String sql = "select * from forum_post where post_id="+post_id;
        plist = bd.executeQuery(sql, null, forum_post.class);
        bd = null;
        return plist.get(0);
    }

    public static layer getlayerById(int post_id,int layer_id){//按post_id,layer_id获取layer实例
        List<layer> layerList;
        BaseDao bd = new BaseDao();
        String sql = "select * from layer where post_id="+post_id+" and layer_id="+layer_id;
        layerList = bd.executeQuery(sql, null, layer.class);
        bd = null;
        return layerList.get(0);
    }





    public static List<layer> getLayersList(int post_id,int ReqNum,boolean isdesc){ //取某一帖子的所有楼层,desc为取倒序,楼层从高到低
        if (ReqNum < 0) {
            System.out.println("ReqNum Error");
            return null;
        }
        List<layer> llist;
        BaseDao bd = new BaseDao();
        String sql=null;
        if (isdesc){
            sql = "select * from layer where post_id="+post_id+ " order by layer_id desc";
        }else {
            sql = "select * from layer where post_id="+post_id+ " order by layer_id ";
        }

        llist = bd.executeQuery(sql, null, layer.class, 9, ReqNum,true);
        bd = null;
        return llist;
    }





}
