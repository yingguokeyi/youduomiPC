package action.service;

import action.sqlhelper.BillSql;
import cache.ResultPoor;
import com.alibaba.fastjson.JSONObject;
import common.BaseCache;
import common.PropertiesConf;
import common.StringHandler;
import common.Utils;

import java.util.*;

/**
 * Created by 18330 on 2018/11/8.
 */
public class TaskService extends BaseService {

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
            sid = sendObjectCreate(675, status,operator,edit_time,id1);
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
        int sid = sendObjectCreate(676, status,operator,edit_time,id);
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

    public static String findTaskInfo(String id){
        JSONObject json = new JSONObject();
        List<String> list = new ArrayList<>();
        List<String> list2 = new ArrayList<>();
        int sid = sendObject(677,id);
        String result = ResultPoor.getResult(sid);
        String resultJson = StringHandler.getRetString(result);
        JSONObject json1 = JSONObject.parseObject(resultJson.toString());
        String[] imgId = json1.getJSONArray("rs").getJSONObject(0).getString("detailImgIds").split(",");
        int length = imgId.length;
        if(!imgId[0].equals("")&&imgId.length !=0) {
            for (int i = 0; i < imgId.length; i++) {
                int sids = sendObject(678, imgId[i]);
                String results = ResultPoor.getResult(sids);
                String resultJsons = StringHandler.getRetString(results);
                JSONObject jsons = JSONObject.parseObject(resultJsons.toString());
                String imgIds = jsons.getJSONArray("rs").getJSONObject(0).getString("image_path");
                list.add(imgIds);
            }
        }
        String[] imgId2 = json1.getJSONArray("rs").getJSONObject(0).getString("contrastImgIds").split(",");
        int length2 = imgId2.length;
        if(!imgId2[0].equals("")&&imgId2.length !=0) {
            for (int i = 0; i < imgId2.length; i++) {
                int sids2 = sendObject(678, imgId2[i]);
                String results2 = ResultPoor.getResult(sids2);
                String resultJsons2 = StringHandler.getRetString(results2);
                JSONObject jsons2 = JSONObject.parseObject(resultJsons2.toString());
                String imgIds2 = jsons2.getJSONArray("rs").getJSONObject(0).getString("image_path");
                list2.add(imgIds2);
            }
        }
        json.put("success",true);
        json.put("img",list);
        json.put("img2",list2);
        return json.toString();
    }

    public static String getUserTaskInfo(int page,int limit,String user_id,String phone,String status,String start_time,String end_time){
        StringBuffer sql = new StringBuffer();
        sql.append(BillSql.getUserTaskPage_sql);
        if (user_id!=null && !"".equals(user_id) ){
            sql.append(" and p.uploader =").append(user_id);
        }
        if (phone!=null && !"".equals(phone) ){
            sql.append(" and t.phone =").append(phone);
        }
        if (status!=null && !"".equals(status) ){
            sql.append(" and p.status =").append(status);
        }

        if ((start_time != null && !"".equals(start_time)) || (end_time!=null && !"".equals(end_time))) {
            String bDate = Utils.transformToYYMMddHHmmss(start_time);
            String eDate = Utils.transformToYYMMddHHmmss(end_time);
            System.out.println(bDate);
            sql.append(" and p.create_time BETWEEN ").append(bDate).append(" and ").append(eDate);
        }
        sql.append(" ORDER BY p.create_time desc");
        int sid = BaseService.sendObjectBase(9997,sql.toString(),page,limit);
        String result = ResultPoor.getResult(sid);
        String resultJson = StringHandler.getRetString(result);
        return resultJson;
    }

    public static HashMap<String,Object> getUseUploadImg(String id){
        int i = sendObject(1015,id);
        String result = ResultPoor.getResult(i);
        JSONObject userList = JSONObject.parseObject(result);
        JSONObject jsonObject = userList.getJSONObject("result").getJSONArray("rs").getJSONObject(0);
        String remark = jsonObject.getString("remark");

        HashMap<String,Object> map = new HashMap<String,Object>();

        if(!"".equals(remark) && remark != null){
            JSONObject jsStr = JSONObject.parseObject(remark);
            int size1 = jsStr.size();
            List<Object> listAll = new ArrayList<Object>();

            for (int n=1;n<=size1;n++){
                String ids = jsStr.getJSONObject(String.valueOf(n)).getString("ids");
                String substring = ids.substring(1, ids.length() - 1);
                List<String> lis = Arrays.asList(substring.split(","));
                List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
                for (String string : lis) {
                    HashMap<String,Object> resultMap = new HashMap<String,Object>();
                    int sid = sendObject(979, PropertiesConf.IMG_URL_PREFIX,string);
                    String result2 = ResultPoor.getResult(sid);
                    JSONObject imgUrl = JSONObject.parseObject(result2);
                    String image = imgUrl.getJSONObject("result").getJSONArray("rs").getJSONObject(0).getString("image");
                    resultMap.put("image",image);
                    list.add(resultMap);
                }
                listAll.add(list);
            }
            map.put("result",listAll);
            return map;

        }
        return null;
    }

    public static String getUseRexamineImg(String id){
        int sid = sendObject(987, PropertiesConf.IMG_URL_PREFIX,id);
        String res = ResultPoor.getResult(sid);
        return res;
    }


    public static String updateUserTaskStatus(String status,String task_end_time,String refusal_reasons,String id){
        String edit_time= BaseCache.getDateTime();
        String substringTime = String.valueOf(Integer.valueOf(edit_time.substring(0, 6))+1)+"000000";

        int sid = sendObjectCreate(1016,edit_time,substringTime,status,refusal_reasons,id);
        String result = ResultPoor.getResult(sid);
        return result;
    }

}
