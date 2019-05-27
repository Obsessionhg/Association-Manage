package wzy.com;

import wzy.com.GZIP.GZIPResponseStream;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletResponseWrapper;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;

public class ResponseWrapper extends HttpServletResponseWrapper {

    private HttpServletResponse response=null;

    private ServletOutputStream outputStream=null;

    private PrintWriter printWriter=null;

    private String encoding=null;

    public ResponseWrapper(HttpServletResponse response){
        super(response);
        this.response=response;
    }
    public ResponseWrapper(HttpServletResponse response,String encoding){
        super(response);
        this.response=response;
        this.encoding=encoding;
    }
    public ServletOutputStream createOutputStream() throws IOException{
        return new GZIPResponseStream(response);
    }

    public void finishResponse(){
        try{
            if(printWriter!=null){
                printWriter.close();
            }else{
                if(outputStream!=null){
                    outputStream.close();
                }
            }
        }catch (IOException e){
            e.printStackTrace();
        }
    }

    @Override
    public void flushBuffer() throws IOException{
        outputStream.flush();
    }

    @Override
    public ServletOutputStream getOutputStream() throws IOException{
        if(printWriter!=null){
            throw new IOException("getWriter()已经被调用");
        }
        if(outputStream==null){
            outputStream=createOutputStream();
        }
        return outputStream;
    }

    @Override
    public PrintWriter getWriter() throws IOException {
        if(printWriter!=null) return printWriter;
        if(outputStream!=null){
            throw new IllegalStateException("getOutputStream()已经被调用");
        }
        outputStream=createOutputStream();
        printWriter=new PrintWriter(new OutputStreamWriter(outputStream,encoding));
        return printWriter;
    }

    //压缩后数据长度有变化，所以不用重写该方法
//    public void setContentLength(int length){}
}
