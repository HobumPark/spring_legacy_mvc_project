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

        // QR Code - BitMatrix ����
        BitMatrix bitMatrix = null;
        try {
            bitMatrix = new MultiFormatWriter().encode(url, BarcodeFormat.QR_CODE, width, height);
            System.out.println("��Ʈ ��Ʈ���� ����");
        } catch (Exception e) {
            // QR �ڵ� ���� ���� �� �α� ���
        	System.out.println("QR �ڵ� ���� ����:"+ e.getMessage());
            throw new Exception("QR �ڵ� ���� ����: " + e.getMessage(), e);
        }

        try (ByteArrayOutputStream out = new ByteArrayOutputStream()) {
            // PNG �������� QR �ڵ� �̹����� ��� ��Ʈ���� �ۼ�
            MatrixToImageWriter.writeToStream(bitMatrix, "PNG", out);
            
            // ����Ʈ �迭�� ��ȯ
            byte[] qrImage = out.toByteArray();

            // ����Ʈ �迭 ���� Ȯ��
            System.out.println("QR �ڵ� �̹��� ũ��: " + qrImage.length);
            
            // ����Ʈ �迭�� ��ȯ
            return out.toByteArray();
        } catch (Exception e) {
            // �̹��� ���� ���� �� ���� ó��
        	System.out.println("QR �ڵ� �̹��� ���� ����:"+ e.getMessage());
            throw new Exception("QR �ڵ� �̹��� ���� ����: " + e.getMessage(), e);
        }
    }

}