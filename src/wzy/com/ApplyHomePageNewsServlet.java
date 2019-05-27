package wzy.com;

import entity.News;
import wzy.CommunitySquare.CommSquare;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 * Created by Jayce on 2017/7/22.
 */
public class ApplyHomePageNewsServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
         doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int org_id=Integer.parseInt(request.getParameter("org_id"));   //获取org_id
        String title=request.getParameter("title");//获取title
        String content=request.getParameter("content");//获取内容

        int news_id=CommSquare.setCommNews(org_id,title,content);
        int appy_id=CommSquare.ApplyHomepageNews(news_id,String.valueOf(org_id));

        //  处理跳转的代码。
        PrintWriter out=response.getWriter();
        out.write("success");

    }
}
