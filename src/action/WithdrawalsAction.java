package action;

import action.service.WithdrawalsService;
import servlet.BaseServlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * Created by 18330 on 2018/11/20.
 */
@WebServlet(name = "Withdrawals", urlPatterns = "/withdrawals")
public class WithdrawalsAction extends BaseServlet{

    //查看会员
    public String getWithdrawalsList(String page, String limit, String user_id,String phone,String status,String start_time,String end_time) {

        int pageI = Integer.valueOf(page);
        int end = Integer.valueOf(limit);
        return WithdrawalsService.getWithdrawalsList((pageI - 1) * end, end, user_id,phone,status,start_time,end_time);
    }
    //修改提现状态
    public String updateWithdrawalsStatu(String status, String id,HttpServletRequest request) {
        HttpSession session=request.getSession();
        int userId = Integer.valueOf(session.getAttribute("userId").toString());
        String res = WithdrawalsService.updateWithdrawalsStatu(status, id,userId);
        return res;
    }

}
