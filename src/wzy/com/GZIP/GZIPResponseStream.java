package wzy.com.GZIP;

import com.sun.xml.internal.ws.policy.privateutil.PolicyUtils;

import javax.servlet.ServletOutputStream;
import javax.servlet.WriteListener;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.zip.GZIPOutputStream;

public class GZIPResponseStream extends ServletOutputStream {
    //将压缩后的数据放入ByteArrayOutputStream对象中
    protected ByteArrayOutputStream byteArrayOutputStream=null;
    //JDK中自带的GZIP压缩类
    protected GZIPOutputStream gzipOutputStream=null;
    protected boolean closed=false;
    protected HttpServletResponse response=null;
    protected ServletOutputStream outputStream=null;

    public GZIPResponseStream(HttpServletResponse response) throws IOException{
        super();
        closed=false;
        this.response=response;
        this.outputStream=response.getOutputStream();
        byteArrayOutputStream=new ByteArrayOutputStream();
        gzipOutputStream=new GZIPOutputStream(byteArrayOutputStream);
    }

    //执行压缩，将数据输出到浏览器
    @Override
    public void close() throws IOException{
        if(closed){
            throw new IOException("输出流已经被关闭");
        }
        //执行压缩
        gzipOutputStream.finish();
        byte[] bytes=byteArrayOutputStream.toByteArray();
        //设置压缩算法为GZIP，浏览器会自动解压数据
        response.addHeader("Content-Length",Integer.toString(bytes.length));
        response.addHeader("Content-Encoding","gzip");

        //输出到浏览器
        outputStream.write(bytes);
        outputStream.flush();
        outputStream.close();
        closed=true;
    }

    @Override
    public void flush() throws IOException{
        if(closed){
            throw new IOException("输出流已关闭，不能被刷新");
        }
        gzipOutputStream.flush();
    }

    @Override
    public void write(int b) throws IOException{
        if(closed){
            throw new IOException("输出流关闭中");
        }
        gzipOutputStream.write((byte)b);
    }

    @Override
    public void write(byte b[]) throws IOException{
        write(b,0,b.length);
    }

    @Override
    public void write(byte b[],int off, int len) throws IOException{
        if(closed){
            throw new IOException("输出流关闭中");
        }
        gzipOutputStream.write(b,off,len);
    }

    public boolean closed(){
        return this.closed;
    }

    @Override
    public boolean isReady() {
        return false;
    }

    @Override
    public void setWriteListener(WriteListener writeListener) {

    }
}
