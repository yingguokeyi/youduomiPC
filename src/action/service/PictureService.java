package action.service;

import cache.ResultPoor;
import com.alibaba.fastjson.JSONObject;
import common.BaseCache;
import common.PropertiesConf;
import common.StringHandler;
import common.Utils;

import javax.servlet.http.HttpServletRequest;

/**
 * @author cuiw
 * @decription cuiw
 */

public class PictureService extends BaseService{
    /**
     *
     * @return
     */
    public static String getPictureCategoryInfo(String pictureName, String status, String edit_time, String editend_time, int begin, int end){
        StringBuffer sql = new StringBuffer();
        //查询条件
        if (pictureName != null && !pictureName.equals("")) {
            sql.append(" AND p.category_name LIKE '%").append(pictureName).append("%'");
        }
        if (status != null && !status.equals("")) {
            sql.append(" AND p.status = '").append(status).append("'");
        }
        if (edit_time != null && !"".equals(edit_time)) {
            String created_date1 = Utils.transformToYYMMddHHmmss(edit_time);
            sql.append(" and p.create_time between '").append(created_date1).append("'");
        }
        if (editend_time != null && !"".equals(editend_time)) {
            String created_date1 = Utils.transformToYYMMddHHmmss(editend_time);
            sql.append(" and '").append(created_date1).append("'");
        }

        sql.append(" order by create_time desc ");
        int sid = sendObjectBase(670, sql.toString(),begin,end);
        String res = ResultPoor.getResult(sid);
        return res;
    }

    /**
     *
     * @param request
     * @param categoryName
     * @return
     */
    public static String insertPictureCategory(HttpServletRequest request,String categoryName){
        String createTime = BaseCache.getTIME();
        int userId = StringHandler.getUserId(request);
        int sid = sendObjectCreate(477, categoryName,userId,createTime,createTime);
        String res = ResultPoor.getResult(sid);
        return res;
    }

    /**
     *
     * @param id
     * @return
     */
    public static String selectPictureCategoryInfo(String id){
        int sid = sendObject(478,id);
        String res = ResultPoor.getResult(sid);
        return res;
    }
    
    /**
     *
     * @param id
     * @param categoryName
     * @return
     */
    public static String updatePictureCategoryInfo(String id,String categoryName){
        String updateTime = BaseCache.getTIME();
        int uid = sendObjectCreate(479,categoryName,updateTime,id);
        String res = ResultPoor.getResult(uid);
        return res;
    }

    /**
     * 上传图片列表
     * @return
     */
    public static String getPictureInfoList(String pictureName, String status, String edit_time, String editend_time, int begin, int end){
        StringBuffer sql = new StringBuffer();
        //查询条件
        if (pictureName != null && !pictureName.equals("")) {
            sql.append(" AND p.picture_name LIKE '%").append(pictureName).append("%'");
        }
        if (status != null && !status.equals("")) {
            sql.append(" AND p.status = '").append(status).append("'");
        }
        if (edit_time != null && !"".equals(edit_time)) {
            String created_date1 = Utils.transformToYYMMddHHmmss(edit_time);
            sql.append(" and p.create_time between '").append(created_date1).append("'");
        }
        if (editend_time != null && !"".equals(editend_time)) {
            String created_date1 = Utils.transformToYYMMddHHmmss(editend_time);
            sql.append(" and '").append(created_date1).append("'");
        }

        sql.append(" order by update_time desc ");
        int sid = sendObjectBase(480, sql.toString(), PropertiesConf.IMG_URL_PREFIX,begin,end);
        String res = ResultPoor.getResult(sid);
        return res;
    }

    public static String getCategoryPicture(){
        int sid = sendObject(481);
        String res = ResultPoor.getResult(sid);
        return res;
    }

    /**
     *
     * @param request
     * @param categoryId
     * @param imgId
     * @param pictureNameInfos
     * @return
     */
    public static String savePictureInfo(HttpServletRequest request,String categoryId,String imgId,String pictureNameInfos){
        String[] imgIds = imgId.split(",");
        String[] pictureNames = pictureNameInfos.split(",");
        int userId = StringHandler.getUserId(request);
        String currentTime = BaseCache.getTIME();
        String res = "";
        for (int i = 0; i < imgIds.length; i++){
            int sid = sendObjectCreate(483,pictureNames[i],imgIds[i],"0",userId,currentTime,currentTime,categoryId);
            res = ResultPoor.getResult(sid);
            System.out.println(" --- savePictureInfo --- "+res);
        }
        return res;
    }

    /**
     *
     * @param ids
     * @param status
     * @return
     */
    public static String updatePictureStatus(String ids,String status,String code){
        String result = null;
        if("0".equals(code)){
            String[] arr = ids.split(",");
            int sid = 0;
            for (String id : arr) {
                sid = sendObjectCreate(671, status, id);
            }
            result = ResultPoor.getResult(sid);
        }else {
            String[] arr = ids.split(",");
            int sid = 0;
            for (String id : arr) {
                sid = sendObjectCreate(484, status, id);
            }
            result = ResultPoor.getResult(sid);
        }
        return result;
    }

    /**
     * 逻辑删除
     * @param ids
     * @param status
     * @return
     */
    public static String deletePictureInfo(String ids,String status,String code){
        String result = null;
        if("0".equals(code)){
            String[] arr = ids.split(",");
            int sid = 0;
            for (String id : arr) {
                sid = sendObjectCreate(672,status, id);
            }
             result = ResultPoor.getResult(sid);
        }else {
            String[] arr = ids.split(",");
            int sid = 0;
            for (String id : arr) {
                sid = sendObjectCreate(485, status, id);
            }
            result = ResultPoor.getResult(sid);
        }
        return result;
    }

    /**
     *
     * @param id
     * @return
     */
    public static String SelectPictureInfo(String id){
        int sid = sendObject(486,PropertiesConf.IMG_URL_PREFIX, id);
        String res = ResultPoor.getResult(sid);
        return res;
    }

    /**
     *
     * @param id
     * @param categoryName
     * @param categoryPicture
     * @param showImgIds
     * @return
     */
    public static String EditPictureInfo(String id,String categoryName,String categoryPicture,String showImgIds){
        int uid = sendObjectCreate(487,categoryPicture.trim(),categoryName.trim(),showImgIds,id);
        String res = ResultPoor.getResult(uid);
        return res;
    }

    public static String isCheckPictureCategory(String id){
        int sid = sendObject(488,id);
        String res = ResultPoor.getResult(sid);
        return res;
    }

    public static String deletePictureCategory(String id){
        int uid = sendObjectCreate(489,id);
        String res = ResultPoor.getResult(uid);
        return res;
    }

    public static String isDulplicate(String categoryName){
        int sid = sendObject(490,categoryName);
        String res = ResultPoor.getResult(sid);
        return res;
    }

    //添加任务
    public static String addTask(String jsonString,HttpServletRequest req){
        JSONObject jsonObject = JSONObject.parseObject(jsonString);
        String detail_img_ids = (jsonObject.get("detailImgIds") == null ? "" : (jsonObject.get("detailImgIds").toString()));//详细商品图片
        String category_name = jsonObject.get("task_name").toString();
        String bonus = jsonObject.get("bonus_name").toString();
        String task_url = jsonObject.get("task_url").toString();
        String presell_begintime = jsonObject.get("presell_begintime").toString();
        String presell_endtime = jsonObject.get("presell_endtime").toString();
        String detail = jsonObject.get("detail").toString();
        int userId = StringHandler.getUserId(req);
        String currentTime = BaseCache.getTIME();
        //category_name,link_adress,remark,bonus,uploader,update_time,create_time,`status`,is_default
        int uid = sendObjectCreate(673,category_name,task_url,detail,bonus,String.valueOf(userId),currentTime,currentTime,0,0,presell_begintime,presell_endtime,detail_img_ids);
        String res = ResultPoor.getResult(uid);
        return res;
    }
}