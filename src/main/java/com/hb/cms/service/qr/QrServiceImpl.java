package com.hb.cms.service.qr;

import com.google.zxing.common.BitMatrix;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.client.j2se.MatrixToImageWriter;

import java.io.ByteArrayOutputStream;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class QrServiceImpl implements QrService{
    @Override
    public Object cerateQR(String url) throws Exception {
    	System.out.println("cerateQR");
        int width = 300;
        int height = 300;

        // QR Code - BitMatrix 생성
        BitMatrix bitMatrix = null;
        try {
            bitMatrix = new MultiFormatWriter().encode(url, BarcodeFormat.QR_CODE, width, height);
            System.out.println("비트 매트릭스 생성");
        } catch (Exception e) {
            // QR 코드 생성 실패 시 로그 출력
        	System.out.println("QR 코드 생성 실패:"+ e.getMessage());
            throw new Exception("QR 코드 생성 실패: " + e.getMessage(), e);
        }

        try (ByteArrayOutputStream out = new ByteArrayOutputStream()) {
            // PNG 형식으로 QR 코드 이미지를 출력 스트림에 작성
            MatrixToImageWriter.writeToStream(bitMatrix, "PNG", out);
            
            // 바이트 배열로 반환
            byte[] qrImage = out.toByteArray();

            // 바이트 배열 길이 확인
            System.out.println("QR 코드 이미지 크기: " + qrImage.length);
            
            // 바이트 배열로 반환
            return out.toByteArray();
        } catch (Exception e) {
            // 이미지 생성 실패 시 예외 처리
        	System.out.println("QR 코드 이미지 생성 실패:"+ e.getMessage());
            throw new Exception("QR 코드 이미지 생성 실패: " + e.getMessage(), e);
        }
    }

}