package action.service;

import action.sqlhelper.BillSql;
import cache.ResultPoor;
import com.alibaba.fastjson.JSONObject;
import common.BaseCache;
import common.StringHandler;
import common.Utils;

/**
 * Created by 18330 on 2018/11/8.
 */
public class BillService extends BaseService {

    public static String getBillList(int page,int limit,String user_id,String phone,String status,String start_time,String end_time){
        StringBuffer sql = new StringBuffer();
        sql.append(BillSql.getBillListPage_sql);
        if (user_id!=null && !"".equals(user_id) ){
            sql.append(" and user_id =").append(user_id);
        }
        if (phone!=null && !"".equals(phone) ){
            sql.append(" and phone =").append(phone);
        }
        if (status!=null && !"".equals(status) ){
            sql.append(" and status =").append(status);
        }

        if ((start_time != null && !"".equals(start_time)) || (end_time!=null && !"".equals(end_time))) {
            String bDate = Utils.transformToYYMMddHHmmss(start_time);
            String eDate = Utils.transformToYYMMddHHmmss(end_time);
            System.out.println(bDate);
            sql.append(" and create_date BETWEEN ").append(bDate).append(" and ").append(eDate);
        }
        sql.append(" ORDER BY create_date desc");
        int sid = BaseService.sendObjectBase(9997,sql.toString(),page,limit);
        String result = ResultPoor.getResult(sid);
        String resultJson = StringHandler.getRetString(result);
        return resultJson;
    }

    public static String updateBillStatus(String status,String id,int userId){
        int uId = UserService.checkUserPwdFirstStep(userId);
        String operator = UserService.selectLoginName(uId);
        String edit_time= BaseCache.getDateTime();
        String[] ids = id.split(",");
        int sid = 0;
        for (String id1 : ids) {
            sid = sendObjectCreate(943, status,operator,edit_time,id1);
        }
        String result = ResultPoor.getResult(sid);
        return result;
    }

    public static String updateBillStatu(String status,String id,int userId){
        int uId = UserService.checkUserPwdFirstStep(userId);
        String operator = UserService.selectLoginName(uId);
        String edit_time= BaseCache.getDateTime();
        if("1".equals(status)){
            recommendRecord(id);
        }
        int sid = sendObjectCreate(943, status,operator,edit_time,id);
        String result = ResultPoor.getResult(sid);
        return result;
    }

    //推荐奖励计算
    public static void recommendRecord(String id){
        int sid = sendObject(945,id);
        String result = ResultPoor.getResult(sid);
        String resultJson = StringHandler.getRetString(result);
        JSONObject json = JSONObject.parseObject(resultJson.toString());
        String userId = json.getJSONArray("rs").getJSONObject(0).getString("id");
        String member_level = json.getJSONArray("rs").getJSONObject(0).getString("member_level");
        String parent_user_id = json.getJSONArray("rs").getJSONObject(0).getString("parent_user_id");
        String edit_time= BaseCache.getDateTime();



        //有上级邀请人
        if (parent_user_id != null && !"".equals(parent_user_id)){
            int sid2 = sendObject(946,parent_user_id);
            String result2 = ResultPoor.getResult(sid2);
            String resultJson2 = StringHandler.getRetString(result2);
            JSONObject json2 = JSONObject.parseObject(resultJson2.toString());
            String parent_member_level = json2.getJSONArray("rs").getJSONObject(0).getString("member_level");

            int sid3 = sendObject(956,parent_user_id);
            String result3 = ResultPoor.getResult(sid3);
            String resultJson3 = StringHandler.getRetString(result3);
            JSONObject json3 = JSONObject.parseObject(resultJson3.toString());
            int money = Integer.parseInt(json3.getJSONArray("rs").getJSONObject(0).getString("money"));
            int balance =  Integer.parseInt(json3.getJSONArray("rs").getJSONObject(0).getString("balance"));

            //返利获取
            if("1".equals(member_level) && "1".equals(parent_member_level)){
                //下级普通会员 上级普通会员
                String notes1 = "普通会员（"+parent_user_id+"）获得返利：0.05元";
                sendObjectCreate(947, id,parent_user_id, 2, 5, notes1, edit_time);
                sendObjectCreate(957, money+5,balance+5,parent_user_id);

            }else if ("1".equals(member_level) && "2".equals(parent_member_level)){
                //下级普通会员 上级VIP会员
                String notes1 = "VIP会员（"+parent_user_id+"）获得返利：0.10元";
                sendObjectCreate(947, id,parent_user_id, 2, 10, notes1, edit_time);
                sendObjectCreate(957, money+10,balance+10,parent_user_id);

            }else if ("2".equals(member_level) && "1".equals(parent_member_level)){
                //下级VIP会员 上级普通会员
                String notes1 = "普通会员（"+parent_user_id+"）获得返利：0.00元";
                sendObjectCreate(947, id,parent_user_id, 2, 0, notes1, edit_time);

            }else if ("2".equals(member_level) && "2".equals(parent_member_level)){
                //下级VIP会员 上级VIP会员
                String notes1 = "VIP会员（"+parent_user_id+"）获得返利：0.10元";
                sendObjectCreate(947, id,parent_user_id, 2, 10, notes1, edit_time);
                sendObjectCreate(957, money+10,balance+10,parent_user_id);

            }

        }

        int sid4 = sendObject(956,userId);
        String result4 = ResultPoor.getResult(sid4);
        String resultJson4 = StringHandler.getRetString(result4);
        JSONObject json4 = JSONObject.parseObject(resultJson4.toString());
        int money = Integer.parseInt(json4.getJSONArray("rs").getJSONObject(0).getString("money"));
        int balance =  Integer.parseInt(json4.getJSONArray("rs").getJSONObject(0).getString("balance"));

        if("1".equals(member_level)){
            String notes1 = "普通会员（"+userId+"）获得奖励：0.15元";
            sendObjectCreate(947, id,userId, 1, 15, notes1, edit_time);
            sendObjectCreate(957, money+15,balance+15,userId);
        }else if("2".equals(member_level)){
            String notes1 = "普通会员（"+userId+"）获得奖励：0.30元";
            sendObjectCreate(947, id,userId, 1, 30, notes1, edit_time);
            sendObjectCreate(957, money+30,balance+30,userId);
        }
    }

    //账户明细查询
    public static String getRecommendList(int page,int limit,String user_id,String phone,String member_type,String start_time,String end_time){
        StringBuffer sql = new StringBuffer();
        sql.append(BillSql.getRecommendListPage_sql);
        if (user_id!=null && !"".equals(user_id) ){
            sql.append(" and user_id =").append(user_id);
        }
        if (phone!=null && !"".equals(phone) ){
            sql.append(" and phone =").append(phone);
        }
        if (member_type!=null && !"".equals(member_type) ){
            sql.append(" and member_type =").append(member_type);
        }

        if ((start_time != null && !"".equals(start_time)) || (end_time!=null && !"".equals(end_time))) {
            String bDate = Utils.transformToYYMMddHHmmss(start_time);
            String eDate = Utils.transformToYYMMddHHmmss(end_time);
            System.out.println(bDate);
            sql.append(" and edit_time BETWEEN ").append(bDate).append(" and ").append(eDate);
        }
        sql.append(" ORDER BY edit_time desc");
        int sid = BaseService.sendObjectBase(9997,sql.toString(),page,limit);
        String result = ResultPoor.getResult(sid);
        String resultJson = StringHandler.getRetString(result);
        return resultJson;
    }
}
