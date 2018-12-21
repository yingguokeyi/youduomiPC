package utils;


import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Collections;

/**
 * @ClassName WechatUtil
 * @Description TODO
 * @Author yanhuo
 * @Date 2018/11/7 10:55
 * @Version 1.0
 **/
public class WechatUtil {
    public static String CheckSignature(String str){
        String[] content=str.split("&");
        String signature=content[0].split("=")[1];
        String timestamp=content[2].split("=")[1];
        String nonce=content[3].split("=")[1];
        //第一步中填写的token一致
        String token="wxsxw";

        ArrayList<String> list=new ArrayList<String>();
        list.add(nonce);
        list.add(timestamp);
        list.add(token);

        //字典序排序
        Collections.sort(list);
        //SHA1加密
        String s = list.get(0) + list.get(1) + list.get(2);
        try {
            byte[] bytes = s.getBytes("UTF-8");
            byte[] checksignature = SHA1Util.encode(bytes);
            String ss = byte2hex(checksignature);
            System.out.println("signature>>>"+signature);
            System.out.println("checksignature>>>>"+ss);

            if(ss.equals(signature)){
                return content[1].split("=")[1];
            }
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return null;
    }

    private static String byte2hex(byte[] b) {
        StringBuilder sbDes = new StringBuilder();
        String tmp = null;
        for (int i = 0; i < b.length; i++) {
            tmp = (Integer.toHexString(b[i] & 0xFF));
            if (tmp.length() == 1) {
                sbDes.append("0");
            }
            sbDes.append(tmp);
        }
        return sbDes.toString();
    }

}
