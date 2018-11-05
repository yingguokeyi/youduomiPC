package action;

import action.service.BaseService;
import action.service.MembersService;
import action.service.NewMemberService;
import action.sqlhelper.MemberSql;
import cache.ResultPoor;
import common.StringHandler;
import servlet.BaseServlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * ypuduomi使用
 * Created by 18330 on 2018/10/4.
 */
@WebServlet(name = "NewMember", urlPatterns = "/newMember")
public class NewMemberAction  extends BaseServlet {

    //会员条件查询
    public String getMemberList(String id,String nick_name, String phone, String status, String member_level,String registration_time, String endDate, String source, String page, String limit) throws Exception {
        int pageI = Integer.valueOf(page);
        int end = Integer.valueOf(limit);
        return NewMemberService.getMemberList(id,nick_name, phone, status,member_level, registration_time, endDate, source, (pageI - 1) * end, end);
    }

    //更新会员状态（禁用，启用）
    public String updateMemberStatus(String status, String id) {
        String res = NewMemberService.updateMemberStatus(status, id);
        return res;
    }

    //删除会员
    public String delNewMemberStatus(String id, String del_status) {
        String res = NewMemberService.delNewMemberStatus(id, del_status);
        return res;
    }

    //更新会员
    public String updateNewMember(String jsonData, String id) {
        String res = NewMemberService.updateNewMember(jsonData, id);
        return res;
    }

    //编辑会员回显
    public String selectNewUpdata(String id) {
        int ids = Integer.valueOf(id);
        return NewMemberService.selectNewUpdata(ids);
    }

    //添加会员
    public String NewMembersAdd(String account_number,String nick_name, String phone, String real_name, String member_level, String vip_start_time, String vip_end_time, String password) {
        String result = NewMemberService.NewMembersAdd(account_number,nick_name, phone, real_name, member_level, vip_start_time, vip_end_time, password);
        return result;
    }


}
