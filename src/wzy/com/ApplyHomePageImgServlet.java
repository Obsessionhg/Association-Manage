package wzy.com;

import entity.Img;
import wzy.CommunitySquare.CommSquare;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import net.sf.json.*;

/**
 * Created by Jayce on 2017/7/22.
 */
public class ApplyHomePageImgServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println(request.getParameter("img_id_array"));

        JSONArray jsonArray=JSONArray.fromObject(request.getParameter("img_id_array"));
        Img temp_img;
        PrintWriter out=response.getWriter();
        for(int i=0;i<jsonArray.size();i++){
//            img_id_array.set(i,Integer.parseInt(temp_string[i]));
            temp_img=CommSquare.getImgById(Integer.parseInt(jsonArray.get(i).toString()));
            System.out.println("=="+temp_img.getImg_name()+"======");
            if(CommSquare.ApplyHomepageImg(temp_img.getImg_name())<0){
                out.write("fail");
            }
        }
        out.write("success");

//        List<Integer> img_idList=null;
//              //获取img_id
//              List<Img> imgList=CommSquare.getImgsFormIdS(img_idList);
//              List<Integer> applyList=new ArrayList<Integer>();//存储提交的applyid，如果servlet不需要返回值可以去掉
//        for (Img img:imgList
//             ) {
//             applyList.add(CommSquare.ApplyHomepageImg(img.getImg_name()))   ;
//        }
//        // 这里加上跳转的代码
    }
}
