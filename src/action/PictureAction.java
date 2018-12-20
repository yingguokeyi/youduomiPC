package action;

import action.service.MembersService;
import action.service.PictureService;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import common.PropertiesConf;
import common.StringHandler;
import servlet.BaseServlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CopyOnWriteArrayList;

import static action.service.BaseService.sendObject;

/**
 * chrysaor使用
 *
 * @author cuiw
 */
@WebServlet(name = "Picture", urlPatterns = "/picture")
public class PictureAction extends BaseServlet {

    /**
     * 查询所有的图片分类
     *
     * @return
     */
    public String getPictureCategoryInfo(String pictureName, String status, String edit_time, String editend_time, String page, String limit) {
        int pageI = (page == null ? 1 : Integer.valueOf(page));
        int limitI = (limit == null ? 10 : Integer.valueOf(limit));
        String res = PictureService.getPictureCategoryInfo(pictureName,status,edit_time,editend_time,(pageI - 1) * limitI, limitI);
        return StringHandler.getRetString(res);

    }

    /**
     * @param request
     * @param categoryName
     * @return
     */
    public String insertPictureCategory(HttpServletRequest request, String categoryName) {
        String res = PictureService.insertPictureCategory(request, categoryName);
        return StringHandler.getRetString(res);
    }

    /**
     * @param id
     * @return
     */
    public String selectPictureCategoryInfo(String id) {
        String res = PictureService.selectPictureCategoryInfo(id);
        return StringHandler.getRetString(res);
    }

    /**
     * @param id
     * @param categoryName
     * @return
     */
    public String updatePictureCategoryInfo(String id, String categoryName) {
        String res = PictureService.updatePictureCategoryInfo(id, categoryName);
        return StringHandler.getRetString(res);
    }

    /**
     *
     * @param pictureName
     * @param status
     * @param edit_time
     * @param editend_time
     * @param page
     * @param limit
     * @return
     */
    public String getPictureInfoList(String pictureName, String status, String edit_time, String editend_time, String page, String limit) {
        int pageI = (page == null ? 1 : Integer.valueOf(page));
        int limitI = (limit == null ? 10 : Integer.valueOf(limit));
        String res = PictureService.getPictureInfoList(pictureName,status,edit_time,editend_time,(pageI - 1) * limitI, limitI);
        return StringHandler.getRetString(res);
    }

    public String getCategoryPicture() {
        Map<String, Object> map = new HashMap<String, Object>();
        String res = PictureService.getCategoryPicture();
        //获取有效的商品来源列表
        JSONArray categorySourceList = StringHandler.getRsOfResult(res);
        map.put("categorySourceList", categorySourceList);
        String outString = JSON.toJSONString(map);
        System.out.println("outString>>>>>>>>>>>>>>>>>>" + outString);
        return outString;
    }

    /**
     *
     * @param request
     * @param categoryId
     * @param imgId
     * @param pictureNameInfos
     * @return
     */
    public String savePictureInfo(HttpServletRequest request,String categoryId,String imgId, String pictureNameInfos) {
        String res = PictureService.savePictureInfo(request,categoryId,imgId, pictureNameInfos);
        return StringHandler.getRetString(res);
    }

    public String updatePictureStatus(String ids,String status,String code){
        String res = PictureService.updatePictureStatus(ids,status,code);
        return StringHandler.getRetString(res);
    }

    /**
     *
     * @param ids
     * @param status
     * @return
     */
    public String deletePictureInfo(String ids,String status,String code){
        String res = PictureService.deletePictureInfo(ids, status,code);
        return StringHandler.getRetString(res);
    }

    /**
     *
     * @param id
     * @param categoryName
     * @param categoryPicture
     * @param showImgIds
     * @return
     */
    public String EditPictureInfo(String id,String categoryName,String categoryPicture,String showImgIds){
        String res = PictureService.EditPictureInfo(id, categoryName, categoryPicture, showImgIds);
        return StringHandler.getRetString(res);
    }

    public String SelectPictureInfo(String id){
        String res = PictureService.SelectPictureInfo(id);
        return StringHandler.getRetString(res);
    }

    /**
     *
     * @param id
     * @return
     */
    public String isCheckPictureCategory(String id){
        String res = PictureService.isCheckPictureCategory(id);
        return StringHandler.getRetString(res);
    }

    /**
     * 删除图片分类
     * @param id
     * @return
     */
    public String deletePictureCategory(String id){
        String res = PictureService.deletePictureCategory(id);
        return StringHandler.getRetString(res);
    }

    public String isDulplicate(String categoryName){
        String res = PictureService.isDulplicate(categoryName);
        return StringHandler.getRetString(res);
    }

    public String saveTask(String jsonString,HttpServletRequest req){
        String s = PictureService.addTask(jsonString, req);
        return StringHandler.getRetString(s);
    }

    public String getUserTaskList(){

        String userTaskList = PictureService.getUserTaskList();
        JSONObject taskJson = JSONObject.parseObject(userTaskList);
        int size = taskJson.getJSONObject("result").getJSONArray("rs").size();
        HashMap<String,Object> resultMapAll = new HashMap<String,Object>();
        List<Map<String,Object>> resultList = new ArrayList<>();
        for (int i=0;i<size;i++){
            HashMap<String,Object> resultMap = new HashMap<String,Object>();
//            String taskImgIds = taskJson.getJSONObject("result").getJSONArray("rs").getJSONObject(i).getString("taskImgIds");
            JSONObject jsonObject = taskJson.getJSONObject("result").getJSONArray("rs").getJSONObject(i);
            String taskImgIds = jsonObject.getString("taskImgIds");
            String id = jsonObject.getString("id");
            String task_id = jsonObject.getString("task_id");
            String category_name = jsonObject.getString("category_name");
            String bonus = jsonObject.getString("bonus");
            String submit_date = jsonObject.getString("submit_date");
            String status = jsonObject.getString("status");
            String remarks = jsonObject.getString("remarks");
            String wx_nick_name = jsonObject.getString("wx_nick_name");

            resultMap.put("id",id);
            resultMap.put("category_name",category_name);
            resultMap.put("task_id",task_id);
            resultMap.put("bonus",bonus);
            resultMap.put("submit_date",submit_date);
            resultMap.put("status",status);
            resultMap.put("remarks",remarks);
            resultMap.put("wx_nick_name",wx_nick_name);
            resultMap.put("taskImgIds",taskImgIds);

            List<Map<String,Object>> imgList = new ArrayList<>();
            if (!"".equals(taskImgIds) && taskImgIds != null){
                String[] arr = taskImgIds.split(",");
                String imgById = null;
                for (String str : arr) {
                    imgById = PictureService.getImgById(str);
                    JSONObject imgJson = JSONObject.parseObject(imgById);
                    int sizeImg = imgJson.getJSONObject("result").getJSONArray("rs").size();
                    HashMap<String,Object> imgMap = new HashMap<String,Object>();
                    String image = imgJson.getJSONObject("result").getJSONArray("rs").getJSONObject(0).getString("image");
                    imgMap.put("image",image);
                    imgList.add(imgMap);
                }
                resultMap.put("imgList",imgList);

            }else{
                resultMap.put("imgList",imgList);
            }
            resultList.add(resultMap);
        }
        resultMapAll.put("res",resultList);
        return creatResult(1, "亲,数据包回来了哦...", resultMapAll).toString();
    }

    public String examineTaskList(String page, String limit, String wx_nick_name,String status,String start_time,String end_time){
        int pageI = Integer.valueOf(page);
        int end = Integer.valueOf(limit);
        return PictureService.examineTaskList((pageI - 1) * end, end, wx_nick_name,status,start_time,end_time);
    }
}
