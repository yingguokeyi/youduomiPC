package action;

import action.service.BaseService;
import cache.ResultPoor;
import common.BaseCache;

/**
 * Created by 18330 on 2018/12/5.
 */
public class TaskStatusManager  extends BaseService implements Runnable  {
    @Override
    public void run() {
        updateTaskStatus();
    }

    private void updateTaskStatus() {
        String getDate = BaseCache.getTIME();
        String substringDate = getDate.substring(0, 6);
        //后台任务更新过期当天status
        int sid = sendObjectCreate(971, substringDate,getDate);
        String result1 = ResultPoor.getResult(sid);
        System.out.println(result1);
        //用户上传任务更新过期当天status
        sendObjectCreate(1022, substringDate);
        //任务过期status 3
        sendObjectCreate(1023, substringDate);
        //任务更新过期后status
        int i = Integer.parseInt(substringDate);
        int j = i-1;
        int sid2 = sendObjectCreate(972, String.valueOf(j));
        String result2 = ResultPoor.getResult(sid2);
        System.out.println(result2);
    }
}
