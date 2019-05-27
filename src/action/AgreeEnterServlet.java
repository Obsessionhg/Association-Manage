package action;

import dao.*;
import daoImpl.*;
import entity.Enter;
import entity.User_Message;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by asus on 2017/7/16.
 */
@WebServlet(name = "AgreeEnterServlet")
public class AgreeEnterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("审核servlet");
        response.setContentType("text/html;charset=utf-8");
        String org_id = request.getParameter("org_id");
        String rec_id = request.getParameter("rec_id");
        String[] uid = request.getParameterValues("uid");
        EnterDao enterdao=new EnterDapImpl();
        ComUserDao comuserdao = new ComUserDaoImpl();
        PrintWriter out = response.getWriter();
        System.out.println(uid[0]);
        CommuDao commudao = new CommuDaoImpl();
        MesDao mesdao =new MesDaoImpl();
        HttpSession session = request.getSession();
        for(int i=0;i<uid.length;i++) {
            User_Message user_mes = new User_Message();
            user_mes.setFrom_uid((String)session.getAttribute("uid"));
            user_mes.setTo_uid(uid[i]);
            user_mes.setMes_title("申请加入社团成功");
            String mes_content="您提交申请的加入"+commudao.queryCommuByOrg(Integer.parseInt(org_id)).getOrg_name()+"社团申请成功";
            user_mes.setMes_content(mes_content);
            SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date date1 = new Date();
            String now1 = sdf1.format(date1);//创建时间
            user_mes.setMes_date(now1);
            user_mes.setStat(2);
            user_mes.setType(1);
            mesdao.addMes(user_mes);
            enterdao.deleteEnterAgree(Integer.parseInt(rec_id), uid[i]);
            if(comuserdao.queryUserByOrgUid(Integer.parseInt(org_id),uid[i]).size()==0)
                   comuserdao.addComUser(Integer.parseInt(org_id),uid[i]);
        }

        request.getRequestDispatcher("recurit-sys.jsp").forward(request,response);
    }
}
