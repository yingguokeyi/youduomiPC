package utils;

import com.alibaba.fastjson.JSONObject;
import common.PropertiesConf;
import model.AccessToken;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @ClassName WeixinUtil
 * @Description TODO
 * @Author yanhuo
 * @Date 2018/11/7 17:18
 * @Version 1.0
 **/
public class WeixinUtil {
    private static final String APPID="wx6073812b9fefac99";//在基础配置中可查看自己APPID
    private static final String APPSECRET="de4d56256fd9bc292dd3d6b24e050fe7";//在基础配置中可查看自己APPSECRET
    private static final String ACCESS_TOKEN_URL="https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=APPID&secret=APPSECRET";
    private static final String UPLOAD_URL = "https://api.weixin.qq.com/cgi-bin/media/upload?access_token=ACCESS_TOKEN&type=TYPE";
    public static JSONObject doGetStr(String url){
        DefaultHttpClient httpClient = new DefaultHttpClient();
        HttpGet httpGet=new HttpGet(url);
        JSONObject jsonObject = null;
        try {
            HttpResponse response = httpClient.execute(httpGet);
            org.apache.http.HttpEntity entity = response.getEntity();
            if(entity!=null){
                String result = EntityUtils.toString(entity,"UTF-8");
                //jsonObject = JSONObject.fromObject(result);
                jsonObject = JSONObject.parseObject(result);
            }
        } catch (ClientProtocolException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        System.out.println(jsonObject);
        return jsonObject;
    }
    /**
     *
     * @Description: TODO 获取AccessToken
     * @param @return
     * @return AccessToken
     * @throws
     * @author qinhongkun
     * @date 2017-12-18
     */
    public static AccessToken getAccessToken(){
        AccessToken token = new AccessToken();
        String url = ACCESS_TOKEN_URL.replace("APPID", APPID).replace("APPSECRET", APPSECRET);
        JSONObject jsonObject = doGetStr(url);
        if(jsonObject!=null){
            token.setToken(jsonObject.getString("access_token"));
            token.setExpiresIn(jsonObject.getIntValue("expires_in"));
        }
        return token;
    }

    /**
     * 引导用户进行网页授权
     * @param request
     * @param response
     */
    public static void oath(HttpServletRequest request, HttpServletResponse response,String state){
        try {
            String oauth2 = PropertiesConf.WEIXIN_OAUTH2_URL.replace("APPID",APPID).
                    replace("REDIRECT_URI",PropertiesConf.YOUDUOMI_URL+"/wechatService?method=codeTOAccessToken").
                    replace("SCOPE","snsapi_base").replace("STATE",state);
            response.sendRedirect(oauth2);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    public static String codeGetAccessToken(String code){
        //换取access_token 其中包含了openid
        String URL = PropertiesConf.WEIXIN_CODE2ACCESSTOKEN_URL.replace("APPID", APPID).replace("SECRET", APPSECRET).replace("CODE", code);
        //URLConnectionHelper是一个模拟发送http请求的类
        JSONObject jsonObject = doGetStr(URL);
        String openid = jsonObject.get("openid").toString();
        return openid;
    }


}
