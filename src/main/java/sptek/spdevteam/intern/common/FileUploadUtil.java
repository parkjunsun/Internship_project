package sptek.spdevteam.intern.common;


import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

public class FileUploadUtil {

    private final MultipartFile multipartFile;
    private final String uploadFilePath;

    public FileUploadUtil(MultipartFile multipartFile, String uploadFilePath) {
        this.multipartFile = multipartFile;
        this.uploadFilePath = uploadFilePath;
    }

    public String getExtension() {
        return multipartFile.getOriginalFilename().substring(multipartFile.getOriginalFilename().lastIndexOf(".") + 1);
    }

    public String getFileName() {
        return multipartFile.getOriginalFilename();
    }

    public String getEncFileName() {
        return UUID.randomUUID().toString();
    }

    public long getSize() {
        return multipartFile.getSize();
    }


    public String getPath(String encFileName) {
        String extension = getExtension();
        return uploadFilePath + encFileName + '.' + extension;
    }

    public void UploadImage(String encFileName) throws IOException {
        String pathName = getPath(encFileName);
        File dest = new File(pathName);
        dest.setWritable(true);
        dest.setReadable(true); 

        multipartFile.transferTo(dest);
    }

}
