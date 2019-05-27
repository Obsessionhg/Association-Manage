package action;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.Properties;

@WebServlet(name = "subIdentiCode",value = "/subIdentiCode")
public class subIdentiCode extends HttpServlet {

    //创建pro用于保存所需的数据
    public static Properties pro;
    static {
        pro = new Properties();
        pro.setProperty("from", "obsession_hg@163.com");
        pro.setProperty("password", "02716900520mail");
        pro.setProperty("mail.smtp.ssl.enable", "true");
        pro.setProperty("mail.smtp.host", "smtp.163.com");
        pro.setProperty("mail.smtp.port", "465");
        pro.setProperty("mail.smtp.auth", "true");
        pro.setProperty("mail.debug","true");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String emailAddr=request.getParameter("email");
        PrintWriter out=response.getWriter();
        if(emailAddr==null||emailAddr.equals("")){
            out.println("fail");
            return;
        }
        HttpSession httpSession=request.getSession();
        Date date=(Date)httpSession.getAttribute("validateTime");
        if(date!=null){
            Date now=new Date();
            long interval=now.getTime()-date.getTime();
            if(interval<60000){
                out.println("fail");
                return;
            }
        }

        //创建session对象，第一个参数为连接邮件服务器的连接信息，第二个为身份验证的接口，重写抽象方法，参数为登陆邮件服务器的代理账号密码。
        Session session = Session.getDefaultInstance(pro, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(pro.getProperty("from"), pro.getProperty("password"));
            }
        });
        try {
            //创建消息对象
            MimeMessage message = new MimeMessage(session);
            //设置发件人
            message.setFrom(new InternetAddress(pro.getProperty("from")));
            //设置收件人
            message.addRecipients(Message.RecipientType.TO, new InternetAddress[]{new InternetAddress(emailAddr)});
            //设置文本主题
            message.setSubject("社团管理系统注册验证码");

            StringBuffer str=new StringBuffer();
            for(int i=0;i<6;i++){
                int a=(int)(Math.random()*3);
                switch (a){
                    case 0:
                        a=(int)(Math.random()*10)+(int)'0';
                        break;
                    case 1:
                        a=(int)(Math.random()*26)+(int)'A';
                        break;
                    case 2:
                        a=(int)(Math.random()*26)+(int)'a';
                        break;
                }
                str.append((char)a);
            }
            //设置文本内容
            message.setText("验证码为"+str.toString()+",5分钟内有效");
            //使用静态方法发送邮件，此静态方法包装了保存内容，连接服务器等方法。
            Transport.send(message);
            httpSession.setAttribute("validateCode",str.toString());
            httpSession.setAttribute("validateTime",new Date());
            out.println("success");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
