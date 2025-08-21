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
            // ����� ������ ���
        	 System.out.println("�޴� ���: " + phoneNumber);
             System.out.println("������ ���: " + sender);
             System.out.println("�޽��� ����: " + content);
             
             //
             DefaultMessageService messageService =  NurigoApp.INSTANCE.initialize("API Ű �Է�", "API ��ũ�� Ű �Է�", "https://api.solapi.com");
 	         // Message ��Ű���� �ߺ��� ��� net.nurigo.sdk.message.model.Message�� ġȯ�Ͽ� �ּ���
 	         Message message = new Message();
 	         message.setFrom("�������� ����� �߽Ź�ȣ �Է�");
 	         message.setTo("���Ź�ȣ �Է�");
 	         message.setText("SMS�� �ѱ� 45��, ���� 90�ڱ��� �Է��� �� �ֽ��ϴ�.");
 	
 	         try {
 	           // send �޼ҵ�� ArrayList<Message> ��ü�� �־ �����մϴ�!
 	           messageService.send(message);
 	         } catch (NurigoMessageNotReceivedException exception) {
 	           // �߼ۿ� ������ �޽��� ����� Ȯ���� �� �ֽ��ϴ�!
 	           System.out.println(exception.getFailedMessageList());
 	           System.out.println(exception.getMessage());
 	         } catch (Exception exception) {
 	           System.out.println(exception.getMessage());
 	         }
            //
            
            boolean isReport = true;
            result.put("report", isReport);
            result.put("message", isReport ? "����" : "����");
            
            return ResponseEntity.ok(result);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("error", "����");
            return ResponseEntity.status(500).body(result);
       }
	
	}
}
