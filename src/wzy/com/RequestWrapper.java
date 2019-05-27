package wzy.com;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;

public class RequestWrapper extends HttpServletRequestWrapper {

    private String encoding;

    public RequestWrapper(HttpServletRequest request) {
        super(request);
    }

    public RequestWrapper(HttpServletRequest request,String encoding){
        super(request);
        this.encoding=encoding;
    }

    @Override
    public String getParameter(String name) {
        String value=getRequest().getParameter(name);
        try{
            if(value!=null&&!value.equals("")){
                value=new String(value.getBytes("ISO-8859-1"),encoding);
            }
        }catch (UnsupportedEncodingException e){
            System.out.println("请求封装器不支持该编码");
            e.printStackTrace();
        }
        return value;
    }
}
