package action;

import dao.ManagerDao;
import dao.UserDao;
import daoImpl.ManagerDaoImpl;
import daoImpl.UserDaoImpl;
import entity.Manager;
import entity.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

/**
 * Created by asus on 2017/7/12.
 */
@WebServlet(name = "userLoginServlet")
public class userLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name =request.getParameter("user-name");
        String pswd = request.getParameter("user-pwd");
        System.out.println( name);
        String type = request.getParameter("type");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession();
        User user = new User();
        user.setUid(name);
        user.setUpwd(pswd);
        UserDao dao = new UserDaoImpl();
        User u = dao.login(user);
        System.out.println(u.getUid());
        System.out.println( u.getUname());
        if(u!=null){
            session.setAttribute("uid", name);
            //session.setAttribute("stat", "log");
            out.write("success");
        }else
        {
            out.write("fail");
        }
        System.out.println(name);
    }
}
