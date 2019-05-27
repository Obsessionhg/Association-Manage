package action;

import dao.NotiDao;
import daoImpl.NotiDaoImpl;
import entity.Notice;

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
 * Created by asus on 2017/7/13.
 */
@WebServlet(name = "NotiServlet")
public class NotiServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String op = request.getParameter("op");
        String org_id = request.getParameter("org_id");
        System.out.println(op);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date = new Date();
        String now = sdf.format( date );
        System.out.print(now);

        NotiDao notidao = new NotiDaoImpl();
        Notice noti =new Notice();
        if(op.equals("add")){
            String noti_title=request.getParameter("noti_title");
            String noti_content=request.getParameter("noti_content");

           noti.setOrg_id(Integer.parseInt(org_id));
            noti.setNoti_date(now);//创建时间
            noti.setNoti_content(noti_content);
            noti.setNoti_title(noti_title);
            notidao.addNoti(noti);}
        else if (op.equals("delete"))
        {
            String noti_id = request.getParameter("noti_id");
            System.out.println(noti_id);
            notidao.deleteNoti(Integer.parseInt(noti_id));
        }
        request.getRequestDispatcher("message.jsp?org_id="+Integer.parseInt(org_id)).forward(request,response);
    }
}
