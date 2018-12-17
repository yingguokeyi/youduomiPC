package action.service;

import action.sqlhelper.BillSql;
import cache.ResultPoor;
import common.BaseCache;
import common.PropertiesConf;
import common.StringHandler;
import common.Utils;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.conn.ssl.SSLContexts;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import utils.MD5Util;
import utils.StringUtil;

import javax.net.ssl.SSLContext;
import java.io.File;
import java.io.FileInputStream;
import java.security.KeyStore;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by 18330 on 2018/11/20.
 */
public class WithdrawalsService extends BaseService {

    public static String getWithdrawalsList(int page,int limit, String user_id,String phone,String status,String start_time,String end_time){

        StringBuffer sql = new StringBuffer();
        sql.append(BillSql.getWithdrawalsListPage_sql);
        if (user_id!=null && !"".equals(user_id) ){
            sql.append(" and user_id =").append(user_id);
        }
        if (phone!=null && !"".equals(phone) ){
            sql.append(" and phone =").append(phone);
        }
        if (status!=null && !"".equals(status) ){
            sql.append(" and status =").append(status);
        }

        if ((start_time != null && !"".equals(start_time)) || (end_time!=null && !"".equals(end_time))) {
            String startTime = Utils.transformToYYMMddHHmmss(start_time);
            String endTime = Utils.transformToYYMMddHHmmss(end_time);
            sql.append(" and create_time BETWEEN ").append(startTime).append(" and ").append(endTime);
        }
        sql.append(" ORDER BY create_time desc");
        int sid = BaseService.sendObjectBase(9997,sql.toString(),page,limit);
        String result = ResultPoor.getResult(sid);
        String resultJson = StringHandler.getRetString(result);
        return resultJson;
    }

    public static String updateWithdrawalsStatu(String status,String id,int userId){
        int uId = UserService.checkUserPwdFirstStep(userId);
        String operator = UserService.selectLoginName(uId);
        String edit_time= BaseCache.getDateTime();
//        if("1".equals(status)){
//            recommendRecord(id);
//        }
        int sid = sendObjectCreate(962, status,operator,edit_time,id);
        String result = ResultPoor.getResult(sid);
        return result;
    }

    public static String putWeChatWallet(String partner_trade_no,String openid,String amount,String user_id,String withdrawals_id) throws Exception{

        String appid = "";
        String mch_id = "";
        String nonce_str = StringUtil.getRandomStringByLength(32);

        String certPath = "";
        CloseableHttpClient closeableHttpClient = null;
        try {
            closeableHttpClient = initCert(mch_id, certPath);
        } catch (Exception e) {
            e.printStackTrace();
        }
        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("mch_appid",appid);
        map.put("mchid",mch_id);
        map.put("openid",openid);
        map.put("amount",amount);
        map.put("nonce_str",nonce_str);
        map.put("partner_trade_no",partner_trade_no);
        map.put("check_name","NO_CHECK");
        map.put("desc","提现到微信");
        map.put("spbill_create_ip","10.1.0.19");
        map.put("sign", MD5Util.sign(StringUtil.createLinkString(map),"&key=" + "", "UTF-8").toUpperCase());

        return null;
    }

    private static CloseableHttpClient initCert(String mch_id, String certPath) throws Exception{
        // 证书密码，默认为商户ID
        String key = mch_id;
        // 证书的路径
        String path = certPath;
        // 指定读取证书格式为PKCS12
        KeyStore keyStore = KeyStore.getInstance("PKCS12");
        // 读取本机存放的PKCS12证书文件
        FileInputStream instream = new FileInputStream(new File(path));
        try {
            // 指定PKCS12的密码(商户ID)
            keyStore.load(instream, key.toCharArray());
        } finally {
            instream.close();
        }
        SSLContext sslcontext = SSLContexts.custom().loadKeyMaterial(keyStore, key.toCharArray()).build();
        SSLConnectionSocketFactory sslsf =
                new SSLConnectionSocketFactory(sslcontext, new String[] {"TLSv1"}, null,
                        SSLConnectionSocketFactory.BROWSER_COMPATIBLE_HOSTNAME_VERIFIER);
        return HttpClients.custom().setSSLSocketFactory(sslsf).build();
    }

}
