package wzy.com;

import wzy.CommunitySquare.CommSquare;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Jayce on 2017/7/20.
 */
public class VideoExaServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String [] ids=  request.getParameterValues("examination_video");
        List<Integer> idlist=new ArrayList<Integer>();
        for (String id:ids
                ) {
            idlist.add(Integer.parseInt(id));
        }
        String result=null;
        result= CommSquare.setHomepageVideo(idlist);
        CommSquare.delOverdueApplyVideo();
        if (result.equals("0")){
           response.sendRedirect("/admin.jsp");
          //  request.getRequestDispatcher("/admin.jsp").forward(request,response);
        }else {
            PrintWriter out= response.getWriter();
            out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
            out.println("<HTML>");
            out.println(" <HEAD><TITLE>设置出错</TITLE></HEAD>");
            out.println(" <BODY>");
            out.print("<p>");
            out.print(result);
            out.print("</p>");
            out.println(" </BODY>");
            out.println("</HTML>");
            out.close();
        }
    }
}
