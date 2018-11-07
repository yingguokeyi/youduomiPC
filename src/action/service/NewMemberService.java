package action.service;


import action.sqlhelper.MemberSql;
import cache.AioTcpCache;
import cache.ResultPoor;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import common.StringHandler;
import common.Utils;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * chrysaor使用
 * Created by 18330 on 2018/10/4.
 */
public class NewMemberService extends BaseService {

    //根据条件查询会员
    public static String getMemberList(String id,String nick_name,String phone,String status,String member_level,String registration_time1,String endDate ,int page,int limit) throws Exception {
        StringBuffer sql = new StringBuffer();
        sql.append(" select * from youduomi.t_user where 1 = 1 AND ( del_status != 1 OR del_status IS NULL) AND department_id IS NULL");
        if (id != null && !id.equals("")) {
            sql.append(" and id =").append(id);
        }
        if (nick_name != null && !nick_name.equals("")) {
            sql.append(" and nick_name like '%").append(nick_name).append("%'");
        }
        if (phone != null && !phone.equals("")) {
            sql.append(" and phone like '%").append(phone).append("%'");
        }
        if (status != null && !status.equals("")) {
            sql.append(" and status =").append(status);
        }
        if (member_level != null && !member_level.equals("") && !member_level.equals("null")) {
            sql.append(" and member_level =").append(member_level);
        }
        if ((registration_time1 != null && !registration_time1.equals("")) || (endDate!=null && !endDate.equals(""))) {
            String bDate = Utils.transformToYYMMddHHmmss(registration_time1);
            String eDate = Utils.transformToYYMMddHHmmss(endDate);
            System.out.println(bDate);
            sql.append(" and registration_time BETWEEN ").append(bDate).append(" and ").append(eDate);
        }
        sql.append(" GROUP BY id").append(" ORDER BY registration_time DESC");

        int sid = BaseService.sendObjectBase(9997, sql.toString(), page, limit);
        System.out.println("=========================="+sid);
        String retString = StringHandler.getRetString(ResultPoor.getResult(sid));
        return retString;
    }

    //更改会员状态
    public static String updateMemberStatus(String status,String id){
        String[] ids = id.split(",");
        int sid = 0;
        for (String id1 : ids) {
            sid = sendObjectCreate(931, status, id1);
        }
        String result = ResultPoor.getResult(sid);
        return result;
    }

    //逻辑删除会员状态
    public static String delNewMemberStatus(String id ,String del_status){
        String[] ids = id.split(",");
        int sid = 0;
        for (String id1 : ids) {
            sid = sendObjectCreate(929, del_status, id1);
        }
        String result = ResultPoor.getResult(sid);
        return result;
    }

    //更新会员
    public static String updateNewMember(String jsonData,String id){
        System.out.println("=======updata===");
        JSONObject jsonObject = JSONObject.parseObject(jsonData);
        int idInt = Integer.valueOf(id);
        String nick_name =(jsonObject.get("nick_name")==null ?"":jsonObject.get("nick_name").toString());
        String phone = jsonObject.get("phone").toString();
        String real_name = jsonObject.get("real_name").toString();
        int source = (jsonObject.get("source")==null ||"".equals(jsonObject.get("source"))? 3:(Integer.valueOf(jsonObject.get("source").toString())));
        //String birthday = jsonObject.get("birthday").toString();
        String sTime = jsonObject.get("vip_start_time").toString();
        String eTime = jsonObject.get("vip_end_time").toString();
        String account_number = jsonObject.get("account_number").toString();
        int member_level = (jsonObject.get("member_level")==null ||"".equals(jsonObject.get("member_level"))? 1:(Integer.valueOf(jsonObject.get("member_level").toString())));
        //String member_level = jsonObject.get("member_level").toString();
        String password = jsonObject.get("password").toString();
        sendObject(AioTcpCache.gtc, 900,"", password, nick_name);
        int sid = sendObjectCreate(930,nick_name,source,phone,real_name,account_number,member_level,sTime,eTime,idInt );
        String result = ResultPoor.getResult(sid);
        return result;
    }

    //编辑查询用于回显
    public static String selectNewUpdata(int id){
        System.out.println("=======selectUpdata===");
        StringBuffer sql = new StringBuffer();
        sql.append(" SELECT u.id, u.nick_name, u.real_name, u.registration_time, u.member_level, u.parent_user_id, u.account_number, u.Invitation_code, u.`source`, u.memo, u.e_mail, g.login_name, g.`password`, g.sex, u.phone FROM youduomi.t_user u, gaia.t_inf_user g WHERE u.gaia_id = g.id");
        sql.append(" and u.id =").append(id);
        int sid = BaseService.sendObjectBase(9999,sql.toString());
        String result = ResultPoor.getResult(sid);
        String resultJson = StringHandler.getRetString(result);
        return resultJson;
    }

    public static String NewMembersAdd(String account_number,String nick_name, String phone, String real_name, String member_level, String vip_start_time, String vip_end_time,String randomCode){
        System.out.println("===========================service=======");
        int member_levelI = Integer.valueOf(member_level);
        Date date=new Date();
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String date2 = df.format(date);
        String registration_time = Utils.transformToYYMMddHHmmss(date2);
        String bDate = "";
        String eDate = "";
        if("2".equals(member_level)){
            bDate = Utils.transformToYYMMddHHmmss(vip_start_time);
            eDate = Utils.transformToYYMMddHHmmss(vip_end_time);
        }
        String source = "4";
        String status ="1";
        String login_name=nick_name;
        String account_numberI =("".equals(account_number) || account_number ==null ?"":account_number);
        String phoneI =("".equals(phone) || phone ==null ?"":phone);
        int source1 = Integer.parseInt(source);
        int status1 = Integer.parseInt(status);
        int category = 0;
        int sid = sendObjectCreate(928, login_name, phoneI, real_name, account_numberI, member_levelI,registration_time,source1,status1,category,bDate,eDate,randomCode);

        String result = ResultPoor.getResult(sid);
        return result;
    }

}
