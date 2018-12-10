package action;

import action.service.MembersService;
import servlet.BaseServlet;

import javax.servlet.annotation.WebServlet;

/**
 * @ClassName WXUser
 * @Description TODO
 * @Author yanhuo
 * @Date 2018/11/9 18:36
 * @Version 1.0
 **/
@WebServlet(name = "WXUser", urlPatterns = "/wxUser")
public class WXUser extends BaseServlet{
    /**
     * 获取用户信息
     * @param openid
     * @return
     */
    public String getUserInfo(String openid){
        String wxMember = MembersService.findWxMember(openid);
        return wxMember;
    }
}
