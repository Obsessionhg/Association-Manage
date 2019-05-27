package action;

import dao.UserDao;
import daoImpl.UserDaoImpl;
import entity.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Created by asus on 2017/7/13.
 */
@WebServlet(name = "RegisterAction")
public class RegisterAction extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
doPost(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String uid =request.getParameter("uid");
        UserDao udao = new UserDaoImpl();
        PrintWriter out = response.getWriter();
        User u= udao.queryUserByUid(uid);
        if(u!=null){
            out.print("duplicated");
            //已经存在
        }else{
            out.println("success");
            //不存在可以使用
        }
    }
}
