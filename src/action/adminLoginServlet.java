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

@WebServlet(name = "adminLoginServlet", value = "/adminLoginServlet")
public class adminLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name =request.getParameter("user-name");
        String pswd = request.getParameter("user-pwd");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession();
        Manager mana=new Manager();
        mana.setMid(name);
        mana.setPassword(pswd);
        System.out.println(mana.getMid());
        System.out.println(mana.getPassword());
        ManagerDao manadao = new ManagerDaoImpl();
        Manager m = manadao.login(mana);
        if(m!=null){
            session.setAttribute("mid", name);
            out.write("success");
        }
        else{
            out.write("fail");
        }
        System.out.println(name);
    }
}
