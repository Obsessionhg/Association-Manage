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
import java.io.PrintWriter;
import java.util.Date;

/**
 * Created by asus on 2017/7/13.
 */
@WebServlet(name = "RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserDao udao=new UserDaoImpl();
        String uid=request.getParameter("uid");
        String name=request.getParameter("name");
        String pwd = request.getParameter("password");
        //String enpwd = udao.MD5(pwd);
        String sex=request.getParameter("sex");
        String birth=request.getParameter("birth");

        String code=request.getParameter("validateCode");

        PrintWriter out=response.getWriter();
        HttpSession session = request.getSession();
        String validateCode=(String)session.getAttribute("validateCode");
        Date date=(Date)session.getAttribute("validateTime");
        if(date==null){

            System.out.println("用户"+uid+","+name+",性别"+sex+"  认证失败");
            String script = "<script>alert('注册失败请重新注册');location.href='register.jsp'</script>";
            response.setContentType("text/html;charset=utf-8");
            out.println(script);
            return;
        }
        Date now=new Date();
        long interval=now.getTime()-date.getTime();
        if(interval>300000){

            System.out.println("用户"+uid+","+name+",性别"+sex+"  认证失败");
            String script = "<script>alert('注册失败请重新注册');location.href='register.jsp'</script>";
            response.setContentType("text/html;charset=utf-8");
            out.println(script);
            return;
        }
        if(!code.trim().equals(validateCode)){

            System.out.println("用户"+uid+","+name+",性别"+sex+"  认证失败");
            String script = "<script>alert('注册失败请重新注册');location.href='register.jsp'</script>";
            response.setContentType("text/html;charset=utf-8");
            out.println(script);
            return;
        }
        System.out.println("用户"+uid+","+name+",性别"+sex+"  认证成功");
        User user = new User();
        user.setUid(uid);
        user.setUname(name);
        user.setUpwd(pwd);
        user.setSex(sex);
        user.setBirth(birth);

        int row = udao.addUser(user);
        if(row==1){
            session.setAttribute("uid",uid);
            request.getRequestDispatcher("club-square.jsp").forward(request,response);
        }
        else{
            String script = "<script>alert('注册失败请重新注册');location.href='register.jsp'</script>";
            response.setContentType("text/html;charset=utf-8");
            response.getWriter().println(script);
        }
    }
}
