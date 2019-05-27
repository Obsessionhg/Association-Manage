package wzy.com;

import comm.BaseDao;
import entity.Img;
import entity.Video;
import wzy.CommunitySquare.CommSquare;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;

/**
 * Created by Jayce on 2017/7/21.
 */
public class FileDel {
    //private static final String UPLOAD_DIRECTORY_IMG ="uploadImg";
    //private static final String UPLOAD_DIRECTORY_VIDEO ="uploadVideo";

    public static void DelUserImg(String uid,String uploadPath){
        String sql=null;
        Img img=null;
        int img_id=-1;
        String fileName=null;
        try {
            img=CommSquare.getUserImg(uid);
            if (img!=null){
                img_id=img.getImg_id();
                fileName=img.getImg_name();
            }
            BaseDao bd=new BaseDao();
            if (img_id>0){           //删除记录
                sql="delete from img where img_id=?";
                Object[] obs1={img_id};
                bd.executeUpdate(sql,obs1);
            }
            File file = new File(uploadPath+File.separator + fileName);//删除文件
            if (file.isFile() && file.exists()) {
                file.delete();
            }



        }catch (Exception e){
            e.printStackTrace();
        }



    }

    public static void DelCommPortrait(int org_id,String uploadPath){
        String sql=null;
        Img img=null;
        int img_id=-1;
        String fileName=null;
        try {
            img=CommSquare.getCommPortrait(org_id);
            if (img!=null){
                img_id=img.getImg_id();
                fileName=img.getImg_name();
            }
            BaseDao bd=new BaseDao();
            if (img_id>0){           //删除记录
                sql="delete from img where img_id=?";
                Object[] obs1={img_id};
                bd.executeUpdate(sql,obs1);
                sql="delete from comm_portrait where org_id=?";
                Object[] obs2={org_id};
                bd.executeUpdate(sql,obs2);
            }
            File file = new File(uploadPath+File.separator + fileName);//删除文件
            if (file.isFile() && file.exists()) {
                file.delete();
            }
        }catch (Exception e){
            e.printStackTrace();
        }

    }
















    public static String DelVideo(int video_id,String uploadPath){
        String sql=null;
        try {
            BaseDao bd=new BaseDao();
            String video_name=null;
            Video delvideo=CommSquare.getVideoById(video_id);
            if (delvideo!=null) video_name=delvideo.getVideo_name();
            sql="delete from homepage_video where video_name=?";
            Object[] _obs={video_name};
            bd.executeUpdate(sql,_obs);
            sql="delete from video where video_id=?";
            Object[] obs={video_id};
            bd.executeUpdate(sql,obs);
            File file = new File(uploadPath+File.separator + video_name);//删除文件
            if (file.isFile() && file.exists()) {
                file.delete();
            }





        }catch (Exception e){
           return e.getMessage();
        }
         return "success";

    }

    public static String DelCommImg(int img_id,String uploadPath){
        String sql=null;
        try {
            BaseDao bd=new BaseDao();
            String img_name=null;
            Img delimg=CommSquare.getImgById(img_id);
            if (delimg!=null) img_name=delimg.getImg_name();
            sql="delete from homepage_img where img_name=?";
            Object[] _obs={img_name};
            bd.executeUpdate(sql,_obs);
            sql="delete from img where img_id=?";
            Object[] obs={img_id};
            bd.executeUpdate(sql,obs);
            File file = new File(uploadPath+File.separator + img_name);//删除文件
            if (file.isFile() && file.exists()) {
                file.delete();
            }





        }catch (Exception e){
            return e.getMessage();
        }
       return "success";

    }




















}
