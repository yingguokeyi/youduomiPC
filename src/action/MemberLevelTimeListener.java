package action;

import action.service.BaseService;
import org.apache.commons.lang3.concurrent.BasicThreadFactory;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ScheduledThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

/**
 * Created by 18330 on 2018/11/13.
 */
public class MemberLevelTimeListener extends BaseService implements ServletContextListener {
    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {
        System.out.println("-------------  contextDestroyed   ----------------");

    }

    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        System.out.println(" -------------   pddTimeListener   ---------------start tme  form  " + LocalDateTime.now());
        executeMemberLevel();
        executeTaskStatus();
    }

    //会员等级定时任务
    public static void executeMemberLevel() {
        ScheduledExecutorService executorService = new ScheduledThreadPoolExecutor(
                1,
                new BasicThreadFactory.Builder().namingPattern("memberLevel-ScheduleReverse-pool-%d").daemon(true).build()
        );

        System.out.println(" -------------   会员等级定时任务   ---------------" + LocalDateTime.now());
        executorService.scheduleAtFixedRate(
                new MemberLevelManager(),
                1000 * 60 * 5,
                1000 * 60 * 5,
                TimeUnit.MILLISECONDS);

    }

    //任务状态定时任务
    public static void executeTaskStatus() {
        ScheduledExecutorService executorService = new ScheduledThreadPoolExecutor(
                1,
                new BasicThreadFactory.Builder().namingPattern("taskStatus-ScheduleReverse-pool-%d").daemon(true).build()
        );

        System.out.println(" -------------   任务状态定时任务   ---------------" + LocalDateTime.now());
        executorService.scheduleAtFixedRate(
                new TaskStatusManager(),
                1000 * 60 * 5,
                1000 * 60 * 5,
                TimeUnit.MILLISECONDS);

    }

    /**
     * 获取指定时间对应的毫秒数
     *
     * @param time "HH:mm:ss"
     * @return
     */
    private static long getTimeMillis(String time) {
        try {
            DateFormat dateFormat = new SimpleDateFormat("yy-MM-dd HH:mm:ss");
            DateFormat dayFormat = new SimpleDateFormat("yy-MM-dd");
            Date curDate = dateFormat.parse(dayFormat.format(new Date()) + " " + time);
            return curDate.getTime();
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
