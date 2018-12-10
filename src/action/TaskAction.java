package action;

import action.service.BillService;
import action.service.TaskService;
import servlet.BaseServlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * Created by 18330 on 2018/11/8.
 */
@WebServlet(name = "Task", urlPatterns = "/task")
public class TaskAction extends BaseServlet {

    private static final long serialVersionUID = 1L;

    //查看会员
    public String getBillList(String page, String limit, String user_id,String phone,String status,String start_time,String end_time) {

        int pageI = Integer.valueOf(page);
        int end = Integer.valueOf(limit);
        return TaskService.getBillList((pageI - 1) * end, end, user_id,phone,status,start_time,end_time);
    }
    //批量修改状态
    public String updateBillStatus(String status, String id,HttpServletRequest request) {
        HttpSession session=request.getSession();
        int userId = Integer.valueOf(session.getAttribute("userId").toString());
        String res = TaskService.updateBillStatus(status, id,userId);
        return res;
    }
    //修改状态
    public String updateBillStatu(String status, String id,HttpServletRequest request) {
        HttpSession session=request.getSession();
        int userId = Integer.valueOf(session.getAttribute("userId").toString());
        String res = TaskService.updateBillStatu(status, id,userId);
        return res;
    }
    //账户明细查询
    public String getRecommendList(String page, String limit, String user_id,String phone,String member_type,String start_time,String end_time) {

        int pageI = Integer.valueOf(page);
        int end = Integer.valueOf(limit);
        return TaskService.getRecommendList((pageI - 1) * end, end, user_id,phone,member_type,start_time,end_time);
    }

    public String getTaskInfo(String id){
        String taskInfo = TaskService.findTaskInfo(id);
        return taskInfo;

    }
}
