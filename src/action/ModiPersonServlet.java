package action;

import dao.UserDao;
import daoImpl.UserDaoImpl;
import entity.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by asus on 2017/7/21.
 */
//@WebServlet(name = "ModiPersonServlet")
public class ModiPersonServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("修改servlet--ModiPersonServlet");
        HttpSession session = request.getSession();
        String uid =(String) session.getAttribute("uid");
        UserDao userdao = new UserDaoImpl();
        User user = userdao.queryUserByUid(uid);
        String name = request.getParameter("name");
        System.out.println(name);
        String paswd=request.getParameter("paswd");
        System.out.println(paswd);
        String sex = request.getParameter("sex");
        System.out.println(sex);
        String birth = request.getParameter("birth");
        System.out.println(birth);
        if(name!=null&&name!="")
            user.setUname(name);
        if(paswd!=null&&paswd!="")
            user.setUpwd(paswd);
        if(sex!=null&&sex!="")
            user.setSex(sex);
        if(birth!=null&&birth!="")
            user.setBirth(birth);
        userdao.update(user);
        response.sendRedirect("personal-info.jsp");
    }


















}
