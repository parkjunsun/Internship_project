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
        return multipartFile.getOriginalFilename().substring(multipartFile.getOriginalFilename().lastIndexOf(".") + 1, multipartFile.getOriginalFilename().length());
    }

    public String getFileName() {
        String originalFilename = multipartFile.getOriginalFilename();
        String extension = getExtension();
        return originalFilename;
    }

    public String getEncFileName() {
        String extension = getExtension();
        return UUID.randomUUID().toString() + "." + extension;
    }

    public long getSize() {
        return multipartFile.getSize();
    }


    public String getPath() {
        String encFileName = getEncFileName();
        return uploadFilePath + encFileName;
    }

    public void UploadImage() throws IOException {
        String pathName = getPath();
        File dest = new File(pathName);
        multipartFile.transferTo(dest);
    }

}
