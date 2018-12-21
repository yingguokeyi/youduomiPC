package model;

/**
 * @ClassName AccessToken
 * @Description TODO
 * @Author yanhuo
 * @Date 2018/11/7 17:34
 * @Version 1.0
 **/
public class AccessToken {
    private String token;
    private int expiresIn;

    public String getToken() {
        return token;
    }
    public void setToken(String token) {
        this.token = token;
    }
    public int getExpiresIn() {
        return expiresIn;
    }
    public void setExpiresIn(int expiresIn) {
        this.expiresIn = expiresIn;
    }

}
