package action;

import dao.ComUserDao;
import dao.CommuDao;
import dao.MesDao;
import daoImpl.ComUserDaoImpl;
import daoImpl.CommuDaoImpl;
import daoImpl.MesDaoImpl;
import entity.Community;
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
import java.util.List;

/**
 * Created by asus on 2017/7/15.
 */
//@WebServlet(name = "ManaOrgServlet")
public class ManaOrgServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String[] org_id=request.getParameterValues("examination");
        String type = request.getParameter("type");
        CommuDao commudao = new CommuDaoImpl();
        MesDao mesdao = new MesDaoImpl();
        HttpSession session = request.getSession();
        String uid = (String)session.getAttribute("uid");
        System.out.println("进入manaorgservlet");
        System.out.println("===========");
        User_Message user_mes = new User_Message();
        if(type.equals("agree"))
        {
        for(int i=0;i<org_id.length;i++) {
            int norg_id = Integer.parseInt(org_id[i]);
            commudao.updateStat(norg_id,1 );
            Community comm = commudao.queryCommuByOrg(norg_id);
            user_mes.setFrom_uid(uid);
            user_mes.setTo_uid(comm.getUid());
            user_mes.setMes_title("社团申请成功");
            String mes_content="您提交申请的"+comm.getOrg_name()+"社团申请成功";
            user_mes.setMes_content(mes_content);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date date = new Date();
            String now = sdf.format(date);//创建时间
            user_mes.setMes_date(now);
            user_mes.setStat(2);
            user_mes.setType(1);
            mesdao.addMes(user_mes);
            ComUserDao comuserdao = new ComUserDaoImpl();
            comuserdao.addComLeader(norg_id,comm.getUid());
        }}
        else if(type.equals("delete"))
        {
            for(int i=0;i<org_id.length;i++) {
                int norg_id = Integer.parseInt(org_id[i]);

                Community comm = commudao.queryCommuByOrg(norg_id);
                user_mes.setFrom_uid(uid);
                user_mes.setTo_uid(comm.getUid());
                user_mes.setMes_title("社团申请失败");
                String mes_content="您提交申请的"+comm.getOrg_name()+"社团申请失败";
                user_mes.setMes_content(mes_content);
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                Date date = new Date();
                String now = sdf.format(date);//创建时间
                user_mes.setMes_date(now);
                user_mes.setStat(2);
                user_mes.setType(1);
                mesdao.addMes(user_mes);
                commudao.deleteCommu(norg_id);

            }
        }
        request.getRequestDispatcher("admin.jsp").forward(request,response);
    }
}
