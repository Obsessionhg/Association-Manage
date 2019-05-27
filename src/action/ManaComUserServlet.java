package action;

import dao.ComUserDao;
import dao.CommuDao;
import dao.UserDao;
import daoImpl.ComUserDaoImpl;
import daoImpl.CommuDaoImpl;
import daoImpl.UserDaoImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Created by asus on 2017/7/14.
 */

/**
 * 人员信息
 * 管理成员
 *
 */
@WebServlet(name = "ManaComUserServlet")
public class ManaComUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String type = request.getParameter("type");
        String id = request.getParameter("id");
        String org_id = request.getParameter("org_id");
        String position = request.getParameter("position");
        ComUserDao comuserdao = new ComUserDaoImpl();
        PrintWriter out = response.getWriter();

        if(type.equals("add")){
            if(comuserdao.queryUserByOrgUid(Integer.parseInt(org_id),id).size()!=0)
            {
                out.print("duplicated");
            }
            else{
                UserDao userdao = new UserDaoImpl();
                if(userdao.queryExist(id).size()==0) {
                    System.out.println("nexist");
                    out.print("nexist");
                }
                else{
                    if(comuserdao.addComUser(Integer.parseInt(org_id),id)==1)
                        out.print("success");
                }
            }
        }
        else if(type.equals("delete")){
            String[] uids=id.split(",");
            String cur_uid;
            for(int i=0;i<uids.length;i++) {
                cur_uid=uids[i];
                if (comuserdao.queryUserByOrgUid(Integer.parseInt(org_id), cur_uid).size() != 0) {
                    System.out.println("=====delete=======");
                    System.out.println("type:" + type);
                    System.out.println("uid:" + cur_uid);
                    System.out.println("org_id:" + org_id);

                    comuserdao.deleteComUser(Integer.parseInt(org_id), cur_uid);
                    out.print("success");
                } else {

                    out.print("duplicated");
                }
            }
        }
        else if(type.equals("update")){
            comuserdao.updatePosition(Integer.parseInt(org_id),id,position);
            if(request.getParameter("leader").equals("1")) {
                comuserdao.updatePosition(Integer.parseInt(org_id),id,"社长");
                comuserdao.updateManaPri(Integer.parseInt(org_id), id,1);
                comuserdao.updateNotiPri(Integer.parseInt(org_id), id,1);
                comuserdao.updateActiaPri(Integer.parseInt(org_id), id,1);
                HttpSession session = request.getSession();
                String uid = (String)session.getAttribute("uid");
                comuserdao.updatePosition(Integer.parseInt(org_id),uid,"普通");
                comuserdao.updateManaPri(Integer.parseInt(org_id), uid,0);
                comuserdao.updateNotiPri(Integer.parseInt(org_id), uid,0);
                comuserdao.updateActiaPri(Integer.parseInt(org_id), uid,0);
            }
            else {
               String priMana = request.getParameter("priManaUser");
                comuserdao.updateManaPri(Integer.parseInt(org_id), id,Integer.parseInt(priMana));
                String priNoNews = request.getParameter("priNoNews");
                comuserdao.updateNotiPri(Integer.parseInt(org_id), id,Integer.parseInt(priNoNews));
                String priActi = request.getParameter("priActi");
                comuserdao.updateActiaPri(Integer.parseInt(org_id), id,Integer.parseInt(priActi));
            }
            out.print("success");
        }
    }
}
