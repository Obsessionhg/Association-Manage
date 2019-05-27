package wzy.com;

/**
 * Created by Jayce on 2017/7/14.
 */
import wzy.com.GZIP.GZIPResponseStream;

import java.io.IOException;
import java.net.URLDecoder;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UrlFilter implements Filter {

    public final static String DEFAULT_URI_ENCODE = "UTF-8";

    private FilterConfig config = null;
    private String encode = null;

    @Override
    public void init(FilterConfig config) throws ServletException {
        this.config = config;
        this.encode = config.getInitParameter("DEFAULT_URI_ENCODE");
        if(this.encode == null) {
            this.encode = DEFAULT_URI_ENCODE;
        }
    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse res,
                         FilterChain chain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response=(HttpServletResponse)res;
        String ae=request.getHeader("Accept-Encoding");
        if(request.getMethod().equals("GET")){
            request=new RequestWrapper(request,encode);
        }else{
            request.setCharacterEncoding(encode);
        }
        String uri = request.getRequestURI();
        String ch = URLDecoder.decode(uri, encode);
        if(uri.equals(ch)) {
            if(ae!=null&&ae.toLowerCase().indexOf("gzip")!=-1){
                ResponseWrapper re=new ResponseWrapper(response,encode);
                chain.doFilter(request,re);
                re.finishResponse();
                return;
            }
            chain.doFilter(request, response);
            return;
        }
        ch = ch.substring(request.getContextPath().length());
        config.getServletContext().getRequestDispatcher(ch).forward(request, response);
    }

    @Override
    public void destroy() {
        config = null;
    }
}
