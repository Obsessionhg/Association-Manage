package daoImpl;

import comm.BaseDao;
import dao.CommuDao;
import entity.Community;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by asus on 2017/7/14.
 */
public class CommuDaoImpl extends BaseDao implements CommuDao {
    public List<Community> queryAllCommu(){
        return executeQuery("select * from community",null,Community.class);
    }
    public List<Community> queryCommuBystat(int stat){
        return executeQuery("select * from community where org_status="+stat,null,Community.class);
    }
    public int addCommu(Community comm){
        Object [] obs={comm.getOrg_intro(),comm.getOrg_name(),comm.getOrg_found_date(),comm.getOrg_status(),comm.getUid()};
        return executeUpdate("insert into community values(default,?,?,?,?,?)", obs );
    }
    public int deleteCommu(int org_id){
        return executeUpdate("delete from community where org_id="+org_id, null );
    }
    public int updateStat(int org_id,int stat){
        return executeUpdate("update community set org_status="+stat+" where org_id="+org_id,null);
    }
    public Community queryCommuByOrg(int org_id){
        List<Community> list =  executeQuery("select * from community where org_id="+org_id,null,Community.class);
        Community community = list.get(0);
        return community;
    }
    public List<Community> queryOrgBykey(String keywd){

            List<Community> list = queryCommuBystat(1);
            // 正则表达式规则
            String regEx = ".*" + keywd + ".*";
            // 编译正则表达式
//            Pattern pattern = Pattern.compile(regEx);
            // 忽略大小写的写法
             Pattern pattern = Pattern.compile(regEx, Pattern.CASE_INSENSITIVE);
            for (int i = 0; i < list.size(); i++) {
                Matcher matcher = pattern.matcher(list.get(i).getOrg_name());
                boolean rs = matcher.find();
                if (!rs) {
                    list.remove(i);
                    i--;
                }
            }
        // 查找字符串中是否有匹配正则表达式的字符/字符串
        return list;
    }
}
