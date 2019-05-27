package daoImpl;

import comm.BaseDao;
import dao.MesDao;
import dao.UserDao;
import entity.User_Message;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by asus on 2017/7/17.
 */
public class MesDaoImpl extends BaseDao implements MesDao {

    public List<User_Message> ShowReceive(String uid){//需要判断不为0
        return executeQuery("select * from User_message where to_uid='"+uid+"' and stat!=0",null,User_Message.class);
    }
    public List<User_Message> ShowSend(String uid){
        return executeQuery("select * from User_message where from_uid='"+uid+"' and stat!=0",null,User_Message.class);
    }

    public List<User_Message> ShowDraf(String uid){
        return executeQuery("select * from User_message where from_uid='"+uid+"' and stat=0",null,User_Message.class);
    }

    public List<User_Message> showCollect(String uid){
        List<User_Message> list1= executeQuery("select * from User_message where from_uid='"+uid+"' and collecF=1",null,User_Message.class);
        List<User_Message> list2= executeQuery("select * from User_message where to_uid='"+uid+"' and collecT=1",null,User_Message.class);
        List<User_Message> list =new ArrayList();
        if(list1.size()>0) {
            for (int i = 0; i < list1.size(); i++) {
                System.out.println(list1.get(i).getMes_content());
                list.add(list1.get(i));
            }
        }
        if(list2.size()>0) {
            for (int i = 0; i < list2.size(); i++)
                    list.add(list2.get(i));
        }
        return  list;
    }
    public int addMes(User_Message user_mes){
        Object [] obs={user_mes.getFrom_uid(),user_mes.getTo_uid(),user_mes.getMes_title(),user_mes.getMes_content(),user_mes.getMes_date(),user_mes.getStat(),-1,-1,user_mes.getType()};
        return executeUpdate("insert into User_message values(null,?,?,?,?,?,?,?,?,?)", obs);
    }

    public int deleteMes(int mes_id){
        return executeUpdate("delete from User_message where  mes_id="+mes_id,null);
    }
    public int sendDraf(int mes_id){
        return executeUpdate("update User_message set stat=2 where mes_id="+mes_id,null);
    }
    public int Read(int mes_id){
        return executeUpdate("update User_message set stat=1 where  mes_id="+mes_id,null);
    }

    public int changecollect(int mes_id,int collect,String whocollect){
        return executeUpdate("update User_message set "+whocollect+"="+collect+" where mes_id="+mes_id,null);
    }

    public int querayCollectF(int mes_id,String uid){
        List<User_Message> list= executeQuery("select * from User_message where from_uid='"+uid+"' and mes_id="+mes_id,null,User_Message.class);
        User_Message user_mes = list.get(0);
        return user_mes.getCollectF();
    }
    public int querayCollectT(int mes_id,String uid){
        List<User_Message> list= executeQuery("select * from User_message where to_uid='"+uid+"' and mes_id="+mes_id,null,User_Message.class);
        User_Message user_mes = list.get(0);
        return user_mes.getCollectT();
    }
    public int noReadcount(String uid){
        List<User_Message> list =executeQuery("select * from User_message where to_uid='"+uid+"' and stat=2",null,User_Message.class);
        return list.size();
    }
    public String[] rencentUser(String uid){
        connection();
        String[] recentUser={null,null,null,null,null};
        List list = new ArrayList();
        try {
            ps = conn.prepareStatement("select DISTINCT to_uid from (select to_uid,mes_date from user_message where from_uid='"+uid+"' ORDER BY mes_date DESC) s ");
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(rs.getString("to_uid"));
            }
            for(int i=0;i<list.size();i++) {
                if(list.get(i)!=null)
                    recentUser[i] = (String)list.get(i);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {

            free();
        }
        return recentUser;
    }

//    public int cancelCollect(int mes_id){
//        return executeUpdate("update User_message set collect=0 where mes_id="+mes_id,null);
//    }
}
