package wzy.com;

import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Created by Jayce on 2017/7/14.
 */
public class CommImgLoadServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 检测是否为多媒体上传
        System.out.println("=====in post======");
        if (!ServletFileUpload.isMultipartContent(request)) {
            // 如果不是则停止
            System.out.println("=====不是多媒体======");
            PrintWriter writer = response.getWriter();
            writer.println("Error: 表单必须包含 enctype=multipart/form-data");
            writer.flush();
            return;
        }
        String org_id=request.getParameter("org_id");

        request.setAttribute("org_id",org_id);
        int isportrait=Integer.parseInt(request.getParameter("is_portrait"));
        String message=null;
        if (isportrait>0){
            message=FileLoad.upload(request,response);
            System.out.println("====is portrait======");
        }else {
            message= FileLoad.upLoad(request,response,false,true);
        }

        request.setAttribute("message",
                message);

        System.out.println("跳转");
      response.sendRedirect("/releasingNotices.jsp?org_id="+org_id);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
