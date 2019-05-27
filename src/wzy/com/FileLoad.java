package wzy.com;

import entity.Img;
import wzy.CommunitySquare.CommSquare;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 * Created by Jayce on 2017/7/14.
 */
public class FileLoad {
    private static final String UPLOAD_DIRECTORY_IMG ="uploadImg";
    private static final String UPLOAD_DIRECTORY_VIDEO ="uploadVideo";

    // 上传配置
    private static final int MEMORY_THRESHOLD   = 1024 * 1024 * 3;  // 3MB
    private static final int MAX_FILE_SIZE      = 1024 * 1024 * 40; // 40MB
    private static final int MAX_REQUEST_SIZE   = 1024 * 1024 * 50; // 50MB

    private static String setFileName (String filename,int org_id){ //按规则重命名文件
        //String prefix=filename.substring(filename.lastIndexOf(".")+1);
        return org_id+"^"+filename;
    }
    private static String  setFileName (String filename,String uid){ //按规则重命名文件
       // String prefix=filename.substring(filename.lastIndexOf(".")+1);
        return uid+"^"+filename;
    }

    public static String upLoad(HttpServletRequest request, HttpServletResponse response,boolean isVideo,boolean isComm){



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
        String uploadPath;
        if (!isVideo){
          uploadPath = request.getServletContext().getRealPath("./") + File.separator + UPLOAD_DIRECTORY_IMG;
        }else {
            uploadPath = request.getServletContext().getRealPath("./") + File.separator + UPLOAD_DIRECTORY_VIDEO;
        }




        // 如果目录不存在则创建
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        try {
            // 解析请求的内容提取文件数据
            @SuppressWarnings("unchecked")
            List<FileItem> formItems = upload.parseRequest(request);

            if (formItems != null && formItems.size() > 0) {
                // 迭代表单数据
                for (FileItem item : formItems) {
                    // 处理不在表单中的字段
                    if (!item.isFormField()) {
                       // String fileName = new File(item.getName()).getName();
                        String fileName=null;
                        int result=-1;
                        //从session获取org_id,uid
                        if (isVideo){
                            if (isComm){
                               // int  org_id =(int) request.getSession().getAttribute("org_id");
                                int org_id=Integer.parseInt((String)request.getAttribute("org_id"));
                                fileName=setFileName(item.getName(),org_id);//设置文件名
                                result= CommSquare.setVideo(org_id,fileName);
                            }else {
                                throw new Exception("添加视频不能用uid参数");
                            }
                        }else {
                            if (isComm){
                                int org_id=Integer.parseInt((String)request.getAttribute("org_id"));
                                fileName=setFileName(item.getName(),org_id);//设置文件名
                                result=CommSquare.setCommImg(org_id,fileName);
                            }else {
                                String uid=(String) request.getSession().getAttribute("uid");
                                fileName=setFileName(item.getName(),uid);//设置文件名
                                FileDel.DelUserImg(uid,uploadPath);
                                result=CommSquare.setUserImg(uid,fileName);
                            }
                        }


                        //插入数据库

                        if (result<1){  throw new Exception(fileName+"数据库插入失败");}        //插入记录失败会抛出异常

                        String filePath = uploadPath + File.separator + fileName;
                        File storeFile = new File(filePath);

                        // 保存文件到硬盘
                        item.write(storeFile);

                        System.out.println(fileName+" 上传成功");
                        if ((!isVideo)&&(!isComm)) break; //头像只能上传一张
                    }
                }

            }
           return "success";
        } catch (Exception ex) {
            /*request.setAttribute("message",
                    "错误信息: " + ex.getMessage());*/
            System.out.println(ex.getMessage());
            return ex.getMessage() ;
        }


    }

    public static String upload(HttpServletRequest request, HttpServletResponse response){//设置社团头像

        DiskFileItemFactory factory = new DiskFileItemFactory();
        factory.setSizeThreshold(MEMORY_THRESHOLD);
        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));
        ServletFileUpload upload = new ServletFileUpload(factory);
        upload.setFileSizeMax(MAX_FILE_SIZE);
        upload.setSizeMax(MAX_REQUEST_SIZE);
        upload.setHeaderEncoding("UTF-8");
        String  uploadPath = request.getServletContext().getRealPath("./") + File.separator + UPLOAD_DIRECTORY_IMG;

        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        try {
            // 解析请求的内容提取文件数据
            @SuppressWarnings("unchecked")
            List<FileItem> formItems = upload.parseRequest(request);

            if (formItems != null && formItems.size() > 0) {
                // 迭代表单数据
                for (FileItem item : formItems) {

                    if (!item.isFormField()) {
                        String fileName=null;
                        Img PreviousImg=null;
                        int result=-1;
                        int org_id=Integer.parseInt((String)request.getAttribute("org_id"));
                        fileName=setFileName(item.getName(),org_id);//设置文件名
                        FileDel.DelCommPortrait(org_id,uploadPath);
                        result=CommSquare.setCommImg(org_id,fileName);
                        System.out.println(result);
                        //插入数据库
                        if (result<1){  throw new Exception(fileName+"数据库插入失败");}        //插入记录失败会抛出异常
                        CommSquare.setCommPortrait(org_id,result);
                        String filePath = uploadPath + File.separator + fileName;
                        File storeFile = new File(filePath);

                        // 保存文件到硬盘
                        item.write(storeFile);

                        System.out.println(fileName+" 上传成功");
                        break; //头像只能上传一张
                    }
                }

            }
            return "success";
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            return ex.getMessage() ;
        }
    }
}
