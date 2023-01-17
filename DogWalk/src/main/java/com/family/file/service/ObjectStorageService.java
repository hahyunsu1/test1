package com.family.file.service;

import java.io.InputStream;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.apache.commons.io.FilenameUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.client.builder.AwsClientBuilder;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.Bucket;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.common.ObjectStorageException;

@Service
public class ObjectStorageService {

    private static final String END_POINT = "https://kr.object.ncloudstorage.com";

    private static final String HOSTING_END_POINT = "http://drop-the-clothes.s3-website.kr.object.ncloudstorage.com/";

    private static final String REGION_NAME = "kr-standard";

    private static final String ACCESS_KEY = "C90DBA3C49357D77D4D7";

    private static final String SECRET_KET = "D37DD13A66CFDB25EECE4A4D91E799D651EAE60C";

    private static final String BUCKET_NAME = "animal2/animal";

    public String uploadFileToObjectStorage(String directory, MultipartFile file) {
        final AmazonS3 naverObjectStorageClient = AmazonS3ClientBuilder.standard()
                                                 .withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration(END_POINT, REGION_NAME))
                                                 .withCredentials(new AWSStaticCredentialsProvider(new BasicAWSCredentials(ACCESS_KEY, SECRET_KET)))
                                                 .build();
        ObjectMetadata objectMetadata = new ObjectMetadata();
        objectMetadata.setContentLength(file.getSize());
        String uploadFileName = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd_HHmmssSSS")) + "." + FilenameUtils.getExtension(file.getOriginalFilename());
        String uploadPathAndFileName = directory + "/" + uploadFileName;
        try {
            naverObjectStorageClient.putObject(BUCKET_NAME, uploadPathAndFileName, file.getInputStream(), objectMetadata);
        } catch (Exception e) {
            throw new ObjectStorageException(e.getMessage());
        }
        return HOSTING_END_POINT + uploadPathAndFileName;
    }

   
}