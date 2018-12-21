package model;

/**
 * @ClassName ClickButton
 * @Description 点击型菜单事件
 * @Author yanhuo
 * @Date 2018/11/8 8:58
 * @Version 1.0
 **/
public class ClickButton {
    private String type;
    private String name;
    private String key;

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }
}
