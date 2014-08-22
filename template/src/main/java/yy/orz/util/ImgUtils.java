package yy.orz.util;

import org.apache.commons.codec.digest.DigestUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.List;

public class ImgUtils {
    public static final String userDir = (System.getProperty("catalina.home") == null) ? System
            .getProperty("user.dir") : System.getProperty("catalina.home");
    public static final String middleDier = (System
            .getProperty("catalina.home") == null) ? "/src/main/webapp"
            : "/webapps/backoffice";
    public static final String imgPath = userDir + middleDier
            + "/static/giftImg/";
    private static Logger LOGGER = LoggerFactory.getLogger(ImgUtils.class);

    public static String saveFiles(List<MultipartFile> files) {
        StringBuilder ret = new StringBuilder();
        for (MultipartFile f : files) {
            if (f.isEmpty()) {
                continue;
            }
            try {
                String fileName = DigestUtils.md5Hex(f.getInputStream());
                File file = new File(imgPath + fileName);
                if (!file.exists()) {
                    file.createNewFile();
                    f.transferTo(file);
                }
                if (ret.length() > 0) {
                    ret.append(",");
                }
                ret.append(fileName);
            } catch (Exception e) {
                LOGGER.error("err" + e, e);
            }
        }
        return ret.toString();
    }

}
