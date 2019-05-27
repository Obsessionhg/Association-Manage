package test;

import comm.BaseDao;
import dao.*;
import daoImpl.*;
import entity.*;
import org.omg.PortableInterceptor.SYSTEM_EXCEPTION;

import java.security.MessageDigest;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by asus on 2017/7/12.
 */
public class testcon {
    public static void main(String arg[]){
//        ComUserDao comuserdao = new ComUserDaoImpl();
//        System.out.println(comuserdao.queryLeaderName(1));
        BaseDao baseDao=new BaseDao();
        baseDao.connection();
    }
}