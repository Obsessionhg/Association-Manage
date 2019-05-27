package action;

import dao.RecDao;
import daoImpl.RecDaoImp;
import entity.Recruitment;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by asus on 2017/7/16.
 */
//@WebServlet(name = "CreateRecServlet")
public class CreateRecServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("创建招新事件");

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date = new Date();
        String now = sdf.format(date);//创建时间
        String org_id = request.getParameter("org_id");
        String rec_title = request.getParameter("rec_title");
        String rec_content = request.getParameter("rec_content");
        RecDao recdao = new RecDaoImp();
        Recruitment rec = new Recruitment();
        rec.setOrg_id(Integer.parseInt(org_id));
        rec.setContent(rec_content);
        rec.setRelease_date(now);
        rec.setRec_title(rec_title);
        rec.setStatus(1);
        rec.setRec_need("0,0,0,0,0,0");
        recdao.addRec(rec);
        request.getRequestDispatcher("recurit-sys.jsp").forward(request,response);
    }
}
