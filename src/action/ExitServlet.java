package action;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Enumeration;

/**
 * Created by asus on 2017/7/16.
 */
@WebServlet(name = "ExitServlet")
public class ExitServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("收到");
        Enumeration em = request.getSession().getAttributeNames();
        while(em.hasMoreElements()){
            request.getSession().removeAttribute(em.nextElement().toString());
        }

        request.getRequestDispatcher("index.jsp").forward(request,response);

    }
}
