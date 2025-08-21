package com.hb.cms.controller;

import java.time.LocalDateTime;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.hb.cms.dto.email.EmailDto;
import com.hb.cms.dto.users.UserDto;
import com.hb.cms.service.support.SupportService;

import javax.servlet.http.HttpSession;

import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

@Controller
public class SupportController {
    
    @Autowired
    private SupportService supportService;
    
    // 컨트롤러 클래스에서 JavaMailSender 주입
    @Autowired
    private JavaMailSender mailSender;
    
    /*
	 AOP전에 컨트롤러에 직접 넣었던 세션정보 확인
	@ModelAttribute
   public void addCommonUserInfo(Model model, HttpSession session) {
		System.out.println("怨듯넻 硫붿꽌�뱶!");
		
       // �쐟 �꽭�뀡 留뚮즺源뚯� �궓�� �떆媛� 怨꾩궛 (珥� �떒�쐞)
       int maxInactiveInterval = session.getMaxInactiveInterval(); // 珥�
       long creationTime = session.getCreationTime();              // ms
       long currentTime = System.currentTimeMillis();              // ms
       
       int remainingSeconds = (int) ((creationTime + (maxInactiveInterval * 1000L) - currentTime) / 1000);
       System.out.println("maxInactiveInterval:"+maxInactiveInterval);
       System.out.println("remainingSeconds:"+remainingSeconds);
		
		
       UserDto user = (UserDto) session.getAttribute("user");
       if (user != null && remainingSeconds > 0) {
           System.out.println("�쑀�� �젙蹂� 議댁옱");
           model.addAttribute("loggedIn", true);
           model.addAttribute("user", user);
           model.addAttribute("sessionRemainingTime", Math.max(remainingSeconds, 0));
       } else {
           System.out.println("�쑀�� �젙蹂� �뾾�쓬 �삉�뒗 �꽭�뀡 留뚮즺");
           session.invalidate(); // �쐟 �꽭�뀡 臾댄슚�솕
           model.addAttribute("loggedIn", false);
           model.addAttribute("sessionRemainingTime", 0);
       }
          
   }
   */
    
    @RequestMapping(value = "/support/contact", method = RequestMethod.GET)
    public String contactPage(Locale locale, Model model) {
        return "/support/contact";
    }
    
    @RequestMapping(value = "/support/email", method = RequestMethod.GET)
    public String emailPage(HttpSession session, Model model) {
        if (session.getAttribute("user") == null) {
            model.addAttribute("loginAlert", true); // 로그인 알림 표시
            return "common/alert-login";
        }
        return "/support/email";
    }
    
    @RequestMapping(value = "/support/email", method = RequestMethod.POST)
    public String sendEmail(
        @RequestParam("from-mail") String fromMail,
        @RequestParam("subject") String subject,
        @RequestParam("content") String content,
        Model model
    ) {
        System.out.println("fromMail:" + fromMail);
        System.out.println("subject:" + subject);
        System.out.println("content:" + content);
        
        Long id = 1L;                      // PK
        String sender = fromMail;          // 수신자 이메일
        LocalDateTime sentAt = LocalDateTime.now();   // 전송 시간
        String status = "success";         // 전송 상태 (SUCCESS, FAIL)
        String errorMessage = "no error";  // 에러 메시지
        
        EmailDto emailDto = new EmailDto(id, sender, subject, content, sentAt, status, errorMessage);
        
        // MimeMessage로 이메일을 전송하고, 사용자 이메일을 'from'에 설정
        try {
            MimeMessage mimeMessage = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");

            // 사용자가 입력한 이메일을 'from'으로 설정
            helper.setFrom(fromMail);  // 사용자가 입력한 이메일
            helper.setTo("fortpower123@gmail.com");  // 관리자 이메일 (고정)
            helper.setSubject(subject);
            helper.setText(content, false);  // 본문 내용 설정
            helper.setReplyTo(fromMail);  // 회신을 사용자의 이메일로 설정

            // 이메일 전송
            mailSender.send(mimeMessage);
            // 이메일 로그를 저장
            supportService.saveEmail(emailDto);
            emailDto.setStatus("SUCCESS");
        } catch (Exception e) {
            emailDto.setStatus("FAIL");
            emailDto.setErrorMessage(e.getMessage());
            e.printStackTrace();
        }

        

        // 성공 메시지와 리다이렉트 URL 설정
        model.addAttribute("message", "메일이 성공적으로 전송되었습니다!");
        model.addAttribute("redirectUrl", "/cms");
        return "common/alert-redirect";
    }

    
    @RequestMapping(value = "/support/inquiry", method = RequestMethod.GET)
    public String inquiryPage(Locale locale, Model model) {
        return "/support/inquiry";
    }
}
