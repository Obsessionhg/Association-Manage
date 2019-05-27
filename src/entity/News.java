package entity;


import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 * Created by Jayce on 2017/7/11.
 */
public class News {

    private int news_id;
    private int org_id;
    private String news_title;
    private String news_content=null;
    private String news_date;






    public int getNews_id(){
        return this.news_id;
    }
    public int getOrg_id(){
        return this.org_id;
    }
    public String getNews_title(){
        return this.news_title;
    }
    public String getNews_content(){
        return this.news_content;
    }
    public String getNews_date(){
        return  this.news_date;
    }


    public void showNews(){//test
        System.out.println("");

        System.out.println(news_id);
        System.out.println(org_id);
        System.out.println(news_title);
        System.out.println(news_content);
        System.out.println(news_date);
    }
}
