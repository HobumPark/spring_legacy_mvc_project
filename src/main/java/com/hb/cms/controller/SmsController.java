package com.hb.cms.controller;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.mail.Message;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.exception.NurigoMessageNotReceivedException;
import net.nurigo.sdk.message.service.DefaultMessageService;

@Controller
public class SmsController {
	
	@RequestMapping(value = "/sms/send", method = RequestMethod.GET)
    public String contactPage(Locale locale, Model model) {
		System.out.println("/sms/send");
        return "/sms/sms-send-page";
    }

	@RequestMapping(value = "/sms/send", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<Map<String, Object>> sendSms(Locale locale, Model model,
			@RequestParam(value = "phone-number", required = true) String phoneNumber, 
            @RequestParam(value = "sender", required = true) String sender, 
            @RequestParam(value = "content", required = true) String content) {
		System.out.println("/sms/send");
		
		Map<String, Object> result = new HashMap<>();
		
        try {
            // 디버깅 용으로 출력
        	 System.out.println("받는 사람: " + phoneNumber);
             System.out.println("보내는 사람: " + sender);
             System.out.println("메시지 내용: " + content);
             
             //
             DefaultMessageService messageService =  NurigoApp.INSTANCE.initialize("API 키 입력", "API 시크릿 키 입력", "https://api.solapi.com");
 	         // Message 패키지가 중복될 경우 net.nurigo.sdk.message.model.Message로 치환하여 주세요
 	         Message message = new Message();
 	         message.setFrom("계정에서 등록한 발신번호 입력");
 	         message.setTo("수신번호 입력");
 	         message.setText("SMS는 한글 45자, 영자 90자까지 입력할 수 있습니다.");
 	
 	         try {
 	           // send 메소드로 ArrayList<Message> 객체를 넣어도 동작합니다!
 	           messageService.send(message);
 	         } catch (NurigoMessageNotReceivedException exception) {
 	           // 발송에 실패한 메시지 목록을 확인할 수 있습니다!
 	           System.out.println(exception.getFailedMessageList());
 	           System.out.println(exception.getMessage());
 	         } catch (Exception exception) {
 	           System.out.println(exception.getMessage());
 	         }
            //
            
            boolean isReport = true;
            result.put("report", isReport);
            result.put("message", isReport ? "성공" : "실패");
            
            return ResponseEntity.ok(result);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("error", "오류");
            return ResponseEntity.status(500).body(result);
       }
	
	}
}
