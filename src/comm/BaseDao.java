package comm;

import java.lang.reflect.Field;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by asus on 2017/7/12.
 */
public class BaseDao {
    private static String driver = "com.mysql.jdbc.Driver";
    private String url = "jdbc:mysql://localhost:3306/group?useUnicode=true&characterEncoding=utf-8";
    private String user = "Obsession";
//    private String pwd = "root";
    private String pwd = "123456";
    public Connection conn = null;
    public PreparedStatement ps = null;
    public ResultSet rs = null;

    static {
        try {
            Class.forName(driver);
            System.out.println("驱动器正确加载");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public void connection() {
        try {
            conn = DriverManager.getConnection(url, user, pwd);
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    public void free() {
        try {
            if (rs != null)
                rs.close();
            if (ps != null)
                ps.close();
            if (conn != null)
                conn.close();
        } catch (Exception e) {
            e.printStackTrace();

        }
    }


    public int executeUpdate(String sql, Object[] para) {
        int row = 0;
        connection();
        try {
            ps = conn.prepareStatement(sql);
            if (para != null && para.length >= 1) {
                for (int i = 0; i < para.length; i++) {
                    ps.setObject((i + 1), para[i]);
                }
            }
            row = ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            {
                free();
            }
        }
        return row;
    }

    public int executeUpdate2(String sql, Object[] para) { //插入自增记录时返回自增id

        connection();
        int autoIncKeyFromApi = -1;
        try {
            ps = conn.prepareStatement(sql,PreparedStatement.RETURN_GENERATED_KEYS);
            if (para != null && para.length >= 1) {
                for (int i = 0; i < para.length; i++) {
                    ps.setObject((i + 1), para[i]);
                }
            }
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                autoIncKeyFromApi = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            {
                free();
            }
        }
        return autoIncKeyFromApi;
    }

    public List executeQuery(String sql, Object[] para, Class cls) {
        List list = new ArrayList();
        connection();
        try {
            ps = conn.prepareStatement(sql);
            if (para != null && para.length > 0) {
                for (int i = 0; i < para.length; i++) {
                    ps.setObject(i + 1, para[i]);
                }
            }
            rs = ps.executeQuery();
            Field[] fields = cls.getDeclaredFields();
            while (rs.next()) {
                Object obj = cls.newInstance();

                for (int i = 0; i < fields.length; i++) {
                    Field field = fields[i];

                    field.setAccessible(true);
                    String fieldname = field.getType().getName();
                    if (fieldname.equals("int")) {
                        field.set(obj, rs.getInt(i + 1));
                    }
                    if (fieldname.equals("java.lang.String")) {
                        field.set(obj, rs.getString(i + 1));
                    }
                    if (fieldname.equals("double")) {
                        field.set(obj, rs.getDouble(i + 1));
                    }
                    if (fieldname.equals("java.util.Date")) {
                        field.set(obj, rs.getDate(i + 1));
                    }


                }
                list.add(obj);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            free();
        }
        return list;
    }
    public List executeQuery(String sql, Object[] para, Class cls,int del,int ReqNum,boolean needContent) {       //del表示不要第几个属性,从0开始.ReqNum表示要取几条记录。
        List list = new ArrayList();
        connection();
        try {
            ps = conn.prepareStatement(sql);
            if (para != null && para.length > 0) {
                for (int i = 0; i < para.length; i++) {
                    ps.setObject(i + 1, para[i]);
                }
            }
            rs = ps.executeQuery();
            Field[] fields = cls.getDeclaredFields();
            int limit;int count=0;
            if (ReqNum==0){
                limit=99999;
            }else {
                limit=ReqNum;
            }

            while ((count<limit)&&(rs.next())) {
                Object obj = cls.newInstance();

                int fieldnum=fields.length;
                if (!needContent) fieldnum--;


                for (int i = 0; i < fieldnum; i++) {
                    Field field;
                    if (i>=del) {
                        field = fields[i+1];
                    }else {
                        field = fields[i];
                    }


                    field.setAccessible(true);
                    String fieldname = field.getType().getName();
                    if (fieldname.equals("int")) {
                        field.set(obj, rs.getInt(i + 1));
                    }
                    if (fieldname.equals("java.lang.String")) {
                        field.set(obj, rs.getString(i + 1));
                    }
                    if (fieldname.equals("double")) {
                        field.set(obj, rs.getDouble(i + 1));
                    }
                    if (fieldname.equals("java.util.Date")) {
                        field.set(obj, rs.getDate(i + 1));
                    }


                }
                list.add(obj);
                count++;
            }



        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            free();
        }
        return list;
    }
}
