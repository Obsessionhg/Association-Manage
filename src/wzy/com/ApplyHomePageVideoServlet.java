package wzy.com;

import entity.Img;
import entity.Video;
import net.sf.json.JSONArray;
import wzy.CommunitySquare.CommSquare;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Jayce on 2017/7/22.
 */
public class ApplyHomePageVideoServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println(request.getParameter("video_id_array"));

        JSONArray jsonArray=JSONArray.fromObject(request.getParameter("video_id_array"));
        Video temp_video;
        PrintWriter out=response.getWriter();
        for(int i=0;i<jsonArray.size();i++){
//            img_id_array.set(i,Integer.parseInt(temp_string[i]));
            temp_video=CommSquare.getVideoById(Integer.parseInt(jsonArray.get(i).toString()));
            System.out.println("=="+temp_video.getVideo_name()+"======");
            if(CommSquare.ApplyHomepageVideo(temp_video.getVideo_name())<0){
                out.write("fail");
            }
        }
        out.write("success");

//        List<Integer> video_idList=null;  //获取video_id ,要加上代码，我没写
//        List<Video> videoList= CommSquare.getVideosFormIdS(video_idList);
//        List<Integer> applyList=new ArrayList<Integer>();//存储提交的applyid，如果servlet不需要返回值可以去掉
//        for (Video video:videoList
//                ) {
//            applyList.add( CommSquare.ApplyHomepageVideo(video.getVideo_name()));
//        }
//        // 这里加上跳转的代码

        response.setContentType("text/plain");
    }
}
