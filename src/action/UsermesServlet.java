package action;

import dao.MesDao;
import daoImpl.MesDaoImpl;
import entity.User_Message;

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
 * Created by asus on 2017/7/18.
 */

/**
 *
 *站内通信servlet
 *
 */
@WebServlet(name = "UsermesServlet")
public class UsermesServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=utf-8");
        String type=request.getParameter("type");
        System.out.println(type);
        MesDao mesdao = new MesDaoImpl();
        User_Message user_mes=new User_Message();
        PrintWriter out = response.getWriter();
        if(type.equals("send"))
        {
            String from_uid=request.getParameter("from_id");
            String to_uid=request.getParameter("to_id");
            String mes_title=request.getParameter("mes_title");
            String mes_content=request.getParameter("mes_content");
            System.out.println(from_uid);
            System.out.println( to_uid);
            System.out.println(mes_title);
            System.out.println(mes_content);
            user_mes.setFrom_uid(from_uid);
            user_mes.setTo_uid(to_uid);
            user_mes.setMes_title(mes_title);
            user_mes.setMes_content(mes_content);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date date = new Date();
            String now = sdf.format(date);//创建时间
            user_mes.setMes_date(now);
            user_mes.setStat(2);
            user_mes.setType(0);
            mesdao.addMes(user_mes);
            System.out.println("jinlai");
            out.print("success");
            System.out.println("chuqu");
        }
        else if(type.equals("save"))
        {
            String from_uid=request.getParameter("from_id");
            String to_uid=request.getParameter("to_id");
            String mes_title=request.getParameter("mes_title");
            String mes_content=request.getParameter("mes_content");
            user_mes.setFrom_uid(from_uid);
            user_mes.setTo_uid(to_uid);
            user_mes.setMes_title(mes_title);
            user_mes.setMes_content(mes_content);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date date = new Date();
            String now = sdf.format(date);//创建时间
            user_mes.setMes_date(now);
            user_mes.setStat(0);
            user_mes.setType(0);
            mesdao.addMes(user_mes);
            out.print("success");
        }
        else if(type.equals("collect"))
        {
            String uid = request.getParameter("uid");
            String mes_id=request.getParameter("mes_id");
            String from_uid=request.getParameter("from_id");
            String to_uid=request.getParameter("to_id");
            System.out.println(mes_id);
            if(from_uid.equals(uid))
            {
                int collectF=mesdao.querayCollectF(Integer.parseInt(mes_id),uid);
                collectF = -collectF;
                mesdao.changecollect(Integer.parseInt(mes_id),collectF,"collecf");
                out.print("success");
            }
            else if(to_uid.equals(uid))
            {
                int collectT=mesdao.querayCollectT(Integer.parseInt(mes_id),uid);
                collectT = -collectT;
                mesdao.changecollect(Integer.parseInt(mes_id),collectT,"collecT");
                out.print("success");
            }
        }
        else if(type.equals("delete")){
            String[] mes_id=request.getParameterValues("mes_id");
//            String[] items=null;
//            if(mes_id!=null) {
//                items = mes_id.split(",");
//            }
//            for(int i=0;i<items.length;i++){
//                System.out.println(items[i]);
//                mesdao.deleteMes(Integer.parseInt(items[i]));
//            }
            for(int i=0;i<mes_id.length;i++)
            {
                mesdao.deleteMes(Integer.parseInt(mes_id[i]));
            }
            System.out.println(request.getParameter("queryType"));
            request.getRequestDispatcher("innerMessage.jsp?queryType="+request.getParameter("queryType")).forward(request,response);
        }
        else if(type.equals("read")){
            String boxtype = request.getParameter("boxtype");
            String mes_id=request.getParameter("mes_id");
            if(boxtype.equals("receive")) {
                mesdao.Read(Integer.parseInt(mes_id));
            }
        }
        else if(type.equals("multiread")){
            String[] mes_id = request.getParameterValues("mes_id");
            for(int i=0;i<mes_id.length;i++) {
                mesdao.Read(Integer.parseInt(mes_id[i]));
            }
            request.getRequestDispatcher("innerMessage.jsp?queryType="+request.getParameter("queryType")).forward(request,response);
        }
    }
}
