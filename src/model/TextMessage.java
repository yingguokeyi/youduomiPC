package model;

/**
 * @ClassName TextMessage
 * @Description TODO
 * @Author yanhuo
 * @Date 2018/11/7 16:36
 * @Version 1.0
 **/
public class TextMessage extends BaseMessage{
    private String Content;
    private String MsgId;

    public String getContent() {
        return Content;
    }
    public void setContent(String content) {
        Content = content;
    }
    public String getMsgId() {
        return MsgId;
    }
    public void setMsgId(String msgId) {
        MsgId = msgId;
    }

}
