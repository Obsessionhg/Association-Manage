package wzy.com;

import comm.BaseDao;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import wzy.CommunitySquare.CommSquare;
import wzy.CommunitySquare.Forum_Ctr;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Jayce on 2017/7/18.
 */
public class LayerImgLoad {
    private static final String UPLOAD_DIRECTORY_ForumIMG ="uploadForumImg";


    // 上传配置
    private static final int MEMORY_THRESHOLD   = 1024 * 1024 * 3;  // 3MB
    private static final int MAX_FILE_SIZE      = 1024 * 1024 * 40; // 40MB
    private static final int MAX_REQUEST_SIZE   = 1024 * 1024 * 50; // 50MB

    private static String setFileName(String filename,int post_id,int layer_id){ //按规则重命名文件
        String prefix=filename.substring(filename.lastIndexOf(".")+1);
        return post_id+"^"+layer_id+"."+prefix;
    }

    public static String[] upLoad(HttpServletRequest request, HttpServletResponse response, boolean creatpost){

        String[] resultlist=new String[3];//第一个是post_id(int),第二是layer_id(int),第三是执行信息(String)
        // 配置上传参数
        DiskFileItemFactory factory = new DiskFileItemFactory();
        // 设置内存临界值 - 超过后将产生临时文件并存储于临时目录中
        factory.setSizeThreshold(MEMORY_THRESHOLD);
        // 设置临时存储目录
        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));

        ServletFileUpload upload = new ServletFileUpload(factory);

        // 设置最大文件上传值
        upload.setFileSizeMax(MAX_FILE_SIZE);

        // 设置最大请求值 (包含文件和表单数据)
        upload.setSizeMax(MAX_REQUEST_SIZE);

        // 中文处理
        upload.setHeaderEncoding("UTF-8");

        // 构造临时路径来存储上传的文件
        // 这个路径相对当前应用的目录
        String uploadPath=request.getServletContext().getRealPath("./") + File.separator + UPLOAD_DIRECTORY_ForumIMG;


        // 如果目录不存在则创建
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        try {
            // 解析请求的内容提取文件数据
            @SuppressWarnings("unchecked")
            List<FileItem> formItems = upload.parseRequest(request);
            String content;
            String title=null;
            int post_id;
            String uid =(String) request.getSession().getAttribute("uid"); //需要uid

            if (!creatpost){
                content=  new String(formItems.get(0).getString().getBytes("iso-8859-1"), "utf-8");
                post_id= Integer.parseInt((String)request.getSession().getAttribute("post_id"));//不是新建帖子则需要通过session拿post_id
            }else {

                title= new String(formItems.get(0).getString().getBytes("iso-8859-1"), "utf-8");
                content= new String(formItems.get(1).getString().getBytes("iso-8859-1"), "utf-8");
                int creatresult=-1;
                creatresult=Forum_Ctr.creatPost(uid,title,content);  //创建帖子,返回post_id
                if (creatresult<1){  throw new Exception("插入forum_post表失败,创建帖子失败");}
                post_id=creatresult;
            }

            int result=-1;
            result= Forum_Ctr.addLayer(post_id,uid,content);
            resultlist[0]=String.valueOf(post_id);
            resultlist[1]=String.valueOf(result);
            if (result<1){  throw new Exception("插入layer表失败");}


            if (formItems != null && formItems.size() > 0) {
                // 迭代表单数据
                for (FileItem item : formItems) {
                    // 处理不在表单中的字段
                    if (!item.isFormField()) {



                        String fileName=setFileName(item.getName(),post_id,result);

                        result=Forum_Ctr.updateImgName(fileName,post_id,result);

                        if (result<1){  throw new Exception(fileName+"更新到layer表失败");}        //抛出异常
                        String filePath = uploadPath + File.separator + fileName;
                        File storeFile = new File(filePath);
                        item.write(storeFile);
                        System.out.println("发布成功");
                        break; //每层只能传一张图片.

                    }
                }

            }
            resultlist[2]="发布成功";
            return resultlist;
        } catch (Exception ex) {
            /*request.setAttribute("message",
                    "错误信息: " + ex.getMessage());*/
            System.out.println(ex.getMessage());
            resultlist[2]=ex.getMessage();
            return  resultlist;
        }






    }
}
