package action;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by wzzz on 2017/7/13.
 */
@WebServlet(name = "testServlet")
public class testServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String script = "<script>alert('用户名或密码错误，请重新登陆');location.href='../web/activity.jsp'</script>";
        response.getWriter().println(script);


    }
}
