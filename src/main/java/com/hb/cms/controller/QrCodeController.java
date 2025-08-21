package com.hb.cms.controller;

import java.util.Locale;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.http.MediaType;  // Spring MediaType

import com.hb.cms.dto.users.UserDto;
import com.hb.cms.service.qr.QrService;

import javax.servlet.http.HttpSession;

@Controller
public class QrCodeController {
    
    @Autowired
    private QrService qrService;
    
    @ModelAttribute
    public void addCommonUserInfo(Model model, HttpSession session) {
        System.out.println("���� ó�� �޼���!");
        
        // ���� ����ð� Ȯ�� �� ���� �ð� ��� (����)
        int maxInactiveInterval = session.getMaxInactiveInterval(); // ��
        long creationTime = session.getCreationTime();              // ms
        long currentTime = System.currentTimeMillis();              // ms
        
        int remainingSeconds = (int) ((creationTime + (maxInactiveInterval * 1000L) - currentTime) / 1000);
        System.out.println("maxInactiveInterval:" + maxInactiveInterval);
        System.out.println("remainingSeconds:" + remainingSeconds);
        
        
        UserDto user = (UserDto) session.getAttribute("user");
        
        if (user != null && remainingSeconds > 0) {
            System.out.println("�α��� ���� Ȯ��");
            model.addAttribute("loggedIn", true);
            model.addAttribute("user", user);
            model.addAttribute("sessionRemainingTime", Math.max(remainingSeconds, 0));
            
        } else {
            System.out.println("�α��� ���°� ���ų� ����� ���� ����");
            session.invalidate(); // ���� ���� ó��
            model.addAttribute("loggedIn", false);
            model.addAttribute("sessionRemainingTime", 0);
        }     
    }

    
    @RequestMapping(value = "/contents/qr", method = RequestMethod.GET)
    public String qrCodeMakePage(Locale locale, Model model) {
    	System.out.println("/contents/qr (get)");
        return "/qr/qr-code-make";
    }
    
    @RequestMapping(value = "/contents/qr", method = RequestMethod.POST)
    public ResponseEntity<byte[]> qrCodeMakePost(Locale locale, Model model, @RequestBody Map<String, String> body) {
        System.out.println("/contents/qr (POST)");

        String url = body.get("url");
        System.out.println("url: " + url);

        byte[] qrImage = null;

        try {
            // QR �ڵ� �̹��� ���� (����Ʈ �迭 ��ȯ)
            qrImage = (byte[]) qrService.cerateQR(url);  
            
            // QR �ڵ� ������ ������ ���
            if (qrImage == null || qrImage.length == 0) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                        .body("QR �ڵ� ���� ����".getBytes());  // ���� �޽��� ��ȯ
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("QR �ڵ� ���� ����".getBytes());  // ���� �߻� �� ���� �޽��� ��ȯ
        }

        // QR �ڵ� �̹����� ��ȯ (200 OK ���� �ڵ�)
        return ResponseEntity.ok()
                             .contentType(MediaType.IMAGE_PNG)  // ���� Ÿ���� image/png�� ����
                             .body(qrImage);  // �̹��� ����Ʈ �迭�� ���� �������� ��ȯ
    }


}
