package sptek.spdevteam.intern.common;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class LogUtil {

    private Logger log = null;

    public LogUtil() {
        this.log = LoggerFactory.getLogger(this.getClass());
    }

    public LogUtil(Class clazz) {
        if (clazz == null) {
            this.log = LoggerFactory.getLogger(this.getClass());
        } else {
            this.log = LoggerFactory.getLogger(clazz);
        }
    }

    public void page(String msg, String function) {
        this.log.info("\t## [PAGE] - url : " + msg + ", function : " + function + " ##");
    }

    public void service(String service,String method) {
        this.log.info("\t## [SERVICE] - ServiceName : " + service + ", Method : " + method + " ##");
    }

    public void proc(String msg) {
        if (this.log.isDebugEnabled()) {
            this.log.debug("\t## [PROC] - " + msg + " ##");
        }
    }

    public void param(String msg) {
        if (this.log.isDebugEnabled()) {
            this.log.debug("\t## [P] - " + msg + " ##");
        }
    }

    public void info(String msg) {
        if (this.log.isDebugEnabled()) {
            this.log.debug("\t## [INFO] - " + msg + " ##");
        }
    }

    public void debug(String msg) {
        if (this.log.isDebugEnabled()) {
            this.log.debug("\t## [DEBUG] - " + msg + " ##");
        }
    }

    public void err(String msg, Throwable e) {

        this.log.error("\t## [ERROR] - " + msg + " ##");
        this.log.error("\t######### ERROR START ##########");

        if (this.log.isErrorEnabled()) {
            for (int i = 0; i < e.getStackTrace().length; i++) {
                this.log.error(e.getStackTrace()[i] + " LOG ::" + e.toString());
            }
        }

        this.log.error("\t######### ERROR END ##########");
    }
}
