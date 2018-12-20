package action.sqlhelper;

/**
 * Created by 18330 on 2018/11/8.
 */
public class taskSql {

    public static final String getBillListPage_sql = " select * from ( SELECT b.*, t.wx_nick_name, t.phone FROM youduomi.b_task_list AS b LEFT JOIN youduomi.t_user AS t ON b.user_id = t.id ) f where 1=1 ";
    public static final String getRecommendListPage_sql = " SELECT * FROM ( SELECT r.*, t.wx_nick_name, t.phone FROM youduomi.b_recommend AS r LEFT JOIN youduomi.t_user AS t ON r.user_id = t.id) f WHERE 1 = 1 ";

    public static final String getExamineTaskListPage_sql = " SELECT p.id, t.id AS task_id, p.category_name,p.bonus,t.submit_date,t.`status`,t.remarks,t.taskImgIds,u.wx_nick_name FROM youduomi.b_task_list AS t LEFT JOIN youduomi.b_picture_category AS p ON t.task_id = p.id LEFT JOIN youduomi.t_user AS u ON t.user_id = u.id WHERE t.`status` IN (3, 4, 5) ";

}
