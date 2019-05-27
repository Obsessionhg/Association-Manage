package wzy.com;

import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Created by Jayce on 2017/7/18.
 */
public class AddLayerServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!ServletFileUpload.isMultipartContent(request)) {
            // 如果不是则停止
            PrintWriter writer = response.getWriter();
            writer.println("Error: 表单必须包含 enctype=multipart/form-data");
            writer.flush();
            return;
        }
        String [] relist= LayerImgLoad.upLoad(request,response,false);
        request.setAttribute("message",
                relist[2]);
        request.setAttribute("post_id",
                relist[0]);
        request.setAttribute("layer_id",
                relist[1]);

        // 跳转到 message.jsp
        getServletContext().getRequestDispatcher("/transAddLayer.jsp").forward(
                request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
