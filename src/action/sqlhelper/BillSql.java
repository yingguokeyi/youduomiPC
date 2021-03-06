package action.sqlhelper;

/**
 * Created by 18330 on 2018/11/8.
 */
public class BillSql {

    public static final String getBillListPage_sql = " select * from ( SELECT b.*, t.wx_nick_name, t.phone FROM youduomi.b_receipts AS b LEFT JOIN youduomi.t_user AS t ON b.user_id = t.id ) f where 1=1 ";
    public static final String getRecommendListPage_sql = " SELECT * FROM ( SELECT r.*, t.wx_nick_name, t.phone FROM youduomi.b_recommend AS r LEFT JOIN youduomi.t_user AS t ON r.user_id = t.id) f WHERE 1 = 1 ";
    public static final String getWithdrawalsListPage_sql = " SELECT * FROM ( SELECT b.*, t.wx_nick_name, t.phone FROM youduomi.b_withdrawals AS b LEFT JOIN youduomi.t_user AS t ON b.user_id = t.id ) f WHERE 1 = 1 ";

    public static final String getUserTaskPage_sql = " SELECT p.*, t.wx_nick_name,t.phone FROM youduomi.b_picture_category AS p LEFT JOIN youduomi.t_user AS t ON p.uploader = t.id WHERE p.source = 1 and p.is_default = 0 ";
}
