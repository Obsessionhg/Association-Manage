package action;

import dao.ComUserDao;
import dao.CommuDao;
import dao.MesDao;
import dao.NotiDao;
import daoImpl.ComUserDaoImpl;
import daoImpl.CommuDaoImpl;
import daoImpl.MesDaoImpl;
import daoImpl.NotiDaoImpl;
import entity.Notice;
import entity.User_Message;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by asus on 2017/7/20.
 */
//@WebServlet(name = "ApplyNoticeServlet")
public class ApplyNoticeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String noti_title=request.getParameter("title");
        String noti_content=request.getParameter("content");
        String type = request.getParameter("type");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date = new Date();
        String now = sdf.format( date );
        Notice noti = new Notice();
        NotiDao notidao = new NotiDaoImpl();
        if(type.equals("add")){
            int org_id = Integer.parseInt(request.getParameter("org_id"));
            noti.setOrg_id(org_id);
            noti.setNoti_date(now);//创建时间
            noti.setNoti_content(noti_content);
            noti.setNoti_title(noti_title);
            notidao.addApplyNoti(noti);
            request.getRequestDispatcher("releasingNotices.jsp?org_id="+org_id).forward(request,response);
        }
        else if(type.equals("agree")){
            String[] noti_id = request.getParameterValues("noti_id");
            User_Message user_mes = new User_Message();
            MesDao mesdao = new MesDaoImpl();
            int[] Nnoti_id = new int[noti_id.length];
            for(int i=0;i<noti_id.length;i++){
                Nnoti_id[i]=Integer.parseInt(noti_id[i]);
                System.out.println("ssssssss"+Nnoti_id[i]+"sssss");
                HttpSession session = request.getSession();
                String uid = (String)session.getAttribute("uid");
                ComUserDao comuserdao = new ComUserDaoImpl();
                String touid = comuserdao.queryLeader(notidao.queryNotiByNoti(Nnoti_id[i]).getOrg_id());
                user_mes.setFrom_uid(uid);
                user_mes.setTo_uid(touid);
                user_mes.setMes_title("公告上首页申请成功");
                String mes_content="您提交申请的"+notidao.queryNotiByNoti(Nnoti_id[i]).getNoti_title()+"公告上首页申请成功";
                user_mes.setMes_content(mes_content);
                SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                Date date1 = new Date();
                String now1 = sdf1.format(date1);//创建时间
                user_mes.setMes_date(now1);
                user_mes.setStat(2);
                user_mes.setType(1);
                mesdao.addMes(user_mes);
            }
            notidao.AgreeApply(Nnoti_id);

            request.getRequestDispatcher("admin.jsp").forward(request,response);
        }
        else if(type.equals("delete")){
            String[] noti_id = request.getParameterValues("noti_id");
            User_Message user_mes = new User_Message();
            int[] Nnoti_id = new int[noti_id.length];
            MesDao mesdao = new MesDaoImpl();
            for(int i=0;i<noti_id.length;i++){
                Nnoti_id[i]=Integer.parseInt(noti_id[i]);
                HttpSession session = request.getSession();
                String uid = (String)session.getAttribute("uid");
                ComUserDao comuserdao = new ComUserDaoImpl();
                String touid = comuserdao.queryLeader(notidao.queryNotiByNoti(Nnoti_id[i]).getOrg_id());
                user_mes.setFrom_uid(uid);
                user_mes.setTo_uid(touid);
                user_mes.setMes_title("公告上首页申请失败");
                String mes_content="您提交申请的"+notidao.queryNotiByNoti(Nnoti_id[i]).getNoti_title()+"公告上首页申请失败";
                user_mes.setMes_content(mes_content);
                SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                Date date1 = new Date();
                String now1 = sdf1.format(date1);//创建时间
                user_mes.setMes_date(now1);
                user_mes.setStat(2);
                user_mes.setType(1);
                mesdao.addMes(user_mes);
            }
            notidao.deleteApplyNoti(Nnoti_id);
            request.getRequestDispatcher("admin.jsp?org_id=").forward(request,response);
        }
    }
}
