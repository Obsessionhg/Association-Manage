package action;

import dao.EnterDao;
import dao.RecDao;
import daoImpl.EnterDapImpl;
import daoImpl.RecDaoImp;
import entity.Enter;
import entity.Recruitment;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by asus on 2017/7/13.
 */
//@WebServlet(name = "RecServlet")
public class RecServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String type = request.getParameter("type");//什么操作
        String rec_content =request.getParameter("rec_content");
        String rec_title =request.getParameter("rec_title");
        String rec_id = request.getParameter("rec_id");
        String org_id =request.getParameter("org_id");
        System.out.println(rec_id);
        System.out.println(type);
        int norg_id = Integer.parseInt(org_id);
        int Rec_id = Integer.parseInt(rec_id);
        PrintWriter out = response.getWriter();
        RecDao recdao = new RecDaoImp();
        if(type.equals("delete"))
       {
           System.out.println("第一层");
           // Recruitment rec = new Recruitment();
            //rec.getRec_id();
           if(recdao.queryAllByOrg(norg_id).get(0).getStatus()==0)//已经停止
           {
               System.out.println("第2层");
              if(recdao.deleteRec(Rec_id)==1){
                  System.out.println("第3层");
                  EnterDao enterDao = new EnterDapImpl();
                  enterDao.deleteEnter(Rec_id);
                      out.print("success");//删除成功
                  System.out.println("第4层");

              }
           }
           else if(recdao.queryAllByOrg(norg_id).get(0).getStatus()==1)
           {System.out.println("第5层");
               out.print("fail");//请先停止
               System.out.println("第6层");
           }

        }
//        else if(type.equals("add")) {
//            System.out.println("第一层");
//            if(recdao.queryAllByOrg(norg_id).get(0).getStatus()==0)
//            { System.out.println("第2层");
//                out.print("exist");//存在招新请先删除
//            }
//            else if(recdao.queryAllByOrg(norg_id).get(0).getStatus()==1)
//            { System.out.println("第3层");
//                out.print("exist");//存在招新请先删除
//                System.out.println("第7层");
//            }
//            else {
//                SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
//                Date date = new Date();
//                String now = sdf.format(date);//创建时间
//
//                Recruitment rec = new Recruitment();
//                rec.setOrg_id(norg_id);
//                rec.setContent(rec_content);
//                rec.setRelease_date(now);
//                rec.setRec_title(rec_title);
//                rec.setStatus(1);
//                rec.setRec_need("0,0,0,0,0,0");
//                System.out.println("第4层");
//                if (recdao.addRec(rec) == 1) {
//                    System.out.println("第5层");
//                    out.print("success");//创建成功
//                    System.out.println("成功创建");
//                }
//            }
//        }
          else if(type.equals("stop")) {
            System.out.println("第一层");
            if(recdao.queryAllByOrg(norg_id).get(0).getStatus()==0)//已经停止
            {
                System.out.println("第2层");
                out.print("stopped");//提示已经停止
            }
            else {
                System.out.println("第3层");
                if (recdao.StopRec(Rec_id) == 1)
                {
                    out.print("success");//成功删除
                    System.out.println("成功停止");
                }
                System.out.println("第4层");
            }
        }

    }
}
