package action;

import com.sun.media.sound.SF2InstrumentRegion;
import dao.RecDao;
import daoImpl.RecDaoImp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Created by asus on 2017/7/16.
 */
@WebServlet(name = "CreateEnterServlet")
public class CreateEnterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String [] need = request.getParameterValues("need");
        for(int i=0;i<need.length;i++){
            System.out.println(need[i]);
        }
        String org_id = request.getParameter("org_id");
        String rec_id = request.getParameter("rec_id");
        System.out.println("今日招新"+rec_id+org_id);
        int []rec_need ={0,0,0,0,0,0};
        PrintWriter out = response.getWriter();
        for(int i=0;i<need.length;i++){
            rec_need[Integer.parseInt(need[i])]=1;
        }
        String Rec_need= String.valueOf(rec_need[0]);
        Rec_need= Rec_need + ",";
        for(int i=1;i<rec_need.length-1;i++){
            System.out.println(rec_need[i]);
            Rec_need= Rec_need + String.valueOf(rec_need[i]);
            Rec_need= Rec_need + ",";
        }
        Rec_need= Rec_need + String.valueOf(rec_need[5]);
        System.out.println(Rec_need);
        RecDao  recdao = new RecDaoImp();
        recdao.updateRecNeed(Integer.parseInt(rec_id),Rec_need);
        out.println("success");
    }
}
