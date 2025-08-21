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
        System.out.println("공통 처리 메서드!");
        
        // 세션 만료시간 확인 및 남은 시간 계산 (예제)
        int maxInactiveInterval = session.getMaxInactiveInterval(); // 초
        long creationTime = session.getCreationTime();              // ms
        long currentTime = System.currentTimeMillis();              // ms
        
        int remainingSeconds = (int) ((creationTime + (maxInactiveInterval * 1000L) - currentTime) / 1000);
        System.out.println("maxInactiveInterval:" + maxInactiveInterval);
        System.out.println("remainingSeconds:" + remainingSeconds);
        
        
        UserDto user = (UserDto) session.getAttribute("user");
        
        if (user != null && remainingSeconds > 0) {
            System.out.println("로그인 상태 확인");
            model.addAttribute("loggedIn", true);
            model.addAttribute("user", user);
            model.addAttribute("sessionRemainingTime", Math.max(remainingSeconds, 0));
            
        } else {
            System.out.println("로그인 상태가 없거나 만료된 세션 종료");
            session.invalidate(); // 세션 종료 처리
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
            // QR 코드 이미지 생성 (바이트 배열 반환)
            qrImage = (byte[]) qrService.cerateQR(url);  
            
            // QR 코드 생성이 실패한 경우
            if (qrImage == null || qrImage.length == 0) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                        .body("QR 코드 생성 실패".getBytes());  // 오류 메시지 반환
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("QR 코드 생성 오류".getBytes());  // 예외 발생 시 오류 메시지 반환
        }

        // QR 코드 이미지를 반환 (200 OK 상태 코드)
        return ResponseEntity.ok()
                             .contentType(MediaType.IMAGE_PNG)  // 응답 타입을 image/png로 설정
                             .body(qrImage);  // 이미지 바이트 배열을 응답 본문으로 반환
    }


}
