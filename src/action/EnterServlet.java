package action;

import dao.EnterDao;
import dao.RecDao;
import daoImpl.EnterDapImpl;
import daoImpl.RecDaoImp;
import entity.Enter;
import entity.Org_user;
import entity.Recruitment;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 * Created by asus on 2017/7/14.
 */
@WebServlet(name = "EnterServlet")
public class EnterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Enter enter = new Enter();
        HttpSession session = request.getSession();
        System.out.println("tiaozhuan");
        String org_id = request.getParameter("org-id");
        String rec_id=request.getParameter("rec-id");
        System.out.println(org_id);
        System.out.println(rec_id);
        System.out.println("tiaozhuan1");
        int norg_id = Integer.parseInt(org_id);
        int nrec_id = Integer.parseInt(rec_id);
        enter.setOrg_id(norg_id);
        enter.setRec_id(nrec_id);
        enter.setUid((String)session.getAttribute("uid"));
        enter.setName( request.getParameter("user-name"));
        String sex=request.getParameter("user-sex");
        enter.setSex(sex==null?"男":sex);
        enter.setGrade( request.getParameter("user-grade"));
        enter.setQq( request.getParameter("user-QQ"));
        enter.setTel( request.getParameter("user-tele"));
        enter.setMail( request.getParameter("user-mail"));
        System.out.println("email"+enter.getMail());
        System.out.println("QQ "+enter.getQq());

        PrintWriter out = response.getWriter();

        EnterDao enterdao = new EnterDapImpl();
//        List<Enter> enters = enterdao.queryExist(nrec_id,enter.getUid());
//        Enter enter1 = enters.get(0);
//        System.out.println(enter1.getUid());
        if(enterdao.queryExist(norg_id,enter.getUid()).size()!=0){
            out.print("duplicated");
            System.out.println("cunzai");
        }
        else {
            System.out.println("bucunzai");
            int change = enterdao.addEnter(enter);
            if(change==1){
                System.out.println("success");
                out.print("success");
            }else out.print("fail");
        }
    }
}
