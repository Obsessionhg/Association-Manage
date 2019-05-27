package wzy.com;

import org.apache.commons.fileupload.servlet.ServletFileUpload;
import wzy.CommunitySquare.CommSquare;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Created by Jayce on 2017/7/14.
 */
public class UserImgLoadServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 检测是否为多媒体上传
        System.out.println("=========UserImgLoadServlet======");
        if (!ServletFileUpload.isMultipartContent(request)) {
            // 如果不是则停止
            PrintWriter writer = response.getWriter();
            writer.println("Error: 表单必须包含 enctype=multipart/form-data");
            writer.flush();
            System.out.println("不是多媒体");
            return;
        }
        FileLoad.upLoad(request,response,false,false);
//        request.setAttribute("message",
//                message);
        response.sendRedirect("../personal-info.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
