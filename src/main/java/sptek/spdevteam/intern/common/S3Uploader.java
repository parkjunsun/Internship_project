package sptek.spdevteam.intern.common;

import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.PutObjectRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import sptek.spdevteam.intern.content.domain.Image;
import sptek.spdevteam.intern.content.service.RegisterService;
import sptek.spdevteam.intern.content.service.UpdateService;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Optional;
import java.util.UUID;

@Slf4j
@RequiredArgsConstructor
@Component
public class S3Uploader {


    private final AmazonS3Client amazonS3Client;
    private final RegisterService registerService;
    private final UpdateService updateService;


    @Value("/home/ec2-user/")
    public String localImgSavePath;

    @Value("internship-admin")
    public String bucket;

    public void uploadSave(MultipartFile multipartFile, String dirName, String imgGrpId, String imgTyCd, int odr) throws IOException {
        File uploadFile = convert(multipartFile)
                .orElseThrow(() -> new IllegalArgumentException("error: MultipartFile -> File convert fail"));

        uploadSave(uploadFile, dirName, imgGrpId, imgTyCd, odr);
    }

    public void uploadUpdate(MultipartFile multipartFile, String dirName, Image image, int odr) throws IOException {
        File uploadFile = convert(multipartFile)
                .orElseThrow(() -> new IllegalArgumentException("error: MultipartFile -> File convert fail"));

        uploadUpdate(uploadFile, dirName, image, odr);
    }


    // S3로 파일 업로드 하기
    private void uploadSave(File uploadFile, String dirName, String imgGrpId, String imgTyCd, int odr) {
        String encFileName = UUID.randomUUID().toString();
        String fileName = dirName + "/" + encFileName + uploadFile.getName(); //S3에 저장된 파일 이름
        saveImage(uploadFile, fileName, uploadFile.getName(), encFileName, imgGrpId, imgTyCd, odr);
        String uploadImageUrl = putS3(uploadFile, fileName);
        removeNewFile(uploadFile);
    }


    private void uploadUpdate(File uploadFile, String dirName, Image image, int odr) {
        String encFileName = UUID.randomUUID().toString();
        String fileName = dirName + "/" + encFileName + uploadFile.getName();
        updateImage(uploadFile, fileName, uploadFile.getName(), encFileName, image, odr);
        String uploadImageUrl = putS3(uploadFile, fileName);
        removeNewFile(uploadFile);
    }


    // 로컬에 저장된 이미지 지우기
    private void removeNewFile(File targetFile) {
        if (targetFile.delete()) {
            log.info("File delete success");
            return;
        }
        log.info("File delete fail");
    }


    // S3로 업로드
    private String putS3(File uploadFile, String fileName) {
        amazonS3Client.putObject(new PutObjectRequest(bucket, fileName, uploadFile).withCannedAcl(CannedAccessControlList.PublicRead));
        return amazonS3Client.getUrl(bucket, fileName).toString();
    }


    private Optional<File> convert(MultipartFile file) throws IOException{
        File convertFile = new File(localImgSavePath + file.getOriginalFilename());
        if (convertFile.createNewFile()) {
            try (FileOutputStream fos = new FileOutputStream(convertFile)) {
                fos.write(file.getBytes());
            }
            return Optional.of(convertFile);
        }

        return Optional.empty();
    }

    private void saveImage(File file, String path, String feNm, String encFeNm, String imgGrpId, String imgTyCd, int odr) {
        Image image = new Image();
        image.setImgGrpId(imgGrpId);
        image.setImgTyCd(imgTyCd);
        image.setPath(path);
        image.setFeNm(feNm);
        image.setEncFeNm(encFeNm);
        image.setFeExt(file.getName().substring(file.getName().lastIndexOf('.') + 1));
        image.setFeSz(file.length());
        image.setRegDt(Timestamp.valueOf(LocalDateTime.now()));
        image.setModDt(Timestamp.valueOf(LocalDateTime.now()));
        image.setImgOdr(odr);
        image.setUseYn("Y");

        registerService.imgSave(image);
    }

    private void updateImage(File file, String path, String fileName, String encFileName, Image image, int odr) {
        image.setPath(path);
        image.setFeNm(fileName);
        image.setEncFeNm(encFileName);
        image.setFeExt(file.getName().substring(file.getName().lastIndexOf('.') + 1));
        image.setFeSz(file.length());
        image.setModDt(Timestamp.valueOf(LocalDateTime.now()));
        image.setUseYn("Y");
        image.setImgOdr(odr);

        updateService.updateImage(image);
    }

}
