package wzy.com;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import wzy.CommunitySquare.CommSquare;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import static wzy.com.FileDel.DelVideo;

/**
 * Created by Jayce on 2017/7/21.
 */
public class DelVideoServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        JSONArray jsonArray=JSONArray.fromObject(request.getParameter("video_id_array"));
        String uploadPath = request.getServletContext().getRealPath("./") + File.separator + "uploadVideo";
        int video_id;
        PrintWriter out = response.getWriter();
        for(int i=0;i<jsonArray.size();i++){
            video_id=Integer.parseInt(jsonArray.get(i).toString());
            System.out.println("@DelVideoServlet video_id= "+video_id);
           if(!DelVideo(video_id,uploadPath).equals("success")){
                out.write(CommSquare.getVideoById(video_id)+" fail");//删一次就调用一次,把video_id改一改,返回的执行信息,成功返回 success
           }else{
               out.write(CommSquare.getVideoById(video_id)+" success");
               System.out.println("删除成功");
           }
        }
//        request.setCharacterEncoding("UTF-8");
//        response.setContentType("text/xml;charset=UTF-8");
//        out.close();
    }
}
