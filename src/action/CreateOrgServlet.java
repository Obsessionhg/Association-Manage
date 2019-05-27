package action;

import dao.CommuDao;
import daoImpl.CommuDaoImpl;
import entity.Community;

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
 * Created by asus on 2017/7/16.
 */
@WebServlet(name = "CreateOrgServlet")
public class CreateOrgServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("创建社团");
        HttpSession session = request.getSession();
        String org_name=request.getParameter("club_name");
        String org_content=request.getParameter("club_content");
        String uid=request.getParameter("uid");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date = new Date();
        String now = sdf.format(date);//创建时间
        CommuDao commudao = new CommuDaoImpl();
        Community comm = new Community();
        comm.setOrg_intro(org_content);
        comm.setOrg_name(org_name);
        comm.setOrg_found_date(now);
        comm.setOrg_status("0");
        comm.setUid((String)session.getAttribute("uid"));
        commudao.addCommu(comm);
        String script = "<script>alert('提交申请成功，点击返回回到广场，或者继续申请');location.href='createClub.jsp'</script>";
        response.setContentType("text/html;charset=utf-8");
        response.getWriter().println(script);

    }
}
