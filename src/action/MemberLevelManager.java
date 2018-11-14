package action;

import action.service.BaseService;
import cache.ResultPoor;
import com.alibaba.fastjson.JSONObject;
import common.BaseCache;
import common.StringHandler;

/**
 * Created by 18330 on 2018/11/13.
 */
public class MemberLevelManager extends BaseService implements Runnable  {
    @Override
    public void run() {
        updateMemberLevel();
    }

    public void updateMemberLevel(){

        String new_time= BaseCache.getDateTime();

        int sid = sendObject(948, new_time);
        String result = ResultPoor.getResult(sid);
        String resultJson = StringHandler.getRetString(result);
        JSONObject json = JSONObject.parseObject(resultJson.toString());
        int size = json.getJSONArray("rs").size();
        for (int i=0;i<size;i++){
            JSONObject jsonObject = json.getJSONArray("rs").getJSONObject(i);
            String id = jsonObject.getString("id");
            int sid1 = sendObjectCreate(949, 1,id);
            String result1 = ResultPoor.getResult(sid1);
            System.out.println(result1);

        }



    }
}
