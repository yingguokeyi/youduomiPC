package action.service;

import action.sqlhelper.BillSql;
import cache.ResultPoor;
import common.BaseCache;
import common.StringHandler;
import common.Utils;

/**
 * Created by 18330 on 2018/11/20.
 */
public class WithdrawalsService extends BaseService {

    public static String getWithdrawalsList(int page,int limit, String user_id,String phone,String status,String start_time,String end_time){

        StringBuffer sql = new StringBuffer();
        sql.append(BillSql.getWithdrawalsListPage_sql);
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
            String startTime = Utils.transformToYYMMddHHmmss(start_time);
            String endTime = Utils.transformToYYMMddHHmmss(end_time);
            sql.append(" and create_time BETWEEN ").append(startTime).append(" and ").append(endTime);
        }
        sql.append(" ORDER BY create_time desc");
        int sid = BaseService.sendObjectBase(9997,sql.toString(),page,limit);
        String result = ResultPoor.getResult(sid);
        String resultJson = StringHandler.getRetString(result);
        return resultJson;
    }

    public static String updateWithdrawalsStatu(String status,String id,int userId){
        int uId = UserService.checkUserPwdFirstStep(userId);
        String operator = UserService.selectLoginName(uId);
        String edit_time= BaseCache.getDateTime();
//        if("1".equals(status)){
//            recommendRecord(id);
//        }
        int sid = sendObjectCreate(962, status,operator,edit_time,id);
        String result = ResultPoor.getResult(sid);
        return result;
    }

}
