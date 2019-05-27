package wzy.CommunitySquare;


import com.sun.deploy.net.HttpRequest;
import comm.BaseDao;
import entity.*;

import java.io.File;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.*;


/**
 * Created by Jayce on 2017/7/11.
 */
public class CommSquare  {




    public static int CreatComm(String uid,String org_name,String org_intro){
        Object [] obs={org_intro,org_name,new Timestamp(System.currentTimeMillis()),0,uid};
        String sql ="insert into community (org_intro,org_name,org_found_date,org_status,uid) values(?,?,?,?,?)";
        BaseDao bd=new BaseDao();
        int i=bd.executeUpdate(sql,obs);
        if (i!=0){
            //sql="select org_id,org_intro,org_name,org_found_date org_status,uid from community where org_name='"+org_name+"' and uid='"+uid+"'";
            sql="select * from community where org_name='"+org_name+"' and uid='"+uid+"'";
            Community community=( Community)bd. executeQuery(sql,null,Community.class).get(0);
            bd=null;
            return community.getOrg_id();
        }
        return -1;



    }




    public  static  Community getCommunity(int org_id){
        BaseDao bd=new BaseDao();
        List<Community> Clist=bd. executeQuery("select org_id,org_intro,org_name,org_found_date,org_status,uid from community where org_id="+org_id,null,Community.class);
        bd=null;
        if (Clist.isEmpty())return null;
        return Clist.get(0);




    }








    public static int setCommNotice(int _org_id,int _noti_id,String _noti_title,String _noti_content){   //添加社团公告
        Object [] obs={_org_id,_noti_id,_noti_title,_noti_content,new Timestamp(System.currentTimeMillis())};
        String sql ="insert into comm_notice (org_id,noti_id,noti_title,noti_content,noti_date) values(?,?,?,?,?)";
        BaseDao bd=new BaseDao();
        int i=bd.executeUpdate(sql,obs);
        return i;

    }

    public static int setCommNews(int _org_id,String _news_title,String _news_content){   //添加社团新闻,返回新闻id

        Object [] obs={_org_id,_news_title,_news_content,new Timestamp(System.currentTimeMillis())};
        String sql ="insert into news (org_id,news_title,news_content,news_date) values(?,?,?,?)";
        BaseDao bd=new BaseDao();
        int news_id=bd.executeUpdate2(sql,obs);
        return news_id;

    }

   public static int setRecruitment(int _org_id,int _rec_id,String _rec_title,String _content,String _rec_need){   //添加社团招新信息

       Object [] obs={_org_id,_rec_id,_rec_title,_content,new Timestamp(System.currentTimeMillis()),_rec_need};
       String sql ="insert into recruitment (org_id,rec_id,rec_title,content,release_date,rec_need) values(?,?,?,?,?,?)";
       BaseDao bd=new BaseDao();
       int i=bd.executeUpdate(sql,obs);
       return i;
//


    }

    public static List<Recruitment> getRecruitmentList(int ReqNum,boolean needContent){   //获取招新列表,若ReqNum为0,则取全部,needContent决定带不带content。
        if (ReqNum < 0) {
            System.out.println("ReqNum Error");
            return null;
        }
        List<Recruitment> Rlist;
        BaseDao bd=new BaseDao();
        if (!needContent){   //不带content
            String sql="select org_id,rec_id,rec_title,release_date,status,rec_need from recruitment where status=1 order by release_date desc";
            Rlist=bd.executeQuery(sql,null,Recruitment.class,3,ReqNum,false);
        }else {//带content
            String sql="select org_id,rec_id,rec_title,content,release_date,status,rec_need from recruitment where status=1 order by release_date desc";
            Rlist=bd.executeQuery(sql,null,Recruitment.class,99,ReqNum,true);
        }

        return Rlist;


    }

    public static  List<Notice> getCommNoticeList(int _org_id,int ReqNum,boolean needContent) {   //获取社团公告,ReqNum的取值表示要从数据库按时间倒序取几个社团公告(不会超过最大记录),0表示取所有,小于0无效。
        if (ReqNum < 0) {
            System.out.println("ReqNum Error");
            return null;
        }
        List<Notice> Nlist;
        BaseDao bd=new BaseDao();
        if (!needContent){   //不带content
            String sql="select org_id,noti_id,noti_title,noti_date from comm_notice where org_id='"+_org_id+"' order by noti_date desc";
            Nlist=bd.executeQuery(sql,null,Notice.class,3,ReqNum,false);
        }else {//带content
            String sql="select org_id,noti_id,noti_title,noti_content,noti_date from comm_notice where org_id='"+_org_id+"' order by noti_date desc";
            Nlist=bd.executeQuery(sql,null,Notice.class,99,ReqNum,true);
        }

        bd=null;
        return Nlist;


    }

    public static  List<Notice> getCommNoticeList(int ReqNum,boolean needContent) {   //获取社团公告,ReqNum的取值表示要从数据库按时间倒序取几个社团公告(不会超过最大记录),0表示取所有,小于0无效。
        if (ReqNum < 0) {
            System.out.println("ReqNum Error");
            return null;
        }
        List<Notice> Nlist;
        BaseDao bd=new BaseDao();
        if (!needContent){   //不带content
            String sql="select org_id,noti_id,noti_title,noti_date from comm_notice order by noti_date desc";
            Nlist=bd.executeQuery(sql,null,Notice.class,3,ReqNum,false);
        }else {//带content
            String sql="select org_id,noti_id,noti_title,noti_content,noti_date from comm_notice order by noti_date desc";
            Nlist=bd.executeQuery(sql,null,Notice.class,99,ReqNum,true);
        }

        bd=null;
        return Nlist;


    }

    public static List<News> getCommNewsList(int ReqNum, boolean needContent){   //获取新闻列表,ReqNum的取值表示要从数据库按时间倒序取几个社团新闻(不会超过最大记录),0表示取所有,小于0无效。
        if (ReqNum < 0) {
            System.out.println("ReqNum Error");
            return null;
        }
        List<News> Nlist;
        BaseDao bd=new BaseDao();
        if (!needContent){   //不带content
            String sql="select news_id,org_id,news_title,news_date from news ";
            Nlist=bd.executeQuery(sql,null,News.class,3,ReqNum,false);
        }else {//带content
            String sql="select news_id,org_id,news_title,news_content,news_date from news ";
            Nlist=bd.executeQuery(sql,null,News.class,99,ReqNum,true);
        }

        bd=null;
        return Nlist;

    }

    public static List<News> getCommNewsListById(int org_id, boolean needContent){   //获取某社团的所有新闻

        List<News> Nlist;
        BaseDao bd=new BaseDao();
        if (!needContent){   //不带content
            String sql="select news_id,org_id,news_title,news_date from news where org_id="+org_id;
            Nlist=bd.executeQuery(sql,null,News.class,3,0,false);
        }else {//带content
            String sql="select news_id,org_id,news_title,news_content,news_date from news where org_id="+org_id;
            Nlist=bd.executeQuery(sql,null,News.class,99,0,true);
        }

        bd=null;
        return Nlist;

    }






    public static News getNewsFormId(int news_id){//获取新闻
        List<News> _newslist;
        BaseDao db=new BaseDao();
        String sql="select * from news where news_id="+news_id ;
        _newslist=db.executeQuery(sql,null,News.class);
        db=null;
        if (_newslist.isEmpty()) return null;
        return _newslist.get(0);

    }
    public static List<News> getNewsFormIdS(List<Integer> ids){//通过id数组获取新闻列表
        List<News> _news;
        String insql="";
        int lenth=ids.size();
        for (int i=0;i<lenth-1;i++){
            insql+=ids.get(i)+",";
        }
        insql+=ids.get(lenth-1)+")";
        BaseDao db=new BaseDao();
        String sql="select * from news where news_id in ("+insql ;
        _news=db.executeQuery(sql,null,News.class);
        db=null;
        return _news;

    }

    public static int deleteNews(int news_id){
        BaseDao db=new BaseDao();
        String sql="delete  from news where news_id=?" ;
        Object [] obs={news_id};
       int i= db.executeUpdate(sql,obs);
       db=null;
       return i;

    }

    public static Notice getNoticeFormId(int org_id,int notice_id){ //获取公告详情

        List<Notice> _noticelist;
        BaseDao db=new BaseDao();
        String sql="select org_id,noti_id,noti_title,noti_content,noti_date from comm_notice where org_id="+org_id+" and noti_id="+notice_id ;
        _noticelist=db.executeQuery(sql,null,Notice.class);
        db=null;
        if (_noticelist.isEmpty())return null;
        return _noticelist.get(0);


    }

    public static Recruitment getRecruitmentFromId(int org_id,int rec_id){   //获取招新详情,带content

        List<Recruitment> _reclist;
        BaseDao db=new BaseDao();
        String sql="select org_id,rec_id,rec_title,content,release_date,status,rec_need from recruitment where org_id="+org_id+" and rec_id="+rec_id ;
        _reclist=db.executeQuery(sql,null,Recruitment.class);
        db=null;
        if (_reclist.isEmpty())return null;
        return _reclist.get(0);


    }

//



    public static List<Video> getVideoList(int ReqNum){   //获取视频id,ReqNum的取值表示要从数据库按时间倒序取几个视频id(不会超过最大记录),0表示取所有,小于0无效。

            if (ReqNum < 0) {
                System.out.println("ReqNum Error");
                return null;
            }
            List<Video> Vlist;
            BaseDao bd = new BaseDao();
            String sql = "select * from video order by video_id desc";

            Vlist = bd.executeQuery(sql, null, Video.class, 9, ReqNum,true);
            bd = null;
            return Vlist;



        }








    public static int setVideo(int _org_id,String videoname){


        Object [] obs={videoname,new Timestamp(System.currentTimeMillis())};
        String sql ="insert into video (video_name,date) values(?,?)";
        BaseDao bd=new BaseDao();
        int id=bd.executeUpdate2(sql,obs);
        bd=null;
        return id;




    }

    public static Video getVideoById(int video_id){  //获取按视频ID拿视频

        List<Video> videoList;
        BaseDao bd=new BaseDao();
        String sql =  "select * from video where video_id="+video_id;
        videoList= bd.executeQuery(sql,null,Video.class);
        bd=null;
        if (videoList.isEmpty())return null;
        return videoList.get(0);
    }

    public static List<Video> getVideosFormIdS(List<Integer> ids){//通过id数组获取video列表
        List<Video> _videos;
        String insql="";
        int lenth=ids.size();
        for (int i=0;i<lenth-1;i++){
            insql+=ids.get(i)+",";
        }
        insql+=ids.get(lenth-1)+")";
        BaseDao db=new BaseDao();
        String sql="select * from video where video_id in ("+insql ;
        _videos=db.executeQuery(sql,null,Video.class);
        db=null;
        return _videos;

    }

    public static int ApplyHomepageVideo(String video_name){   //申请将社团视频发到首页,返回申请id.
        Object [] obs={video_name,new Timestamp(System.currentTimeMillis()),0,0};
        String sql ="insert into homepage_video (video_name,applytime,status,nextdel) values(?,?,?,?)";
        BaseDao bd=new BaseDao();
        int apply_id=bd.executeUpdate2(sql,obs);
        bd=null;
        return apply_id;
    }

    public static int ApplyHomepageVideo(String video_name,String org_name){   //申请将社团视频发到首页,返回申请id.
        Object [] obs={video_name,org_name,new Timestamp(System.currentTimeMillis()),0,0};
        String sql ="insert into homepage_video (video_name,org_name,applytime,status,nextdel) values(?,?,?,?,?)";
        BaseDao bd=new BaseDao();
        int apply_id=bd.executeUpdate2(sql,obs);
        bd=null;
        return apply_id;
    }


    public static String setHomepageVideo(List<Integer> ids){
        String sql;
        try {
            BaseDao bd=new BaseDao();
            sql="update homepage_video set status=?";   //把所有记录的status置0
            Object [] obs={0};
            bd.executeUpdate(sql,obs);
            sql="update homepage_video set status=?,nextdel=? where apply_id=?";  //选择记录,置status和nextdel为1
            int length=(ids.size()>5)?5:ids.size();
            for (int i=0;i<length;i++){
                Object [] obs2={1,1,ids.get(i)};
                bd.executeUpdate(sql,obs2);
            }
            sql="delete from homepage_video where status=? and nextdel=?"; //删除所有status=0且nextdel=1的记录
            Object [] obs3={0,1};
            bd.executeUpdate(sql,obs3);
            bd=null;
        }catch (Exception ex){
            return ex.getMessage();
        }
       return "0";
    }

    public static List<homepage_video> getHomepageVideoApplyList(int ReqNum){ //返回status为0的记录,按申请时间排序.先申请的在前
        if (ReqNum < 0) {
            System.out.println("ReqNum Error");
            return null;
        }
        List<homepage_video> hplist;
        BaseDao bd = new BaseDao();
        String sql = "select * from homepage_video where status=0";
        hplist=bd.executeQuery(sql,null,homepage_video.class,9,ReqNum,true);
        bd = null;
        return hplist;
    }

    public static List<homepage_video> getHomepageVideoList(){ //返回status为1的记录
        String sql =  "select * from homepage_video where status=1";
        List<homepage_video> hplist;
        BaseDao bd=new BaseDao();
        hplist=bd.executeQuery(sql,null,homepage_video.class);
        bd=null;
        return hplist;
    }


   public static Img getImgById(int img_id){  //获取按图片id拿图片

       List<Img> imgList;
       BaseDao bd=new BaseDao();
       String sql =  "select img_id,img_name,date,uid,org_id from img where img_id="+img_id;
       imgList=bd.executeQuery(sql,null,Img.class);
       bd=null;
       if (imgList.isEmpty())return null;
       return imgList.get(0);
   }

    public static List<Img> getImgsFormIdS(List<Integer> ids){//通过id数组获取img列表
        List<Img> _imgs;
        String insql="";
        int lenth=ids.size();
        for (int i=0;i<lenth-1;i++){
            insql+=ids.get(i)+",";
        }
        insql+=ids.get(lenth-1)+")";
        BaseDao db=new BaseDao();
        String sql="select img_id,img_name,date,uid,org_id from img where img_id in ("+insql ;
        _imgs=db.executeQuery(sql,null,Img.class);
        db=null;
        return _imgs;

    }

    public static List<Img> getCommImgList(int ReqNum){  //获取最新的社团图片(不分社团)
        if (ReqNum < 0) {
            System.out.println("ReqNum Error");
            return null;
        }
        List<Img> Ilist;
        BaseDao bd=new BaseDao();

       String sql="select * from img where org_id is not null order by img_id desc";
        Ilist=bd.executeQuery(sql,null,Img.class,9,ReqNum,true);
        bd=null;
        return Ilist;
    }

    public static List<Img> getCommImgList(int org_id,int ReqNum){  //获取社团图片(按社团id)
        if (ReqNum < 0) {
            System.out.println("ReqNum Error");
            return null;
        }
        List<Img> Ilist;
        BaseDao bd=new BaseDao();

        String sql="select * from img where org_id="+org_id+" order by img_id desc";
        Ilist=bd.executeQuery(sql,null,Img.class,9,ReqNum,true);
        return Ilist;
    }

    public static int ApplyHomepageImg(String img_name){   //申请将社团图片发到首页,返回申请id.
        Object [] obs={img_name,new Timestamp(System.currentTimeMillis()),0,0};
        String sql ="insert into homepage_img (img_name,applytime,status,nextdel) values(?,?,?,?)";
        BaseDao bd=new BaseDao();
        int apply_id=bd.executeUpdate2(sql,obs);
        bd=null;
        return apply_id;
    }

    public static int ApplyHomepageImg(String img_name,String org_name){   //申请将社团图片发到首页,返回申请id.
        Object [] obs={img_name,org_name,new Timestamp(System.currentTimeMillis()),0,0};
        String sql ="insert into homepage_img (img_name,org_name,applytime,status,nextdel) values(?,?,?,?,?)";
        BaseDao bd=new BaseDao();
        int apply_id=bd.executeUpdate2(sql,obs);
        bd=null;
        return apply_id;
    }

    public static String setHomepageImg(List<Integer> ids){
        String sql;
        try {
            BaseDao bd=new BaseDao();
            sql="update homepage_img set status=?";   //把所有记录的status置0
            Object [] obs={0};
            bd.executeUpdate(sql,obs);
            sql="update homepage_img set status=?,nextdel=? where apply_id=?";  //选择记录,置status和nextdel为1
            int length=(ids.size()>4)?4:ids.size();
            for (int i=0;i<length;i++){
                Object [] obs2={1,1,ids.get(i)};
                bd.executeUpdate(sql,obs2);
            }
            sql="delete from homepage_img where status=? and nextdel=?"; //删除所有status=0且nextdel=1的记录
            Object [] obs3={0,1};
            bd.executeUpdate(sql,obs3);
            bd=null;

        }catch (Exception ex){
            return ex.getMessage() ;
        }
        return "0";

    }
    public static List<homepage_img> getHomepageImgApplyList(int ReqNum){ //返回status为0的记录,按申请时间排序.先申请的在前
        if (ReqNum < 0) {
            System.out.println("ReqNum Error");
            return null;
        }
        List<homepage_img> hplist;
        BaseDao bd = new BaseDao();
        String sql = "select * from homepage_img where status=0";
        hplist=bd.executeQuery(sql,null,homepage_img.class,9,ReqNum,true);
        bd = null;
        return hplist;
    }





    public static List<homepage_img> getHomepageImgList(){ //返回status为1的记录
        String sql =  "select * from homepage_img where status=1";
        List<homepage_img> hplist;
        BaseDao bd=new BaseDao();
        hplist=bd.executeQuery(sql,null,homepage_img.class);
        bd=null;
        return hplist;
    }

    public static int ApplyHomepageNews(int news_id){   //申请将社团新闻发到首页,返回申请id.
        Object [] obs={news_id,new Timestamp(System.currentTimeMillis()),0,0};
        String sql ="insert into homepage_news (news_id,applytime,status,nextdel) values(?,?,?,?)";
        BaseDao bd=new BaseDao();
        int apply_id=bd.executeUpdate2(sql,obs);
        bd=null;
        return apply_id;
    }

    public static int ApplyHomepageNews(int news_id,String org_name){   //申请将社团新闻发到首页,在申请中附上社团名字,返回申请id.
        Object [] obs={news_id,org_name,new Timestamp(System.currentTimeMillis()),0,0};
        String sql ="insert into homepage_news (news_id,org_name,applytime,status,nextdel) values(?,?,?,?,?)";
        BaseDao bd=new BaseDao();
        int apply_id=bd.executeUpdate2(sql,obs);
        bd=null;
        return apply_id;
    }

    public static String setHomepageNews(List<Integer> ids){ //传入一个要上首页的apply_id数组
        String sql;
        try{
            BaseDao bd=new BaseDao();
            sql="update homepage_news set status=?";   //把所有记录的status置0
            Object [] obs={0};
            bd.executeUpdate(sql,obs);
            sql="update homepage_news set status=?,nextdel=? where apply_id=?";  //选择记录,置status和nextdel为1
            int length=(ids.size()>5)?5:ids.size();
            for (int i=0;i<length;i++){
                Object [] obs2={1,1,ids.get(i)};
                bd.executeUpdate(sql,obs2);
            }
            sql="delete from homepage_news where status=? and nextdel=?"; //删除所有status=0且nextdel=1的记录
            Object [] obs3={0,1};
            bd.executeUpdate(sql,obs3);
            bd=null;
        }catch (Exception ex){
            return ex.getMessage();
        }
            return "0";

    }
    public static List<homepage_news> getHomepageNewsApplyList(int ReqNum){ //返回status为0的记录,按申请时间排序.先申请的在前
        if (ReqNum < 0) {
            System.out.println("ReqNum Error");
            return null;
        }
        List<homepage_news> hplist;
        BaseDao bd = new BaseDao();
        String sql = "select apply_id,news_id,org_name,applytime,status,nextdel from homepage_news where status=0";
        hplist=bd.executeQuery(sql,null,homepage_news.class,9,ReqNum,true);
        bd = null;
        return hplist;
    }





    public static List<homepage_news> getHomepageNewsList(){ //返回status为1的记录
        String sql =  "select apply_id,news_id,org_name,applytime,status,nextdel from homepage_news where status=1";
        List<homepage_news> hplist;
        BaseDao bd=new BaseDao();
        hplist=bd.executeQuery(sql,null,homepage_news.class);
        bd=null;
        return hplist;
    }





    public static Img getUserImg(String uid){  //获取个人图片,用处好像就是头像?

        List<Img> imgList;
        BaseDao bd=new BaseDao();
       String sql="select * from img where uid='"+uid+"' order by img_id desc";

        imgList=bd.executeQuery(sql,null,Img.class,9,1,true);
        bd=null;
        if (imgList.isEmpty()) return null;
        return imgList.get(0);

    }




    private static int setImg(String img_name,int org_id){

        Object [] obs={img_name,new Timestamp(System.currentTimeMillis()),org_id};
        String sql ="insert into img (img_name,date,org_id) values(?,?,?)";
        BaseDao bd=new BaseDao();
        int id=bd.executeUpdate2(sql,obs);
        bd=null;
        return id;

    }

    private static int setImg(String img_name,String uid){

        Object [] obs={img_name,new Timestamp(System.currentTimeMillis()),uid};
        String sql ="insert into img (img_id,img_name,date,uid) values(default,?,?,?)";
        BaseDao bd=new BaseDao();
        int id=bd.executeUpdate2(sql,obs);
        return id;

    }

    public static int setCommImg(int org_id,String img_name){
        int img_id=setImg(img_name,org_id);
        return img_id;
    }

    public static int setUserImg(String uid,String img_name){
        int img_id=setImg(img_name,uid);
        if (img_id==-1)return -1;
        return img_id;
    }

    public static List<Video> getVideoFromOrg(int org_id){//按时间倒序返回该社团的Video对象
        List<Video> Ilist;
        BaseDao bd=new BaseDao();
        String sql = "select * from video where video_name like '"+org_id+"%' order by video_id desc";
        Ilist=bd.executeQuery(sql,null,Video.class);
        bd=null;
        return Ilist;
    }
    public static int delNews(int news_id){
        BaseDao bd=new BaseDao();
        String sql="delete from news where news_id=?";
        Object[] obs={news_id};
        return bd.executeUpdate(sql,obs);
    }
    public static int delNotice(int org_id,int noti_id){
        BaseDao bd=new BaseDao();
        String sql="delete from comm_notice where org_id=? and noti_id=?";
        Object[] obs={org_id,noti_id};
        return bd.executeUpdate(sql,obs);
    }
    public static int setCommPortrait(int org_id,int img_id){
        BaseDao bd=new BaseDao();
        Object [] obs={org_id,img_id};
        String sql ="insert into comm_portrait (org_id,img_id) values(?,?)";
        int i=bd.executeUpdate(sql,obs);
        bd=null;
        return i;
    }
   public static Img getCommPortrait(int org_id){
       List<Img> imgList;
       List<comm_portrait>idList;
       BaseDao bd=new BaseDao();
       String sql="select * from comm_portrait where org_id="+org_id;
       idList=bd.executeQuery(sql,null,comm_portrait.class);
       bd=null;
       if (idList.isEmpty()) return null;
       return CommSquare.getImgById(idList.get(0).getImg_id());
   }

    public static  void delOverdueNewsById(int apply_id,int news_id){
       String sql="delete from homepage_news where apply_id=?";
        Object[] obs={apply_id};
        BaseDao bd=new BaseDao();
        bd.executeUpdate(sql,obs);
        bd=null;
        CommSquare.deleteNews(news_id);


    }
    public static  void delOverdueApplyNews(){
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String date = df.format(new java.util.Date());
        String sql="select * from homepage_news where status=0 and date_add(applytime,INTERVAL 15 DAY)<"+"'"+date+"'";
        BaseDao bd=new BaseDao();
        List<homepage_news> homepage_newsList=bd.executeQuery(sql,null,homepage_news.class);
        bd=null;
        for (homepage_news hpn:homepage_newsList
             ) {
            delOverdueNewsById(hpn.getApply_id(),hpn.getNews_id());

        }

    }
    public static  void delOverdueApplyImg(){
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String date = df.format(new java.util.Date());
        String sql="select * from homepage_img where status=0 and date_add(applytime,INTERVAL 15 DAY)<"+"'"+date+"'";
        BaseDao bd=new BaseDao();
        List<homepage_img> homepage_imgList=bd.executeQuery(sql,null,homepage_img.class);
        for (homepage_img hpi:homepage_imgList
                ) {
            sql="delete from homepage_img where apply_id=?";
            Object[] obs={hpi.getApply_id()};
            bd.executeUpdate(sql,obs);

        }
        bd=null;

    }

    public static  void delOverdueApplyVideo(){
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String date = df.format(new java.util.Date());
        String sql="select * from homepage_video where status=0 and date_add(applytime,INTERVAL 15 DAY)<"+"'"+date+"'";
        BaseDao bd=new BaseDao();
        List<homepage_video> homepage_videoList=bd.executeQuery(sql,null,homepage_video.class);
        for (homepage_video hpv:homepage_videoList
                ) {
            sql="delete from homepage_video where apply_id=?";
            Object[] obs={hpv.getApply_id()};
            bd.executeUpdate(sql,obs);

        }
        bd=null;

    }


}
