package action;

import dao.ActiDao;
import daoImpl.ActiDaoImpl;
import entity.Activity;


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
@WebServlet(name = "ActiServlet")
public class ActiServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String act_id = request.getParameter("id");
        String op = request.getParameter("op");
        String org_id = request.getParameter("org_id");
        System.out.print(act_id);
        System.out.print(op);

       // HttpSession session = request.getSession();
       // int org_id =(int)session.getAttribute("");//社团id
        //String op=request.getParameter("op");//获取修改还是删除
        ActiDao actdao = new ActiDaoImpl();
        if(op.equals("delete")) {
            //System.out.println("yes");
            int nAct_id = Integer.parseInt(act_id);
            actdao.deleteActi(nAct_id);
            System.out.print("delete success");
        }
       else if(op.equals("update"))
        {
            String acti_title=request.getParameter("act_title");
            String acti_content=request.getParameter("act_content");
            Activity acti=new Activity();
            int nAct_id = Integer.parseInt(act_id);
            acti.setAct_id(nAct_id);
            acti.setOrg_id(Integer.parseInt(org_id));
            //acti.setAct_date("2017-07-12 20:11");
            acti.setAct_content(acti_content);
            acti.setAct_title(acti_title);
           actdao.update(acti);
            System.out.print("update success");
        }
        else if(op.equals("add"))
        {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date date = new Date();
            String now = sdf.format( date );
            String acti_title=request.getParameter("act_title");
            String acti_content=request.getParameter("act_content");
            Activity acti=new Activity();
            //acti.setAct_id(Act_id);
            acti.setOrg_id(Integer.parseInt(org_id));
            acti.setAct_date(now);//创建时间
            acti.setAct_content(acti_content);
            acti.setAct_title(acti_title);
            actdao.addActi(acti);
            System.out.print("add success");
        }
        request.getRequestDispatcher("activity.jsp?org_id="+Integer.parseInt(org_id)).forward(request,response);
    }
}
