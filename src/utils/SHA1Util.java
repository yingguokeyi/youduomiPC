package utils;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * @ClassName SHA1Util
 * @Description TODO
 * @Author yanhuo
 * @Date 2018/11/7 11:19
 * @Version 1.0
 **/
public class SHA1Util {
    /*
     * 注：
     * 1、安全哈希算法（Secure Hash Algorithm）主要适用于数字签名标准 （Digital Signature Standard DSS）里面定义的
     * 数字签名算法（Digital Signature Algorithm DSA）。对于长度小于2^64位的消息，SHA1会产生一个160位的消息摘要。
     * 2、SHA-1与MD5的比较：前者在长度上长32 位；强行攻击有更大的强度
     * 3、MD5输出128bit、SHA1输出160bit、SHA256输出256bit、另外还有SHA244,SHA512，分别输出244bit，512bit
     */

    public static final String ALGORITHM = "SHA1";

    public static byte[] encode(byte[] content){
        try{
            MessageDigest digest = MessageDigest.getInstance(ALGORITHM);
            digest.update(content);
            return digest.digest();
        }catch(NoSuchAlgorithmException e){

        }
        return null;
    }
}
